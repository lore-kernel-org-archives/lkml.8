Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FE3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BFC24656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKteuqhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAVTWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:22:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38441 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVTWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:22:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so266845wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 11:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWpBHT4hqMde43eyJwKJtDhZYAonZRKx3iAocjQUyYo=;
        b=FKteuqhg5IqrDdKVJUufetZplTyyIq1xOfIAB6ZhlcoAH82hqhzC1zPZG2O1j95Pke
         kudDVShcKHguDFB5zWZ97aa+vPOmu1FPqii65xvZ6RNlyuEIrpr72s2jo7mFmuaEgT19
         Vnw5kdo9TvOplFc1H2IrQSsTchWIBTFu70WIyw8xufiucG2keaVlBFd5XssvZA4RLBUY
         oXNSE0pqYQ9g8FlNr88uIJlX3zqdyQrqBDgNOEipKe8u8DJkfIdINunBXHZ5KpWKWP+F
         bHlDfNXtspy/u8qc5zsO5D40d8j7mlvk5/i87z38kCeEKuW1dro6HgCDEH4niM+Z+kTD
         lVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWpBHT4hqMde43eyJwKJtDhZYAonZRKx3iAocjQUyYo=;
        b=SpB6Qt3krXG58WoVAeMBYjMQo29btXmaxlqrMMrGDFBgk8rbTCL5u2golIxf2gMhKy
         lePwZaSTnT0sn10rSOdNMUZe9mXAPBoLi43zJKfDN3BDKAVLYyYk+33oVZC935vDKw4f
         V9QCrbQLt1OVTsORXdL+4vQ83OddpnzQwqu8jht4NjVFsY+0L1oEvrW/BY5C7cTuDoxP
         Flavoynz/f5CEsFjCVoyOxb4GQ/5UEL7uRqs8FrCBVB54DZTlVIb14x7mlmIUCXd9rB7
         rMcd7C7jvuJcQhSTL36hT6YUVz/coRVOxKW8zblFXoWHwwadMvKYZYcV6wfyM2Nns6Ud
         nW7Q==
X-Gm-Message-State: APjAAAWUDgdGX3iJ9erj7IxnDujAgzDhmbZUBJE6I4QnCVpH5vj9kzPl
        T+mjKTMq5uB4itVQuDAU5IkDnNOlqlXtvDQQcJSySg==
X-Google-Smtp-Source: APXvYqwRW+EwzVj5UEPQoOlpO6wziKAlvxhI+CJC5G6xAtmvKCWwe6S4Vibgd8gpmiqNy43iw1yV/iqL2dF22WnIZHU=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr4766627wmk.68.1579720970736;
 Wed, 22 Jan 2020 11:22:50 -0800 (PST)
MIME-Version: 1.0
References: <20200122191430.4888-1-cai@lca.pw> <CAKv+Gu_snhTpsM4cjZ38UhH02v151NW4cJdQu9QVqCWu4rFVZw@mail.gmail.com>
In-Reply-To: <CAKv+Gu_snhTpsM4cjZ38UhH02v151NW4cJdQu9QVqCWu4rFVZw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 22 Jan 2020 20:22:40 +0100
Message-ID: <CAKv+Gu9R40uywfPkq02AGtKAWqvq+63EEOrhGJf5_gY1xfHkNQ@mail.gmail.com>
Subject: Re: [PATCH -next] efi/libstub/x86: fix an EFI server boot failure
To:     Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020 at 20:17, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 22 Jan 2020 at 20:15, Qian Cai <cai@lca.pw> wrote:
> >
> > x86_64 EFI systems are unable to boot due to a typo in the recent commit.
> >
> > EFI config tables not found.
> >  -- System halted
> >
> > Fixes: 796eb8d26a57 ("efi/libstub/x86: Use const attribute for efi_is_64bit()")
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  arch/x86/boot/compressed/eboot.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> > index 82e26d0ff075..287393d725f0 100644
> > --- a/arch/x86/boot/compressed/eboot.c
> > +++ b/arch/x86/boot/compressed/eboot.c
> > @@ -32,7 +32,7 @@ __attribute_const__ bool efi_is_64bit(void)
> >  {
> >         if (IS_ENABLED(CONFIG_EFI_MIXED))
> >                 return efi_is64;
> > -       return IS_ENABLED(CONFIG_X64_64);
> > +       return IS_ENABLED(CONFIG_X86_64);
> >  }
> >
> >  static efi_status_t
>
> Apologies for the breakage - your fix is obviously correct. But I did
> test this code, so I am curious why I didn't see this problem. Are you
> booting via GRUB or from the UEFI shell? Can you share your .config
> please?

Hmm, I guess it is simply the absence of CONFIG_EFI_MIXED=y ...

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Ingo, Thomas, could you drop this into efi/core directly please? Thanks.
