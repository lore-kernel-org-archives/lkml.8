Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D901FC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DC620753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVpwsncD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDISPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:15:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37696 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDISPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:15:44 -0400
Received: by mail-io1-f65.google.com with SMTP id n20so530824ioa.4;
        Thu, 09 Apr 2020 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LL3UHibZ+te+7A+uSzs2GWjULtkRzuINzptnfU6LoEo=;
        b=pVpwsncD80U1Vo8ia9pZ/EIwpyB6jWDA1LFtTHdzPhG+PFggIu9xT7DWirMQXBLPvb
         uONSu5B2gHFjWRPVcNH4Y7lAyNfvbDbR+XNpc4f3kIZPCNIB9lO6Bl2mFI6sC2wKDYPN
         Jmt9gIPoVwW9WEkdi6ZVE7PSyBZDTrzDHaC9eGZMC4Du/1odJcs2mIp+sRe+xvVTsSmA
         c6LqudHjmIPcnK0EmbwGnZJt7WuHeUI8VqGyShq35ttOanWgY7xllA5m3KPzFsw4MMnx
         6zR9PxwSVHh503zEcoQG+weKgF7X0M20jHJwW9OOhmeHUMqwnInLweQaxjijxb8SDjyH
         lO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LL3UHibZ+te+7A+uSzs2GWjULtkRzuINzptnfU6LoEo=;
        b=n9XOUsA/MiLfMW8SVmLhzppSBdPMr+7j2s1G2v8eG73+5rs4FG0QowowIb1in0ZtqB
         DfaAM9t/nbiEbtWyWxT72kkW2dECsjMWrMDTwMsyv37/jH0Qps99xapOJsUAZcEWy0rz
         bKkfjKW1VSJnuuGrc0qIFxnRNdjYD+8Mv/hi57y1TW3M4X70eG1MirHvgnre46juykFt
         3cSAoNrO11VcjedW9E5vPB8lpP6un9cLqFrlQ/gM5Y91AKp9JsIkAoF9QdbGxeewYj0e
         0YMZTJQ9IAZ+AYRgigi1Osofo1fz+xYxu2q00Xg/2YgwKflq44Q/DxSOTpjJQAXP2alR
         43KA==
X-Gm-Message-State: AGi0PubAkExVN9pgAFQmJlD0/IGNdXIbg0h/NjD7Tr/FDo0LNafcB/cC
        cGjS2spPUsU7qbcZFr+vgCp+z3zYL0a0lJmlT5g=
X-Google-Smtp-Source: APiQypJVQCvGnxu7nG00aqRlf3SSOvrrDHqAXeb07CR8HgcmHaQ/4QZcfGexyp4Xp6Arr7ZLoLwDE9ymHWIXeKQNlD0=
X-Received: by 2002:a02:ccf4:: with SMTP id l20mr794921jaq.28.1586456143394;
 Thu, 09 Apr 2020 11:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200408181406.40389-1-alcooperx@gmail.com> <20200408181406.40389-5-alcooperx@gmail.com>
 <CAHp75Vd_nbgwdE5Fbm3oxd_+51BJZ=67sVyjKiN2zLS+J4X-Fw@mail.gmail.com>
 <CAOGqxeXQE0z=+6yuEME48am__2vtJhBpetYd_sZamJmm1h_TLQ@mail.gmail.com> <20200409123005.GZ3676135@smile.fi.intel.com>
In-Reply-To: <20200409123005.GZ3676135@smile.fi.intel.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Thu, 9 Apr 2020 14:15:32 -0400
Message-ID: <CAOGqxeUounB5f5oht+d=y+bOiAFe_RM20GUACv2rkL6aR_DV2Q@mail.gmail.com>
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
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 8:30 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Apr 09, 2020 at 07:49:52AM -0400, Alan Cooper wrote:
> > On Thu, Apr 9, 2020 at 5:08 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Thu, Apr 9, 2020 at 12:52 AM Al Cooper <alcooperx@gmail.com> wrote:
> > > >
> > > > Add the build system changes needed to get the Broadcom STB XHCI,
> > > > EHCI and OHCI functionality working. The OHCI support does not
> > > > require anything unique to Broadcom so the standard ohci-platform
> > > > driver is being used. The link order for XHCI was changed in the
> > > > Makefile because of the way STB XHCI, EHCI and OHCI controllers
> > > > share a port which requires that the XHCI driver be initialized
> > > > first. Also update MAINTAINERS.
> > >
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -3477,6 +3477,14 @@ S:       Supported
> > > >  F:     drivers/i2c/busses/i2c-brcmstb.c
> > > >  F:     Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml
> > > >
> > > > +BROADCOM BRCMSTB USB EHCI DRIVER
> > > > +M:     Al Cooper <alcooperx@gmail.com>
> > > > +L:     linux-usb@vger.kernel.org
> > > > +L:     bcm-kernel-feedback-list@broadcom.com
> > > > +S:     Maintained
> > > > +F:     drivers/usb/host/ehci-brcm.*
> > > > +F:     Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
> > >
> > > This has ordering issues.
> > > Run parse-maintainer.pl to fix. (Note, it creates by default a new
> > > file, you might need to run diff manually to see the difference).
> >
> > I'm not sure what you mean.
> > I ran "./scripts/parse-maintainers.pl" and did "diff MAINTAINERS
> > MAINTAINERS.new" and there are no differences in or around my entry.
>
> Perhaps --order should be added.

So you're asking me to swap the following lines?

F:    drivers/usb/host/ehci-brcm.*
F:    Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml

Al

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
