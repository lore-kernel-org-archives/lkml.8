Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10066C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A9320757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pb9aAJmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgDILuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:50:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41049 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgDILuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:50:04 -0400
Received: by mail-io1-f68.google.com with SMTP id b12so3493438ion.8;
        Thu, 09 Apr 2020 04:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XqP7Ap1vUorR0W4ROT/4/sK/I8YLfCYd/qeR1cdEgE=;
        b=pb9aAJmgSBJLFZELTtD91Tc95hIg9mDY+5kW6+GTYkZaHen2JQf7wzds/IJmGDXHUe
         C5XEesCYKp3GfC6zLjKW6/rvD1Yrj3DHNXFn1DbVZQ8i7epRLwih8GTlFT1vZSK/iYU8
         vlTFysaBrWnf11tqcUfcGUNE46VNhUcf8ztZzk/5FRvhWUb3VEOSNVyBh0nlgN6nh2d8
         YTMQ6vxxVkgVp4cgEPHpp42L2cxkjxsoMNvWzg53KTRQONuKukD05S9tegwhGPsq396I
         FmAQwmI57WYF2vX58i/su/H2kvtQmacL17KBJJy8pNhDaC8XurNV8rGaHkA8bQGfYj5k
         ELYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XqP7Ap1vUorR0W4ROT/4/sK/I8YLfCYd/qeR1cdEgE=;
        b=ASPO49B6wmSm9iVAe2Tzq9BLkM/gYshECuOECmlDZ9ra3LzNf3VI4jb0gVgNHuB+GD
         VSe7Kfh8hN02osjyDKZpwzQjNE4RdEiT9GFqLz1uBpBCiXJXI8OYrU637MIk/uIZHjrf
         XUHxcpwtBpAq8QXdz8cemW1+k6rxMRAEL94GYUg646qs/kp6nufpxek/OIy/MZ4LzVs5
         m95X8ALrTWZqGKz5g1v0BlMll4k3q8Moig/wQhPuJdnkQV+H/4qmMXdfknAX1iOKGG7x
         fvZLHaLnT4000iysc4TPJD/u+BxY3+XuJqCd1HFA2JwGxk6j2GnkGtOUHfTVMud3YwCS
         sZug==
X-Gm-Message-State: AGi0PuYzy2PdlbjhheieVSrC32Pw1AwUL0QIy5/3uhzzGoEwWyjs59lI
        EKR7LATooYnSqrb5wd/v/PTeOlSuyMyfPNyJ76BMtpHaErY=
X-Google-Smtp-Source: APiQypJQhXszQeNXb++KfW2iCUidd5W34HBnZ+kUn+qj+aseYfrFokyXuutDqIhvyASuZlMs6VaFb/5bfk17ypWr05s=
X-Received: by 2002:a6b:5116:: with SMTP id f22mr11568386iob.15.1586433003478;
 Thu, 09 Apr 2020 04:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200408181406.40389-1-alcooperx@gmail.com> <20200408181406.40389-5-alcooperx@gmail.com>
 <CAHp75Vd_nbgwdE5Fbm3oxd_+51BJZ=67sVyjKiN2zLS+J4X-Fw@mail.gmail.com>
In-Reply-To: <CAHp75Vd_nbgwdE5Fbm3oxd_+51BJZ=67sVyjKiN2zLS+J4X-Fw@mail.gmail.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Thu, 9 Apr 2020 07:49:52 -0400
Message-ID: <CAOGqxeXQE0z=+6yuEME48am__2vtJhBpetYd_sZamJmm1h_TLQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] usb: host: Add ability to build new Broadcom STB
 USB drivers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        devicetree <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 5:08 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Apr 9, 2020 at 12:52 AM Al Cooper <alcooperx@gmail.com> wrote:
> >
> > Add the build system changes needed to get the Broadcom STB XHCI,
> > EHCI and OHCI functionality working. The OHCI support does not
> > require anything unique to Broadcom so the standard ohci-platform
> > driver is being used. The link order for XHCI was changed in the
> > Makefile because of the way STB XHCI, EHCI and OHCI controllers
> > share a port which requires that the XHCI driver be initialized
> > first. Also update MAINTAINERS.
>
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3477,6 +3477,14 @@ S:       Supported
> >  F:     drivers/i2c/busses/i2c-brcmstb.c
> >  F:     Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml
> >
> > +BROADCOM BRCMSTB USB EHCI DRIVER
> > +M:     Al Cooper <alcooperx@gmail.com>
> > +L:     linux-usb@vger.kernel.org
> > +L:     bcm-kernel-feedback-list@broadcom.com
> > +S:     Maintained
> > +F:     drivers/usb/host/ehci-brcm.*
> > +F:     Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
>
> This has ordering issues.
> Run parse-maintainer.pl to fix. (Note, it creates by default a new
> file, you might need to run diff manually to see the difference).

I'm not sure what you mean.
I ran "./scripts/parse-maintainers.pl" and did "diff MAINTAINERS
MAINTAINERS.new" and there are no differences in or around my entry.

Al

>
> --
> With Best Regards,
> Andy Shevchenko
