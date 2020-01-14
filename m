Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ACCC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE47024673
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579039173;
	bh=zJWCWSOhHDeEqNF2yErLCC2xC0maaTa3qYu5FhuOrh8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WNdve/B1SlXbDSZ3MPRo9Zz0UCN3FVb2Is+z3Fu2b+jaVdTpE554+Y+9mVOYm3Bil
	 Ak4c/qna3rJN/7JpGEdXVdpNet1iZBx7GWGufrX0HxBn2Xk7RBKyTM2G84+m7WGnG3
	 Bw4nQ+mHREX+NycG+Os2v0AX0lzNrhS5MkJbJWZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgANV7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:59:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANV7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:59:31 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81C3024673;
        Tue, 14 Jan 2020 21:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579039170;
        bh=zJWCWSOhHDeEqNF2yErLCC2xC0maaTa3qYu5FhuOrh8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MsxBFZ1sSqm0ONGM+VzeO01CT3AFqKClr8dIYzHrYGReVdFEiaOG3tA9Yhj8qpCQo
         8Wx6wN11xc8saLCW00kPko8DwdFnhakLEL6Szm2xnn26iE1a27+dvTAmLLGopZ8p+1
         r/tSFPNF8wX/35xMMEMKTzGE1rWGs0AwxAoeBVG8=
Received: by mail-qv1-f54.google.com with SMTP id dp13so6434035qvb.7;
        Tue, 14 Jan 2020 13:59:30 -0800 (PST)
X-Gm-Message-State: APjAAAWlYbidPYhkwxXxU/qv1qPx7n1xbZOFYDTS4/flLtNuKL0qBOJ1
        7ieAFf82cmyAUACz9OVgt4eBoOJFE7767fSu0g==
X-Google-Smtp-Source: APXvYqwq7E+CYgVOvhkNu4ZwbkCIUECyJO9AoKk6K3ct3z+22Upakg4Zec8xFRF4mmPeyUbM0xZt2DUav5zMOi1Fn3c=
X-Received: by 2002:a0c:f6cd:: with SMTP id d13mr22537735qvo.20.1579039169569;
 Tue, 14 Jan 2020 13:59:29 -0800 (PST)
MIME-Version: 1.0
References: <20191127105522.31445-1-miquel.raynal@bootlin.com>
 <20191127105522.31445-5-miquel.raynal@bootlin.com> <20191209113506.41341ed4@collabora.com>
 <CAL_JsqJP3-h7bPAommzt7KQKoohZpkk=RMxfN1j3rXbisD4eCA@mail.gmail.com> <20200114191052.0a16d116@xps13>
