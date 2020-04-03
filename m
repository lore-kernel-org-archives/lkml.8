Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CF1C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDA72077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tziT14oL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403957AbgDCN03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:26:29 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:52317 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDCN03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:26:29 -0400
Received: by mail-wm1-f46.google.com with SMTP id t8so7147090wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4T7Qsj6CynDngOrz2dqSy+OPhg3SW7c6xSuioaWCzGY=;
        b=tziT14oL6c9BGR485nRHP/XS3h0hiTjEngMnrwBE+lP7dt0D1z8Sr0722cArj01bmn
         aMhYi3/vU80wfJpIynPdiSxFyCUOWZs+HChBUDJbiCt4oPwzy3H6Rk6B34D3Owgqmscm
         IGkHcxH+lxwI7auFQzPDzLQfxOsb+gEMBl/Tv0l/4k56X24GbS/xIOcyV9o9dbfVu6k9
         xrXRtmdHZ8S0Ony/3Ae+H5PpHgTASsf6fWk5AiSpmHjvH3h3UILoluqa7onL8BlCEPex
         BgmYKVvtqXico7G4o33SwJOuFb3OLccnMgaMdIlwou8fE7hnn/NOUUUWOr3pvAdFnnZC
         M1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4T7Qsj6CynDngOrz2dqSy+OPhg3SW7c6xSuioaWCzGY=;
        b=AkwQVXRR7sTRcZlEv1AjgWNw1Imcjq3TlNYBUhDL4F597EKbNw1dCMpHvFlY8zieLv
         ldNA/I52Q4xd0ngSldfcXqIxpMI8oIelERseK+njZDsaXdo/0j/BYy72KjXe2dOI8SgW
         SGGXX/1kfpl/l6XKA4SiKCK92UfGgZp8+FgP1x2SW8xj2YdjbB08jtMJa8XpNPz/X8LS
         MWVvl0BL/SgeSFHe8rzvGs4GdVI6xkAbrGyalF1PGSM24LAYkX65xrqeG/dFpAFeNhkR
         xYnxBaHTudyjbP9pgQGpXKi3wcGv0sWCtf7UXMI6hElZhViKejrdBPaNPGqufoKseb3v
         uolw==
X-Gm-Message-State: AGi0PuarSsi1ly87AHhYr+wJiP3N0f+FiucgdvJhGw3KRAGzeqlpROFD
        9W6pGW0YlVcoHU0GDXRB+U7HtzwRl2Rph1XeqldgKg==
X-Google-Smtp-Source: APiQypIu19HlIJv7Eh7E90o50MZ433hYtWyLCKq8HZfpTO7aVP2fTzRiTdccIcYofhUYSYsEKBWDr9cOIgreHhBy7+U=
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr8765538wmj.139.1585920386194;
 Fri, 03 Apr 2020 06:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAE3Pknn88NZNqiaHahM4HVvTU82hdMcbhGWWb4AyXXYMbcGuaQ@mail.gmail.com>
 <3ebbe879471898218f34918b1d009887@kernel.org> <CAE3PknnmUBPfCjJUxwLaTjAqU4tYXxakvH+qZTwYYyw4SS_DiA@mail.gmail.com>
 <20200403130327.6d961882@why>
In-Reply-To: <20200403130327.6d961882@why>
From:   =?UTF-8?Q?Lu=C3=ADs_Matallui?= <matallui@gmail.com>
Date:   Fri, 3 Apr 2020 07:26:15 -0600
Message-ID: <CAE3Pknkq3+B=z32ZRsQS1aM1+EqGnysMY4pitFdpOKGmv4ax8Q@mail.gmail.com>
Subject: Re: Help with IRQ-MSI-IRQ bridges
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Apr 2020 at 06:03, Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 3 Apr 2020 05:13:35 -0600
> Lu=C3=ADs Matallui <matallui@gmail.com> wrote:
>
> > Hi Marc,
> >
> > On Fri, 3 Apr 2020 at 04:18, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > Hi Luis,
> > >
> > > On 2020-04-03 02:35, Lu=C3=ADs Matallui wrote:
> > > > Hi,
> > > >
> > > > I've got this SoC which uses IRQ-MSI and MSI-IRQ bridges in order t=
o
> > > > get interrupts from devices external to the ARM subsystem.
> > > > I already got some pointers from Maz and have been able to create t=
he
> > > > drivers with the stacked domains and can now see the mappings worki=
ng
> > > > fine across domains.
> > > >
> > > > Maz pointed me to the Marvell mvebu-gicp (for my MSI controller, a.=
k.a
> > > > MSI-IRQ bridge) and to mvebu-icu for the MSI client (IRQ-MSI bridge=
).
> > > >
> > > > I now have the interrupts working, but it seems like I'm missing a
> > > > bunch of them. And therefore my device doesn't work properly.
> > > > The main difference between my HW and Marvell's is that my IRQs are
> > > > not level-triggered and the MSIs don't support the two messages for
> > > > level-triggered interrupts.
> > >
> > > Which is probably a very good thing, as long as all your devices
> > > generate
> > > only edge-triggered interrupts.
> > >
> > > >
> > > > To illustrate my system:
> > > >
> > > > DEV --line--> IRQ-MSI Bridge (MSIC) --msi--> MSI-IRQ Bridge (GICP)
> > > > --line--> GICv2
> > > >
> > > > For MSIC, all I can do is configure the address and data for the MS=
I,
> > > > and I believe on every rising edge of the Device IRQ, an MSI is sen=
t.
> > > > For GICP, all I have is a doorbell and a way to enable/disable it, =
and
> > > > whenever the doorbell is enabled and has a value !=3D 0, the IRQ li=
ne to
> > > > GICv2 gets asserted.
> > > >
> > > > The first thing I noticed is that when I get an interrupt, the IRQ
> > > > flow goes like:
> > > >
> > > >   handle_irq();
> > > >   irq_eoi();
> > > >
> > > > So, I guess my first question here is, how can I guarantee that I
> > > > don't get another MSI whilst in handle_irq()?
> > >
> > > At the GIC level, once the interrupt is Ack'd, anything that is signe=
d
> > > after this ack is a separate interrupt. It will be made pending and w=
ill
> > > fire once the GIC driver EOIs the first one.
> >
> > The thing here is, there is no Ack, or at least my irqchips are not get=
ting
> > the irq_ack() callback, which is where I was expecting to clear the doo=
rbell.
>
> Not getting an irq_ack() here is expected, as the GIC uses the fast_eoi
> flow, which doesn't use irq_ack() at all. If you really want irq_ack()
> to be called, you'll need to change that flow for the specified
> interrupts (handle_fasteoi_ack_irq is probably of interest).
>

