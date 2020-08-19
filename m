Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B42C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9012F207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHSAiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:38:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:47301 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgHSAiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 20:38:16 -0400
IronPort-SDR: 89Q37X6ws2imSc10k4HBJcbF5TF6q6C8VE3YBbGKLzDNs6h9cvKgnEHhMViA2P3U6IEaqemFGh
 /52ylZED0mkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="135093419"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="135093419"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 17:38:16 -0700
IronPort-SDR: z+ryxSXWekjTNsVBa2eKrkv1pBi82hpSvhsBcfhMh/sPqoqTGC3HEYXY1cwPCYhrloH8EDWRId
 3lfixg7qrWFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="279551279"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2020 17:38:15 -0700
Date:   Wed, 19 Aug 2020 00:38:15 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Babu Moger <babu.moger@amd.com>, H Peter Anvin <hpa@zytor.com>,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] x86/resctrl: Enable user to view thread or core
 throttling mode
Message-ID: <20200819003815.GA358477@otcwcpicx6.sc.intel.com>
References: <1594921994-66192-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594921994-66192-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, X86 maintainers,

On Thu, Jul 16, 2020 at 10:53:12AM -0700, Fenghua Yu wrote:
> This series enumerates Memory Bandwidth Allocation (MBA) per-thread
> feature and introduces a new resctrl file "thread_throttle_mode".
> The file shows either "per-thread" on newer systems that implement the MBA
> per-thread feature or "max" on other systems that allocate maximum
> throttling per-core.
> 
> Details about the feature can be found in the commit description and
> in Chapter 9 of the most recent Intel ISE available from
> https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
> 
> This series replaces the original MBA thread throttling patch series
> found at
> https://lore.kernel.org/lkml/cover.1592841671.git.reinette.chatre@intel.com/
> 
> This is a simplified version of the previous series that skips the
> min/max mode and just provides the per-core vs. per-thread indicator.
> 

Any comment on this series? Could you please help push to upstream?

Thanks.

-Fenghua
