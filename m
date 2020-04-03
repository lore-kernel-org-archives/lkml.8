Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95C5C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FDA207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIFeEpOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgDCVqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:46:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43373 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgDCVqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 17:46:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id w15so4017936wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 14:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v+iGE8oCdknnpLmOrrqR6BJMhA0bX9IgV8fpeXtQ5J0=;
        b=MIFeEpOzrtF50CYfGfCWVPnqO4KbHC2Sn9NyluzFXcVN9AXY6JcYpMTUfV+XVHje8y
         o4sPQglPkr7+4A/cEHACtRxJKElF7det8wgP18jiG/8WFbg7s44CkizK2rtjxuHkikGL
         rcbQrnHhYhfJ6DcrSBWx2EfnkYj618fAn5QhxDCcyM5R+yrIN9LOgqfnXPecGA1dAKWM
         KjCwCIsyHA2/JAPAV+El0oqGixL8dfe5PvLtvJGtd0JUX+fIFV7ESKCwStaOgAPqdNX2
         X3HMQu0s+9mzyrdipv9lcOuGvA4d7TEjBAQzhu0ikj/F0uKktjgW2JkOeOhdIAb7KaAS
         Qogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v+iGE8oCdknnpLmOrrqR6BJMhA0bX9IgV8fpeXtQ5J0=;
        b=dPUNBMWufsd29ADehCIGwy7lwn9RjZis/RXYZMimFR6TgyRV5ErAj/7Bhu6kh8Embb
         rO+kfy3LSEGExFFmeicA2PmA8g8/2d/1VwK4D6bIeV8feigPgkieFyUUnPqekZTG5DRr
         zz9w0oZRhdloRq8sp2+ZqZpbHdP6XaoN31E7g/htU6h7NqXVw1szjP6yV+SZlZ567HMy
         cXmUa55fmwXwmnCpeH1DS2kTL4XcQFjs/9KAZhuTczjPab1Gliflb4ABJSolr99eg7gP
         jqIqaQua3wNPI7nIEn8c+b+8J0RioBe0d8nnnBCyF97e0q4pe/1akgFz2RR9aGug2wKH
         iqQA==
X-Gm-Message-State: AGi0Pub1WMxe003YOy8aJl3+0MDIorOLcz0ReGRg+TeTY9VUcY3HDVTE
        3yjWtYkOhq6Yn7bqjHRMZTI6bqxB1Fmr9D2VYtE=
X-Google-Smtp-Source: APiQypIvGXoRArWnzY9VhQZKGNTTHUzl+dkL4Yr2T4iVaq5crIPD6a6+IehQ6ZrNo6MUVm2I++obaAfyLqJ+hYKBJtg=
X-Received: by 2002:adf:e48a:: with SMTP id i10mr11745336wrm.71.1585950394605;
 Fri, 03 Apr 2020 14:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAE3Pknn88NZNqiaHahM4HVvTU82hdMcbhGWWb4AyXXYMbcGuaQ@mail.gmail.com>
 <3ebbe879471898218f34918b1d009887@kernel.org> <CAE3PknnmUBPfCjJUxwLaTjAqU4tYXxakvH+qZTwYYyw4SS_DiA@mail.gmail.com>
 <20200403130327.6d961882@why> <CAE3Pknkq3+B=z32ZRsQS1aM1+EqGnysMY4pitFdpOKGmv4ax8Q@mail.gmail.com>
In-Reply-To: <CAE3Pknkq3+B=z32ZRsQS1aM1+EqGnysMY4pitFdpOKGmv4ax8Q@mail.gmail.com>
From:   =?UTF-8?Q?Lu=C3=ADs_Matallui?= <matallui@gmail.com>
Date:   Fri, 3 Apr 2020 15:46:23 -0600
Message-ID: <CAE3Pkn=e5FgvKAxMXWHSPDM7GruSq-udFsb0aAsCQvXs65o8Sg@mail.gmail.com>
Subject: Re: Help with IRQ-MSI-IRQ bridges
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marc,

