Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ADBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 21:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0032075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 21:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgAXVgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:36:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43682 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXVgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 16:36:23 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iv6cW-000218-Bi; Fri, 24 Jan 2020 22:36:04 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1EBC010308A; Fri, 24 Jan 2020 22:36:03 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Luck\, Tony" <tony.luck@intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "Christopherson\, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu\, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj\, Ashok" <ashok.raj@intel.com>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v14] x86/split_lock: Enable split lock detection by kernel
In-Reply-To: <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
References: <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com> <20200114055521.GI14928@linux.intel.com> <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com> <20200115225724.GA18268@linux.intel.com> <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com> <20200122224245.GA2331824@rani.riverdale.lan> <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com> <20200123004507.GA2403906@rani.riverdale.lan> <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com> <20200123044514.GA2453000@rani.riverdale.lan> <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
Date:   Fri, 24 Jan 2020 22:36:03 +0100
Message-ID: <87h80kmta4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

"Luck, Tony" <tony.luck@intel.com> writes:
> +	split_lock_detect=
> +			[X86] Enable split lock detection
> +
> +			When enabled (and if hardware support is present), atomic
> +			instructions that access data across cache line
> +			boundaries will result in an alignment check exception.
> +
> +			off	- not enabled
> +
> +			warn	- the kernel will pr_alert about applications

pr_alert is not a verb. And the implementation uses
pr_warn_ratelimited(). So this should be something like:

                       The kernel will emit rate limited warnings about
                       applications ...

> +				  triggering the #AC exception
> @@ -40,4 +40,21 @@ int mwait_usable(const struct cpuinfo_x86 *);
>  unsigned int x86_family(unsigned int sig);
>  unsigned int x86_model(unsigned int sig);
>  unsigned int x86_stepping(unsigned int sig);
> +#ifdef CONFIG_CPU_SUP_INTEL
> +extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
> +extern bool split_lock_detect_enabled(void);

That function is unused.

> +extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
> +extern void switch_sld(struct task_struct *);
> +#else
> +static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
> +static inline bool split_lock_detect_enabled(void)
> +{
> +	return false;
> +}
> +static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
> +{
> +	return false;
> +}
> +static inline void switch_sld(struct task_struct *prev) {}
> +#endif
  
> +enum split_lock_detect_state {
> +	sld_off = 0,
> +	sld_warn,
> +	sld_fatal,
> +};
> +
> +/*
> + * Default to sld_off because most systems do not support
> + * split lock detection. split_lock_setup() will switch this

Can you please add: If supported, then ...

> + * to sld_warn, and then check to see if there is a command
> + * line override.

I had to read this 3 times and then stare at the code.

> + */
> +static enum split_lock_detect_state sld_state = sld_off;
> +
> +static void __init split_lock_setup(void)
> +{
> +	enum split_lock_detect_state sld;
> +	char arg[20];
> +	int i, ret;
> +
> +	sld_state = sld = sld_warn;

This intermediate variable is pointless.

> +	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
> +
> +	ret = cmdline_find_option(boot_command_line, "split_lock_detect",
> +				  arg, sizeof(arg));
> +	if (ret < 0)
> +		goto print;
> +
> +	for (i = 0; i < ARRAY_SIZE(sld_options); i++) {
> +		if (match_option(arg, ret, sld_options[i].option)) {
> +			sld = sld_options[i].state;
> +			break;
> +		}
> +	}
> +
> +	if (sld != sld_state)
> +		sld_state = sld;
> +
> +print:

> +/*
> + * The TEST_CTRL MSR is per core. So multiple threads can
> + * read/write the MSR in parallel. But it's possible to
> + * simplify the read/write without locking and without
> + * worry about overwriting the MSR because only bit 29
> + * is implemented in the MSR and the bit is set as 1 by all
> + * threads. Locking may be needed in the future if situation
> + * is changed e.g. other bits are implemented.

This sentence doesn't parse. Something like this perhaps:

     Locking is not required at the moment because only bit 29 of this
     MSR is implemented and locking would not prevent that the operation
     of one thread is immediately undone by the sibling thread.

This implies that locking might become necessary when new bits are added.

> + */
> +
> +static bool __sld_msr_set(bool on)
> +{
> +	u64 test_ctrl_val;
> +
> +	if (rdmsrl_safe(MSR_TEST_CTRL, &test_ctrl_val))
> +		return false;
> +
> +	if (on)
> +		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
> +	else
> +		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
> +
> +	if (wrmsrl_safe(MSR_TEST_CTRL, test_ctrl_val))
> +		return false;
> +
> +	return true;

	return !wrmsrl_safe(MSR_TEST_CTRL, test_ctrl_val);

> +}
> +
> +static void split_lock_init(void)
> +{
> +	if (sld_state == sld_off)
> +		return;
> +
> +	if (__sld_msr_set(true))
> +		return;
> +
> +	/*
> +	 * If this is anything other than the boot-cpu, you've done
> +	 * funny things and you get to keep whatever pieces.
> +	 */
> +	pr_warn("MSR fail -- disabled\n");
> +	__sld_msr_set(sld_off);

That should do:

        sld_state = sld_off;

for consistency sake.

> +}
> +
> +bool split_lock_detect_enabled(void)
> +{
> +	return sld_state != sld_off;
> +}
> +
> +bool handle_user_split_lock(struct pt_regs *regs, long error_code)
> +{
> +	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
> +		return false;
> +
> +	pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
> +		 current->comm, current->pid, regs->ip);

So with 10 prints per 5 seconds an intentional offender can still fill dmesg
pretty good. A standard dmesg buffer should be full of this in
~15min. Not a big issue, but it might be annoying. Let's start with this
and deal with it when people complain.

The magic below really lacks a comment. Something like:

	/*
         * Disable the split lock detection for this task so it can make
         * progress and set TIF_SLD so the detection is reenabled via
         * switch_to_sld() when the task is scheduled out.
         */

> +	__sld_msr_set(false);
> +	set_tsk_thread_flag(current, TIF_SLD);
> +	return true;
> +}
> +
> +void switch_sld(struct task_struct *prev)

switch_to_sld() perhaps?

> +{
> +	__sld_msr_set(true);
> +	clear_tsk_thread_flag(prev, TIF_SLD);
> +}
>  
> +dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
> +{
> +	const char str[] = "alignment check";
> +
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +
> +	if (notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_AC, SIGBUS) == NOTIFY_STOP)
> +		return;
> +
> +	if (!user_mode(regs))
> +		die("Split lock detected\n", regs, error_code);
> +
> +	cond_local_irq_enable(regs);

This cond is pointless. We recently removed the ability for user space
to disable interrupts and even if that would still be allowed then
keeping interrupts disabled here does not make sense.

Other than those details, I really like this approach.

Thanks,

        tglx
