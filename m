Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF165C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1ABF20775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="UO1iaSKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgG0Nsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgG0Ns3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:48:29 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC65FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:48:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k13so207541plk.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=szunKijEXv6Oi5Ur3X4bC9MRzV/pKzbZV4r4GAHkBNY=;
        b=UO1iaSKRkRYbWrwirjm9kkXJySnMLFJjvS2oQm6NqGsKeD7NxjL+SjCe6bZbkRJgtL
         4RKQwVeN4Xl2hQZo3ELW4F4Xs6QpFdkvmiuqPpfa6rQ7QH2eVnnP1M/nnk6IOrfqrI9u
         ypAHwwB5TIOTqkCNdLBeOUKZP7rfpjZNxR8Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=szunKijEXv6Oi5Ur3X4bC9MRzV/pKzbZV4r4GAHkBNY=;
        b=ArrT1iY3po1y/lxcplbhPwFrmDLaTPnEILL2geR/LyC7ebpWERb7qUTPNFyWEWNtSP
         q6H7gMxAOPsUadDIWV3UhLSa/wKNur+5VGUqLnClf6nq7/6rp0JWn8lYzCNB0wp+xAf6
         b7QAE9qJ7xJ65R5pubB7Fkm2tiRS5K4dwfbXGPpgVKTfIkH0RPVj3arzvbsaF4QmnP58
         8Wetpri10YIZtDPpmyDYfxPd+o5hEI62g6PSQUqfjEzPijgCdld6CIxSXRKmJu0Bkavm
         anCTSxzzActn5wbCu4hBKGDyJ41owtkTywLRhKBn7C7+/ldHcGn1xrYUWeJypmABzct5
         l+Vw==
X-Gm-Message-State: AOAM533bc+w+DAGTqOXum42nw1kpjlwRIQ6zV8wxvjRkXwY8OQ6u73xZ
        hexqxvyZLVb3XQJJ91uxyqltrn1kXRw=
X-Google-Smtp-Source: ABdhPJyuxmOYDhPH3QVlCnzX7TGgH1yjOH7R1emHg9aNyw2t6pWlA3Ge4DTuqMAMunateeij5IEfhg==
X-Received: by 2002:a17:90b:f0a:: with SMTP id br10mr12838066pjb.77.1595857708308;
        Mon, 27 Jul 2020 06:48:28 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-9402-c547-7ebf-a307.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:9402:c547:7ebf:a307])
        by smtp.gmail.com with ESMTPSA id g13sm15295894pje.29.2020.07.27.06.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 06:48:27 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] powerpc/mm: Remove custom stack expansion checking
In-Reply-To: <20200724092528.1578671-4-mpe@ellerman.id.au>
References: <20200724092528.1578671-1-mpe@ellerman.id.au> <20200724092528.1578671-4-mpe@ellerman.id.au>
Date:   Mon, 27 Jul 2020 23:48:24 +1000
Message-ID: <87tuxtrrvb.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I tested v1 of this. I ran the test from the bug with a range of stack
sizes, in a loop, for several hours and didn't see any crashes/signal
delivery failures.

I retested v2 for a few minutes just to be sure, and I ran stress-ng's
stack, stackmmap and bad-altstack stressors to make sure no obvious
kernel bugs were exposed. Nothing crashed.

All tests done on a P8 LE guest under KVM.

On that basis:

Tested-by: Daniel Axtens <dja@axtens.net>

The more I look at this the less qualified I feel to Review it, but
certainly it looks better than my ugly hack from late last year.

Kind regards,
Daniel

