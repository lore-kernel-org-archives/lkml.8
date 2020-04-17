Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319B5C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124FB21D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgDQDB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 23:01:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:21668 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgDQDBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:01:25 -0400
IronPort-SDR: M5EIEsAo9IUlYXQ9fj8IK7R9TAjjf751f6Mab25GQ/A/4W07lmjbtoxhxfgtnSt5EcKjzCgtOi
 Z+Ygmz8ATj4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 20:01:25 -0700
IronPort-SDR: 4xXBe1wnECRz/UV85LMKUwzgWH5fHFhfCBvqCT4xRlF3F0nTHNQLb9gHFmsHaGegX0rnJCKXYe
 +nq561+7bwVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; 
   d="scan'208";a="254072337"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga003.jf.intel.com with ESMTP; 16 Apr 2020 20:01:23 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: swap: properly update readahead statistics in unuse_pte_range()
References: <20200416180132.GB3352@xps-13>
Date:   Fri, 17 Apr 2020 11:01:22 +0800
In-Reply-To: <20200416180132.GB3352@xps-13> (Andrea Righi's message of "Thu,
        16 Apr 2020 20:01:32 +0200")
Message-ID: <871romvmrh.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Righi <andrea.righi@canonical.com> writes:

> In unuse_pte_range() we blindly swap-in pages without checking if the
> swap entry is already present in the swap cache.
>
> By doing this, the hit/miss ratio used by the swap readahead heuristic
> is not properly updated and this leads to non-optimal performance during
> swapoff.

It's more important to describe why we need this patch in the patch
description.  So, please add some information about your use case.  And
please focus on the technical part instead of the business part.

> Tracing the distribution of the readahead size returned by the swap
> readahead heuristic during swapoff shows that a small readahead size is
> used most of the time as if we had only misses (this happens both with
> cluster and vma readahead), for example:
>
> r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
>         COUNT      EVENT
>         36948      $retval = 8
>         44151      $retval = 4
>         49290      $retval = 1
>         527771     $retval = 2
>
> Checking if the swap entry is present in the swap cache, instead, allows
> to properly update the readahead statistics and the heuristic behaves in
> a better way during swapoff, selecting a bigger readahead size:
>
> r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
>         COUNT      EVENT
>         1618       $retval = 1
>         4960       $retval = 2
>         41315      $retval = 4
>         103521     $retval = 8
>
> In terms of swapoff performance the result is the following:
>
> Testing environment
> ===================
>
>  - Host:
>    CPU: 1.8GHz Intel Core i7-8565U (quad-core, 8MB cache)
>    HDD: PC401 NVMe SK hynix 512GB
>    MEM: 16GB
>
>  - Guest (kvm):
>    8GB of RAM
>    virtio block driver
>    16GB swap file on ext4 (/swapfile)
>
> Test case
> =========
>  - allocate 85% of memory
>  - `systemctl hibernate` to force all the pages to be swapped-out to the
>    swap file
>  - resume the system
>  - measure the time that swapoff takes to complete:
>    # /usr/bin/time swapoff /swapfile
>
> Result (swapoff time)
> ======
>                   5.6 vanilla   5.6 w/ this patch
>                   -----------   -----------------
> cluster-readahead      22.09s              12.19s
>     vma-readahead      18.20s              15.33s
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

Thanks!  But you don't need to do this.  You can add my Reviewed-by after
we have finished the work on patch description.

Best Regards,
Huang, Ying