Just wanted to close this thread and thank you for the help.
Using that handle_fasteoi_ack_irq() saved my life.

I was just having trouble unrelated to this, but some poorly documented SoC=
.

Thanks again!
Luis

On Fri, 3 Apr 2020 at 07:26, Lu=C3=ADs Matallui <matallui@gmail.com> wrote:
>
> On Fri, 3 Apr 2020 at 06:03, Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Fri, 3 Apr 2020 05:13:35 -0600
> > Lu=C3=ADs Matallui <matallui@gmail.com> wrote:
> >
> > > Hi Marc,
> > >
> > > On Fri, 3 Apr 2020 at 04:18, Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > Hi Luis,
> > > >
> > > > On 2020-04-03 02:35, Lu=C3=ADs Matallui wrote:
> > > > > Hi,
> > > > >
> > > > > I've got this SoC which uses IRQ-MSI and MSI-IRQ bridges in order=
 to
> > > > > get interrupts from devices external to the ARM subsystem.
> > > > > I already got some pointers from Maz and have been able to create=
 the
> > > > > drivers with the stacked domains and can now see the mappings wor=
king
> > > > > fine across domains.
> > > > >
> > > > > Maz pointed me to the Marvell mvebu-gicp (for my MSI controller, =
a.k.a
> > > > > MSI-IRQ bridge) and to mvebu-icu for the MSI client (IRQ-MSI brid=
ge).
> > > > >
> > > > > I now have the interrupts working, but it seems like I'm missing =
a
> > > > > bunch of them. And therefore my device doesn't work properly.
> > > > > The main difference between my HW and Marvell's is that my IRQs a=
re
> > > > > not level-triggered and the MSIs don't support the two messages f=
or
> > > > > level-triggered interrupts.
> > > >
> > > > Which is probably a very good thing, as long as all your devices
> > > > generate
> > > > only edge-triggered interrupts.
> > > >
> > > > >
> > > > > To illustrate my system:
> > > > >
> > > > > DEV --line--> IRQ-MSI Bridge (MSIC) --msi--> MSI-IRQ Bridge (GICP=
)
> > > > > --line--> GICv2
> > > > >
> > > > > For MSIC, all I can do is configure the address and data for the =
MSI,
> > > > > and I believe on every rising edge of the Device IRQ, an MSI is s=
ent.
> > > > > For GICP, all I have is a doorbell and a way to enable/disable it=
, and
> > > > > whenever the doorbell is enabled and has a value !=3D 0, the IRQ =
line to
> > > > > GICv2 gets asserted.
> > > > >
> > > > > The first thing I noticed is that when I get an interrupt, the IR=
Q
> > > > > flow goes like:
> > > > >
> > > > >   handle_irq();
> > > > >   irq_eoi();
> > > > >
> > > > > So, I guess my first question here is, how can I guarantee that I
> > > > > don't get another MSI whilst in handle_irq()?
> > > >
> > > > At the GIC level, once the interrupt is Ack'd, anything that is sig=
ned
> > > > after this ack is a separate interrupt. It will be made pending and=
 will
