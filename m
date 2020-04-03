Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9799DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D2B2078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585915413;
	bh=qtxzkSL2Q0viebR1oN3Lwqybpq/M+C6FDvjXoXPPmO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=M6OubPR7nYryG8by5RuTgN9wJl61KkNxTjyu/igHUaeRzQvt0clqvgWhyXDd4mh8q
	 wjS5bR5uhh6yZ4TQK8Egf4e6cIPyVUAYew+NjAMADzuG+4jzn0ZUN7j9P+v3kFSAgt
	 2XNn7XaSsO+iGUheLLeM+kwqZot5WlufdbNTclAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390882AbgDCMDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgDCMDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:03:31 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47C6C20737;
        Fri,  3 Apr 2020 12:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585915410;
        bh=qtxzkSL2Q0viebR1oN3Lwqybpq/M+C6FDvjXoXPPmO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zB6HrpamQI1qkFW2xJ7MpYvEKsC1uHZgBGGWOI6S97eG6zJkVp3g54lJzUQxDRd+Z
         R00CcsOaXrQ4i5t77MjNvBl9AyiANiqH5SSsClxghtak65+W62bQwNYGxAi2q4nSbe
         3cZeVbP1HeA1medpwGWCK1RyOubq+ZpKcsqroQu4=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jKL2m-000Ucw-H9; Fri, 03 Apr 2020 13:03:28 +0100
Date:   Fri, 3 Apr 2020 13:03:27 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     =?UTF-8?Q?Lu=C3=ADs?= Matallui <matallui@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Help with IRQ-MSI-IRQ bridges
Message-ID: <20200403130327.6d961882@why>
In-Reply-To: <CAE3PknnmUBPfCjJUxwLaTjAqU4tYXxakvH+qZTwYYyw4SS_DiA@mail.gmail.com>
References: <CAE3Pknn88NZNqiaHahM4HVvTU82hdMcbhGWWb4AyXXYMbcGuaQ@mail.gmail.com>
        <3ebbe879471898218f34918b1d009887@kernel.org>
        <CAE3PknnmUBPfCjJUxwLaTjAqU4tYXxakvH+qZTwYYyw4SS_DiA@mail.gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: matallui@gmail.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Apr 2020 05:13:35 -0600
Lu=C3=ADs Matallui <matallui@gmail.com> wrote:

> Hi Marc,
>=20
> On Fri, 3 Apr 2020 at 04:18, Marc Zyngier <maz@kernel.org> wrote:
> >
> > Hi Luis,
> >
> > On 2020-04-03 02:35, Lu=C3=ADs Matallui wrote: =20
> > > Hi,
> > >
> > > I've got this SoC which uses IRQ-MSI and MSI-IRQ bridges in order to
> > > get interrupts from devices external to the ARM subsystem.
> > > I already got some pointers from Maz and have been able to create the
> > > drivers with the stacked domains and can now see the mappings working
> > > fine across domains.
> > >
> > > Maz pointed me to the Marvell mvebu-gicp (for my MSI controller, a.k.a
> > > MSI-IRQ bridge) and to mvebu-icu for the MSI client (IRQ-MSI bridge).
> > >
> > > I now have the interrupts working, but it seems like I'm missing a
> > > bunch of them. And therefore my device doesn't work properly.
> > > The main difference between my HW and Marvell's is that my IRQs are
> > > not level-triggered and the MSIs don't support the two messages for
> > > level-triggered interrupts. =20
> >
> > Which is probably a very good thing, as long as all your devices
> > generate
> > only edge-triggered interrupts.
> > =20
> > >
> > > To illustrate my system:
> > >
> > > DEV --line--> IRQ-MSI Bridge (MSIC) --msi--> MSI-IRQ Bridge (GICP)
> > > --line--> GICv2
> > >
> > > For MSIC, all I can do is configure the address and data for the MSI,
> > > and I believe on every rising edge of the Device IRQ, an MSI is sent.
> > > For GICP, all I have is a doorbell and a way to enable/disable it, and
> > > whenever the doorbell is enabled and has a value !=3D 0, the IRQ line=
 to
