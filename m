Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAE7C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC562078C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbgDAPct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:32:49 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57560 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732799AbgDAPct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:32:49 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C40C68030776;
        Wed,  1 Apr 2020 15:32:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vf465bd7u2PJ; Wed,  1 Apr 2020 18:32:46 +0300 (MSK)
Date:   Wed, 1 Apr 2020 18:32:56 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
List-Id: <soc.lore.kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] soc: Add Baikal-T1 SoC APB/AXI EHB and L2-cache
 drivers
Message-ID: <20200401153256.6x2f252eckror2jm@ubsrv2.baikal.int>
References: <20200306130731.938808030702@mail.baikalelectronics.ru>
 <CAK8P3a0PjNS9+sAiPnDgkmLsnJ6=hR_Vk8oqe493t-Ad_mGa9w@mail.gmail.com>
 <20200312212557.GB27332@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200312212557.GB27332@bogus>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 04:25:57PM -0500, Rob Herring wrote:
> On Fri, Mar 06, 2020 at 04:19:47PM +0100, Arnd Bergmann wrote:
> > On Fri, Mar 6, 2020 at 2:07 PM <Sergey.Semin@baikalelectronics.ru> wrote:
> > >
> > > From: Serge Semin <fancer.lancer@gmail.com>
> > >
> > > Aside from PCIe/SATA/DDR/I2C/CPU-reboot specific settings the Baikal-T1
> > > system controller provides three vendor-specific blocks. In particular
> > > there are two Errors Handler Blocks to detect and report an info regarding
> > > any problems discovered on the AXI and APB buses. These are the main buses
> > > utilized by the SoC devices to interact with each other. In addition there
> > > is a way to tune the MIPS P5600 CM2 L2-cache up by setting the Tag/Data/WS
> > > L2-to-RAM latencies. All of this functionality is implemented in the
> > > APB/AXI EHB and L2-cache control block drivers to be a part of the kernel soc
> > > subsystem (as being specific to the Baikal-T1 SoC) and introduced in the
> > > framework of this patchset.
> > >
> > > This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> > > commit 98d54f81e36b ("Linux 5.6-rc4").
> > 
> > I have no objection to the drivers, but I wonder if these should be
> > in drivers/bus and drivers/memory instead of drivers/soc, which have
> > similar drivers already. The driver for the L2 cache is not really a
> > memory controller driver, but it may be close enough, and we
> > already have a couple of different things in there.
> 
> I don't have the driver side in my inbox, but isn't setting up cache 
> latencies in a driver a little late?
> 
> Rob

Generally speaking there is no much difference at what moment the driver
is loaded and device is probed. First of all the L2-RAM latencies should be
setup by the system bootloader before RAM is detected and the memory controller
is enabled and run (though default value is normally Ok to use). In a worst case
if the bootloader did something wrong it may cause either the performance
degradation (up to 10% - 20% drop), or the system may get to be absolutely
unstable. In the later the kernel (and bootloader) may collapse at any moment,
most likely before the driver is loaded even at the very first possible stage.
Due to this uncertainty the upcoming l2-cache tuning stage doesn't really matter.

So this driver can be used either to tune the system performance up by updating
the system dtb while leaving the bootloader code unchanged, or by setting the
latencies from user-space to the corresponding sysfs nodes exported by
the driver.

Regards,
-Sergey
