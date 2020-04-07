Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D923C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF36520768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqEj5G+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgDGAvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:51:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37424 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGAvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:51:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id u65so8478531pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 17:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=tAw8KW0bFK0Yz8fIQWiF5l2yjocFDcbB0anIbqS6PMQ=;
        b=CqEj5G+G1Sj4eY6jp4z1gwYVVfP3ETQnuFn7UF14pAzWnqbjMtwoznXsx7fbhBZ3xx
         SfE7Wcbx04ZI0XVPq+w0HsmW6uLefMOG6+x/k1RYvEaUjUoTBZ1xMHzuJYN2VfDMo+rN
         xwbW3q//wywrDHb3RgR8RnRdXvYXUfHFmvXA2GjclllReOVuFY3IcPOr6lySEPouZvTI
         SZaWhnsVBPesQsSW59bWFclTF+EZ2amlNN+n38mbG9tssPXWypwA/q2SGOfFgqnfj9HI
         XIHrmdopSuoZ1bTv193cBLOYcZJqpaWksg9cLZ60IFbf5laJuNZjUXuIXybMHqhnZunN
         T98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=tAw8KW0bFK0Yz8fIQWiF5l2yjocFDcbB0anIbqS6PMQ=;
        b=NZiiDCyFchVwkphX1/Yp8BOLWWtiQbRxWIDkAalEs4rGPi55oWMsIg5fGTqtnKtEmS
         DpaSKVNQpcsDKm/BFkRCOB2SR74n1YqKiJ7n4A9UyA1BXKCebUZ3qPoBdOs2bkSBxfYM
         fnCxGejtR7e1DpP6reCucYIG1fnvPJHRfjgaZoyLTdztoUIAZSdC2OUdPDy3NTQUetS4
         M7yEWcbcQzDV/p7ZSmDSNAZM2128/LsqUCsWmIcwYzQKBfF3gNkdaAXyRzFGHAgH5XUk
         IbqMqQ7qxj8uVB8joFYmCecYwTfcSyuveQjS6i0bRQ6Qzq8HGWkzXxlOTAnKiJJePapf
         7m7Q==
X-Gm-Message-State: AGi0PuZjugnzl+CW58zoDrFF0hOMlWWrIZrK1QjqLy8sLDDfJq6dEz0J
        8aHfK2HIfKQAPwFbvbRYryg=
X-Google-Smtp-Source: APiQypJiXLxaPiaqtXc+2hUQni5NRszaSjpfE6ESZh4OGo/SjydSw+b7jjk1VPM3FGSAKr2kgTwqcA==
X-Received: by 2002:a65:670e:: with SMTP id u14mr1842173pgf.264.1586220705440;
        Mon, 06 Apr 2020 17:51:45 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id o15sm11699220pgj.60.2020.04.06.17.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 17:51:44 -0700 (PDT)
Date:   Tue, 07 Apr 2020 10:50:20 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH v3 05/15] powerpc/irq: Add helpers to get and set
 regs->softe
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <5aeaa33383e833f6eca30893fbd188b88e019eaa.1586196948.git.christophe.leroy@c-s.fr>
        <f9f0bd58f9e75e8e3826f25d9db9ff2c6ad9c84b.1586196948.git.christophe.leroy@c-s.fr>
In-Reply-To: <f9f0bd58f9e75e8e3826f25d9db9ff2c6ad9c84b.1586196948.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1586219567.cl8bye6kgu.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy's on April 7, 2020 4:16 am:
> regs->softe doesn't exist on PPC32.
>=20
> Add helpers to get and set regs->softe.
> Those helpers will void on PPC32.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/hw_irq.h | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm=
/hw_irq.h
> index e0e71777961f..e69466867d5f 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -39,6 +39,8 @@
>  #define PACA_IRQ_MUST_HARD_MASK	(PACA_IRQ_EE)
>  #endif
> =20
> +#endif /* CONFIG_PPC64 */
> +
>  /*
>   * flags for paca->irq_soft_mask
>   */
> @@ -47,8 +49,6 @@
>  #define IRQS_PMI_DISABLED	2
>  #define IRQS_ALL_DISABLED	(IRQS_DISABLED | IRQS_PMI_DISABLED)
> =20
> -#endif /* CONFIG_PPC64 */
> -
>  #ifndef __ASSEMBLY__
> =20
>  extern void replay_system_reset(void);
> @@ -282,6 +282,15 @@ extern void irq_set_pending_from_srr1(unsigned long =
srr1);
> =20
>  extern void force_external_irq_replay(void);
> =20
> +static inline unsigned long get_softe(struct pt_regs *regs)
> +{
> +	return regs->softe;
> +}
> +
> +static inline void set_softe(struct pt_regs *regs, unsigned long val)
> +{
> +	regs->softe =3D val;
> +}
>  #else /* CONFIG_PPC64 */
> =20
>  static inline unsigned long arch_local_save_flags(void)
> @@ -350,6 +359,14 @@ static inline bool arch_irq_disabled_regs(struct pt_=
regs *regs)
> =20
>  static inline void may_hard_irq_enable(void) { }
> =20
> +static inline unsigned long get_softe(struct pt_regs *regs)
> +{
> +	return 0;
> +}
> +
> +static inline void set_softe(struct pt_regs *regs, unsigned long val)
> +{
> +}

If this goes into a general shared header, I would prefer if we could
do something a bit more general (at least with the name).

I think get_softe() could just be replaced with arch_irq_disabled_regs().

For set, could we call it irq_soft_mask_regs_set_state()? 32 has no soft
mask state in regs, so it's more obvious that it's a no-op. Or you could
make 32-bit version a BUG(), and then always guard it with IS_ENABLED().

Thanks,
Nick
=
