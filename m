Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4D6C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D658C2467C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgANSLB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:11:01 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43143 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANSLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:11:01 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 19A3B240005;
        Tue, 14 Jan 2020 18:10:53 +0000 (UTC)
Date:   Tue, 14 Jan 2020 19:10:52 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Bernhard Frauendienst <kernel@nospam.obeliks.de>
Subject: Re: [PATCH v5 4/4] mtd: Add driver for concatenating devices
Message-ID: <20200114191052.0a16d116@xps13>
In-Reply-To: <CAL_JsqJP3-h7bPAommzt7KQKoohZpkk=RMxfN1j3rXbisD4eCA@mail.gmail.com>
References: <20191127105522.31445-1-miquel.raynal@bootlin.com>
        <20191127105522.31445-5-miquel.raynal@bootlin.com>
        <20191209113506.41341ed4@collabora.com>
        <CAL_JsqJP3-h7bPAommzt7KQKoohZpkk=RMxfN1j3rXbisD4eCA@mail.gmail.com>
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

Rob Herring <robh+dt@kernel.org> wrote on Tue, 14 Jan 2020 11:46:18
-0600:

> On Mon, Dec 9, 2019 at 4:35 AM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Wed, 27 Nov 2019 11:55:22 +0100
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >  
> > > Introduce a generic way to define concatenated MTD devices. This may
> > > be very useful in the case of ie. stacked SPI-NOR. Partitions to
> > > concatenate are described in an additional property of the partitions
> > > subnode:
> > >
> > >         flash0 {
> > >                 partitions {
> > >                         compatible = "fixed-partitions";
> > >                         part-concat = <&flash0_part1>, <&flash1_part0>;
> > >
> > >                       part0@0 {
> > >                               label = "part0_0";
> > >                               reg = <0x0 0x800000>;
> > >                       };
> > >
> > >                       flash0_part1: part1@800000 {
> > >                               label = "part0_1";
> > >                               reg = <0x800000 0x800000>;  
> >
> > So, flash0_part1 and flash0_part2 will be created even though the user
> > probably doesn't need them?  
> 
> I don't follow?

Well, one will have to create "fake" partitions in order to concatenate
them with this solution, instead of just concatenating the devices (in
the case where you want to concatenate the entire devices). But the real
debate is below, on the representation.

> 
> >  
> > >                       };
> > >                 };
> > >         };
> > >
> > >         flash1 {
> > >                 partitions {
> > >                         compatible = "fixed-partitions";
> > >
> > >                       flash0_part1: part1@0 {
> > >                               label = "part1_0";
> > >                               reg = <0x0 0x800000>;
> > >                       };
> > >
> > >                       part0@800000 {
> > >                               label = "part1_1";
> > >                               reg = <0x800000 0x800000>;
> > >                       };
> > >                 };
> > >         };  
> >
> > IMHO this representation is far from intuitive. At first glance it's not
> > obvious which partitions are linked together and what's the name of the
> > resulting concatenated part. I definitely prefer the solution where we
> > have a virtual device describing the concatenation. I also understand
> > that this goes against the #1 DT rule: "DT only decribes HW blocks, not
> > how they should be used/configured", but maybe we can find a compromise
> > here, like moving this description to the /chosen node?
> >
> > chosen {
> >         flash-arrays {
> >                 /*
> >                  * my-flash-array is the MTD name if label is
> >                  * not present.
> >                  */
> >                 my-flash-array {
> >                         /*
> >                          * We could have
> >                          * compatible = "flash-array";
> >                          * but we can also do without it.
> >                          */
> >                         label = "foo";
> >                         flashes = <&flash1 &flash2 ...>;
> >                         partitions {
> >                                 /* usual partition description. */
> >                                 ...
> >                         };
> >                 };
> >         };
> > };
> >
> > Rob, what do you think?  
> 
> I don't think chosen is the right place to put all the partition
> information. It's not something the bootloader configures.
> 
> This suffers from the same issue I have with the original proposal. It
> will not work for existing s/w. There's only 1 logical partition that

I don't get why it would not work? Current hardware will just not have
the concatenation support, that's all. How is this a problem?

> concatenated. The rest of the partitions shouldn't need any special
> handling. So we really only need some way to say 'link these 2
> partitions into 1 logical partition'. Though perhaps one could want to
> combine any number of physical partitions into logical partitions, but
> then none of the proposals could support that. Then again, maybe

Yes, the flash-array proposal supports having more than two
partitions/devices concatenated, it is also already supported by the
driver (you don't care about this, but I do :) ).

> that's a userspace problem like with disks.

I see one big issue with this solution: what about bootloaders?

The root cause for such idea is that, in my case, the 2 MTD devices are
too small to contain the images needed to boot. The perfect solution is
to merge the two devices virtually in one single device and let U-Boot
read it like one.

I need to have the same representation both in U-Boot and Linux, hence
a userspace tool and a kernel command line argument do not work, right?

> To throw out another option, what if the first device contains the
> complete partitions for both devices with some property in one or both
> devices pointing to the other device? That would make the partitions
> in the 1st device still accessible to existing s/w (unless it bounds
> checks the partitions).

From a coding perspective this is very difficult as bound checks are
done everywhere and lying about the boundaries is IMHO a bit complex.

Thanks,
Miquèl
