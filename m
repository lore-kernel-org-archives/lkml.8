Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD41C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0DF207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgANJYk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:24:40 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:43995 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANJYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:24:37 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 09180C0012;
        Tue, 14 Jan 2020 09:24:33 +0000 (UTC)
Date:   Tue, 14 Jan 2020 10:24:32 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Bernhard Frauendienst <kernel@nospam.obeliks.de>
Subject: Re: [PATCH v5 4/4] mtd: Add driver for concatenating devices
Message-ID: <20200114102432.602415a4@xps13>
In-Reply-To: <20191209113506.41341ed4@collabora.com>
References: <20191127105522.31445-1-miquel.raynal@bootlin.com>
        <20191127105522.31445-5-miquel.raynal@bootlin.com>
        <20191209113506.41341ed4@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Boris Brezillon <boris.brezillon@collabora.com> wrote on Mon, 9 Dec
2019 11:35:06 +0100:

> On Wed, 27 Nov 2019 11:55:22 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Introduce a generic way to define concatenated MTD devices. This may
> > be very useful in the case of ie. stacked SPI-NOR. Partitions to
> > concatenate are described in an additional property of the partitions
> > subnode:
> > 
> >         flash0 {
> >                 partitions {
> >                         compatible = "fixed-partitions";
> >                         part-concat = <&flash0_part1>, <&flash1_part0>;
> > 
> > 			part0@0 {
> > 				label = "part0_0";
> > 				reg = <0x0 0x800000>;
> > 			};
> > 
> > 			flash0_part1: part1@800000 {
> > 				label = "part0_1";
> > 				reg = <0x800000 0x800000>;  
> 
> So, flash0_part1 and flash0_part2 will be created even though the user
> probably doesn't need them?
> 
> > 			};
> >                 };
> >         };
> > 
> >         flash1 {
> >                 partitions {
> >                         compatible = "fixed-partitions";
> > 
> > 			flash0_part1: part1@0 {
> > 				label = "part1_0";
> > 				reg = <0x0 0x800000>;
> > 			};
> > 
> > 			part0@800000 {
> > 				label = "part1_1";
> > 				reg = <0x800000 0x800000>;
> > 			};
> >                 };
> >         };  
> 
> IMHO this representation is far from intuitive. At first glance it's not
> obvious which partitions are linked together and what's the name of the
> resulting concatenated part. I definitely prefer the solution where we
> have a virtual device describing the concatenation. I also understand
> that this goes against the #1 DT rule: "DT only decribes HW blocks, not
> how they should be used/configured", but maybe we can find a compromise
> here, like moving this description to the /chosen node?
> 
> chosen {
> 	flash-arrays {
> 		/*
> 		 * my-flash-array is the MTD name if label is
> 		 * not present.
> 		 */
> 		my-flash-array {
> 			/*
> 			 * We could have
> 			 * compatible = "flash-array";
> 			 * but we can also do without it.
> 			 */
> 			label = "foo";
> 			flashes = <&flash1 &flash2 ...>;
> 			partitions {
> 				/* usual partition description. */
> 				...
> 			};
> 		};
> 	};
> };
> 
> Rob, what do you think?

Rob, I would really welcome your thoughts on this solution, having
something like a flash-array node in the /chosen/ node would avoid
creating dummy devices, keep the declarations of the physical nodes
tidy and have a very simple description.

Hope this compromise could fit!
 
> 
> > 
> > This is useful for boards where memory range has been extended with
> > the use of multiple flash chips as memory banks of a single MTD
> > device, with partitions spanning chip borders.
> > 
> > Suggested-by: Bernhard Frauendienst <kernel@nospam.obeliks.de>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
