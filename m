Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83366C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6147B207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgGBFCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:02:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:56821 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgGBFCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:02:09 -0400
IronPort-SDR: f9cFO4cXLqCC4JFFiVoIQ5wBcoSKpbIeo3fgn6msJD2F6q1txIA0Ugl1J88Ux5jBoDgup5K9Eu
 ijxZkXRSEzBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="134248177"
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; 
   d="scan'208";a="134248177"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 22:02:08 -0700
IronPort-SDR: MyyxQQ8g6JkMfyH8jmNxP9XjOz5K/O3Nte8eq9pu15YuiVO558HbtrUYlrwT9E+2rkAfKAFid9
 wAdyKi1O0cqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; 
   d="scan'208";a="266975060"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jul 2020 22:02:06 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kbusch@kernel.org>, <yang.shi@linux.alibaba.com>,
        <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH 3/8] mm/vmscan: Attempt to migrate page in lieu of discard
References: <20200629234503.749E5340@viggo.jf.intel.com>
        <20200629234509.8F89C4EF@viggo.jf.intel.com>
        <alpine.DEB.2.22.394.2006301732010.1644114@chino.kir.corp.google.com>
        <c06b4453-c533-a9ba-939a-8877fb301ad6@intel.com>
        <alpine.DEB.2.23.453.2007011203500.1908531@chino.kir.corp.google.com>
Date:   Thu, 02 Jul 2020 13:02:03 +0800
In-Reply-To: <alpine.DEB.2.23.453.2007011203500.1908531@chino.kir.corp.google.com>
        (David Rientjes's message of "Wed, 1 Jul 2020 12:25:08 -0700")
Message-ID: <87mu4ijyr8.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes <rientjes@google.com> writes:

> On Wed, 1 Jul 2020, Dave Hansen wrote:
>
>> > Could this cause us to break a user's mbind() or allow a user to 
>> > circumvent their cpuset.mems?
>> 
>> In its current form, yes.
>> 
>> My current rationale for this is that while it's not as deferential as
>> it can be to the user/kernel ABI contract, it's good *overall* behavior.
>>  The auto-migration only kicks in when the data is about to go away.  So
>> while the user's data might be slower than they like, it is *WAY* faster
>> than they deserve because it should be off on the disk.
>> 
>
> It's outside the scope of this patchset, but eventually there will be a 
> promotion path that I think requires a strict 1:1 relationship between 
> DRAM and PMEM nodes because otherwise mbind(), set_mempolicy(), and 
> cpuset.mems become ineffective for nodes facing memory pressure.

I have posted an patchset for AutoNUMA based promotion support,

https://lore.kernel.org/lkml/20200218082634.1596727-1-ying.huang@intel.com/

Where, the page is promoted upon NUMA hint page fault.  So all memory
policy (mbind(), set_mempolicy(), and cpuset.mems) are available.  We
can refuse promoting the page to the DRAM nodes that are not allowed by
any memory policy.  So, 1:1 relationship isn't necessary for promotion.

> For the purposes of this patchset, agreed that DRAM -> PMEM -> swap makes 
> perfect sense.  Theoretically, I think you could have DRAM N0 and N1 and 
> then a single PMEM N2 and this N2 can be the terminal node for both N0 and 
> N1.  On promotion, I think we need to rely on something stronger than 
> autonuma to decide which DRAM node to promote to: specifically any user 
> policy put into effect (memory tiering or autonuma shouldn't be allowed to 
> subvert these user policies).
>
> As others have mentioned, we lose the allocation or process context at the 
> time of demotion or promotion

As above, we have process context at time of promotion.

> and any workaround for that requires some 
> hacks, such as mapping the page to cpuset (what is the right solution for 
> shared pages?) or adding NUMA locality handling to memcg.

It sounds natural to me to add NUMA nodes restriction to memcg.

Best Regards,
Huang, Ying
