Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B67C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76D9206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="FQ18p5YP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgEFFJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725821AbgEFFJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:09:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE81C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 22:09:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x17so556655wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 22:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KONjtN1d3tvLqOY/wlrmm4pE107x+jxzOGMlbDSUVz0=;
        b=FQ18p5YPTcGlRz3bil64DOWyaUFNzUGsMcJEieNlyq0+xx1A/HZ5dCilifPHh9/fk3
         PUNP3u8BMuh6N1x98sX7bB/gVTH9YZdwASkZZzw4yQ3w+SGIHydcApzO7g1SgaW+lPFh
         KVQMIPqAEJhOhdnT2oide6UFBbaqSudSAhIWAvzlyDpbs2Abhr3Oh6vQzsDLw70A4pUC
         P+l/+ZvVJgadmYYTiIUpgzvmdT1P3bteDki0zL8RkCix1p/Gv+NyYXbeBD5lZ0ksgPwS
         sKf9021GOW2ZOmI6409KCg2WvlycsflKN1GgzOx8y816x4GLBen2u764lGkUpuoVLJmR
         BhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KONjtN1d3tvLqOY/wlrmm4pE107x+jxzOGMlbDSUVz0=;
        b=f0/xj4QAdkODCY5OECrDdJ//YfnFo4GadKPg1NoMFjNaTmff+VRVvYzokaQkyD0CeH
         aFVqB4JKLqWfGJPebZDNgBb+NkU2mYlGaTdIfRDUZS7fpqVSmOfwrngo41fGIbuMYuKq
         QwiziW2bOyEE3eMoflpDfYPa3+T1+j9izOwzrRXrCuqC17TqS5Zki37UvOd3QK5Z3v/P
         6LMCtLRyD7QFPGInp6Uj/GhT4ixI+LZ/JpNwUXklzwVJfPHiMF9mt8vshVEbhc3Ho1sl
         BxH38TIc/NeOsQedg43ldTQKRShHtf6yKddJH9ZuqztFcllMcz24UqZvrrPdNYmuz3cF
         sVOg==
X-Gm-Message-State: AGi0PubNBWW4E10+PT4qakOe1HssUFYMe5sx/geQewm4waloGerSkG3D
        E2WogV+VTp95m3T4Re6icVjaSyZLfPEE2wYfX62sghSM
X-Google-Smtp-Source: APiQypLiK8pkP0blfJITIvDGiJsn0oXglVqI5ta6/Xl1PsEi49y7oSsq6UhO9umLyTKjcm1Qj115Z0f6CpEsHoGYib4=
X-Received: by 2002:adf:fcc8:: with SMTP id f8mr7286277wrs.230.1588741792592;
 Tue, 05 May 2020 22:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <BN8PR13MB2611968A7252308925FF18B399A70@BN8PR13MB2611.namprd13.prod.outlook.com>
 <mhng-29e22ca7-538a-4094-923f-8fbc0fd327b9@palmerdabbelt-glaptop1> <BYAPR13MB2614FE811C8DD83BBDD3A26599A40@BYAPR13MB2614.namprd13.prod.outlook.com>
In-Reply-To: <BYAPR13MB2614FE811C8DD83BBDD3A26599A40@BYAPR13MB2614.namprd13.prod.outlook.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 6 May 2020 10:39:39 +0530
Message-ID: <CAAhSdy2-ECrOP=kZOTXxj1t+f8NrcYjbXKDRwPB3KU36mDmWWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: defconfig: enable spi nor on Hifive Unleashed
 A00 board.
