Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01336C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD52A2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgD0UMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:12:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:27097 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgD0UMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:12:38 -0400
IronPort-SDR: y2yfBt5icar2QeaXqxKou1J0qCBHWJJSHJ33CTeOpJiknHkxxRBC3oMVqiCIQg7esu7jim02km
 IvzJMno/tldg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 13:12:38 -0700
IronPort-SDR: YBiqKDU6yALRocwGMfAP5WdABSpYbxOMw94dJKnOcHjyDm/PQNZwcV+8e63r+ViAUTAQzF2MWh
 3uvOvlkaS+iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="404431049"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga004.jf.intel.com with ESMTP; 27 Apr 2020 13:12:37 -0700
Date:   Mon, 27 Apr 2020 13:11:42 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 6/7] x86/traps: Fix up invalid PASID
Message-ID: <20200427201141.GA242333@romley-ivt3.sc.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-7-git-send-email-fenghua.yu@intel.com>
 <87mu6ys20d.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu6ys20d.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 05:25:06PM +0200, Thomas Gleixner wrote:
> Fenghua Yu <fenghua.yu@intel.com> writes:
> > A #GP fault is generated when ENQCMD instruction is executed without
> > a valid PASID value programmed in.
> 
> Programmed in what?

Will change to "...programmed in the PASID MSR".

> 
> > The #GP fault handler will initialize the current thread's PASID MSR.
> >
> > The following heuristic is used to avoid decoding the user instructions
> > to determine the precise reason for the #GP fault:
> > 1) If the mm for the process has not been allocated a PASID, this #GP
> >    cannot be fixed.
> > 2) If the PASID MSR is already initialized, then the #GP was for some
> >    other reason
> > 3) Try initializing the PASID MSR and returning. If the #GP was from
> >    an ENQCMD this will fix it. If not, the #GP fault will be repeated
> >    and we will hit case "2".
> >
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Just for the record I also suggested to have a proper errorcode in the
> #GP for ENQCMD and I surely did not suggest to avoid decoding the user
> instructions.
> 
> >  void __free_pasid(struct mm_struct *mm);
> > +bool __fixup_pasid_exception(void);
> >  
> >  #endif /* _ASM_X86_IOMMU_H */
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 6ef00eb6fbb9..369b5ba94635 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -56,6 +56,7 @@
> >  #include <asm/umip.h>
> >  #include <asm/insn.h>
> >  #include <asm/insn-eval.h>
> > +#include <asm/iommu.h>
> >  
> >  #ifdef CONFIG_X86_64
> >  #include <asm/x86_init.h>
> > @@ -488,6 +489,16 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
> >  	return GP_CANONICAL;
> >  }
> >  
> > +static bool fixup_pasid_exception(void)
> > +{
> > +	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
> > +		return false;
> > +	if (!static_cpu_has(X86_FEATURE_ENQCMD))
> > +		return false;
> > +
> > +	return __fixup_pasid_exception();
> > +}
> > +
> >  #define GPFSTR "general protection fault"
> >  
> >  dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
> > @@ -499,6 +510,12 @@ dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
> >  	int ret;
> >  
> >  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> > +
> > +	if (user_mode(regs) && fixup_pasid_exception()) {
> > +		cond_local_irq_enable(regs);
> 
> The point of this conditional irq enable _AFTER_ calling into the fixup
> function is? Also what's the reason for keeping interrupts disabled
> while calling into that function? Comments exist for a reason.

irq needs to be disabled because the fixup function requires to disable
preempt in order to update the PASID MSR on the faulting CPU.

Will add comments here.

> 
> > +		return;
> > +	}
> > +
> >  	cond_local_irq_enable(regs);
> >  
> >  	if (static_cpu_has(X86_FEATURE_UMIP)) {
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index da718a49e91e..5ed39a022adb 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -759,3 +759,40 @@ void __free_pasid(struct mm_struct *mm)
> >  	 */
> >  	ioasid_free(pasid);
> >  }
> > +
> > +/*
> > + * Fix up the PASID MSR if possible.
> > + *
> > + * But if the #GP was due to another reason, a second #GP might be triggered
> > + * to force proper behavior.
> > + */
> > +bool __fixup_pasid_exception(void)
> > +{
> > +	struct mm_struct *mm;
> > +	bool ret = true;
> > +	u64 pasid_msr;
> > +	int pasid;
> > +
> > +	mm = get_task_mm(current);
> 
> Why do you need a reference to current->mm ?

The PASID for the address space is per mm and is stored in mm.
To get the PASID, we need to get the mm and the pasid=mm->context.pasid.


> 
> > +	/* This #GP was triggered from user mode. So mm cannot be NULL. */
> > +	pasid = mm->context.pasid;
> > +	/* Ensure this process has been bound to a PASID. */
> > +	if (!pasid) {
> > +		ret = false;
> > +		goto out;
> > +	}
> > +
> > +	/* Check to see if the PASID MSR has already been set for this task. */
> > +	rdmsrl(MSR_IA32_PASID, pasid_msr);
> > +	if (pasid_msr & MSR_IA32_PASID_VALID) {
> > +		ret = false;
> > +		goto out;
> > +	}
> > +
> > +	/* Fix up the MSR. */
> > +	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
> > +out:
> > +	mmput(mm);

Thanks,

-Fenghua

