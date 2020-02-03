Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D18C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072852084E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgBCWFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:05:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:63768 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgBCWFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:05:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 14:05:38 -0800
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="249140829"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 14:05:38 -0800
Message-ID: <6758b1e3373fc06b37af1c87901237974d52322f.camel@linux.intel.com>
Subject: Re: [PATCH v16.1 0/9] mm / virtio: Provide support for free page
 reporting
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        david@redhat.com
Cc:     yang.zhang.wz@gmail.com, nitesh@redhat.com, konrad.wilk@oracle.com,
        pagupta@redhat.com, riel@surriel.com, lcapitulino@redhat.com,
        dave.hansen@intel.com, wei.w.wang@intel.com, aarcange@redhat.com,
        pbonzini@redhat.com, dan.j.williams@intel.com, osalvador@suse.de,
        vbabka@suse.cz, AlexanderDuyck <alexander.duyck@gmail.com>,
        kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org
Date:   Mon, 03 Feb 2020 14:05:38 -0800
In-Reply-To: <20200122173040.6142.39116.stgit@localhost.localdomain>
References: <20200122173040.6142.39116.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-22 at 09:43 -0800, Alexander Duyck wrote:
> This series provides an asynchronous means of reporting free guest pages
> to a hypervisor so that the memory associated with those pages can be
> dropped and reused by other processes and/or guests on the host. Using
> this it is possible to avoid unnecessary I/O to disk and greatly improve
> performance in the case of memory overcommit on the host.

<snip>

> A brief history on the background of free page reporting can be found at:
> https://lore.kernel.org/lkml/29f43d5796feed0dec8e8bb98b187d9dac03b900.camel@linux.intel.com/
> 
> Changes from v14:
> https://lore.kernel.org/lkml/20191119214454.24996.66289.stgit@localhost.localdomain/
> Renamed "unused page reporting" to "free page reporting"
>   Updated code, kconfig, and patch descriptions
> Split out patch for __free_isolated_page
>   Renamed function to __putback_isolated_page
> Rewrote core reporting functionality
>   Added logic to reschedule worker in 2 seconds instead of run to completion
>   Removed reported_pages statistics
>   Removed REPORTING_REQUESTED bit used in zone flags
>   Replaced page_reporting_dev_info refcount with state variable
>   Removed scatterlist from page_reporting_dev_info
>   Removed capacity from page reporting device
>   Added dynamic scatterlist allocation/free at start/end of reporting process
>   Updated __free_one_page so that reported pages are not always added to tail
>   Added logic to handle error from report function
> Updated virtio-balloon patch that adds support for page reporting
>   Updated patch description to try and highlight differences in approaches
>   Updated logic to reflect that we cannot limit the scatterlist from device
>   Added logic to return error from report function
> Moved documentation patch to end of patch set
> 
> Changes from v15:
> https://lore.kernel.org/lkml/20191205161928.19548.41654.stgit@localhost.localdomain/
> Rebased on linux-next-20191219
> Split out patches for budget and moving head to last page processed
> Updated budget code to reduce how much memory is reported per pass
> Added logic to also rotate the list if we exit due a page isolation failure
> Added migratetype as argument in __putback_isolated_page
> 
> Changes from v16:
> https://lore.kernel.org/lkml/20200103210509.29237.18426.stgit@localhost.localdomain/
> Rebased on linux-next-20200122
>   Updated patch 2 to to account for removal of pr_info in __isolate_free_page
> Updated patch title for patches 7, 8, and 9 to use prefix mm/page_reporting
> No code changes other than conflict resolution for patch 2

So I thought I would put out a gentle nudge since it has been about 4
weeks since v16 was submitted, a little over a week and a half for v16.1,
and I have yet to get any feedback on the code contained in the patchset.
Codewise nothing has changed from the v16 patchset other than rebasing it
off of the linux-next tree to resolve some merge conflicts that I saw
recently, and discussion around v16.1 was mostly about next steps and how
to deal with the page cache instead of discussing the code itself.

The full patchset can be found at:
https://lore.kernel.org/lkml/20200122173040.6142.39116.stgit@localhost.localdomain/

I believe I still need review feedback for patches 3, 4, 7, 8, and 9.

Thanks.

- Alex

