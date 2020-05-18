Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB25C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9BE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgERT4y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:56:54 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:52343 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgERT4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:56:54 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D6A89200005;
        Mon, 18 May 2020 19:56:50 +0000 (UTC)
Date:   Mon, 18 May 2020 21:56:49 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Alban Bedel <albeu@free.fr>
Subject: Re: [PATCH] mtd: Fix mtd not registered due to nvmem name collision
Message-ID: <20200518215649.5273b132@xps13>
In-Reply-To: <CAPybu_3D5p7P5ND5qb8-2QmaQhQuvdEbiNKkeK5PbHdF3s-2Fg@mail.gmail.com>
References: <20200430131721.360064-1-ricardo@ribalda.com>
        <20200504104339.31b4a858@xps13>
        <CAPybu_3D5p7P5ND5qb8-2QmaQhQuvdEbiNKkeK5PbHdF3s-2Fg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Ricardo Ribalda Delgado <ricardo@ribalda.com> wrote on Mon, 18 May 2020
16:01:47 +0200:

> Hi
> 
> This is just a friendly ping after two weeks ;)

Don't worry, it's in the pipe :)

> 
> On Mon, May 4, 2020 at 10:44 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Richard,
> >
> > Ricardo Ribalda Delgado <ricardo@ribalda.com> wrote on Thu, 30 Apr 2020
> > 15:17:21 +0200:
> >  
> > > From: Ricardo Ribalda Delgado <ribalda@kernel.org>
> > >
> > > When the nvmem framework is enabled, a nvmem device is created per mtd
> > > device/partition.
> > >
> > > It is not uncommon that a device can have multiple mtd devices with
> > > partitions that have the same name. Eg, when there DT overlay is allowed
> > > and the same device with mtd is attached twice.
> > >
> > > Under that circumstances, the mtd fails to register due to a name
> > > duplication on the nvmem framework.
> > >
> > > With this patch we use the mtdX name instead of the partition name,
> > > which is unique.
> > >
> > > [    8.948991] sysfs: cannot create duplicate filename '/bus/nvmem/devices/Production Data'
> > > [    8.948992] CPU: 7 PID: 246 Comm: systemd-udevd Not tainted 5.5.0-qtec-standard #13
> > > [    8.948993] Hardware name: AMD Dibbler/Dibbler, BIOS 05.22.04.0019 10/26/2019
> > > [    8.948994] Call Trace:
> > > [    8.948996]  dump_stack+0x50/0x70
> > > [    8.948998]  sysfs_warn_dup.cold+0x17/0x2d
> > > [    8.949000]  sysfs_do_create_link_sd.isra.0+0xc2/0xd0
> > > [    8.949002]  bus_add_device+0x74/0x140
> > > [    8.949004]  device_add+0x34b/0x850
> > > [    8.949006]  nvmem_register.part.0+0x1bf/0x640
> > > ...
> > > [    8.948926] mtd mtd8: Failed to register NVMEM device
> > >
> > > Fixes: c4dfa25ab307 ("mtd: add support for reading MTD devices via the nvmem API")
> > > Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
> > > ---
> > >  drivers/mtd/mtdcore.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> > > index 2916674208b3..29d41003d6e0 100644
> > > --- a/drivers/mtd/mtdcore.c
> > > +++ b/drivers/mtd/mtdcore.c
> > > @@ -555,7 +555,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
> > >
> > >       config.id = -1;
> > >       config.dev = &mtd->dev;
> > > -     config.name = mtd->name;
> > > +     config.name = dev_name(&mtd->dev);
> > >       config.owner = THIS_MODULE;
> > >       config.reg_read = mtd_nvmem_reg_read;
> > >       config.size = mtd->size;  
> >
> > We hope this will definitely fix the NVMEM duplicate name issue. If it
> > does not reliably, we might want to revert this patch and create an MTD
> > unique ID field which, for each MTD device, concatenates the name of
> > its parent and its own mtd->name.
> >
> > Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > Thanks,
> > Miquèl  
> 
> 
> 
