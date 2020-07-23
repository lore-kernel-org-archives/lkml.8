Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB166C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02FF2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fI9Cze+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgGWRv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWRv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:51:26 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE30AC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:51:25 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id e64so7140561iof.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Dp8barP5vzlP5XS3FVcWPILo1gscVYMo/mw0MIKvTYE=;
        b=fI9Cze+V4UJp94tcq4eh9j+pb8cf3YCt91Qw83uqhHiZrd7+3+4u3wnzCWTN3a6GJO
         +edT5kjdytpPP+oeEFJaoUSHid8sa2hhM8ip+tsamp3IwvRQCweh/PAYqVzAVL6ffGrH
         pjDQSM0M4+NwYirIkslyC/c0pR8aUkM4KHu0tLJtLw6CVNf4CqtOKr/mYlNvgIQMHeLe
         uVoU6v5EEyTGNmOKeLCfgtkhgpM5V799e5AYbFi0owID02q/buKLrAxKiooqvLMtY936
         0jJT2oujH+ndwm8jvwRcrqjrrjr3ExmU1tx67wnR2TREyQiclUBGwoZJ/eodFguJvrhy
         W4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Dp8barP5vzlP5XS3FVcWPILo1gscVYMo/mw0MIKvTYE=;
        b=hhAm8b9S27YZGdCG84dsedmr0ahv2abF2lwACnKSfgaU5rw5WsL3Gdgxy932FKEJ5B
         0WIWTx4hY8AuCesSBbmBnYX0tz9Y762ixBM05AMZFHe5enVnDTaJlPUGfKikyBdMEk1N
         nW6kO5kaG8E+W4IRV90Pnbmo/3mZwx2nHdBoOqbv/dU2tdfT0oG2/KPhSWuAsbymscyU
         GPV4IESGNazCp15LqL+iZJcs0pG9S+Dablg5WO+9yko7MjDtDYomNAEpgTgOxvO9onQl
         klLEQfjW+KhdaeWbgmPwflqY2jcspta8mh0+wr21Ib7/00xgDg4nhq1Y4CARYrt0Mw5R
         VrvA==
X-Gm-Message-State: AOAM530XsNRZNNO7qxnK/f3B+0LPplqX80enfMtrPJwI9QQqcjtXtYBo
        SDNQcneTJlEMWVyoTYPNTDk+e04AlP02+2P7aA4=
X-Google-Smtp-Source: ABdhPJx8g1BHb8SisEPpCfbThq2IBbUifErGVu7IAmKP8PNxOWrWOhNR8o7ggZIGvq6u/xgzxyNyodGG4JiHaiyRY5E=
X-Received: by 2002:a02:9469:: with SMTP id a96mr3273340jai.121.1595526685075;
 Thu, 23 Jul 2020 10:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200723171119.9881-1-sedat.dilek@gmail.com> <6730f39e-120c-9fec-6bee-f210833d91f2@infradead.org>
In-Reply-To: <6730f39e-120c-9fec-6bee-f210833d91f2@infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 23 Jul 2020 19:51:13 +0200
Message-ID: <CA+icZUUsTRyX4yJU1JAu9-Nfc-MeXvw_gbz3_G52ytUpUv0umg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/configs: Remove CONFIG_CRYPTO_AES_586 from i386_defconfig
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 7:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 7/23/20 10:11 AM, Sedat Dilek wrote:
> > Initially CONFIG_CRYPTO_AES_586=y was added to i386_defconfig file
> > with commit c1b362e3b4d3 ("x86: update defconfigs").
> >
> > The code and Kconfig for CONFIG_CRYPTO_AES_586 was removed in:
> >
> > commit 1d2c3279311e4f03fcf164e1366f2fda9f4bfccf
> > ("crypto: x86/aes - drop scalar assembler implementations")
> >
> > Remove the Kconfig relict from i386_defconfig file.
>
>                      relic
>

leftover :-)

https://dict.leo.org/englisch-deutsch/Relikt

> >
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>

Thanks for the review.

- Sedat -

> Thanks.
>
> > ---
> > Changes v1 -> v2:
> > - Add CC to Ard and Herbert (see commit 1d2c3279311e)
> >
> >  arch/x86/configs/i386_defconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
> > index 550904591e94..3a2a89882350 100644
> > --- a/arch/x86/configs/i386_defconfig
> > +++ b/arch/x86/configs/i386_defconfig
> > @@ -290,7 +290,6 @@ CONFIG_SECURITY_NETWORK=y
> >  CONFIG_SECURITY_SELINUX=y
> >  CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> >  CONFIG_SECURITY_SELINUX_DISABLE=y
> > -CONFIG_CRYPTO_AES_586=y
> >  # CONFIG_CRYPTO_ANSI_CPRNG is not set
> >  CONFIG_EFI_STUB=y
> >  CONFIG_ACPI_BGRT=y
> >
>
>
> --
> ~Randy