To:     Sagar Kadam <sagar.kadam@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "richard@nod.at" <richard@nod.at>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 9:26 AM Sagar Kadam <sagar.kadam@sifive.com> wrote:
>
> Hi Palmer,
>
> > -----Original Message-----
> > From: Palmer Dabbelt <palmer@dabbelt.com>
> > Sent: Wednesday, May 6, 2020 4:54 AM
> > To: Sagar Kadam <sagar.kadam@sifive.com>
> > Cc: tudor.ambarus@microchip.com; miquel.raynal@bootlin.com;
> > richard@nod.at; vigneshr@ti.com; Paul Walmsley
> > <paul.walmsley@sifive.com>; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; linux-mtd@lists.infradead.org
> > Subject: RE: [PATCH 1/2] riscv: defconfig: enable spi nor on Hifive Unleashed
> > A00 board.
> >
> > [External Email] Do not click links or attachments unless you recognize the
> > sender and know the content is safe
> >
> > On Tue, 05 May 2020 00:18:45 PDT (-0700), sagar.kadam@sifive.com wrote:
> > > Hello Palmer,
> > >
> > >> -----Original Message-----
> > >> From: Palmer Dabbelt <palmer@dabbelt.com>
> > >> Sent: Tuesday, May 5, 2020 3:40 AM
> > >> To: Sagar Kadam <sagar.kadam@sifive.com>
> > >> Cc: tudor.ambarus@microchip.com; miquel.raynal@bootlin.com;
> > >> richard@nod.at; vigneshr@ti.com; Paul Walmsley
> > >> <paul.walmsley@sifive.com>; linux-riscv@lists.infradead.org; linux-
> > >> kernel@vger.kernel.org; linux-mtd@lists.infradead.org; Sagar Kadam
> > >> <sagar.kadam@sifive.com>
> > >> Subject: Re: [PATCH 1/2] riscv: defconfig: enable spi nor on Hifive
> > Unleashed
> > >> A00 board.
> > >>
> > >> [External Email] Do not click links or attachments unless you recognize
> > the
> > >> sender and know the content is safe
> > >>
> > >> On Thu, 30 Apr 2020 02:58:51 PDT (-0700), sagar.kadam@sifive.com
> > wrote:
> > >> > Enable MTD based SPI-NOR framework in order to use spi flash
> > available
> > >> > on HiFive Unleashed A00 board.
> > >> >
> > >> > Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> > >> > ---
> > >> >  arch/riscv/configs/defconfig | 2 ++
> > >> >  1 file changed, 2 insertions(+)
> > >> >
> > >> > diff --git a/arch/riscv/configs/defconfig
> > >> > b/arch/riscv/configs/defconfig index 4da4886..970580b 100644
> > >> > --- a/arch/riscv/configs/defconfig
> > >> > +++ b/arch/riscv/configs/defconfig
> > >> > @@ -80,6 +80,8 @@ CONFIG_USB_STORAGE=y  CONFIG_USB_UAS=y
> > >> CONFIG_MMC=y
> > >> > CONFIG_MMC_SPI=y
> > >> > +CONFIG_MTD=y
> > >> > +CONFIG_MTD_SPI_NOR=y
> > >> >  CONFIG_RTC_CLASS=y
> > >> >  CONFIG_VIRTIO_PCI=y
> > >> >  CONFIG_VIRTIO_BALLOON=y
> > >>
> > >> From the second patch's description I'm assuming that MTD still
> > functions
> > >> correctly without that change?
> > >
> > > Yes Palmer, the second patch is to enable QUAD write to nor flash..
> > > MTD  function's correctly without second patch.
> > >
> > > Using the character interface (/dev/mtd0) mtd_utils (mtd_debug :
> > erase/read/write) work fine.
> > > We might require CONFIG_MTD_BLOCK, CONFIG_MTD_CMDLINE_PARTS
> > in order to use MTD partitioning.
> > > IMHO it can be at user's choice weather to use flash partitions or not, so I
> > have not enabled. Please let me
> > > know if I should enable these features as well.
> >
> > Looks like arm64 has these:
> >
> > arch/arm64/configs/defconfig:CONFIG_MTD=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_BLOCK=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_CFI=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_CFI_ADV_OPTIONS=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_CFI_INTELEXT=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_CFI_AMDSTD=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_CFI_STAA=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_PHYSMAP=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_PHYSMAP_OF=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_DATAFLASH=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_SST25L=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_RAW_NAND=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_NAND_DENALI_DT=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_NAND_MARVELL=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_NAND_FSL_IFC=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_NAND_QCOM=y
> > arch/arm64/configs/defconfig:CONFIG_MTD_SPI_NOR=y
> >
> > so I think we're good with just what you have here: MTD_BLOCK doesn't
> > seem that
> > useful, and the rest are drivers.  That said, these (along with SPI and
> > SPI_SIFIVE) should really be in Kconfig.socs rather than defconfig.  Can you
> > send a patch that does that?
> >
>
> Yes sure, I will send a V2 series, where SPI,  SPI_SIFIVE,  MTD,
> and MTD_SPI_NOR will be a part of Kconfig.socs.

We had build issues in past by selecting major driver subsystems
in Kconfig.socs

I suggest to select SPI_SIFIVE from Kconfig.socs and other
platform independent options should go in defconfig and
rv32_defconfig.

The general rule of thumb is to force select only required
drivers from Kconfig.socs.

Regards,
Anup

>
> Thanks & BR,
> Sagar Kadam
>
> > >
> > > To demonstrate a bit more with linux 5.7-rc3
> > >
> > > Specify on U-boot prompt:
> > > # setenv bootargs "root=/dev/ram rw console=ttySIF0
> > mtdparts=spi0.0:1024k(loader1),4096K(loader2),26M(rootfs)"
> > >
> > > After booting linux will enumerate mtd partitions:
> > > # cat /proc/mtd
> > > dev:    size   erasesize  name
> > > mtd0: 00100000 00001000 "loader1"
> > > mtd1: 00400000 00001000 "loader2"
> > > mtd2: 01a00000 00001000 "rootfs"
> > >
> > > # cat /proc/partitions
> > > major minor  #blocks  name
> > >   31        0       1024 mtdblock0
> > >   31        1       4096 mtdblock1
> > >   31        2      26624 mtdblock2
> > >
> > > #Format mtdblock2 with mkfs.ext3/4 and mount results in
> > > # mkfs.ext3 /dev/mtdblock2
> > > mke2fs 1.44.5 (15-Dec-2018)
> > > /dev/mtdblock2 contains a ext3 file system
> > >         last mounted on /mnt on Thu Jan  1 00:00:14 1970
> > > Proceed anyway? (y,N) y
> > > Creating filesystem with 26624 1k blocks and 6656 inodes
> > > Filesystem UUID: 1b09252d-e313-430c-9ecb-79b0cef003ca
> > > Superblock backups stored on blocks:
> > >         8193, 24577
> > >
> > > Allocating group tables: done
> > > Writing inode tables: done
> > > Creating journal (1024 blocks): done
> > > Writing superblocks and filesystem accounting information: done
> > >
> > > # mount
> > > none on / type rootfs (rw)
> > > proc on /proc type proc (rw,relatime)
> > > devpts on /dev/pts type devpts
> > (rw,relatime,gid=5,mode=620,ptmxmode=666)
> > > tmpfs on /dev/shm type tmpfs (rw,relatime,mode=777)
> > > tmpfs on /tmp type tmpfs (rw,relatime)
> > > tmpfs on /run type tmpfs (rw,nosuid,nodev,relatime,mode=755)
> > > sysfs on /sys type sysfs (rw,relatime)
> > > /dev/mtdblock2 on /mnt type ext3 (rw,relatime)
> > >
> > > Thanks & BR,
> > > Sagar Kadam
>
