Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254F0C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E784E20717
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgC0KZh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:25:37 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58545 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgC0KZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:25:37 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 03B3AFF813;
        Fri, 27 Mar 2020 10:25:31 +0000 (UTC)
Date:   Fri, 27 Mar 2020 11:25:30 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: Add Baikal-T1 Boot Controller driver
Message-ID: <20200327112530.71192909@xps13>
In-Reply-To: <20200327090139.GK603801@dell>
References: <20200306130528.9973-1-Sergey.Semin@baikalelectronics.ru>
        <20200306130614.696EF8030704@mail.baikalelectronics.ru>
        <20200325100940.GI442973@dell>
        <20200325165511.tjdaf2l5kkuhbhrr@ubsrv2.baikal.int>
        <20200326091313.GA603801@dell>
        <20200326113254.nfgiw5uynpbx5xhy@ubsrv2.baikal.int>
        <20200327090139.GK603801@dell>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee, Sergey,

Lee Jones <lee.jones@linaro.org> wrote on Fri, 27 Mar 2020 09:01:39
+0000:

> On Thu, 26 Mar 2020, Sergey Semin wrote:
> 
> > Michael, Richard, Vignesh and MTD mailing list are Cc'ed to have their
> > comments on the issue.
> > 
> > My answers on the previous email are below.
> > 
> > On Thu, Mar 26, 2020 at 09:13:13AM +0000, Lee Jones wrote:  
> > > On Wed, 25 Mar 2020, Sergey Semin wrote:
> > >   
> > > > Hello Lee,
> > > > 
> > > > On Wed, Mar 25, 2020 at 10:09:40AM +0000, Lee Jones wrote:  
> > > > > On Fri, 06 Mar 2020, Sergey.Semin@baikalelectronics.ru wrote:
> > > > >   
> > > > > > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > > > 
> > > > > > Baikal-T1 Boot Controller is an IP block embedded into the SoC and
> > > > > > responsible for the chip proper pre-initialization and further
> > > > > > booting up from some memory device. From the Linux kernel point of view
> > > > > > it's just a multi-functional device, which exports three physically mapped
> > > > > > ROMs and a single SPI controller.
> > > > > > 
> > > > > > Primarily the ROMs are intended to be used for transparent access of
> > > > > > the memory devices with system bootup code. First ROM device is an
> > > > > > embedded into the SoC firmware, which is supposed to be used just for
> > > > > > the chip debug and tests. Second ROM device provides a MMIO-based
> > > > > > access to an external SPI flash. Third ROM mirrors either the Internal
> > > > > > or SPI ROM region, depending on the state of the external BOOTCFG_{0,1}
> > > > > > chip pins selecting the system boot device.
> > > > > > 
> > > > > > External SPI flash can be also accessed by the DW APB SSI SPI controller
> > > > > > embedded into the Baikal-T1 Boot Controller. In this case the memory mapped
> > > > > > SPI flash region shouldn't be accessed.
> > > > > > 
> > > > > > Taking into account all the peculiarities described above, we created
> > > > > > an MFD-based driver for the Baikal-T1 controller. Aside from ordinary
> > > > > > OF-based sub-device registration it also provides a simple API to
> > > > > > serialize an access to the external SPI flash from either the MMIO-based
> > > > > > SPI interface or embedded SPI controller.  
> > > > > 
> > > > > Not sure why this is being classified as an MFD.
> > > > > 
> > > > > This is clearly 'just' a memory device.
> > > > >   
> > > > 
> > > > Hm, I see this as a normal MFD device. The Boot controller provides a
> > > > set of physically mapped ROMs and a DW APB SSI-based embedded SPI
> > > > controller. Yes, the SPI controller is normally utilized to access an external
> > > > flash device, and at boot stage it is used for it. But still it's a SPI
> > > > controller which driver belongs to the kernel SPI subsystem. Moreover
> > > > nothing prevents a platform designer from using it together with custom
> > > > GPIO-based chip-selects to have additional devices on the SPI bus.
> > > > 
> > > > As I said the problem is that an SPI flash might be accessed either with
> > > > use of a physically mapped ROM or via the normal DW APB SPI controller.
> > > > These two interfaces can't be used simultaneously, because the ROM is
> > > > just an rtl state-machine, which is built to translate MMIO operations
> > > > through the SPI controller registers to an external SPI-nor at CS0 of
> > > > the interface. That's why first I need to make sure the interface is locked,
> > > > then being enabled, then the corresponding driver can use it, then get
> > > > to unlock. That's the point of having the __bt1_bc_spi_lock() and
> > > > bt1_bc_spi_unlock() methods exported from the driver.
> > > > 
> > > > I've got two drivers for MTD ROM and SPI controller based on that
> > > > methods. But I haven't submitted them yet, because they belong to two
> > > > different subsystems and I need to have this one being accepted first.  
> > > 
> > > This is not a totally unique device/situation.  I've seen (and NACKed)
> > > this type of device before.  You need to explain this to the MTD
> > > (SPI-NOR?) maintainers.  They should be in a good position to provide
> > > guidance.
> > >   
> > 
> > Sorry, I don't really understand your justification. The boot controller
> > exports two types of devices: physically mapped ROMs and an DW APB
> > SSI-based SPI controller. Aside from being able to access an externally
> > attached SPI flash the SPI controller has normal SPI interface which in
> > general can be used to access any other SPI-slave. The complexity of
> > the case is that one of physically mapped ROM RTL uses the DW APB SSI
> > controller to access an external SPI flash, which when done makes the
> > DW APB SSI registers unusable on direct way. That's why I implemented the
> > boot controller as an MFD. An alternation caused by this peculiarity
> > will be submitted to drivers/mtd/maps/physmap-{core.c,baikal-t1-rom.c}
> > later after this change is reviewed and accepted. Similar situation
> > concerns a driver of DW APB SSI-based SPI controller. So according to
> > the current design the boot controller with it' sub-devices will be
> > declared in dts as follows:
> > 
> > boot: boot@1f040000 {
> > 	compatible = "be,bt1-boot-ctl";
> > 	reg = <0x1f040000 0x100>;
> > 	#address-cells = <1>;
> > 	#size-cells = <1>;
> > 	ranges;  
> 
> What control does this device offer in those 0x100 registers? 
> 
> > 	clocks = <&ccu_sys CCU_SYS_APB_CLK>;
> > 	clock-names = "pclk";
> > 
> > 	int_rom: rom@1bfc0000 {
> > 		compatible = "be,bt1-int-rom", "mtd-rom";
> > 		reg = <0x1bfc0000 0x10000>;
> > 		...
> > 	};
> > 
> > 	spi_rom: rom@1c000000 {
> > 		compatible = "be,bt1-ssi-rom", "mtd-rom";
> > 		reg = <0x1c000000 0x1000000>;
> > 		...
> > 	};
> > 
> > 	spi0: spi@1f040100 {
> > 		compatible = "be,bt1-boot-ssi";
> > 		reg = <0x1f040100 0xf00>;
> > 		#address-cells = <1>;
> > 		#size-cells = <0>;
> > 
> > 		clocks = <&ccu_sys CCU_SYS_SPI_CLK>;
> > 		clock-names = "ref";
> > 
> > 		...
> > 	};
> > 
> > 	boot_rom: rom@1fc00000 {
> > 		compatible = "be,bt1-boot-rom", "mtd-rom";
> > 		reg = <0x1fc00000 0x400000>;
> > 		...
> > 	};
> > };
> > 
> > I dare to assume, that by saying: "Despite including the MFD API, I don't
> > see it being used at all." you meant that since the driver doesn't
> > redistribute any resource by declaring mfd_cell'es, doesn't
> > register mfd-based sub-devices, and primary use-case of the boot
> > controller is to access flash-devices, it should be just moved to the MTD
> > subsystem. I don't think it would be better than to have a common part 
> > defined here in MFD while ROM-specific part - in MTD, and SPI-specific - in
> > the SPI subsystems. I would consider Baikal-T1 Boot Controller being similar
> > to drivers/mfd/qcom-spmi-pmic.c, drivers/mfd/atmel-flexcom.c, etc, but
> > instead of having GPIO, RTC, UART, i2c, etc sub-devices (which are also
> > fully defied in dts), it exports MMIO-based ROMs and SPI-controller.  
> 
> Are the ROMs all controlled via SPI?
> 
> > Lee, explain me please what is the difference between these MFDs and
> > Baikal-T1 Boot Controller, that makes one simple MFDs suitable for the
> > MFD subsystem, while another isn't?  
> 
> Complexity.
> 
> [NB: Please Don't assume that just because I accepted a driver into
>      MFD 6 years ago, that it would be accepted again today.]
> 
> To me this looks like an MTD device which is controlled via SPI.
> 
> The way I'm reading this currently, it might serve well to make the
> MTD portion(s) children of the SPI controller.  I still do not see a
> compelling reason to warrant adding a superfluous MFD driver if at all
> avoidable.
> 
> > Miquel, Richard, Vignesh and everyone from MTD, who can help could you
> > join this discussion and clarify whether the Baikal-T1 Boot Controller
> > driver is supposed to be moved to the MTD subsystem? If so, then what is
> > the better place to put it within the drivers/mtd/ directory tree?
> >   

Thank you for the detailed explanation. I'll try to bring useful
information to sort this out. IIUC, this bloc exports:

1/ One ROM located in the SoC
2/ The access to a possible second ROM over SPI

And also:

3/ Access to the SPI controller itself
4/ Access to 1/ or 2/ depending on an external switch.

IMHO:

1/ Might be seen as a random MTD device, its driver should be in
   /drivers/mtd/devices I guess.
3/ Is a SPI controller, its driver should be memory agnostic and
   located in /driver/spi/. However, it should probably implement
   the spi-mem infrastructure *and* the direct-mapping infrastructure
   which would automatically cover 2/ as well. The reg property of 2/
   should probably be part of 3/.

For 4/ I don't know what is the right thing to do yet.

What do you think?
 
> > > > Recently I've sent an RFC regarding a different question, but it
> > > > concerns the Baikal-T1 system controller and the boot controller as being part
> > > > of it:
> > > > 
> > > > https://lkml.org/lkml/2020/3/22/393  


Thanks,
Miquèl
