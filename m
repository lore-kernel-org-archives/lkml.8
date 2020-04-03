Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B0FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD54208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSIUF3zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390728AbgDCLNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:13:49 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:35228 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgDCLNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:13:48 -0400
Received: by mail-wr1-f43.google.com with SMTP id g3so5745123wrx.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 04:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JvWqGNGSWU6DWrsOHOFKdACpD+bY4oqNaVseQCkk5wY=;
        b=qSIUF3zGi9tV3IrF1qe82YGqzafnUkfe/mm+KL59FIbShzEdN2pLPv2S7/ANxsUC/Z
         gR0ENOe+P6wpalquOb7E6clVPjAxAmkuv3b0r1MdZ0PTNwrpb7FEXsu05Tr/8gwUDWZp
         esPfXBSgQD+qwhI0epBNbG6RYiwfKIlDtONttjwfjEq/9ZaAWHKTVoIYVbV4r8prlVAw
         nhXwgy/1nB5lqGW9yxv4pCsfyt3maUZwLE+YAz79JCTLTW6ofF3UZX7efDwNJHYmWOrm
         q9OFeRWLP+3g7vbSMR7dhKetiqpJPNnO2cIsikLujJ23xRrdr9TQ6HNdwKff61JcmTyT
         E0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JvWqGNGSWU6DWrsOHOFKdACpD+bY4oqNaVseQCkk5wY=;
        b=fdVfOV0XyPlVLx1nwcwVrZKDZRZa1y+Kbh4aFzIZ7QOafQTPuFyQ0OW1BAVZ8f+rvl
         qME/dsAWxIyI+NYnQNxXS5MsF2ROrXnzA/RKNq+62B0I4iQ3m2X9MMzW1NSgc8p1GMRs
         BV2kpbF/8WPATveW/ZJjRhDwsHVfLM3HofDs+HgDfVao/QnXixdJFbvJSxE0SeK3JfNM
         7Hb6f69ixPXrUaNlicOEsKvS7gamZ17FjeCzoYb9U9MZnHmL5vJLdTQp3OguiSDd1USK
         OMRMVJVWECmQC+vlIz1nXUUazmDsbqVSUBxwwhzXJ2hXDCoKw1kAuixYEucRRcXhGz50
         JiQA==
X-Gm-Message-State: AGi0PubBpSIUD0IIBIn4PV94PC84Y4UHicpLaJgkDn6fKfR2J3SWGwhY
        6mwu0cn/ObLXroI2z4ibxEfm/XXBJeQQZN3TcyxDJw==
X-Google-Smtp-Source: APiQypKezTBkDczLILhhJ22RcepOC/B/eMarN+9FRJfBE2r0g2OFDw/G+h7DRbHaIiKhEIaViQdrn9BAPqsAwmg5e8U=
X-Received: by 2002:adf:ff8b:: with SMTP id j11mr8958919wrr.117.1585912425936;
 Fri, 03 Apr 2020 04:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAE3Pknn88NZNqiaHahM4HVvTU82hdMcbhGWWb4AyXXYMbcGuaQ@mail.gmail.com>
 <3ebbe879471898218f34918b1d009887@kernel.org>