> > > GICv2 gets asserted.
> > >
> > > The first thing I noticed is that when I get an interrupt, the IRQ
> > > flow goes like:
> > >
> > >   handle_irq();
> > >   irq_eoi();
> > >
> > > So, I guess my first question here is, how can I guarantee that I
> > > don't get another MSI whilst in handle_irq()? =20
> >
> > At the GIC level, once the interrupt is Ack'd, anything that is signed
> > after this ack is a separate interrupt. It will be made pending and will
> > fire once the GIC driver EOIs the first one. =20
>=20
> The thing here is, there is no Ack, or at least my irqchips are not getti=
ng
> the irq_ack() callback, which is where I was expecting to clear the doorb=
ell.

Not getting an irq_ack() here is expected, as the GIC uses the fast_eoi
flow, which doesn't use irq_ack() at all. If you really want irq_ack()
to be called, you'll need to change that flow for the specified
interrupts (handle_fasteoi_ack_irq is probably of interest).

>=20
> > =20
> > > If I do, then I will clear the doorbell on irq_eoi() (because that's
> > > my only choice) and will lose the queued IRQs. =20
> >
> > Why do you need to do anything at the doorbell level? This is just a
> > write,
> > so there should be nothing to clear. If you do need to clear anything,
> > then your MSI-IRQ bridge isn't stateless as it should, and you'll need
> > to
> > give much more details about the HW. Do you have a pointer to the TRM
> > for your HW? =20
>=20
> The hardware is really simple. On the MSI controller (GICP) side, each
> interrupt only has 3 registers: 1 status, 1 mask and 1 clear. When an
> MSI lands a write on the status register, it asserts the interrupt line.
> The interrupt stays asserted until we clear the status (using the clear
> register). The mask register is just to enable the interrupt basically.
> The MSI data is really irrelevant, as long as it's non-zero we always
> obtain the same result.

Does it mean it asserts a level each time it gets an edge, and you need
to clear the MSI to allow another one? If so, that's a bit silly. it
would have made a lot more sense to leave it flowing to the GIC where
all the logic is already present.

>=20
> On the MSI client side, we only configure the MSI address and data for
> a certain device interrupt line, and for each rising edge, an MSI gets is=
sued.
>=20
> > =20
> > > It also seems that I'm missing IRQs in the beginning after probing the
> > > device, and before it was working for me when I was setting up all
> > > these registers manually and simply using GICv2 as my only interrupt
> > > controller. =20
> >
> > Well, setting all of this in firmware is always the preferred option
> > if you don't expect things to change dynamically. =20
>=20
> Well, the solution I have now works perfectly for the configuration, beca=
use
> the MSIC gets configured by msi_compose_msg -> msi_write_msg at IRQ
> allocation time and never gets touched again.
>=20
> Then when the IRQ gets activated, the GICP is unmasking the interrupt but
> enabling the doorbell (setting the mask register).
>=20
> The only thing I really need is to intercept every MSI before the handler=
 so
> I can Ack it by clearing the doorbell status register.

See above.

> > > I do see the unmask() ops being called for all my stacked irqchips, so
> > > I don't understand how I'm missing so many interrupts. =20
> >
> > unmask is just a static configuration to enable the interrupt. There
> > shouldn't
> > be that many calls to that later on unless an endpoint driver
> > disables/enables
> > interrupts by hand.
> >
> > Please give us a bit more details to understand the context, as there is
> > only
> > so much I can do with so little HW information.
> >
> > Thanks,
> >
> >          M.
> > --
> > Jazz is not dead. It just smells funny... =20
>=20
> Let me know if that is good enough information. There's really not much on
> the HW side.

If I'm correct above, I'd say there is a bit too much there! ;-)

	M.
--=20
Jazz is not dead. It just smells funny...