> > > > fire once the GIC driver EOIs the first one.
> > >
> > > The thing here is, there is no Ack, or at least my irqchips are not g=
etting
> > > the irq_ack() callback, which is where I was expecting to clear the d=
oorbell.
> >
> > Not getting an irq_ack() here is expected, as the GIC uses the fast_eoi
> > flow, which doesn't use irq_ack() at all. If you really want irq_ack()
> > to be called, you'll need to change that flow for the specified
> > interrupts (handle_fasteoi_ack_irq is probably of interest).
> >
>
> I had tried level and trigger flow handlers and was always getting weird =
hangs,
> so never even attempted that, but with that handler I do get the Ack call=
s now.
>
> I'm still missing the interrupts, so I'm starting to believe I'm just
> doing something
> else wrong.
>
> > >
> > > >
> > > > > If I do, then I will clear the doorbell on irq_eoi() (because tha=
t's
> > > > > my only choice) and will lose the queued IRQs.
> > > >
> > > > Why do you need to do anything at the doorbell level? This is just =
a
> > > > write,
> > > > so there should be nothing to clear. If you do need to clear anythi=
ng,
> > > > then your MSI-IRQ bridge isn't stateless as it should, and you'll n=
eed
> > > > to
> > > > give much more details about the HW. Do you have a pointer to the T=
RM
> > > > for your HW?
> > >
> > > The hardware is really simple. On the MSI controller (GICP) side, eac=
h
> > > interrupt only has 3 registers: 1 status, 1 mask and 1 clear. When an
> > > MSI lands a write on the status register, it asserts the interrupt li=
ne.
> > > The interrupt stays asserted until we clear the status (using the cle=
ar
> > > register). The mask register is just to enable the interrupt basicall=
y.
> > > The MSI data is really irrelevant, as long as it's non-zero we always
> > > obtain the same result.
> >
> > Does it mean it asserts a level each time it gets an edge, and you need
> > to clear the MSI to allow another one? If so, that's a bit silly. it
> > would have made a lot more sense to leave it flowing to the GIC where
> > all the logic is already present.
>
> Yes! I totally agree this is silly, but I'm pretty sure that's how it
> works. I will
> try to reach out to the SoC team to double check, but from their document=
ation,
> they say the interrupt line will stay asserted as long as the doorbell st=
atus
> value is different than 0, so until we manually clear it, it stays assert=
ed.
>
> > >
> > > On the MSI client side, we only configure the MSI address and data fo=
r
> > > a certain device interrupt line, and for each rising edge, an MSI get=
s issued.
> > >
> > > >
> > > > > It also seems that I'm missing IRQs in the beginning after probin=
g the
> > > > > device, and before it was working for me when I was setting up al=
l
> > > > > these registers manually and simply using GICv2 as my only interr=
upt
> > > > > controller.
> > > >
> > > > Well, setting all of this in firmware is always the preferred optio=
n
> > > > if you don't expect things to change dynamically.
> > >
> > > Well, the solution I have now works perfectly for the configuration, =
because
> > > the MSIC gets configured by msi_compose_msg -> msi_write_msg at IRQ
> > > allocation time and never gets touched again.
> > >
> > > Then when the IRQ gets activated, the GICP is unmasking the interrupt=
 but
> > > enabling the doorbell (setting the mask register).
> > >
> > > The only thing I really need is to intercept every MSI before the han=
dler so
> > > I can Ack it by clearing the doorbell status register.
> >
> > See above.
> >
> > > > > I do see the unmask() ops being called for all my stacked irqchip=
s, so
> > > > > I don't understand how I'm missing so many interrupts.
> > > >
> > > > unmask is just a static configuration to enable the interrupt. Ther=
e
> > > > shouldn't
> > > > be that many calls to that later on unless an endpoint driver
> > > > disables/enables
> > > > interrupts by hand.
> > > >
> > > > Please give us a bit more details to understand the context, as the=
re is
> > > > only
> > > > so much I can do with so little HW information.
> > > >
> > > > Thanks,
> > > >
> > > >          M.
> > > > --
> > > > Jazz is not dead. It just smells funny...
> > >
> > > Let me know if that is good enough information. There's really not mu=
ch on
> > > the HW side.
> >
> > If I'm correct above, I'd say there is a bit too much there! ;-)
> >
> >         M.
> > --
> > Jazz is not dead. It just smells funny...
>
> Thanks again Marc!
> Let me try to reach out to the SoC guys and try to figure out what
> else I'm doing
> wrong. I will give you an update once I figure it out.
>
> -- Luis