In-Reply-To: <20200114191052.0a16d116@xps13>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Jan 2020 15:59:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLp6++g9ArSm9guuHeywETanCaLvSKVmV3vV5EYfvUDvg@mail.gmail.com>
Message-ID: <CAL_JsqLp6++g9ArSm9guuHeywETanCaLvSKVmV3vV5EYfvUDvg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mtd: Add driver for concatenating devices
To:     Miquel Raynal <miquel.raynal@bootlin.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 12:11 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Rob,
>
> Rob Herring <robh+dt@kernel.org> wrote on Tue, 14 Jan 2020 11:46:18
> -0600:
>
> > On Mon, Dec 9, 2019 at 4:35 AM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > >
> > > On Wed, 27 Nov 2019 11:55:22 +0100
> > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > > Introduce a generic way to define concatenated MTD devices. This may
> > > > be very useful in the case of ie. stacked SPI-NOR. Partitions to
> > > > concatenate are described in an additional property of the partitions
> > > > subnode:
> > > >
> > > >         flash0 {
> > > >                 partitions {
> > > >                         compatible = "fixed-partitions";
> > > >                         part-concat = <&flash0_part1>, <&flash1_part0>;
> > > >
> > > >                       part0@0 {
> > > >                               label = "part0_0";
> > > >                               reg = <0x0 0x800000>;
> > > >                       };
> > > >
> > > >                       flash0_part1: part1@800000 {
> > > >                               label = "part0_1";
> > > >                               reg = <0x800000 0x800000>;
> > >
> > > So, flash0_part1 and flash0_part2 will be created even though the user
> > > probably doesn't need them?
> >
> > I don't follow?
>
> Well, one will have to create "fake" partitions in order to concatenate
> them with this solution, instead of just concatenating the devices (in
> the case where you want to concatenate the entire devices). But the real
> debate is below, on the representation.

So concatenating multiple devices without partitions defined in DT? To
support that, then we need to link flash nodes rather than partition
nodes.

> > > >                       };
> > > >                 };
> > > >         };
> > > >
> > > >         flash1 {
> > > >                 partitions {
> > > >                         compatible = "fixed-partitions";
> > > >
> > > >                       flash0_part1: part1@0 {
> > > >                               label = "part1_0";
> > > >                               reg = <0x0 0x800000>;
> > > >                       };
> > > >
> > > >                       part0@800000 {
> > > >                               label = "part1_1";
> > > >                               reg = <0x800000 0x800000>;
> > > >                       };
> > > >                 };
> > > >         };
> > >
> > > IMHO this representation is far from intuitive. At first glance it's not
> > > obvious which partitions are linked together and what's the name of the
> > > resulting concatenated part. I definitely prefer the solution where we
> > > have a virtual device describing the concatenation. I also understand
> > > that this goes against the #1 DT rule: "DT only decribes HW blocks, not
> > > how they should be used/configured", but maybe we can find a compromise
> > > here, like moving this description to the /chosen node?
> > >
> > > chosen {
> > >         flash-arrays {
> > >                 /*
> > >                  * my-flash-array is the MTD name if label is
> > >                  * not present.
> > >                  */
> > >                 my-flash-array {
> > >                         /*
> > >                          * We could have
> > >                          * compatible = "flash-array";
> > >                          * but we can also do without it.
> > >                          */
> > >                         label = "foo";
> > >                         flashes = <&flash1 &flash2 ...>;
> > >                         partitions {
> > >                                 /* usual partition description. */
> > >                                 ...
> > >                         };
> > >                 };
> > >         };
> > > };
> > >
> > > Rob, what do you think?
> >
> > I don't think chosen is the right place to put all the partition
> > information. It's not something the bootloader configures.
> >
> > This suffers from the same issue I have with the original proposal. It
> > will not work for existing s/w. There's only 1 logical partition that
>
> I don't get why it would not work? Current hardware will just not have
> the concatenation support, that's all. How is this a problem?

No one has multiple flash devices on any h/w already? If I already
have a working system that can load and boot a kernel off an MTD
partition, but could benefit from concatenating other partitions (i.e.
rootfs), why should I have to modify my bootloader(s)?

> > concatenated. The rest of the partitions shouldn't need any special
> > handling. So we really only need some way to say 'link these 2
> > partitions into 1 logical partition'. Though perhaps one could want to
> > combine any number of physical partitions into logical partitions, but
> > then none of the proposals could support that. Then again, maybe
>
> Yes, the flash-array proposal supports having more than two
> partitions/devices concatenated, it is also already supported by the
> driver (you don't care about this, but I do :) ).

I meant for N devices, you'd only have at most N-1 concatenated
partitions as there are N-1 device boundaries. Whereas you could
define any partition could be combined with any other number of
partitions regardless of where they lie. The types of things you can
do with LVM and disk partitions is what I'm thinking of.

> > that's a userspace problem like with disks.
>
> I see one big issue with this solution: what about bootloaders?

Similar to how it works with disks. Bootloaders (at a minimum)
understand physical partitions. Later stages understand logical
partitions.

> The root cause for such idea is that, in my case, the 2 MTD devices are
> too small to contain the images needed to boot. The perfect solution is
> to merge the two devices virtually in one single device and let U-Boot
> read it like one.

Got any actual h/w that the flash devices are smaller than a
kernel+ramdisk yet had the $ and board space to put multiple devices
down?

What about the stages before u-boot? Assume they all use DT, why
require adding this support before a stage that actually needs it.

> I need to have the same representation both in U-Boot and Linux, hence
> a userspace tool and a kernel command line argument do not work, right?

I never said u-boot can't gain support for this, it's just requiring
it to from the start even if you only wanted to have a concatenated
partition for your rootfs or non-boot partition. Only the kernel would
need to understand concatenating partitions vs. every component that
reads the partitions.

Rob
