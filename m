Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EB0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9A8207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgH0Jyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:54:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbgH0Jye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:54:34 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD3A0207CD;
        Thu, 27 Aug 2020 09:54:31 +0000 (UTC)
Date:   Thu, 27 Aug 2020 10:54:29 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/35] arm64: mte: Add in-kernel tag fault handler
Message-ID: <20200827095429.GC29264@gaia>
References: <cover.1597425745.git.andreyknvl@google.com>
 <f173aacd755e4644485c551198549ac52d1eb650.1597425745.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f173aacd755e4644485c551198549ac52d1eb650.1597425745.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 07:27:03PM +0200, Andrey Konovalov wrote:
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 5e832b3387f1..c62c8ba85c0e 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -33,6 +33,7 @@
>  #include <asm/debug-monitors.h>
>  #include <asm/esr.h>
>  #include <asm/kprobes.h>
> +#include <asm/mte.h>
>  #include <asm/processor.h>
>  #include <asm/sysreg.h>
>  #include <asm/system_misc.h>
> @@ -222,6 +223,20 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
>  	return 1;
>  }
>  
> +static bool is_el1_mte_sync_tag_check_fault(unsigned int esr)
> +{
> +	unsigned int ec = ESR_ELx_EC(esr);
> +	unsigned int fsc = esr & ESR_ELx_FSC;
> +
> +	if (ec != ESR_ELx_EC_DABT_CUR)
> +		return false;
> +
> +	if (fsc == ESR_ELx_FSC_MTE)
> +		return true;
> +
> +	return false;
> +}
> +
>  static bool is_el1_instruction_abort(unsigned int esr)
>  {
>  	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_CUR;
> @@ -294,6 +309,18 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
>  	do_exit(SIGKILL);
>  }
>  
> +static void report_tag_fault(unsigned long addr, unsigned int esr,
> +			     struct pt_regs *regs)
> +{
> +	bool is_write = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
> +
> +	pr_alert("Memory Tagging Extension Fault in %pS\n", (void *)regs->pc);
> +	pr_alert("  %s at address %lx\n", is_write ? "Write" : "Read", addr);
> +	pr_alert("  Pointer tag: [%02x], memory tag: [%02x]\n",
> +			mte_get_ptr_tag(addr),
> +			mte_get_mem_tag((void *)addr));
> +}
> +
>  static void __do_kernel_fault(unsigned long addr, unsigned int esr,
>  			      struct pt_regs *regs)
>  {
> @@ -317,12 +344,16 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
>  			msg = "execute from non-executable memory";
>  		else
>  			msg = "read from unreadable memory";
> +	} else if (is_el1_mte_sync_tag_check_fault(esr)) {
> +		report_tag_fault(addr, esr, regs);
> +		msg = "memory tagging extension fault";

IIUC, that's dead code. See my comment below on do_tag_check_fault().

>  	} else if (addr < PAGE_SIZE) {
>  		msg = "NULL pointer dereference";
>  	} else {
>  		msg = "paging request";
>  	}
>  
> +

Unnecessary empty line.

>  	die_kernel_fault(msg, addr, esr, regs);
>  }
>  
> @@ -658,10 +689,27 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  	return 0;
>  }
>  
> +static int do_tag_recovery(unsigned long addr, unsigned int esr,
> +			   struct pt_regs *regs)
> +{
> +	report_tag_fault(addr, esr, regs);
> +
> +	/* Skip over the faulting instruction and continue: */
> +	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);

Ooooh, do we expect the kernel to still behave correctly after this? I
thought the recovery means disabling tag checking altogether and
restarting the instruction rather than skipping over it. We only skip if
we emulated it.

> +
> +	return 0;
> +}
> +
> +
>  static int do_tag_check_fault(unsigned long addr, unsigned int esr,
>  			      struct pt_regs *regs)
>  {
> -	do_bad_area(addr, esr, regs);
> +	/* The tag check fault (TCF) is per TTBR */
> +	if (is_ttbr0_addr(addr))
> +		do_bad_area(addr, esr, regs);
> +	else
> +		do_tag_recovery(addr, esr, regs);

So we never invoke __do_kernel_fault() for a synchronous tag check in
the kernel. What's with all the is_el1_mte_sync_tag_check_fault() check
above?

-- 
Catalin
