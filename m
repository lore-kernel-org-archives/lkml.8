Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17BDC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 08:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C18F92067C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 08:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgHPIm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 04:42:26 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50611 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgHPImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 04:42:16 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MryKp-1kUPuC3cg9-00nzRF for <linux-kernel@vger.kernel.org>; Sun, 16 Aug
 2020 10:42:14 +0200
Received: by mail-qv1-f54.google.com with SMTP id t6so6387397qvw.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 01:42:13 -0700 (PDT)
X-Gm-Message-State: AOAM533CjgdBf4UeWC14fgwxXxK7PXxrzBQ9HbvFp11AqbjWVQugpiag
        WgvPU2DYh2Unc2kUVs9A2zBZuHSgFA+qHVxuleY=
X-Google-Smtp-Source: ABdhPJyT4ba0KjtjvrTFsQR8K9en1ajCsl5ivlE6fwXu46F/qDg96TBozqonUPhoUOVqk1XJE/qc0o+pw2NR84KPM6g=
X-Received: by 2002:a0c:e604:: with SMTP id z4mr9908333qvm.222.1597567332693;
 Sun, 16 Aug 2020 01:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200804135817.5495-1-daniel.gutson@eclypsium.com>
 <CAK8P3a0_fJ0BfD5Qvxdo0s7CbjPWaGA8QTgYhbXR=omafOHH4Q@mail.gmail.com>
 <CAFmMkTHEm8k+5GZkVJbDZMEhMwpsqVKRb-hGskSpBstdLRuFyA@mail.gmail.com>
 <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com>
 <CAFmMkTF9eVm0tpOKEy2rzdX=Scr3RwqHDFy_i24R3F5ok-4=eA@mail.gmail.com>
 <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com>
 <CAFmMkTFzmC=aY0gR6urLu-8Oq8aeHBUWi-TodG8XhXKCcC057A@mail.gmail.com>
 <CAK8P3a13N_wNORz_3cYHTN8t29pPrY+dJ+g+1Ga_MmG1TmrUQw@mail.gmail.com> <CAFmMkTGm3pMsBzEenYOsRbhOZKFhbHiZ5LxPyVmTdYTTRpKzVQ@mail.gmail.com>
In-Reply-To: <CAFmMkTGm3pMsBzEenYOsRbhOZKFhbHiZ5LxPyVmTdYTTRpKzVQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 16 Aug 2020 10:41:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2_RV33kiJ0c34aopZ4iG7LYBR-u=-+BbC+Upyjh1T0Eg@mail.gmail.com>
Message-ID: <CAK8P3a2_RV33kiJ0c34aopZ4iG7LYBR-u=-+BbC+Upyjh1T0Eg@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI flash
 chip writable
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1ZIjlOXyVg+Nqq9l4D0AKIsxNhGAWFM0ujR3LVEqIMF0q/nW69r
 hn8vsawMBbvuKNqSGO7kvFzF0YU0Ca+1rwsYauY/b9YqPEXKMrtFS7goZqQk7cR3oOBkFpc
 3e90hg1/NFAYmhY3i+TczqWUmbhDshihjetp58xozul4V11CEDePTF0QXrf4uvNzDr1wEBw
 sygvLJAbOGMwZ/yN6QtuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1BdS/hfeqHs=:kVyCXP0/FJY7oZmBBHYTGl
 iJGtYs4uzvqjrRVYXcI8++fI3/6OBUFy6bPVg98RxJTILp5CEwwX/vuxmCaVH8psy/PjKWbwu
 MSii3ugfSvZDlOxUMLz+XXNOHx/Z60MKxwFaGekN8TmF+QAuQordPgvqrVexNzxk7esmdKRoy
 K16rJmnvsvTJKTPiuHN5j/oSpKtdgBTI99DD7V1GkMrSiWYXj8xkPpryXiRsanb6bYmMxcHH4
 iD6yzL4IsWyFS2sgcFXCoHMduU943Yd0zuwQMumpEmcTFezntP2gPqM/tmxJZ7S1HTy4CWfkp
 lUFqSeW5+BEYarU9C0HdtDJT4JcfC+wuoo5XPOJQbpsBxXlPCjiwFE8vAC5GlSN5T3cLvUQEY
 X08p2c1MBV1dKgetRQZr9+omjPNPVLogLvFFm9s97PeWU9iIDDqpPENu0Er9c9Ku3VzKWHh+h
 R6+GtG+6urQ8t3O2AZxop05qTp+LYVTXT505fiVx5Y2tygIVi+mXeNuKYcdvIbQMBYpjdYf1u
 0s02PEyFZTEQvD/mMdP48Nl7Ndzf2LsF27fgsmX2tueXSB9M3eDFZUzsBYwzcaR4Xv9TdEyRa
 bER5lg9Vu42N9vH0Z3pBG1fQYyZXlwHevEYb2Yjtw5qbFcfWPlM/4oZoftWf6z1YeXrh0dZ2L
 AG1wxfYNTBZyNVSjLEoE7dq7KZnpax4E7muUd4m3vSJr+Cd3DSFfRA7kXD0dRpB8nD/uuKswY
 Tq9r4/N2b1W0f4VsDvE/JmdABInPIrsGet/zYLs9Cgx2IN+hS9Voci667UfoGeG4tEK9lDipf
 t5o+TX+2GPNfUEdLQwaWlRE3W30eH58mHobHTqxI0v5vn8XGra0ME9py342MHQqyomSNUDy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 11:40 PM Daniel Gutson <daniel@eclypsium.com> wrote:
