Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB93BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70AC20661
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgA0PqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:46:00 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33244 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgA0PqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:46:00 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D655228CFD7;
        Mon, 27 Jan 2020 15:45:57 +0000 (GMT)
Date:   Mon, 27 Jan 2020 16:45:54 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: How to handle write-protect pin of NAND device ?
Message-ID: <20200127164554.34a21177@collabora.com>
In-Reply-To: <20200127153559.60a83e76@xps13>
References: <CAK7LNAR0FemABUg5uN5fhy5LRsOm7n5GhmFVVHE8T57knDM9Ug@mail.gmail.com>
        <20200127153559.60a83e76@xps13>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020 15:35:59 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Masahiro,
> 
> Masahiro Yamada <masahiroy@kernel.org> wrote on Mon, 27 Jan 2020
> 21:55:25 +0900:
> 
> > Hi.
> > 
> > I have a question about the
> > WP_n pin of a NAND chip.
> > 
> > 
> > As far as I see, the NAND framework does not
> > handle it.  
> 
> There is a nand_check_wp() which reads the status of the pin before
> erasing/writing.
> 
> > 
> > Instead, it is handled in a driver level.
> > I see some DT-bindings that handle the WP_n pin.
> > 
> > $ git grep wp -- Documentation/devicetree/bindings/mtd/
> > Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt:-
> > brcm,nand-has-wp          : Some versions of this IP include a
> > write-protect  
> 
> Just checked: brcmnand de-assert WP when writing/erasing and asserts it
> otherwise. IMHO this switching is useless.
> 
> > Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt:-
> > wp-gpios: GPIO specifier for the write protect pin.
> > Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt:
> >          wp-gpios = <&gpf 22 GPIO_ACTIVE_LOW>;
> > Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt:-
> > wp-gpios: GPIO specifier for the write protect pin.
> > Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt:
> >          wp-gpios = <&gpio TEGRA_GPIO(S, 0) GPIO_ACTIVE_LOW>;  
> 
> In both cases, the WP GPIO is unused in the code, just de-asserted at
> boot time like what you do in the patch below.
> 
> > 
> > 
> > 
> > I wrote a patch to avoid read-only issue in some cases:
> > http://patchwork.ozlabs.org/patch/1229749/
> > 
> > Generally speaking, we expect NAND devices
> > are writable in Linux. So, I think my patch is OK.  
> 
> I think the patch is fine.
> 
> > 
> > 
> > However, I asked this myself:
> > Is there a useful case to assert the write protect
> > pin in order to make the NAND chip really read-only?
> > For example, the system recovery image is stored in
> > a read-only device, and the write-protect pin is
> > kept asserted to assure nobody accidentally corrupts it.  
> 
> It is very likely that the same device is used for RO and RW storage so
> in most cases this is not possible. We already have squashfs which is
> actually read-only at filesystem level, I'm not sure it is needed to
> enforce this at a lower level... Anyway if there is actually a pin for
> that, one might want to handle the pin directly as a GPIO, what do you
> think?

FWIW, I've always considered the WP pin as a way to protect against
spurious destructive command emission, which is most likely to happen
during transition phases (bootloader -> linux, linux -> kexeced-linux,
platform reset, ..., or any other transition where the pin state might
be undefined at some point). This being said, if you're worried about
other sources of spurious cmds (say your bus is shared between
different kind of memory devices, and the CS pin is unreliable), you
might want to leave the NAND in a write-protected state de-asserting WP
only when explicitly issuing a destructive command (program page, erase
block).
