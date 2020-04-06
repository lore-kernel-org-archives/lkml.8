Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFD6C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 01:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC88206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 01:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ+PmV5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDFBlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 21:41:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44152 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgDFBlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 21:41:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id b72so6771286pfb.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 18:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=ZjAetnopWdMxGyjnSrN75kk2ay5nqI1VTFapcI0Q71Y=;
        b=jQ+PmV5dBl4ToT38NRk69sBj73w87EirdNztRXfBQppNXYzGLqw3QzPw+pui13r1UO
         U0bsOqCVN5M20WFP1ylKlpYTWn+SVSU81+J2hqnTHG5dbRtl9tNPNDCvAZsImqOdp6pW
         IIWu2yzdlPcdo8FB9/Hg0UQZYxCpPBmdrPiGLIXbG0S/5H93HAlaeE5fPJ/JVO5u60eC
         tTLDIurjTt4FZgYFTvlgRfF7SiPcN8fbmSIncAbc/wD/Kx0cdD4tfjrNIN2COy5CVlBm
         Y5HCFWkKGMvLky19HBsKvbINpbSQln+nDvOVTLhPbyWZ6/j7XUCsahuv5n2UD3kC4DB4
         6IeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=ZjAetnopWdMxGyjnSrN75kk2ay5nqI1VTFapcI0Q71Y=;
        b=SW002OYMD/rsPIa4aBqAg8XjgZbg51gkQeY0ZmuxOlswsaRRJPnJM/XrqpUAMeL51w
         ZTRkzkFSfRqbEetnWOegD3c1ztbISDKLGqdO43pF9r7fAilKBhkVqeKjPOyP6BRl0kXh
         EmDsh7ejr96OzxNJt1rH3w1AiC9/cGcKRj1GaVHuImB8mLTKmtwWywqcBNPtCvaD6Qy9
         svj9Es63UUsUzhw9UsL66T8z4FKdDy37pV0MlRydqRyhsW1CYfHwoQzosPXFLfBKsll8
         4qm1MBAXEZU8RYKKFHVu8YCoK8JDmAHiHjZoCx0KQg/mn1ByqB4nLspY1ADIcofOspso
         xMCQ==
X-Gm-Message-State: AGi0PuaksrarJ3wYhbs6s032f+JXP6RtwbbCy6WIUICejEmYHnExYg8Y
        v0jMMpFcOXjuGEq52J9rB6U=
X-Google-Smtp-Source: APiQypK/otmJxZFUmepB+6PtPtUiBN9QrDEIqmQuG5yWxoWRBkAClAWfcaSUmVnhCGYEl6A5JQi8nA==
X-Received: by 2002:a63:2057:: with SMTP id r23mr19445823pgm.232.1586137313658;
        Sun, 05 Apr 2020 18:41:53 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id i15sm9511571pgc.74.2020.04.05.18.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 18:41:53 -0700 (PDT)
Date:   Mon, 06 Apr 2020 11:40:46 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH v2 01/13] powerpc/radix: Make kuap_check_amr() and
 kuap_restore_amr() generic
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
In-Reply-To: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1586137222.q67h0yqplh.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy's on April 6, 2020 3:44 am:
> In preparation of porting powerpc32 to C syscall entry/exit,
> rename kuap_check_amr() and kuap_restore_amr() as kuap_check()
> and kuap_restore(), and move the stub for when CONFIG_PPC_KUAP is
> not selected in the generic asm/kup.h