In-Reply-To: <3ebbe879471898218f34918b1d009887@kernel.org>
From:   =?UTF-8?Q?Lu=C3=ADs_Matallui?= <matallui@gmail.com>
Date:   Fri, 3 Apr 2020 05:13:35 -0600
Message-ID: <CAE3PknnmUBPfCjJUxwLaTjAqU4tYXxakvH+qZTwYYyw4SS_DiA@mail.gmail.com>
Subject: Re: Help with IRQ-MSI-IRQ bridges
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Fri, 3 Apr 2020 at 04:18, Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Luis,
>
> On 2020-04-03 02:35, Lu=C3=ADs Matallui wrote:
> > Hi,
> >
> > I've got this SoC which uses IRQ-MSI and MSI-IRQ bridges in order to
> > get interrupts from devices external to the ARM subsystem.
> > I already got some pointers from Maz and have been able to create the
> > drivers with the stacked domains and can now see the mappings working
> > fine across domains.
> >
> > Maz pointed me to the Marvell mvebu-gicp (for my MSI controller, a.k.a
> > MSI-IRQ bridge) and to mvebu-icu for the MSI client (IRQ-MSI bridge).
> >
> > I now have the interrupts working, but it seems like I'm missing a
> > bunch of them. And therefore my device doesn't work properly.
> > The main difference between my HW and Marvell's is that my IRQs are
> > not level-triggered and the MSIs don't support the two messages for
> > level-triggered interrupts.
>
> Which is probably a very good thing, as long as all your devices
> generate
> only edge-triggered interrupts.
>
> >
> > To illustrate my system:
> >
> > DEV --line--> IRQ-MSI Bridge (MSIC) --msi--> MSI-IRQ Bridge (GICP)
> > --line--> GICv2
> >
> > For MSIC, all I can do is configure the address and data for the MSI,
> > and I believe on every rising edge of the Device IRQ, an MSI is sent.
> > For GICP, all I have is a doorbell and a way to enable/disable it, and
> > whenever the doorbell is enabled and has a value !=3D 0, the IRQ line t=
o
> > GICv2 gets asserted.
> >
> > The first thing I noticed is that when I get an interrupt, the IRQ
> > flow goes like:
> >
> >   handle_irq();
> >   irq_eoi();
> >
> > So, I guess my first question here is, how can I guarantee that I
> > don't get another MSI whilst in handle_irq()?
>
> At the GIC level, once the interrupt is Ack'd, anything that is signed
> after this ack is a separate interrupt. It will be made pending and will
> fire once the GIC driver EOIs the first one.

The thing here is, there is no Ack, or at least my irqchips are not getting
the irq_ack() callback, which is where I was expecting to clear the doorbel=
l.

>
> > If I do, then I will clear the doorbell on irq_eoi() (because that's
> > my only choice) and will lose the queued IRQs.
>
> Why do you need to do anything at the doorbell level? This is just a
> write,
> so there should be nothing to clear. If you do need to clear anything,
> then your MSI-IRQ bridge isn't stateless as it should, and you'll need
> to
> give much more details about the HW. Do you have a pointer to the TRM
> for your HW?

The hardware is really simple. On the MSI controller (GICP) side, each
interrupt only has 3 registers: 1 status, 1 mask and 1 clear. When an
MSI lands a write on the status register, it asserts the interrupt line.
The interrupt stays asserted until we clear the status (using the clear
register). The mask register is just to enable the interrupt basically.
The MSI data is really irrelevant, as long as it's non-zero we always
obtain the same result.

On the MSI client side, we only configure the MSI address and data for
a certain device interrupt line, and for each rising edge, an MSI gets issu=
ed.

>
> > It also seems that I'm missing IRQs in the beginning after probing the
> > device, and before it was working for me when I was setting up all
> > these registers manually and simply using GICv2 as my only interrupt
> > controller.
>
> Well, setting all of this in firmware is always the preferred option
> if you don't expect things to change dynamically.

Well, the solution I have now works perfectly for the configuration, becaus=
e
the MSIC gets configured by msi_compose_msg -> msi_write_msg at IRQ
allocation time and never gets touched again.

Then when the IRQ gets activated, the GICP is unmasking the interrupt but
enabling the doorbell (setting the mask register).

The only thing I really need is to intercept every MSI before the handler s=
o
I can Ack it by clearing the doorbell status register.

>
> > I do see the unmask() ops being called for all my stacked irqchips, so
> > I don't understand how I'm missing so many interrupts.
>
> unmask is just a static configuration to enable the interrupt. There
> shouldn't
> be that many calls to that later on unless an endpoint driver
> disables/enables
> interrupts by hand.
>
> Please give us a bit more details to understand the context, as there is
> only
> so much I can do with so little HW information.
>
> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...

Let me know if that is good enough information. There's really not much on
the HW side.

Thanks,
Luis
