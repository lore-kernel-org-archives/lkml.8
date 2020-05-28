Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624B2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F82207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391176AbgE1Oi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:38:57 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:42488 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgE1Oiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:38:51 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id E422580307C0;
        Thu, 28 May 2020 14:38:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MN5UivzRgvTa; Thu, 28 May 2020 17:38:48 +0300 (MSK)
Date:   Thu, 28 May 2020 17:38:47 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH RESEND v2] mtd: physmap: Add Baikal-T1 physically mapped
 ROMs support
Message-ID: <20200528143847.vd7b434xtgiaobv4@mobilestation>
References: <20200526225849.20985-1-Sergey.Semin@baikalelectronics.ru>
 <5f5fc883-1cf0-f0b8-11bb-a60b45d135cd@ti.com>
 <20200528104245.jurucbblufluyjut@mobilestation>
 <0a9160b6-f915-2a2b-582f-3e6d657ca7df@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0a9160b6-f915-2a2b-582f-3e6d657ca7df@ti.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:35:41PM +0530, Vignesh Raghavendra wrote:
> 
> 
> On 28/05/20 4:12 pm, Serge Semin wrote:
> [...]
> >>> +
> >>> +static map_word __xipram bt1_rom_dummy_read(struct map_info *map,
> >>> +					  unsigned long ofs)
> >>> +{
> >>> +	map_word ret;
> >>> +
> >>> +	ret.x[0] = 0xFF;
> >>> +
> >>> +	return ret;
> >>> +}
> >> Why define dummy_io for "baikal,bt1-boot-rom"? I don't see any use of
> >> adding a driver that always reads 0xFFs
> > This is supposed to be temporary solution for the baikal,bt1-boot-rom ROM.
> > The Boot ROM mirror might reflect either an embedded firmware or the SPI flash
> > directly mapped into the memory. In former case there is no problem, we can
> > freely read from the Boot ROM region. But in the later case the mirrored region
> > (memory mapped SPI flash) is not always accessible. If normal Boot SPI
> > controller is enabled, then the SPI flash mapping isn't accessible (any attempt
> > will cause a bus-error). In order to fix this we'd need a mutual exclusive lock,
> > which would disable the SPI controller while the mirrored memory mapped SPI flash
> > region needs to be accessed. Such mechanism isn't currently implemented, but it
> > will in be in the framework of my patch created for the SPI subsystem.
> > 
> > My idea was to just provide a dummy callback for now and replace it with normal
> > IO-methods with mutual exclusive lock-unlocks when the corresponding SPI driver
> > is accepted.
> > 
> 
> Yes I understand, but I don't see any advantage for end user by
> providing dummy calls... So please don't add the callbacks until they
> implement proper functionality

Agreed. I'll remove the Baikal-T1 Boot ROM support in the next version.

-Sergey
