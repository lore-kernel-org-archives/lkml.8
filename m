Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAC8C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B912070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="EAsYCt1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgG0Kuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgG0Kux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:50:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D451AC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 03:50:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i92so1379164pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 03:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=VW4nx3HJC3GTr4WQovKita528C2f+Z4sEHBp51DiCgY=;
        b=EAsYCt1FUA9wRC2Xm6Mr61eF98VtF0g2zcVzKEqN3cDGfLVaPzI9Nk5cUDpKSFvxK4
         ZtDKcdWTL6cBHAAlSgpv7f+lvID904zYcT/xm7Nbc2prZFRj/hBzccoc73aEH0eHyj/D
         yuYD5W7S7xrIUX/squJwiiLAbCXNP5YiE4fjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VW4nx3HJC3GTr4WQovKita528C2f+Z4sEHBp51DiCgY=;
        b=AeIBEUCHJKKUf9Wa1GrsHAjJHNqHa34ue3u4fkNVUD00NNej7xdp5sThSELWuWVlm1
         5yamz6rLUR0wKX/W+L2NTxzsoGUrp0FcRm61Oo7OnTjEfDY89yN+2d7X+2Hy8H4+vWVd
         32FOtSMs339GH2QKrIP8W2/XtwXlocOBOFpE+er2D2SqmdJt17Xya5sR7TPjK4txrbHZ
         2+a2ks/O3QdgNKX09uT9af6pl0OVrW+IDl4Ne5OKzHPXUcnrLqcu/iZ0MWPKCGwg36EA
         QiiaJw8AXH3gUKHBMobimGW/3VS94FQpNoYQedvcOkv0TQbVNZX2s3O/moLosBjXJm4N
         hofg==
X-Gm-Message-State: AOAM5321AWh/G0VPG5kqs2Nh97slEtuLq+6CGkBnDN/aatrlhKpw6VWw
        iPwfvoGUuOYFx91w0eJTnUc8Aj7NMTA=
X-Google-Smtp-Source: ABdhPJwMrxDDDKk2+yIhU7W9PcbeMFTv8yspow6RW4e7rUV/x9YNYINLKac1noepKLENhpYnzOUzWw==
X-Received: by 2002:a17:90a:f996:: with SMTP id cq22mr19692582pjb.208.1595847053266;
        Mon, 27 Jul 2020 03:50:53 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-e189-1479-1117-2b11.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:e189:1479:1117:2b11])
        by smtp.gmail.com with ESMTPSA id 66sm15227419pfg.63.2020.07.27.03.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 03:50:52 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] powerpc: Allow 4224 bytes of stack expansion for the signal frame
In-Reply-To: <20200724092528.1578671-2-mpe@ellerman.id.au>
References: <20200724092528.1578671-1-mpe@ellerman.id.au> <20200724092528.1578671-2-mpe@ellerman.id.au>
Date:   Mon, 27 Jul 2020 20:50:49 +1000
Message-ID: <87y2n5s03a.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I have tested this with the test from the bug and it now seems to pass
fine. On that basis:

Tested-by: Daniel Axtens <dja@axtens.net>

Thank you for coming up with a better solution than my gross hack!

Kind regards,
Daniel

