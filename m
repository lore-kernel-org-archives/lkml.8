Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0BAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBA520733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgC3N0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:26:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:42344 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgC3N0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:26:31 -0400
IronPort-SDR: 0cPios/04IFdxM17fVxR0n35PDba+Vqt6ufukKREA/bQoyTMQan0FYcO8zgH/LKqn3whaQ7Leg
 XwRrwwU15NkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 06:26:30 -0700
IronPort-SDR: EkuIJNXNzFQIEUGlHCsXAWMWnpvSpf2QGdwssfPWjoRDjfUQ9GfiuQ5Bs2gmTtXNo0N63d864M
 rpsG0hmyP/Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,324,1580803200"; 
   d="scan'208";a="272368217"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.255.28.64]) ([10.255.28.64])
  by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2020 06:26:26 -0700
Subject: Re: [PATCH v7 1/2] x86/split_lock: Rework the initialization flow of
 split lock detection
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20200325030924.132881-1-xiaoyao.li@intel.com>
 <20200325030924.132881-2-xiaoyao.li@intel.com>
 <20200328163201.GI8104@linux.intel.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <9db4acdc-add6-f63c-fb5c-654cb429b578@intel.com>
Date:   Mon, 30 Mar 2020 21:26:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200328163201.GI8104@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2020 12:32 AM, Sean Christopherson wrote:
> On Wed, Mar 25, 2020 at 11:09:23AM +0800, Xiaoyao Li wrote:
>>   static void __init split_lock_setup(void)
>>   {
>> +	enum split_lock_detect_state state = sld_warn;
>>   	char arg[20];
>>   	int i, ret;
>>   
>> -	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
>> -	sld_state = sld_warn;
>> +	if (!split_lock_verify_msr(false)) {
>> +		pr_info("MSR access failed: Disabled\n");
> 
> A few nits on the error handling.
> 
> The error message for this is a bit wonky, lots of colons and it's not
> super clear what "Disabled" refers to.
> 
>    [    0.000000] x86/split lock detection: MSR access failed: Disabled
> 
> Maybe this, so that it reads "split lock detection disabled because the MSR
> access failed".
> 
> 		pr_info("Disabled, MSR access failed\n");
> 
> And rather than duplicate the error message, maybe use a goto, e.g.
> 
> 	if (!split_lock_verify_msr(false))
> 		goto msr_failed;
> 
> 	...
> 
> 	if (!split_lock_verify_msr(true))
> 		goto msr_failed;
> 

Will do it in next version.

thanks

>> +		return;
>> +	}
>>   
>>   	ret = cmdline_find_option(boot_command_line, "split_lock_detect",
>>   				  arg, sizeof(arg));
>>   	if (ret >= 0) {
>>   		for (i = 0; i < ARRAY_SIZE(sld_options); i++) {
>>   			if (match_option(arg, ret, sld_options[i].option)) {
>> -				sld_state = sld_options[i].state;
>> +				state = sld_options[i].state;
>>   				break;
>>   			}
>>   		}
>>   	}
>>   
>> -	switch (sld_state) {
>> +	switch (state) {
>>   	case sld_off:
>>   		pr_info("disabled\n");
>> -		break;
>> -
>> +		return;
>>   	case sld_warn:
>>   		pr_info("warning about user-space split_locks\n");
>>   		break;
>> -
>>   	case sld_fatal:
>>   		pr_info("sending SIGBUS on user-space split_locks\n");
>>   		break;
>>   	}
>> +
>> +	if (!split_lock_verify_msr(true)) {
>> +		pr_info("MSR access failed: Disabled\n");
>> +		return;
>> +	}
>> +
>> +	sld_state = state;
>> +	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
>>   }
>>   
>>   /*
>> - * Locking is not required at the moment because only bit 29 of this
>> - * MSR is implemented and locking would not prevent that the operation
>> - * of one thread is immediately undone by the sibling thread.
>> - * Use the "safe" versions of rdmsr/wrmsr here because although code
>> - * checks CPUID and MSR bits to make sure the TEST_CTRL MSR should
>> - * exist, there may be glitches in virtualization that leave a guest
>> - * with an incorrect view of real h/w capabilities.
>> + * MSR_TEST_CTRL is per core, but we treat it like a per CPU MSR. Locking
>> + * is not implemented as one thread could undo the setting of the other
>> + * thread immediately after dropping the lock anyway.
>>    */
>> -static bool __sld_msr_set(bool on)
>> +static void sld_update_msr(bool on)
>>   {
>>   	u64 test_ctrl_val;
>>   
>> -	if (rdmsrl_safe(MSR_TEST_CTRL, &test_ctrl_val))
>> -		return false;
>> +	rdmsrl(MSR_TEST_CTRL, test_ctrl_val);
>>   
>>   	if (on)
>>   		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
>>   	else
>>   		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
>>   
>> -	return !wrmsrl_safe(MSR_TEST_CTRL, test_ctrl_val);
>> +	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
>>   }
>>   
>>   static void split_lock_init(void)
>>   {
>> -	if (sld_state == sld_off)
>> -		return;
>> -
>> -	if (__sld_msr_set(true))
>> -		return;
>> -
>> -	/*
>> -	 * If this is anything other than the boot-cpu, you've done
>> -	 * funny things and you get to keep whatever pieces.
>> -	 */
>> -	pr_warn("MSR fail -- disabled\n");
>> -	sld_state = sld_off;
>> +	split_lock_verify_msr(sld_state != sld_off);
> 
> I think it'd be worth a WARN_ON() if this fails with sld_state != off.  If
> the WRMSR fails, then presumably SLD is off when it's expected to be on.
> The implied WARN on the unsafe WRMSR in sld_update_msr() won't fire unless
> a task generates an #AC on a non-buggy core and then gets migrated to the
> buggy core.  Even if the WARNs are redundant, if something is wrong it'd be
> a lot easier for a user to triage/debug if there is a WARN in boot as
> opposed to a runtime WARN that requires a misbehaving application and
> scheduler behavior.
> 

IIUC, you're recommending something like below?

         WARN_ON(!split_lock_verify_msr(sld_state != sld_off) &&
		sld_state != sld_off);

>>   }
>>   
>>   bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>> @@ -1071,7 +1083,7 @@ bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>>   	 * progress and set TIF_SLD so the detection is re-enabled via
>>   	 * switch_to_sld() when the task is scheduled out.
>>   	 */
>> -	__sld_msr_set(false);
>> +	sld_update_msr(false);
>>   	set_tsk_thread_flag(current, TIF_SLD);
>>   	return true;
>>   }
>> @@ -1085,7 +1097,7 @@ bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>>    */
>>   void switch_to_sld(unsigned long tifn)
>>   {
>> -	__sld_msr_set(!(tifn & _TIF_SLD));
>> +	sld_update_msr(!(tifn & _TIF_SLD));
>>   }
>>   
>>   #define SPLIT_LOCK_CPU(model) {X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY}
>> -- 
>> 2.20.1
>>

