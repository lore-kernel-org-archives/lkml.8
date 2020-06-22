Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C827EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A695020768
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgFVOwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:52:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:9987 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbgFVOw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:52:29 -0400
IronPort-SDR: e0dI40RslVo546WVbWMJokCSwOfxzJpd0byrxPpC/35WyZHtA2MWTen4AK267POZHc8ktRobkS
 sr0R3fiDGe+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="228434601"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="228434601"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 07:52:29 -0700
IronPort-SDR: uMQJPEYClNjDigT7oU1qg5eLI+U5px+QNl8XtG/n5aRquRd1be7vgR2AXexdLQvUCNoIo1eJVv
 iZ2vGOEbO+nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="278780609"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2020 07:52:28 -0700
Received: from [10.251.30.218] (unknown [10.251.30.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6B9275804D6;
        Mon, 22 Jun 2020 07:52:26 -0700 (PDT)
Subject: Re: [PATCH 17/21] x86/fpu: Use proper mask to replace full
 instruction mask
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-18-git-send-email-kan.liang@linux.intel.com>
 <20200619193140.GI576888@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <aa3d239b-6ffe-261e-e70a-ffd17b8b506b@linux.intel.com>
Date:   Mon, 22 Jun 2020 10:52:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619193140.GI576888@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2020 3:31 PM, Peter Zijlstra wrote:
> On Fri, Jun 19, 2020 at 07:04:05AM -0700, kan.liang@linux.intel.com wrote:
> 
>> KVM includes the header file fpu/internal.h. To avoid 'undefined
>> xfeatures_mask_all' compiling issue, xfeatures_mask_all has to be
>> exported.
> 
>> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
>> index 587e03f..eb2e44e 100644
>> --- a/arch/x86/kernel/fpu/xstate.c
>> +++ b/arch/x86/kernel/fpu/xstate.c
>> @@ -58,6 +58,7 @@ static short xsave_cpuid_features[] __initdata = {
>>    * XSAVE buffer, both supervisor and user xstates.
>>    */
>>   u64 xfeatures_mask_all __read_mostly;
>> +EXPORT_SYMBOL_GPL(xfeatures_mask_all);
> 
> *groan*...
> 
> AFAICT KVM doesn't actually use any of those functions,

It seems KVM may eventually invoke copy_xregs_to_kernel() as below.

kvm_save_current_fpu()
     copy_fpregs_to_fpstate()
         copy_xregs_to_kernel()

I think we have to export the xfeatures_mask_all.

Thanks,
Kan

> can't we have
> something like BUILD_KVM (like BUILD_VDSO) and exclude those functions
> from the KVM build?
> 
> I so detest exporting random crap because kvm..
> 
