Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FE4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 12:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BE020674
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 12:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="RTA4AbD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgAYMPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 07:15:17 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41985 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgAYMPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 07:15:17 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 484Zhf2j3Nz9sRs;
        Sat, 25 Jan 2020 23:15:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1579954515;
        bh=nB61mmKQ3P/Bh6P9qi8s5DC02swBkMgHUM4/AJusMZ0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RTA4AbD4gSDN2H4g+4/4hKN9q4ND6fzXneYsmv0V7O9TwgYfiz4CgSEvYkJiJXGVV
         5yk/MoCHxdaw+5MoNK7ad3IRaDNr9m5/gmdTo/Jeqzg5vnGjFWTJI1TUYPWQVedCUz
         c4aDuHNiy8pv7qjQMH/NbYtNxDHjFL5JZ3SpgM5B4whskGXRCJsFSqHBoW+SrIzb5n
         FnW5MG/CpoiPmR5H8SIJtR4THSKA0cW30US+zJoA4fFKEoo/huJgXj0hh43ZVUmYD/
         g/LZXgd1PhHBwYLUMkxJuALzBkCOjS1TxJf8vq+XHnJJhhrNwPI/nHXXyXYszBPZ5u
         53MHQnIy+EQvA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32: Add missing context synchronisation with CONFIG_VMAP_STACK
In-Reply-To: <872477f7c7552d3bb7baf0b302398fcd42c5fcfd.1579885334.git.christophe.leroy@c-s.fr>
References: <872477f7c7552d3bb7baf0b302398fcd42c5fcfd.1579885334.git.christophe.leroy@c-s.fr>
Date:   Sat, 25 Jan 2020 23:15:13 +1100
Message-ID: <87r1znhgvi.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> After reactivation of data translation by modifying MSR[DR], a isync
> is required to ensure the translation is effective.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> Rebased on powerpc/merge-test
>
> @mpe: If not too late:
> - change to head_32.h should be squashed into "powerpc/32: prepare for CONFIG_VMAP_STACK"
> - change to head_32.S should be squashed into "powerpc/32s: Enable CONFIG_VMAP_STACK"
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/head_32.S | 1 +
>  arch/powerpc/kernel/head_32.h | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
> index 73a035b40dbf..a6a5fbbf8504 100644
> --- a/arch/powerpc/kernel/head_32.h
> +++ b/arch/powerpc/kernel/head_32.h
> @@ -43,6 +43,7 @@
>  	.ifeq	\for_rtas
>  	li	r11, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
>  	mtmsr	r11
> +	isync

Actually this one leads to:

  /home/michael/linux/arch/powerpc/kernel/head_8xx.S: Assembler messages:
  /home/michael/linux/arch/powerpc/kernel/head_8xx.S:151: Error: attempt to move .org backwards
  make[3]: *** [/home/michael/linux/scripts/Makefile.build:348: arch/powerpc/kernel/head_8xx.o] Error 1

For mpc885_ads_defconfig.

That's the alignment exception overflowing into the program check
handler:

/* Alignment exception */
	. = 0x600
Alignment:
	EXCEPTION_PROLOG handle_dar_dsisr=1
	save_dar_dsisr_on_stack r4, r5, r11
	li	r6, RPN_PATTERN
	mtspr	SPRN_DAR, r6	/* Tag DAR, to be used in DTLB Error */
	addi	r3,r1,STACK_FRAME_OVERHEAD
	EXC_XFER_STD(0x600, alignment_exception)

/* Program check exception */
	EXCEPTION(0x700, ProgramCheck, program_check_exception, EXC_XFER_STD)


Can't see an obvious/easy way to fix it.

cheers

>  	.endif
>  	subi	r11, r1, INT_FRAME_SIZE		/* use r1 if kernel */
>  #else