I have no problem with this,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/book3s/64/kup-radix.h | 12 ++----------
>  arch/powerpc/include/asm/kup.h                 |  2 ++
>  arch/powerpc/kernel/syscall_64.c               | 10 +++++-----
>  3 files changed, 9 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h b/arch/powerp=
c/include/asm/book3s/64/kup-radix.h
> index 3bcef989a35d..1f2716a0dcd8 100644
> --- a/arch/powerpc/include/asm/book3s/64/kup-radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
> @@ -60,13 +60,13 @@
>  #include <asm/mmu.h>
>  #include <asm/ptrace.h>
> =20
> -static inline void kuap_restore_amr(struct pt_regs *regs)
> +static inline void kuap_restore(struct pt_regs *regs)
>  {
>  	if (mmu_has_feature(MMU_FTR_RADIX_KUAP))
>  		mtspr(SPRN_AMR, regs->kuap);
>  }
> =20
> -static inline void kuap_check_amr(void)
> +static inline void kuap_check(void)
>  {
>  	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG) && mmu_has_feature(MMU_FTR_RADIX_=
KUAP))
>  		WARN_ON_ONCE(mfspr(SPRN_AMR) !=3D AMR_KUAP_BLOCKED);
> @@ -141,14 +141,6 @@ bad_kuap_fault(struct pt_regs *regs, unsigned long a=
ddress, bool is_write)
>  		    (regs->kuap & (is_write ? AMR_KUAP_BLOCK_WRITE : AMR_KUAP_BLOCK_RE=
AD)),
>  		    "Bug: %s fault blocked by AMR!", is_write ? "Write" : "Read");
>  }
> -#else /* CONFIG_PPC_KUAP */
> -static inline void kuap_restore_amr(struct pt_regs *regs)
> -{
> -}
> -
> -static inline void kuap_check_amr(void)
> -{
> -}
>  #endif /* CONFIG_PPC_KUAP */
> =20
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/ku=
p.h
> index 92bcd1a26d73..1100c13b6d9e 100644
> --- a/arch/powerpc/include/asm/kup.h
> +++ b/arch/powerpc/include/asm/kup.h
> @@ -62,6 +62,8 @@ bad_kuap_fault(struct pt_regs *regs, unsigned long addr=
ess, bool is_write)
>  {
>  	return false;
>  }
> +static inline void kuap_restore(struct pt_regs *regs) { }
> +static inline void kuap_check(void) { }
>  #endif /* CONFIG_PPC_KUAP */
> =20
>  static inline void allow_read_from_user(const void __user *from, unsigne=
d long size)
> diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/sysca=
ll_64.c
> index cf06eb443a80..72f3d2f0a823 100644
> --- a/arch/powerpc/kernel/syscall_64.c
> +++ b/arch/powerpc/kernel/syscall_64.c
> @@ -2,7 +2,7 @@
> =20
>  #include <linux/err.h>
>  #include <asm/asm-prototypes.h>
> -#include <asm/book3s/64/kup-radix.h>
> +#include <asm/kup.h>
>  #include <asm/cputime.h>
>  #include <asm/hw_irq.h>
>  #include <asm/kprobes.h>
> @@ -48,7 +48,7 @@ notrace long system_call_exception(long r3, long r4, lo=
ng r5,
>  	}
>  #endif
> =20
> -	kuap_check_amr();
> +	kuap_check();
> =20
>  	/*
>  	 * This is not required for the syscall exit path, but makes the
> @@ -206,7 +206,7 @@ notrace unsigned long syscall_exit_prepare(unsigned l=
ong r3,
>  	local_paca->tm_scratch =3D regs->msr;
>  #endif
> =20
> -	kuap_check_amr();
> +	kuap_check();
> =20
>  	account_cpu_user_exit();
> =20
> @@ -294,7 +294,7 @@ notrace unsigned long interrupt_exit_user_prepare(str=
uct pt_regs *regs, unsigned
>  	local_paca->tm_scratch =3D regs->msr;
>  #endif
> =20
> -	kuap_check_amr();
> +	kuap_check();
> =20
>  	account_cpu_user_exit();
> =20
> @@ -372,7 +372,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(s=
truct pt_regs *regs, unsign
>  	 * We don't need to restore AMR on the way back to userspace for KUAP.
>  	 * The value of AMR only matters while we're in the kernel.
>  	 */
> -	kuap_restore_amr(regs);
> +	kuap_restore(regs);
> =20
>  	return ret;
>  }
> --=20
> 2.25.0
>=20
>=20
=