> We have powerpc specific logic in our page fault handling to decide if
> an access to an unmapped address below the stack pointer should expand
> the stack VMA.
>
> The code was originally added in 2004 "ported from 2.4". The rough
> logic is that the stack is allowed to grow to 1MB with no extra
> checking. Over 1MB the access must be within 2048 bytes of the stack
> pointer, or be from a user instruction that updates the stack pointer.
>
> The 2048 byte allowance below the stack pointer is there to cover the
> 288 byte "red zone" as well as the "about 1.5kB" needed by the signal
> delivery code.
>
> Unfortunately since then the signal frame has expanded, and is now
> 4224 bytes on 64-bit kernels with transactional memory enabled. This
> means if a process has consumed more than 1MB of stack, and its stack
> pointer lies less than 4224 bytes from the next page boundary, signal
> delivery will fault when trying to expand the stack and the process
> will see a SEGV.
>
> The total size of the signal frame is the size of struct rt_sigframe
> (which includes the red zone) plus __SIGNAL_FRAMESIZE (128 bytes on
> 64-bit).
>
> The 2048 byte allowance was correct until 2008 as the signal frame
> was:
>
> struct rt_sigframe {
>         struct ucontext    uc;                           /*     0  1440 */
>         /* --- cacheline 11 boundary (1408 bytes) was 32 bytes ago --- */
>         long unsigned int          _unused[2];           /*  1440    16 */
>         unsigned int               tramp[6];             /*  1456    24 */
>         struct siginfo *           pinfo;                /*  1480     8 */
>         void *                     puc;                  /*  1488     8 */
>         struct siginfo     info;                         /*  1496   128 */
>         /* --- cacheline 12 boundary (1536 bytes) was 88 bytes ago --- */
>         char                       abigap[288];          /*  1624   288 */
>
>         /* size: 1920, cachelines: 15, members: 7 */
>         /* padding: 8 */
> };
>
> 1920 + 128 = 2048
>
> Then in commit ce48b2100785 ("powerpc: Add VSX context save/restore,
> ptrace and signal support") (Jul 2008) the signal frame expanded to
> 2304 bytes:
>
> struct rt_sigframe {
>         struct ucontext    uc;                           /*     0  1696 */	<--
>         /* --- cacheline 13 boundary (1664 bytes) was 32 bytes ago --- */
>         long unsigned int          _unused[2];           /*  1696    16 */
>         unsigned int               tramp[6];             /*  1712    24 */
>         struct siginfo *           pinfo;                /*  1736     8 */
>         void *                     puc;                  /*  1744     8 */
>         struct siginfo     info;                         /*  1752   128 */
>         /* --- cacheline 14 boundary (1792 bytes) was 88 bytes ago --- */
>         char                       abigap[288];          /*  1880   288 */
>
>         /* size: 2176, cachelines: 17, members: 7 */
>         /* padding: 8 */
> };
>
> 2176 + 128 = 2304
>
> At this point we should have been exposed to the bug, though as far as
> I know it was never reported. I no longer have a system old enough to
> easily test on.
>
> Then in 2010 commit 320b2b8de126 ("mm: keep a guard page below a
> grow-down stack segment") caused our stack expansion code to never
> trigger, as there was always a VMA found for a write up to PAGE_SIZE
> below r1.
>
> That meant the bug was hidden as we continued to expand the signal
> frame in commit 2b0a576d15e0 ("powerpc: Add new transactional memory
> state to the signal context") (Feb 2013):
>
> struct rt_sigframe {
>         struct ucontext    uc;                           /*     0  1696 */
>         /* --- cacheline 13 boundary (1664 bytes) was 32 bytes ago --- */
>         struct ucontext    uc_transact;                  /*  1696  1696 */	<--
>         /* --- cacheline 26 boundary (3328 bytes) was 64 bytes ago --- */
>         long unsigned int          _unused[2];           /*  3392    16 */
>         unsigned int               tramp[6];             /*  3408    24 */
>         struct siginfo *           pinfo;                /*  3432     8 */
>         void *                     puc;                  /*  3440     8 */
>         struct siginfo     info;                         /*  3448   128 */
>         /* --- cacheline 27 boundary (3456 bytes) was 120 bytes ago --- */
>         char                       abigap[288];          /*  3576   288 */
>
>         /* size: 3872, cachelines: 31, members: 8 */
>         /* padding: 8 */
>         /* last cacheline: 32 bytes */
> };
>
> 3872 + 128 = 4000
>
> And commit 573ebfa6601f ("powerpc: Increase stack redzone for 64-bit
> userspace to 512 bytes") (Feb 2014):
>
> struct rt_sigframe {
>         struct ucontext    uc;                           /*     0  1696 */
>         /* --- cacheline 13 boundary (1664 bytes) was 32 bytes ago --- */
>         struct ucontext    uc_transact;                  /*  1696  1696 */
>         /* --- cacheline 26 boundary (3328 bytes) was 64 bytes ago --- */
>         long unsigned int          _unused[2];           /*  3392    16 */
>         unsigned int               tramp[6];             /*  3408    24 */
>         struct siginfo *           pinfo;                /*  3432     8 */
>         void *                     puc;                  /*  3440     8 */
>         struct siginfo     info;                         /*  3448   128 */
>         /* --- cacheline 27 boundary (3456 bytes) was 120 bytes ago --- */
>         char                       abigap[512];          /*  3576   512 */	<--
>
>         /* size: 4096, cachelines: 32, members: 8 */
>         /* padding: 8 */
> };
>
> 4096 + 128 = 4224
>
> Then finally in 2017, commit 1be7107fbe18 ("mm: larger stack guard
> gap, between vmas") exposed us to the existing bug, because it changed
> the stack VMA to be the correct/real size, meaning our stack expansion
> code is now triggered.
>
> Fix it by increasing the allowance to 4224 bytes.
>
> Hard-coding 4224 is obviously unsafe against future expansions of the
> signal frame in the same way as the existing code. We can't easily use
> sizeof() because the signal frame structure is not in a header. We
> will either fix that, or rip out all the custom stack expansion
> checking logic entirely.
>
> Fixes: ce48b2100785 ("powerpc: Add VSX context save/restore, ptrace and signal support")
> Cc: stable@vger.kernel.org # v2.6.27+
> Reported-by: Tom Lane <tgl@sss.pgh.pa.us>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>
> v2: Account for the extra 128 bytes of __SIGNAL_FRAMESIZE, making the
>     total size 4224, as noticed by dja.
>
> See also https://bugzilla.kernel.org/show_bug.cgi?id=205183
> ---
>  arch/powerpc/mm/fault.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 641fc5f3d7dd..3ebb1792e636 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -267,6 +267,9 @@ static bool bad_kernel_fault(struct pt_regs *regs, unsigned long error_code,
>  	return false;
>  }
>  
> +// This comes from 64-bit struct rt_sigframe + __SIGNAL_FRAMESIZE
> +#define SIGFRAME_MAX_SIZE	(4096 + 128)
> +
>  static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
>  				struct vm_area_struct *vma, unsigned int flags,
>  				bool *must_retry)
> @@ -274,7 +277,7 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
>  	/*
>  	 * N.B. The POWER/Open ABI allows programs to access up to
>  	 * 288 bytes below the stack pointer.
> -	 * The kernel signal delivery code writes up to about 1.5kB
> +	 * The kernel signal delivery code writes a bit over 4KB
>  	 * below the stack pointer (r1) before decrementing it.
>  	 * The exec code can write slightly over 640kB to the stack
>  	 * before setting the user r1.  Thus we allow the stack to
> @@ -299,7 +302,7 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
>  		 * between the last mapped region and the stack will
>  		 * expand the stack rather than segfaulting.
>  		 */
> -		if (address + 2048 >= uregs->gpr[1])
> +		if (address + SIGFRAME_MAX_SIZE >= uregs->gpr[1])
>  			return false;
>  
>  		if ((flags & FAULT_FLAG_WRITE) && (flags & FAULT_FLAG_USER) &&
> -- 
> 2.25.1
