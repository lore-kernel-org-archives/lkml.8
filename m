Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FEFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 128842080C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgFVRr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:47:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:4410 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbgFVRr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:47:28 -0400
IronPort-SDR: uJOzZZbp/knPQBNMCiX9G7aHowTfenBDE8qeaLLCLRk8uFH8KrZwBbAC0RX7jvRx72Ij9SNpPK
 HBQXl/CUnQkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="142880811"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="142880811"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 10:47:27 -0700
IronPort-SDR: MUyeD6xExVXemwRYy5FMtNNvaDfRRVRRbsbON+eKS9UwEj0zX3E/Oy253aZKNAzYHdKICGbQVt
 d6HbF/e4lVFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="422710430"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2020 10:47:27 -0700
Received: from [10.251.30.218] (kliang2-mobl.ccr.corp.intel.com [10.251.30.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E599D580342;
        Mon, 22 Jun 2020 10:47:24 -0700 (PDT)
Subject: Re: [PATCH 17/21] x86/fpu: Use proper mask to replace full
 instruction mask
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, yu-cheng.yu@intel.com,
        bigeasy@linutronix.de, gorcunov@gmail.com, hpa@zytor.com,
        alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-18-git-send-email-kan.liang@linux.intel.com>
 <20200619193140.GI576888@hirez.programming.kicks-ass.net>
 <aa3d239b-6ffe-261e-e70a-ffd17b8b506b@linux.intel.com>
 <c95b6ade-2cc9-e065-01ab-b449dd846c50@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <56653932-4c11-60f9-1541-a19ea307c0a9@linux.intel.com>
Date:   Mon, 22 Jun 2020 13:47:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c95b6ade-2cc9-e065-01ab-b449dd846c50@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/2020 11:02 AM, Dave Hansen wrote:
> On 6/22/20 7:52 AM, Liang, Kan wrote:
>>>> --- a/arch/x86/kernel/fpu/xstate.c
>>>> +++ b/arch/x86/kernel/fpu/xstate.c
>>>> @@ -58,6 +58,7 @@ static short xsave_cpuid_features[] __initdata = {
>>>>     * XSAVE buffer, both supervisor and user xstates.
>>>>     */
>>>>    u64 xfeatures_mask_all __read_mostly;
>>>> +EXPORT_SYMBOL_GPL(xfeatures_mask_all);
>>>
>>> *groan*...
>>>
>>> AFAICT KVM doesn't actually use any of those functions,
>>
>> It seems KVM may eventually invoke copy_xregs_to_kernel() as below.
>>
>> kvm_save_current_fpu()
>>      copy_fpregs_to_fpstate()
>>          copy_xregs_to_kernel()
>>
>> I think we have to export the xfeatures_mask_all.
> 
> I'm wondering if we should just take these copy_*regs_to_*() functions
> and uninline them.  Yeah, they are basically wrapping one instruction,
> but it might literally be the most heavyweight instruction in the whole ISA.
>

Thanks for the suggestions, but I'm not sure if I follow these methods.

I don't think simply removing the "inline" key word for the 
copy_xregs_to_kernel() functions would help here.
Do you mean exporting the copy_*regs_to_*()?


> Or, maybe just make an out-of-line version for KVM to call?
> 

I think the out-of-line version for KVM still needs the 
xfeatures_mask_all. Because the size of vcpu's XSAVE buffer 
(&vcpu->arch.guest_fpu) is the same as other kernel XSAVE buffers, such 
as task->fpu. The xfeatures_mask_all is required for KVM to filter out 
the dynamic supervisor feature as well. I think even if we make an 
out-of-line version for KVM, we still have to export the 
xfeatures_mask_all for KVM.


Thanks,
Kan
