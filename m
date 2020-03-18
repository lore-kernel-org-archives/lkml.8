Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84041C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3232077A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584562428;
	bh=4COnoFw4zZTTnD0icQvz2MrvlZlhqnrg/n8Iz1/EMx4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y8dGe5f3K2PVxsTbIEKot59iRJxvNkXW7t8R3y6oorq/Oc99wc2JCBy+45itFXfl6
	 yUcRsFVMQPK4Er56QgqZjKgTP7wlLctYkTINwejtpYlK59aFaQTvlADkSXztXo8iBR
	 A6tnHCd4f1cwgx2B3/jD2DZn4jLE4gvVVi/GsJao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCRUNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgCRUNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:13:46 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1432020780
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 20:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584562426;
        bh=4COnoFw4zZTTnD0icQvz2MrvlZlhqnrg/n8Iz1/EMx4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hG3NmuBEg/VNJF/IzasJRv+KrhKn+chfwwim8Zb9QBC6PEP9RK7WhXO6Ozcvpoajp
         o2uT+sbqXtoNk9wLw4UdvfiYnCrwx6H8PzyQgeaPmwR321fVuj+8CQWqgSHLDO71Kn
         CsyL8chkBDdoLaUByLk+zYQ6P3dQ0+H8ur6eIKAc=
Received: by mail-qk1-f175.google.com with SMTP id s11so29804831qks.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 13:13:46 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0OLz2Jg3oHXYPj31/DpUOijaAdDw0GhEI2Ey+E02Dj3u4f6hfK
        b+VxKf5V/6M19VpY5YDlg1w2JZnCE66tAYgvpGlTYw==
X-Google-Smtp-Source: ADFU+vv74xrkhSks5Z1lN+CW1yz6xICk4LN6UCwfLkqXNiod5pEmiZcGPF75Cr+JQKJXgdsr8mOh0nXsoF/xtGiZ/nA=
X-Received: by 2002:a37:634d:: with SMTP id x74mr6249300qkb.254.1584562425124;
 Wed, 18 Mar 2020 13:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200313110258.94A0668C4E@verein.lst.de> <20200317221743.GD20788@willie-the-truck>
In-Reply-To: <20200317221743.GD20788@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 18 Mar 2020 16:13:33 -0400
X-Gmail-Original-Message-ID: <CAKv+Gu9_gV0aVwa2QG7jgaR71bTz12vs386R9uPjdQTtm0HcUw@mail.gmail.com>
Message-ID: <CAKv+Gu9_gV0aVwa2QG7jgaR71bTz12vs386R9uPjdQTtm0HcUw@mail.gmail.com>
Subject: Re: [Patch][Fix] crypto: arm{,64} neon: memzero_explicit aes-cbc key
To:     Will Deacon <will@kernel.org>
Cc:     Torsten Duwe <duwe@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 at 18:17, Will Deacon <will@kernel.org> wrote:
>
> [+Ard]
>
> On Fri, Mar 13, 2020 at 12:02:58PM +0100, Torsten Duwe wrote:
> > From: Torsten Duwe <duwe@suse.de>
> >
> > At function exit, do not leave the expanded key in the rk struct
> > which got allocated on the stack.
> >
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > ---
> > Another small fix from our FIPS evaluation. I hope you don't mind I merged
> > arm32 and arm64 into one patch -- this is really simple.
> > --- a/arch/arm/crypto/aes-neonbs-glue.c
> > +++ b/arch/arm/crypto/aes-neonbs-glue.c
> > @@ -138,6 +138,7 @@ static int aesbs_cbc_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
> >       kernel_neon_begin();
> >       aesbs_convert_key(ctx->key.rk, rk.key_enc, ctx->key.rounds);
> >       kernel_neon_end();
> > +     memzero_explicit(&rk, sizeof(rk));
> >
> >       return crypto_cipher_setkey(ctx->enc_tfm, in_key, key_len);
> >  }
> > diff --git a/arch/arm64/crypto/aes-neonbs-glue.c b/arch/arm64/crypto/aes-neonbs-glue.c
> > index e3e27349a9fe..c0b980503643 100644
> > --- a/arch/arm64/crypto/aes-neonbs-glue.c
> > +++ b/arch/arm64/crypto/aes-neonbs-glue.c
> > @@ -151,6 +151,7 @@ static int aesbs_cbc_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
> >       kernel_neon_begin();
> >       aesbs_convert_key(ctx->key.rk, rk.key_enc, ctx->key.rounds);
> >       kernel_neon_end();
> > +     memzero_explicit(&rk, sizeof(rk));
> >
> >       return 0;
> >  }
>
> I'm certainly not a crypto person, but this looks sensible to me and I
> couldn't find any other similar stack variable usage under
> arch/arm64/crypto/ at a quick glance.
>
> Acked-by: Will Deacon <will@kernel.org>
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>
