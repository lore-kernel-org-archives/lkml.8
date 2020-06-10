Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56C1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F49D20814
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFJVgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:36:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:8907 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgFJVgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:36:05 -0400
IronPort-SDR: 743q4c38cybqGE+XYfq4CNivY8uXZwV2V9WjKFap4l31AMJM913au8trOfcavxvV9gqbQpTpQ9
 mBRTUTbcIwCA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 14:36:04 -0700
IronPort-SDR: VGR49SxO4V7TZXUsKgr0PkSZES+SlQ/oVEiz8EZpTNdpGpxR8a9I7NZe29I5vOtDH+GDwr9SBA
 QVlAn+F0J8YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,497,1583222400"; 
   d="scan'208";a="275115369"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2020 14:36:04 -0700
Date:   Wed, 10 Jun 2020 14:36:04 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "David P. Reed" <dpreed@deepplum.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix undefined operation VMXOFF during reboot and crash
Message-ID: <20200610213604.GG18790@linux.intel.com>
References: <20200610181254.2142-1-dpreed@deepplum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610181254.2142-1-dpreed@deepplum.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 02:12:50PM -0400, David P. Reed wrote:
> If a panic/reboot occurs when CR4 has VMX enabled, a VMXOFF is
> done on all CPUS, to allow the INIT IPI to function, since
> INIT is suppressed when CPUs are in VMX root operation.
> However, VMXOFF causes an undefined operation fault if the CPU is not
> in VMX operation, that is, VMXON has not been executed, or VMXOFF
> has been executed, but VMX is enabled. This fix makes the reboot
> work more reliably by modifying the #UD handler to skip the VMXOFF
> if VMX is enabled on the CPU and the VMXOFF is executed as part
> of cpu_emergency_vmxoff().
> The logic in reboot.c is also corrected, since the point of forcing
> the processor out of VMX root operation is because when VMX root
> operation is enabled, the processor INIT signal is always masked.
> See Intel SDM section on differences between VMX Root operation and normal
> operation. Thus every CPU must be forced out of VMX operation.
> Since the CPU will hang rather than restart, a manual "reset" is the
> only way out of this state (or if there is a BMC, it can issue a RESET
> to the chip).
> 
> Signed-off-by: David P. Reed <dpreed@deepplum.com>
> ---
> @@ -47,17 +51,25 @@ static inline int cpu_vmx_enabled(void)
>  	return __read_cr4() & X86_CR4_VMXE;
>  }
>  
> -/** Disable VMX if it is enabled on the current CPU
> +/** Force disable VMX if it is enabled on the current CPU.
> + * Note that if CPU is not in VMX root operation this
> + * VMXOFF will fault an undefined operation fault.
> + * So the 'doing_emergency_vmxoff' percpu flag is set,
> + * the trap handler for just restarts execution after
> + * the VMXOFF instruction.
>   *
> - * You shouldn't call this if cpu_has_vmx() returns 0.
> + * You shouldn't call this directly if cpu_has_vmx() returns 0.
>   */
>  static inline void __cpu_emergency_vmxoff(void)
>  {
> -	if (cpu_vmx_enabled())
> +	if (cpu_vmx_enabled()) {
> +		this_cpu_write(doing_emergency_vmxoff, 1);
>  		cpu_vmxoff();
> +		this_cpu_write(doing_emergency_vmxoff, 0);
> +	}
>  }

...

> +/*
> + * Fix any unwanted undefined operation fault due to VMXOFF instruction that
> + * is needed to ensure that CPU is not in VMX root operation at time of
> + * a reboot/panic CPU reset. There is no safe and reliable way to know
> + * if a processor is in VMX root operation, other than to skip the
> + * VMXOFF. It is safe to just skip any VMXOFF that might generate this
> + * exception, when VMX operation is enabled in CR4. In the extremely
> + * rare case that a VMXOFF is erroneously executed while VMX is enabled,
> + * but VMXON has not been executed yet, the undefined opcode fault
> + * should not be missed by valid code, though it would be an error.
> + * To detect this, we could somehow restrict the instruction address
> + * to the specific use during reboot/panic.
> + */
> +static int fixup_emergency_vmxoff(struct pt_regs *regs, int trapnr)
> +{
> +	const static u8 insn_vmxoff[3] = { 0x0f, 0x01, 0xc4 };
> +	u8 ud[3];
> +
> +	if (trapnr != X86_TRAP_UD)
> +		return 0;
> +	if (!cpu_vmx_enabled())
> +		return 0;
> +	if (!this_cpu_read(doing_emergency_vmxoff))
> +		return 0;
> +
> +	/* undefined instruction must be in kernel and be VMXOFF */
> +	if (regs->ip < TASK_SIZE_MAX)
> +		return 0;
> +	if (probe_kernel_address((u8 *)regs->ip, ud))
> +		return 0;
> +	if (memcmp(ud, insn_vmxoff, sizeof(insn_vmxoff)))
> +		return 0;
> +
> +	regs->ip += sizeof(insn_vmxoff);
> +	return 1;
> +}
> +
>  static nokprobe_inline int
>  do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
>  		  struct pt_regs *regs,	long error_code)
> @@ -193,9 +234,16 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
>  	/*
>  	 * WARN*()s end up here; fix them up before we call the
>  	 * notifier chain.
> +	 * Also, VMXOFF causes unwanted fault during reboot
> +	 * if VMX is enabled, but not in VMX root operation. Fix
> +	 * before calling notifier chain.
>  	 */
> -	if (!user_mode(regs) && fixup_bug(regs, trapnr))
> -		return;
> +	if (!user_mode(regs)) {
> +		if (fixup_bug(regs, trapnr))
> +			return;
> +		if (fixup_emergency_vmxoff(regs, trapnr))
> +			return;
> +	}

Isn't this just a really kludgy way of doing fixup on vmxoff?  E.g. wouldn't
the below patch do the trick?

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 9aad0e0876fb..54bc84d7028d 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -32,13 +32,15 @@ static inline int cpu_has_vmx(void)

 /** Disable VMX on the current CPU
  *
- * vmxoff causes a undefined-opcode exception if vmxon was not run
- * on the CPU previously. Only call this function if you know VMX
- * is enabled.
+ * VMXOFF causes a #UD if the CPU is not post-VMXON, eat any #UDs to handle
+ * races with a hypervisor doing VMXOFF, e.g. if an NMI arrived between VMXOFF
+ * and clearing CR4.VMXE.
  */
 static inline void cpu_vmxoff(void)
 {
-       asm volatile ("vmxoff");
+       asm volatile("1: vmxoff\n\t"
+                    "2:\n\t"
+                    _ASM_EXTABLE(1b, 2b));
        cr4_clear_bits(X86_CR4_VMXE);
 }


