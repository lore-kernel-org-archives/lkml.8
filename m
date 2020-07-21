Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6798C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94DA0206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgGUS11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 14:27:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:64355 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgGUS11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 14:27:27 -0400
IronPort-SDR: F9zu2VgX4W0AEK8Eyff5xGrKAxS3lPnOUB+qr/0TPAgydKG98JwimbZogLRJFtmAxCpS0gKi67
 XETtFzmGzqYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="168353300"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="168353300"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 11:27:20 -0700
IronPort-SDR: 5GjH+19Wc9U8yWdLSKHoAraq6GgFcIZyaqak8j7NSKmroac9UQnHclIoR27KedQL5wKu8I46Ms
 zJrXUx03JAxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="462172821"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2020 11:27:19 -0700
Received: from [10.254.76.99] (kliang2-mobl.ccr.corp.intel.com [10.254.76.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 55FE8580299;
        Tue, 21 Jul 2020 11:27:18 -0700 (PDT)
Subject: Re: [PATCH] x86/fpu/xstate: Fix an xstate size check warning
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, hpa@zytor.com,
        eranian@google.com, ak@linux.intel.com, chang.seok.bae@intel.com
References: <1595253051-75374-1-git-send-email-kan.liang@linux.intel.com>
 <20200720173313.GA4221@grain>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <7fbe722b-7a75-098d-23b5-fd1fd7d310d6@linux.intel.com>
Date:   Tue, 21 Jul 2020 14:27:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720173313.GA4221@grain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2020 1:33 PM, Cyrill Gorcunov wrote:
> On Mon, Jul 20, 2020 at 06:50:51AM -0700, kan.liang@linux.intel.com wrote:
> ...
>>   static unsigned int __init get_xsave_size(void)
>>   {
>>   	unsigned int eax, ebx, ecx, edx;
>> @@ -710,7 +741,7 @@ static int __init init_xstate_size(void)
>>   	xsave_size = get_xsave_size();
>>   
>>   	if (boot_cpu_has(X86_FEATURE_XSAVES))
>> -		possible_xstate_size = get_xsaves_size();
>> +		possible_xstate_size = get_xsaves_size_no_dynamic();
>>   	else
>>   		possible_xstate_size = xsave_size;
> 
> Hi! Maybe we could enhance get_xsaves_size instead ? The get_xsaves_size is
> static and __init function (thus not a hot path) used once as far as I see.
> Say
> 
> static unsigned int __init get_xsaves_size(void)
> {
> 	u64 mask = xfeatures_mask_dynamic();
> 	unsigned int eax, ebx, ecx, edx;
> 
> 	/*
> 	 * In case if dynamic features are present make
> 	 * sure they are not accounted in the result since
> 	 * the buffer should be allocated separately from
> 	 * task->fpu.
> 	 */
> 	if (mask)
> 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
> 
> 	/*
> 	 * - CPUID function 0DH, sub-function 1:
> 	 *    EBX enumerates the size (in bytes) required by
> 	 *    the XSAVES instruction for an XSAVE area
> 	 *    containing all the state components
> 	 *    corresponding to bits currently set in
> 	 *    XCR0 | IA32_XSS.
> 	 */
> 	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
> 
> 	if (mask)
> 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() | mask);
> 
> 	return ebx;
> }
> 
> but if you expect more use of get_xsaves_size_no_dynamic() and
> get_xsaves_size() in future then sure, we need a separate function.
> 

For now, I don't have more use of 
get_xsaves_size_no_dynamic()/get_xsaves_size(). I don't know if anyone 
else will use them later.

> The benefit from such extension is that when you read get_xsaves_size
> you'll notice the dependency on dynamic features immediaely.
> 
> Though I'm fine with current patch as well, up to you. Thanks for the patch!
> 

Personally, I prefer to keep the current patch because I like the name 
get_xsaves_size_no_dynamic(), which explicitly tells the dynamic 
features are excluded.

> Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
> 

Thanks for the review.

Kan

