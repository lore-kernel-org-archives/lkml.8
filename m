Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C37C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28F520716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgA2Ngm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:36:42 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50835 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgA2Ngm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:36:42 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 04BF160002;
        Wed, 29 Jan 2020 13:36:39 +0000 (UTC)
Date:   Wed, 29 Jan 2020 14:36:39 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: How to handle write-protect pin of NAND device ?
Message-ID: <20200129143639.7f80addb@xps13>
In-Reply-To: <CAK7LNAQyK+jy4pm5M5z58uD5Zdv95Day6C6D3Gwvpv2C4Vh53Q@mail.gmail.com>
References: <CAK7LNAR0FemABUg5uN5fhy5LRsOm7n5GhmFVVHE8T57knDM9Ug@mail.gmail.com>
        <20200127153559.60a83e76@xps13>
        <20200127164554.34a21177@collabora.com>
        <20200127164755.29183962@xps13>
        <20200128075833.129902f6@collabora.com>
        <CAK7LNAQyK+jy4pm5M5z58uD5Zdv95Day6C6D3Gwvpv2C4Vh53Q@mail.gmail.com>
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

Masahiro Yamada <masahiroy@kernel.org> wrote on Wed, 29 Jan 2020
19:06:46 +0900:

> On Tue, Jan 28, 2020 at 3:58 PM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Mon, 27 Jan 2020 16:47:55 +0100
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >  
> > > Hi Hello,
> > >
> > > Boris Brezillon <boris.brezillon@collabora.com> wrote on Mon, 27 Jan
> > > 2020 16:45:54 +0100:
> > >  
> > > > On Mon, 27 Jan 2020 15:35:59 +0100
> > > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > >  
> > > > > Hi Masahiro,
> > > > >
> > > > > Masahiro Yamada <masahiroy@kernel.org> wrote on Mon, 27 Jan 2020
> > > > > 21:55:25 +0900:
> > > > >  
> > > > > > Hi.
> > > > > >
> > > > > > I have a question about the
> > > > > > WP_n pin of a NAND chip.
> > > > > >
> > > > > >
> > > > > > As far as I see, the NAND framework does not
> > > > > > handle it.  
> > > > >
> > > > > There is a nand_check_wp() which reads the status of the pin before
> > > > > erasing/writing.
> > > > >  
> > > > > >
> > > > > > Instead, it is handled in a driver level.
> > > > > > I see some DT-bindings that handle the WP_n pin.
> > > > > >
> > > > > > $ git grep wp -- Documentation/devicetree/bindings/mtd/
> > > > > > Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt:-
> > > > > > brcm,nand-has-wp          : Some versions of this IP include a
> > > > > > write-protect  
> > > > >
> > > > > Just checked: brcmnand de-assert WP when writing/erasing and asserts it
> > > > > otherwise. IMHO this switching is useless.
> > > > >  
> > > > > > Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt:-
> > > > > > wp-gpios: GPIO specifier for the write protect pin.
> > > > > > Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt:
> > > > > >          wp-gpios = <&gpf 22 GPIO_ACTIVE_LOW>;
> > > > > > Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt:-
> > > > > > wp-gpios: GPIO specifier for the write protect pin.
> > > > > > Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt:
> > > > > >          wp-gpios = <&gpio TEGRA_GPIO(S, 0) GPIO_ACTIVE_LOW>;  
> > > > >
> > > > > In both cases, the WP GPIO is unused in the code, just de-asserted at
> > > > > boot time like what you do in the patch below.
> > > > >  
> > > > > >
> > > > > >
> > > > > >
> > > > > > I wrote a patch to avoid read-only issue in some cases:
> > > > > > http://patchwork.ozlabs.org/patch/1229749/
> > > > > >
> > > > > > Generally speaking, we expect NAND devices
> > > > > > are writable in Linux. So, I think my patch is OK.  
> > > > >
> > > > > I think the patch is fine.
> > > > >  
> > > > > >
> > > > > >
> > > > > > However, I asked this myself:
> > > > > > Is there a useful case to assert the write protect
> > > > > > pin in order to make the NAND chip really read-only?
> > > > > > For example, the system recovery image is stored in
> > > > > > a read-only device, and the write-protect pin is
> > > > > > kept asserted to assure nobody accidentally corrupts it.  
> > > > >
> > > > > It is very likely that the same device is used for RO and RW storage so
> > > > > in most cases this is not possible. We already have squashfs which is
> > > > > actually read-only at filesystem level, I'm not sure it is needed to
> > > > > enforce this at a lower level... Anyway if there is actually a pin for
> > > > > that, one might want to handle the pin directly as a GPIO, what do you
> > > > > think?  
> > > >
> > > > FWIW, I've always considered the WP pin as a way to protect against
> > > > spurious destructive command emission, which is most likely to happen
> > > > during transition phases (bootloader -> linux, linux -> kexeced-linux,
> > > > platform reset, ..., or any other transition where the pin state might
> > > > be undefined at some point). This being said, if you're worried about
> > > > other sources of spurious cmds (say your bus is shared between
> > > > different kind of memory devices, and the CS pin is unreliable), you
> > > > might want to leave the NAND in a write-protected state de-asserting WP
> > > > only when explicitly issuing a destructive command (program page, erase
> > > > block).  
> > >
> > > Ok so with this in mind, only the brcmnand driver does a useful use of
> > > the WP output.  
> >
> > Well, I'd just say that brcmnand is more paranoid, which is a good
> > thing I guess, but that doesn't make other solutions useless, just less
> > safe. We could probably flag operations as 'destructive' at the
> > nand_operation level, so drivers can assert/de-assert the pin on a
> > per-operation basis.  
> 
> Sounds a good idea.
> 
> If it is supported in the NAND framework,
> I will be happy to implement in the Denali NAND driver.
> 

There is currently no such thing at NAND level but I doubt there is
more than erase and write operation during which it would be needed
to assert/deassert WP. I don't see why having this flag would help
the controller drivers?

Thanks,
Miquèl
