Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EC8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FAD020748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgGJOJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:09:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:34856 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbgGJOJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:09:13 -0400
IronPort-SDR: yLbBhbfzqMBnqOMHhxwE61vt1dtyYUDzeIaAuXRJa/Y8hw0s8hArwXE/vIiwYRB846If3bNRsK
 RBYsHVIijl3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="166291197"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="166291197"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 07:09:12 -0700
IronPort-SDR: 8m7Skck1q5Go487gXDzzzdUrNsv8q02qmEmELTNsgbhpPoUrvJn7gYLAMsMOfORZMwhcBCnVJn
 pBvEw2A3bULw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="428573363"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 10 Jul 2020 07:09:12 -0700
Received: from [10.252.137.247] (kliang2-mobl.ccr.corp.intel.com [10.252.137.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C1697580299;
        Fri, 10 Jul 2020 07:09:11 -0700 (PDT)
Subject: Re: [tip: perf/core] x86/cpufeatures: Add Architectural LBRs feature
 bit
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
References: <1593780569-62993-2-git-send-email-kan.liang@linux.intel.com>
 <159420191583.4006.10876391642907607745.tip-bot2@tip-bot2>
 <e231263a-76f8-326a-ae47-0ae785137c9a@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <fb64b207-a933-cbd7-bc90-03f04c6e5444@linux.intel.com>
Date:   Fri, 10 Jul 2020 10:09:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e231263a-76f8-326a-ae47-0ae785137c9a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/2020 7:00 PM, Dave Hansen wrote:
> On 7/8/20 2:51 AM, tip-bot2 for Kan Liang wrote:
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index 02dabc9..72ba4c5 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -366,6 +366,7 @@
>>   #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
>>   #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
>>   #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
>> +#define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
>>   #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
>>   #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
>>   #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
> 
> Are architectural LBRs useful *without* XSAVE?  

Yes, previous model-specific LBRs don't have XSAVE support, but it's 
still widely used.

Adding XSAVE is more based on performance considerations. It doesn't 
impact the existing LBR capabilities.

I once talked with our virtualization team. They also want us to support 
both XSAVE and non-XSAVE version of LBRs. If the XSAVE is not available, 
we should fall back to the previous MSR method.

I don't think we should make Arch LBR depends on XSAVE.

Thanks,
Kan

> If not, should we add an
> entry in arch/x86/kernel/cpu/cpuid-deps.c::cpuid_deps[] for this?
> 
> ...
>          { X86_FEATURE_ARCH_LBR,            X86_FEATURE_XSAVES    },
> ...
> 