I had tried level and trigger flow handlers and was always getting weird ha=
ngs,
so never even attempted that, but with that handler I do get the Ack calls =
now.

I'm still missing the interrupts, so I'm starting to believe I'm just
doing something
else wrong.

> >
> > >
> > > > If I do, then I will clear the doorbell on irq_eoi() (because that'=
s
> > > > my only choice) and will lose the queued IRQs.
> > >
> > > Why do you need to do anything at the doorbell level? This is just a
> > > write,
> > > so there should be nothing to clear. If you do need to clear anything=
,
> > > then your MSI-IRQ bridge isn't stateless as it should, and you'll nee=
d
> > > to
> > > give much more details about the HW. Do you have a pointer to the TRM
> > > for your HW?
> >
> > The hardware is really simple. On the MSI controller (GICP) side, each
> > interrupt only has 3 registers: 1 status, 1 mask and 1 clear. When an
> > MSI lands a write on the status register, it asserts the interrupt line=
.
> > The interrupt stays asserted until we clear the status (using the clear
> > register). The mask register is just to enable the interrupt basically.
> > The MSI data is really irrelevant, as long as it's non-zero we always
> > obtain the same result.
>
> Does it mean it asserts a level each time it gets an edge, and you need
> to clear the MSI to allow another one? If so, that's a bit silly. it
> would have made a lot more sense to leave it flowing to the GIC where
> all the logic is already present.

Yes! I totally agree this is silly, but I'm pretty sure that's how it
works. I will
try to reach out to the SoC team to double check, but from their documentat=
ion,
they say the interrupt line will stay asserted as long as the doorbell stat=
us
value is different than 0, so until we manually clear it, it stays asserted=
.

> >
> > On the MSI client side, we only configure the MSI address and data for
> > a certain device interrupt line, and for each rising edge, an MSI gets =
issued.
> >
> > >
> > > > It also seems that I'm missing IRQs in the beginning after probing =
the
> > > > device, and before it was working for me when I was setting up all
> > > > these registers manually and simply using GICv2 as my only interrup=
t
> > > > controller.
> > >
> > > Well, setting all of this in firmware is always the preferred option
> > > if you don't expect things to change dynamically.
> >
> > Well, the solution I have now works perfectly for the configuration, be=
cause
> > the MSIC gets configured by msi_compose_msg -> msi_write_msg at IRQ
> > allocation time and never gets touched again.
> >
> > Then when the IRQ gets activated, the GICP is unmasking the interrupt b=
ut
> > enabling the doorbell (setting the mask register).
> >
> > The only thing I really need is to intercept every MSI before the handl=
er so
> > I can Ack it by clearing the doorbell status register.
>
> See above.
>
> > > > I do see the unmask() ops being called for all my stacked irqchips,=
 so
> > > > I don't understand how I'm missing so many interrupts.
> > >
> > > unmask is just a static configuration to enable the interrupt. There
> > > shouldn't
> > > be that many calls to that later on unless an endpoint driver
> > > disables/enables
> > > interrupts by hand.
> > >
> > > Please give us a bit more details to understand the context, as there=
 is
> > > only
> > > so much I can do with so little HW information.
> > >
> > > Thanks,
> > >
> > >          M.
> > > --
> > > Jazz is not dead. It just smells funny...
> >
> > Let me know if that is good enough information. There's really not much=
 on
> > the HW side.
>
> If I'm correct above, I'd say there is a bit too much there! ;-)
>
>         M.
> --
> Jazz is not dead. It just smells funny...

Thanks again Marc!
Let me try to reach out to the SoC guys and try to figure out what
else I'm doing
wrong. I will give you an update once I figure it out.

-- Luis
