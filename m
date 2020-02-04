Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86033C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A08E2084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBDAEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 19:04:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:13095 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbgBDAEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 19:04:50 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 16:04:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="310876865"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2020 16:04:49 -0800
Date:   Mon, 3 Feb 2020 16:04:49 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mark D Rustad <mrustad@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v17] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200204000449.GA28014@linux.intel.com>
References: <4E95BFAA-A115-4159-AA4F-6AAB548C6E6C@gmail.com>
 <C3302B2F-177F-4C39-910E-EADBA9285DD0@intel.com>
 <8CC9FBA7-D464-4E58-8912-3E14A751D243@gmail.com>
 <20200126200535.GB30377@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126200535.GB30377@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 12:05:35PM -0800, Luck, Tony wrote:

...

> +bool handle_user_split_lock(struct pt_regs *regs, long error_code)

No reason to take the error code unless there's a plan to use it.

> +{
> +	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
> +		return false;

Any objection to moving the EFLAGS.AC up to do_alignment_check()?  And
take "unsigned long rip" instead of @regs?

That would allow KVM to reuse handle_user_split_lock() for guest faults
without any changes (other than exporting).

E.g. do_alignment_check() becomes:

	if (!(regs->flags & X86_EFLAGS_AC) && handle_user_split_lock(regs->ip))
		return;

> +
> +	pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
> +			    current->comm, current->pid, regs->ip);
> +
> +	/*
> +	 * Disable the split lock detection for this task so it can make
> +	 * progress and set TIF_SLD so the detection is re-enabled via
> +	 * switch_to_sld() when the task is scheduled out.
> +	 */
> +	__sld_msr_set(false);
> +	set_tsk_thread_flag(current, TIF_SLD);
> +	return true;
> +}

...

> +dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
> +{
> +	char *str = "alignment check";
> +
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +
> +	if (notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_AC, SIGBUS) == NOTIFY_STOP)
> +		return;
> +
> +	if (!user_mode(regs))
> +		die("Split lock detected\n", regs, error_code);
> +
> +	local_irq_enable();
> +
> +	if (handle_user_split_lock(regs, error_code))
> +		return;
> +
> +	do_trap(X86_TRAP_AC, SIGBUS, "alignment check", regs,
> +		error_code, BUS_ADRALN, NULL);
> +}
> +
>  #ifdef CONFIG_VMAP_STACK
>  __visible void __noreturn handle_stack_overflow(const char *message,
>  						struct pt_regs *regs,
> -- 
> 2.21.1
> 
