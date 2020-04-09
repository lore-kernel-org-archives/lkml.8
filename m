Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6B2C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DAF20757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icaxSU3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDISr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:47:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38353 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgDISr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:47:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id w3so4151389plz.5;
        Thu, 09 Apr 2020 11:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZDdniR7NTevPMDr1trPdIDslAxCkIb8J3cWVjAJceyA=;
        b=icaxSU3owH1flf3ySVGW8jbknL98eJpTQhRfkvzKZyhtl2WOsWW0D7Qw/I13o35OoH
         Xd0Q7g25IkBHotzhIOdvOSrU6fPrxM5Bj84Wchnpol2LH4wfht3vPQP2mi9HYNMFytgK
         xyMJbeQC5Fmn15md2cZOlIZBHHYdOZ3PN5qNGnhGTb55XbCZJL4ugoJyc5N2TZtGG9ne
         5SFsgAawRJKIB07MEyyPSRLXxRR9j2AeKlz5LmV00kN7CmL5IS5s0arFGwQNOmxaT08e
         NSqbU+vK4WRg6FbIHFUvoUwOKfnKKGOKe0A6hvUGr8B8pMK5xZfhFng4zA4SUIW//b/p
         x23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDdniR7NTevPMDr1trPdIDslAxCkIb8J3cWVjAJceyA=;
        b=EgfuEWRe890XoEnM+Wiwuvzz07lSgr1q79Q46P6i2TKEvmIUcdbrY4cH3grVkixFUn
         Eyjvt0auVe+rwm4E/1LP5J15P9HAbBtSRs7+HhDxVqfx1pO1uPNkUn9djFtS5f5Nt6Pt
         3ti+SEvmMTl2Pt2KlE9wSadzNGivEPevr1oMm5Wq3z0qTU9UTvt7oUPCr+bzbwnfK77R
         AER7lY8ei+29bJt/oR5hsRKNQov8XOz8tz3jWN8YBJH06D1XVuuQp+i9w+9hiqiPlh1A
         5O4OOy7KIZ6i2drwHIoFRlejClvmSokCPYVREKHIscC/+tbO2uVlIs480lyDLHL/Bjh/
         JmZg==
X-Gm-Message-State: AGi0PuZ/Z+esajIwUUnaDtb5cBUkXi19Or1m1zvDlT3FYOQESNdPF5JJ
        LsQokjJEJ8bgBs1OUAlBMEOnu44GojCyixsIr7A=
X-Google-Smtp-Source: APiQypIYTyu3DqCydfYcHdeX232tss9x+b0H5x2b1rs5sl8bYFrA6BUqpEbRPu1ngw+ImtFsojTUXW5qy6HYr9GUwiE=
X-Received: by 2002:a17:902:b190:: with SMTP id s16mr970782plr.262.1586458077427;
 Thu, 09 Apr 2020 11:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200408181406.40389-1-alcooperx@gmail.com> <20200408181406.40389-5-alcooperx@gmail.com>
 <CAHp75Vd_nbgwdE5Fbm3oxd_+51BJZ=67sVyjKiN2zLS+J4X-Fw@mail.gmail.com>
 <CAOGqxeXQE0z=+6yuEME48am__2vtJhBpetYd_sZamJmm1h_TLQ@mail.gmail.com>
 <20200409123005.GZ3676135@smile.fi.intel.com> <CAOGqxeUounB5f5oht+d=y+bOiAFe_RM20GUACv2rkL6aR_DV2Q@mail.gmail.com>
In-Reply-To: <CAOGqxeUounB5f5oht+d=y+bOiAFe_RM20GUACv2rkL6aR_DV2Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Apr 2020 21:47:50 +0300
Message-ID: <CAHp75VfjeY+0KRS92RC_rRayAu2piCSjMHG1mMVwVkgw9XWN8g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] usb: host: Add ability to build new Broadcom STB
 USB drivers
To:     Alan Cooper <alcooperx@gmail.com>
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

On Thu, Apr 9, 2020 at 9:15 PM Alan Cooper <alcooperx@gmail.com> wrote:
> On Thu, Apr 9, 2020 at 8:30 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Apr 09, 2020 at 07:49:52AM -0400, Alan Cooper wrote:
> > > On Thu, Apr 9, 2020 at 5:08 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Thu, Apr 9, 2020 at 12:52 AM Al Cooper <alcooperx@gmail.com> wrote:

> > > > > +BROADCOM BRCMSTB USB EHCI DRIVER
> > > > > +M:     Al Cooper <alcooperx@gmail.com>
> > > > > +L:     linux-usb@vger.kernel.org
> > > > > +L:     bcm-kernel-feedback-list@broadcom.com
> > > > > +S:     Maintained
> > > > > +F:     drivers/usb/host/ehci-brcm.*
> > > > > +F:     Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
> > > >
> > > > This has ordering issues.
> > > > Run parse-maintainer.pl to fix. (Note, it creates by default a new
> > > > file, you might need to run diff manually to see the difference).
> > >
> > > I'm not sure what you mean.
> > > I ran "./scripts/parse-maintainers.pl" and did "diff MAINTAINERS
> > > MAINTAINERS.new" and there are no differences in or around my entry.
> >
> > Perhaps --order should be added.
>
> So you're asking me to swap the following lines?
>
> F:    drivers/usb/host/ehci-brcm.*
> F:    Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml

Yes, that is correct.

-- 
With Best Regards,
Andy Shevchenko
