Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F468C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F0520678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgHCIgx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:36:53 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37463 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHCIgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:36:53 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 194E3C000A;
        Mon,  3 Aug 2020 08:36:49 +0000 (UTC)
Date:   Mon, 3 Aug 2020 10:36:48 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] mtd: rawnand: ingenic: Limit MTD_NAND_JZ4780 to
 architecture only
Message-ID: <20200803103648.17273c10@xps13>
In-Reply-To: <CAK8P3a3zM4M2y1shVnUYCArZxxf9FHbOkVCK0yAK8wbfQTVChg@mail.gmail.com>
References: <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
        <IBDZDQ.K28R5FAI0BXI2@crapouillou.net>
        <20200724155436.GA7460@kozik-lap>
        <K5Y0EQ.WYAK00ADM46F3@crapouillou.net>
        <CAK8P3a0HDu15u5dREd6gk_e9D6mrZ9JqT0DJs9AeC9C2602nAw@mail.gmail.com>
        <20200726160616.GA2662@kozik-lap>
        <RO33EQ.546WD84D5N7K2@crapouillou.net>
        <20200726161545.GA6058@kozik-lap>
        <B243EQ.VEXGA7ZL5JAE2@crapouillou.net>
        <CAK8P3a1r6AMz2wKBEosAqn7qkuJY4LGFYK7o85sO++d+TSVOgQ@mail.gmail.com>
        <20200727170302.GA3507@kozik-lap>
        <CAK8P3a3zM4M2y1shVnUYCArZxxf9FHbOkVCK0yAK8wbfQTVChg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Arnd Bergmann <arnd@arndb.de> wrote on Mon, 27 Jul 2020 19:28:48 +0200:

> On Mon, Jul 27, 2020 at 7:03 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Mon, Jul 27, 2020 at 09:55:54AM +0200, Arnd Bergmann wrote:  
> > >
> > > The way we do it on Arm, the machine Kconfig identifiers stay around
> > > even for multiplatform targets (which now make up basically actively
> > > maintained machines).
> > >
> > > I don't think it makes any sense for a driver to depend on MIPS_GENERIC:
> > > either it is a generic driver that should always be visible or it is specific
> > > to a set of SoCs and should depend on some corresponding vendor
> > > specific identifiers.  
> >
> > If support for Ingenic is provided also by MIPS_GENERIC (without
> > selecting MACH_INGENIC), then it makes sense. This would be just a
> > different way than ARM of building multi-platform kernel.  
> 
> Yes, it would work just as well, my point was just that it is somewhat
> confusing to have every architecture do it differently, and that I
> prefer the way Arm (and also ppc, x86 etc) handles it today.
> 
> On MIPS, most platforms are not yet part of MIPS_GENERIC, so
> they are fairly free to pick whatever method works best and is
> consistent with the rest of the kernel.

In the end, shall I apply Krzysztof patch or shall I wait for an update
(eg. without 'default y')?

Thanks,
Miquèl