>
> On Thu, Aug 13, 2020 at 12:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Aug 4, 2020 at 11:26 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> > > On Tue, Aug 4, 2020 at 5:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > But wait, Mika, the author of the file, asked earlier not to remove
> > > > > the module parameter of intel-spi, and just remove the unconditional
> > > > > attempt to turn the chip writable in intle-spi-pci.
> > > >
> > > > Yes, and I think that is fine (aside from the inconsistency with bay trail
> > > > that you have not commented on),
> > >
> > > There are two inconsistencies before any of my patches:
> > > 1) in intel-spi.c: uses the module parameter only for bay trail.
> > > 2) intel-spi.c uses a module parameter whereas intel-spi-pci doesn't
> >
> > Neither of these matches what I see in the source code. Please
> > check again.
> >
> > Once more: intel-spi.c has a module parameter that controls writing
> > to the device regardless of the back-end (platform or pci), purely
> > in software.
>
> If I understand you correctly, this is not what I see:
> If the deviceID is listed in intel-spi-pci.c
> (https://elixir.bootlin.com/linux/latest/source/drivers/mtd/spi-nor/controllers/intel-spi-pci.c#L66)
> then intel_spi_pci_probe will be called, where it unconditionally will
> try to make the chip writable
> https://elixir.bootlin.com/linux/latest/source/drivers/mtd/spi-nor/controllers/intel-spi-pci.c#L44
> These devices correspond to the BXT and CNL devices (lines 19 and 23 resp.).
>
> Lines later (53), it will call intel-spi.c 's intel_spi_probe
> function, which ends up calling intel_spi_init,
> which checks for the type
> (https://elixir.bootlin.com/linux/latest/source/drivers/mtd/spi-nor/controllers/intel-spi.c#L313)
> It is in this switch where the module parameter is checked, but only
> in the BYT case; however,
> flow coming from intel-spi-pci is BXT and CNL as mentioned before,
> landing in their case labels (lines 343 and 351 respectively)
> where the module parameter is not checked.
>
> Therefore, for BXT and CNL probed in intel-spi-pci, the chip is turned
> writable and later the module parameter is not honored.

The module parameter is definitely honored on all hardware, but the driver
only cares about the functionality it provides through the mtd interface:

https://elixir.bootlin.com/linux/latest/source/drivers/mtd/spi-nor/controllers/intel-spi.c#L941

If you care about other (malicious) code writing to the driver, please explain
what the specific attack scenario is that you are worried about, and
why you think
this is not sufficient. What code would be able to write to the device
if not the
device driver itself?

    Arnd
