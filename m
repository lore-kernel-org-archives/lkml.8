Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE32C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAF8206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgC1QcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:32:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:41730 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgC1QcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:32:01 -0400
IronPort-SDR: R3J+PJG7vba9ujKPlC1WE5LfxgVHxoiSIyUunV7wm1ZuPRRG3PIHaVFh5UnvRx2duKuBYT2OaO
 U/pnpiKQEEQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 09:32:01 -0700
IronPort-SDR: 3YgAP+y5LhQ1XSXQE7XhXK5YtO7kUL4CmFFbPQOqrtQr28IqWBb9cCKLsilwvR9TvVtYPeFnw8
 R/X7tfLPu+NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,317,1580803200"; 
   d="scan'208";a="394686164"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga004.jf.intel.com with ESMTP; 28 Mar 2020 09:32:01 -0700
Date:   Sat, 28 Mar 2020 09:32:01 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v7 1/2] x86/split_lock: Rework the initialization flow of
 split lock detection
Message-ID: <20200328163201.GI8104@linux.intel.com>
References: <20200325030924.132881-1-xiaoyao.li@intel.com>
 <20200325030924.132881-2-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325030924.132881-2-xiaoyao.li@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 11:09:23AM +0800, Xiaoyao Li wrote:
>  static void __init split_lock_setup(void)
>  {
> +	enum split_lock_detect_state state = sld_warn;
>  	char arg[20];
>  	int i, ret;
>  
> -	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
> -	sld_state = sld_warn;
> +	if (!split_lock_verify_msr(false)) {
> +		pr_info("MSR access failed: Disabled\n");

A few nits on the error handling.

The error message for this is a bit wonky, lots of colons and it's not
super clear what "Disabled" refers to.

  [    0.000000] x86/split lock detection: MSR access failed: Disabled

Maybe this, so that it reads "split lock detection disabled because the MSR
access failed".

		pr_info("Disabled, MSR access failed\n");

And rather than duplicate the error message, maybe use a goto, e.g.

	if (!split_lock_verify_msr(false))
		goto msr_failed;

	...

	if (!split_lock_verify_msr(true))
		goto msr_failed;


> +		return;
> +	}
>  
>  	ret = cmdline_find_option(boot_command_line, "split_lock_detect",
>  				  arg, sizeof(arg));
>  	if (ret >= 0) {
>  		for (i = 0; i < ARRAY_SIZE(sld_options); i++) {
>  			if (match_option(arg, ret, sld_options[i].option)) {
> -				sld_state = sld_options[i].state;
> +				state = sld_options[i].state;
>  				break;
>  			}
>  		}
>  	}
>  
> -	switch (sld_state) {
> +	switch (state) {
>  	case sld_off:
>  		pr_info("disabled\n");
> -		break;
> -
> +		return;
>  	case sld_warn:
>  		pr_info("warning about user-space split_locks\n");
>  		break;
> -
>  	case sld_fatal:
>  		pr_info("sending SIGBUS on user-space split_locks\n");
>  		break;
>  	}
> +
> +	if (!split_lock_verify_msr(true)) {
> +		pr_info("MSR access failed: Disabled\n");
> +		return;
> +	}
> +
> +	sld_state = state;
> +	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
>  }
>  
>  /*
> - * Locking is not required at the moment because only bit 29 of this
> - * MSR is implemented and locking would not prevent that the operation
> - * of one thread is immediately undone by the sibling thread.
> - * Use the "safe" versions of rdmsr/wrmsr here because although code
> - * checks CPUID and MSR bits to make sure the TEST_CTRL MSR should
> - * exist, there may be glitches in virtualization that leave a guest
> - * with an incorrect view of real h/w capabilities.
> + * MSR_TEST_CTRL is per core, but we treat it like a per CPU MSR. Locking
> + * is not implemented as one thread could undo the setting of the other
> + * thread immediately after dropping the lock anyway.
>   */
> -static bool __sld_msr_set(bool on)
> +static void sld_update_msr(bool on)
>  {
>  	u64 test_ctrl_val;
>  
> -	if (rdmsrl_safe(MSR_TEST_CTRL, &test_ctrl_val))
> -		return false;
> +	rdmsrl(MSR_TEST_CTRL, test_ctrl_val);
>  
>  	if (on)
>  		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
>  	else
>  		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
>  
> -	return !wrmsrl_safe(MSR_TEST_CTRL, test_ctrl_val);
> +	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
>  }
>  
>  static void split_lock_init(void)
>  {
> -	if (sld_state == sld_off)
> -		return;
> -
> -	if (__sld_msr_set(true))
> -		return;
> -
> -	/*
> -	 * If this is anything other than the boot-cpu, you've done
> -	 * funny things and you get to keep whatever pieces.
> -	 */
> -	pr_warn("MSR fail -- disabled\n");
> -	sld_state = sld_off;
> +	split_lock_verify_msr(sld_state != sld_off);

I think it'd be worth a WARN_ON() if this fails with sld_state != off.  If
the WRMSR fails, then presumably SLD is off when it's expected to be on.
The implied WARN on the unsafe WRMSR in sld_update_msr() won't fire unless
a task generates an #AC on a non-buggy core and then gets migrated to the
buggy core.  Even if the WARNs are redundant, if something is wrong it'd be
a lot easier for a user to triage/debug if there is a WARN in boot as
opposed to a runtime WARN that requires a misbehaving application and
scheduler behavior.

>  }
>  
>  bool handle_user_split_lock(struct pt_regs *regs, long error_code)
> @@ -1071,7 +1083,7 @@ bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>  	 * progress and set TIF_SLD so the detection is re-enabled via
>  	 * switch_to_sld() when the task is scheduled out.
>  	 */
> -	__sld_msr_set(false);
> +	sld_update_msr(false);
>  	set_tsk_thread_flag(current, TIF_SLD);
>  	return true;
>  }
> @@ -1085,7 +1097,7 @@ bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>   */
>  void switch_to_sld(unsigned long tifn)
>  {
> -	__sld_msr_set(!(tifn & _TIF_SLD));
> +	sld_update_msr(!(tifn & _TIF_SLD));
>  }
>  
>  #define SPLIT_LOCK_CPU(model) {X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY}
> -- 
> 2.20.1
> 
