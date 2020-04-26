Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F42BC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 15:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E602C2078E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 15:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDZPZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 11:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgDZPZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 11:25:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61767C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 08:25:20 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jSj9W-0004rs-Tl; Sun, 26 Apr 2020 17:25:07 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 541F0100605; Sun, 26 Apr 2020 17:25:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        iommu@lists.linux-foundation.org, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 6/7] x86/traps: Fix up invalid PASID
In-Reply-To: <1585596788-193989-7-git-send-email-fenghua.yu@intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com> <1585596788-193989-7-git-send-email-fenghua.yu@intel.com>
Date:   Sun, 26 Apr 2020 17:25:06 +0200
Message-ID: <87mu6ys20d.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fenghua Yu <fenghua.yu@intel.com> writes:
> A #GP fault is generated when ENQCMD instruction is executed without
> a valid PASID value programmed in.

Programmed in what?

> The #GP fault handler will initialize the current thread's PASID MSR.
>
> The following heuristic is used to avoid decoding the user instructions
> to determine the precise reason for the #GP fault:
> 1) If the mm for the process has not been allocated a PASID, this #GP
>    cannot be fixed.
> 2) If the PASID MSR is already initialized, then the #GP was for some
>    other reason
> 3) Try initializing the PASID MSR and returning. If the #GP was from
>    an ENQCMD this will fix it. If not, the #GP fault will be repeated
>    and we will hit case "2".
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>

Just for the record I also suggested to have a proper errorcode in the
#GP for ENQCMD and I surely did not suggest to avoid decoding the user
instructions.

>  void __free_pasid(struct mm_struct *mm);
> +bool __fixup_pasid_exception(void);
>  
>  #endif /* _ASM_X86_IOMMU_H */
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 6ef00eb6fbb9..369b5ba94635 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -56,6 +56,7 @@
>  #include <asm/umip.h>
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
> +#include <asm/iommu.h>
>  
>  #ifdef CONFIG_X86_64
>  #include <asm/x86_init.h>
> @@ -488,6 +489,16 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
>  	return GP_CANONICAL;
>  }
>  
> +static bool fixup_pasid_exception(void)
> +{
> +	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
> +		return false;
> +	if (!static_cpu_has(X86_FEATURE_ENQCMD))
> +		return false;
> +
> +	return __fixup_pasid_exception();
> +}
> +
>  #define GPFSTR "general protection fault"
>  
>  dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
> @@ -499,6 +510,12 @@ dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
>  	int ret;
>  
>  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +
> +	if (user_mode(regs) && fixup_pasid_exception()) {
> +		cond_local_irq_enable(regs);

The point of this conditional irq enable _AFTER_ calling into the fixup
function is? Also what's the reason for keeping interrupts disabled
while calling into that function? Comments exist for a reason.

> +		return;
> +	}
> +
>  	cond_local_irq_enable(regs);
>  
>  	if (static_cpu_has(X86_FEATURE_UMIP)) {
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index da718a49e91e..5ed39a022adb 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -759,3 +759,40 @@ void __free_pasid(struct mm_struct *mm)
>  	 */
>  	ioasid_free(pasid);
>  }
> +
> +/*
> + * Fix up the PASID MSR if possible.
> + *
> + * But if the #GP was due to another reason, a second #GP might be triggered
> + * to force proper behavior.
> + */
> +bool __fixup_pasid_exception(void)
> +{
> +	struct mm_struct *mm;
> +	bool ret = true;
> +	u64 pasid_msr;
> +	int pasid;
> +
> +	mm = get_task_mm(current);

Why do you need a reference to current->mm ?

> +	/* This #GP was triggered from user mode. So mm cannot be NULL. */
> +	pasid = mm->context.pasid;
> +	/* Ensure this process has been bound to a PASID. */
> +	if (!pasid) {
> +		ret = false;
> +		goto out;
> +	}
> +
> +	/* Check to see if the PASID MSR has already been set for this task. */
> +	rdmsrl(MSR_IA32_PASID, pasid_msr);
> +	if (pasid_msr & MSR_IA32_PASID_VALID) {
> +		ret = false;
> +		goto out;
> +	}
> +
> +	/* Fix up the MSR. */
> +	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
> +out:
> +	mmput(mm);

Thanks,

        tglx