> We have powerpc specific logic in our page fault handling to decide if
> an access to an unmapped address below the stack pointer should expand
> the stack VMA.
>
> The logic aims to prevent userspace from doing bad accesses below the
> stack pointer. However as long as the stack is < 1MB in size, we allow
> all accesses without further checks. Adding some debug I see that I
> can do a full kernel build and LTP run, and not a single process has
> used more than 1MB of stack. So for the majority of processes the
> logic never even fires.
>
> We also recently found a nasty bug in this code which could cause
> userspace programs to be killed during signal delivery. It went
> unnoticed presumably because most processes use < 1MB of stack.
>
> The generic mm code has also grown support for stack guard pages since
> this code was originally written, so the most heinous case of the
> stack expanding into other mappings is now handled for us.
>
> Finally although some other arches have special logic in this path,
> from what I can tell none of x86, arm64, arm and s390 impose any extra
> checks other than those in expand_stack().
>
> So drop our complicated logic and like other architectures just let
> the stack expand as long as its within the rlimit.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/mm/fault.c | 109 ++--------------------------------------
>  1 file changed, 5 insertions(+), 104 deletions(-)
>
> v2: no change just rebased.
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 3ebb1792e636..925a7231abb3 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -42,39 +42,7 @@
>  #include <asm/kup.h>
>  #include <asm/inst.h>
>  
> -/*
> - * Check whether the instruction inst is a store using
> - * an update addressing form which will update r1.
> - */
> -static bool store_updates_sp(struct ppc_inst inst)
> -{
> -	/* check for 1 in the rA field */
> -	if (((ppc_inst_val(inst) >> 16) & 0x1f) != 1)
> -		return false;
> -	/* check major opcode */
> -	switch (ppc_inst_primary_opcode(inst)) {
> -	case OP_STWU:
> -	case OP_STBU:
> -	case OP_STHU:
> -	case OP_STFSU:
> -	case OP_STFDU:
> -		return true;
> -	case OP_STD:	/* std or stdu */
> -		return (ppc_inst_val(inst) & 3) == 1;
> -	case OP_31:
> -		/* check minor opcode */
> -		switch ((ppc_inst_val(inst) >> 1) & 0x3ff) {
> -		case OP_31_XOP_STDUX:
> -		case OP_31_XOP_STWUX:
> -		case OP_31_XOP_STBUX:
> -		case OP_31_XOP_STHUX:
> -		case OP_31_XOP_STFSUX:
> -		case OP_31_XOP_STFDUX:
> -			return true;
> -		}
> -	}
> -	return false;
> -}
> +
>  /*
>   * do_page_fault error handling helpers
>   */
> @@ -267,57 +235,6 @@ static bool bad_kernel_fault(struct pt_regs *regs, unsigned long error_code,
>  	return false;
>  }
>  
> -// This comes from 64-bit struct rt_sigframe + __SIGNAL_FRAMESIZE
> -#define SIGFRAME_MAX_SIZE	(4096 + 128)
> -
> -static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
> -				struct vm_area_struct *vma, unsigned int flags,
> -				bool *must_retry)
> -{
> -	/*
> -	 * N.B. The POWER/Open ABI allows programs to access up to
> -	 * 288 bytes below the stack pointer.
> -	 * The kernel signal delivery code writes a bit over 4KB
> -	 * below the stack pointer (r1) before decrementing it.
> -	 * The exec code can write slightly over 640kB to the stack
> -	 * before setting the user r1.  Thus we allow the stack to
> -	 * expand to 1MB without further checks.
> -	 */
> -	if (address + 0x100000 < vma->vm_end) {
> -		struct ppc_inst __user *nip = (struct ppc_inst __user *)regs->nip;
> -		/* get user regs even if this fault is in kernel mode */
> -		struct pt_regs *uregs = current->thread.regs;
> -		if (uregs == NULL)
> -			return true;
> -
> -		/*
> -		 * A user-mode access to an address a long way below
> -		 * the stack pointer is only valid if the instruction
> -		 * is one which would update the stack pointer to the
> -		 * address accessed if the instruction completed,
> -		 * i.e. either stwu rs,n(r1) or stwux rs,r1,rb
> -		 * (or the byte, halfword, float or double forms).
> -		 *
> -		 * If we don't check this then any write to the area
> -		 * between the last mapped region and the stack will
> -		 * expand the stack rather than segfaulting.
> -		 */
> -		if (address + SIGFRAME_MAX_SIZE >= uregs->gpr[1])
> -			return false;
> -
> -		if ((flags & FAULT_FLAG_WRITE) && (flags & FAULT_FLAG_USER) &&
> -		    access_ok(nip, sizeof(*nip))) {
> -			struct ppc_inst inst;
> -
> -			if (!probe_user_read_inst(&inst, nip))
> -				return !store_updates_sp(inst);
> -			*must_retry = true;
> -		}
> -		return true;
> -	}
> -	return false;
> -}
> -
>  #ifdef CONFIG_PPC_MEM_KEYS
>  static bool access_pkey_error(bool is_write, bool is_exec, bool is_pkey,
>  			      struct vm_area_struct *vma)
> @@ -483,7 +400,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>  	int is_user = user_mode(regs);
>  	int is_write = page_fault_is_write(error_code);
>  	vm_fault_t fault, major = 0;
> -	bool must_retry = false;
>  	bool kprobe_fault = kprobe_page_fault(regs, 11);
>  
>  	if (unlikely(debugger_fault_handler(regs) || kprobe_fault))
> @@ -572,30 +488,15 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>  	vma = find_vma(mm, address);
>  	if (unlikely(!vma))
>  		return bad_area(regs, address);
> -	if (likely(vma->vm_start <= address))
> -		goto good_area;
> -	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
> -		return bad_area(regs, address);
>  
> -	/* The stack is being expanded, check if it's valid */
> -	if (unlikely(bad_stack_expansion(regs, address, vma, flags,
> -					 &must_retry))) {
> -		if (!must_retry)
> +	if (unlikely(vma->vm_start > address)) {
> +		if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
>  			return bad_area(regs, address);
>  
> -		mmap_read_unlock(mm);
> -		if (fault_in_pages_readable((const char __user *)regs->nip,
> -					    sizeof(unsigned int)))
> -			return bad_area_nosemaphore(regs, address);
> -		goto retry;
> +		if (unlikely(expand_stack(vma, address)))
> +			return bad_area(regs, address);
>  	}
>  
> -	/* Try to expand it */
> -	if (unlikely(expand_stack(vma, address)))
> -		return bad_area(regs, address);
> -
> -good_area:
> -
>  #ifdef CONFIG_PPC_MEM_KEYS
>  	if (unlikely(access_pkey_error(is_write, is_exec,
>  				       (error_code & DSISR_KEYFAULT), vma)))
> -- 
> 2.25.1
