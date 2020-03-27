Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE27C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E1F2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAzYXAia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgC0JAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:00:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37703 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgC0JAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:00:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so10467833wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 02:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sw9EHe0rp4jEdZod7LUvBRAPC/j1wI6TRL3+L6zHB3k=;
        b=aAzYXAia5nPIJG0jSbMozw4pVDrHXdamQoXPwzA41RmrJ5Ogm0mTx5L/sJbg6suBd7
         MloDGRZzaYsZh6D84nlRqop46ZsMghBb9ycCyInFi29VxhfNn3xBTlU0avNUJLsxwL+s
         C6lGh+N2MyA0/4uWEb/A+8yCIZLykKbNQT1+b/AvfHbqHRRLHR5R/hc/RwECKOlyheHd
         Jut/6wQlph1RUDk8rj4N7nCwPgEoPqGhmU8i+aP8nAw7zfqMt8AMiwvn68EL9LITtAL8
         uD1B3qUyAp6AYvVNG+nefMoJxVNeUYZbQ5DgM7DWNf0+71/GQPu/DKXCOGOE16eOdX/F
         puaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sw9EHe0rp4jEdZod7LUvBRAPC/j1wI6TRL3+L6zHB3k=;
        b=C4JB0quoToP9HlU5M6+KTpXEMHv1xNPtBfPlvxbYXnNhpEmP1swWXoY3f+QS7LT2dD
         v+LZ01FBUgSneScXQMgx8ukY/2+7ogZxKe/+T5+VVvnrDJzR466BExl0sqYMXieR56WR
         4yM/CcPD/S16hfCf1vIjMlL+OJ2vD/4S3nCRSSN+x2J70g9tQ6+WdoKgMG5VSUc0Jnit
         FLmQoK1wERXlYfUg/sgG1J1LkfrYaHYMv5vokq+kUBlPwwHUmC83VdtCKNsfRffTxIEN
         h4/sJoeEU3utXLFNCmwnHNFK6v2DPGrx70DA3r5RPIzAldMT1fvE0FzYc8U3+S7Fog3N
         /uZw==
X-Gm-Message-State: ANhLgQ1oEA5UKeZGjreX7/WZmRejz1k9OvfQmpUI5HfFSCuv2BaXgorf
        K3Kz0s3hClMftYJTJmfm9dqjhQ==
X-Google-Smtp-Source: ADFU+vvjoty5CnSjs6+JrMK5QXrvDCdt7OK2Ri9BD5FemldQ3tZqNWcycGcCv24TvdUPEWtBmunJmQ==
X-Received: by 2002:a5d:4d07:: with SMTP id z7mr13373134wrt.89.1585299649928;
        Fri, 27 Mar 2020 02:00:49 -0700 (PDT)
Received: from dell ([95.149.164.95])
        by smtp.gmail.com with ESMTPSA id y80sm7405082wmc.45.2020.03.27.02.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 02:00:49 -0700 (PDT)
Date:   Fri, 27 Mar 2020 09:01:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sergey Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: Add Baikal-T1 Boot Controller driver
Message-ID: <20200327090139.GK603801@dell>
References: <20200306130528.9973-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130614.696EF8030704@mail.baikalelectronics.ru>
 <20200325100940.GI442973@dell>
 <20200325165511.tjdaf2l5kkuhbhrr@ubsrv2.baikal.int>
 <20200326091313.GA603801@dell>
 <20200326113254.nfgiw5uynpbx5xhy@ubsrv2.baikal.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200326113254.nfgiw5uynpbx5xhy@ubsrv2.baikal.int>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020, Sergey Semin wrote:

> Michael, Richard, Vignesh and MTD mailing list are Cc'ed to have their
> comments on the issue.
> 
> My answers on the previous email are below.
> 
> On Thu, Mar 26, 2020 at 09:13:13AM +0000, Lee Jones wrote:
> > On Wed, 25 Mar 2020, Sergey Semin wrote:
> > 
> > > Hello Lee,
> > > 
> > > On Wed, Mar 25, 2020 at 10:09:40AM +0000, Lee Jones wrote:
> > > > On Fri, 06 Mar 2020, Sergey.Semin@baikalelectronics.ru wrote:
> > > > 
> > > > > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > > 
> > > > > Baikal-T1 Boot Controller is an IP block embedded into the SoC and
> > > > > responsible for the chip proper pre-initialization and further
> > > > > booting up from some memory device. From the Linux kernel point of view
> > > > > it's just a multi-functional device, which exports three physically mapped
> > > > > ROMs and a single SPI controller.
> > > > > 
> > > > > Primarily the ROMs are intended to be used for transparent access of
> > > > > the memory devices with system bootup code. First ROM device is an
> > > > > embedded into the SoC firmware, which is supposed to be used just for
> > > > > the chip debug and tests. Second ROM device provides a MMIO-based
> > > > > access to an external SPI flash. Third ROM mirrors either the Internal
> > > > > or SPI ROM region, depending on the state of the external BOOTCFG_{0,1}
> > > > > chip pins selecting the system boot device.
> > > > > 
> > > > > External SPI flash can be also accessed by the DW APB SSI SPI controller
> > > > > embedded into the Baikal-T1 Boot Controller. In this case the memory mapped
> > > > > SPI flash region shouldn't be accessed.
> > > > > 
> > > > > Taking into account all the peculiarities described above, we created
> > > > > an MFD-based driver for the Baikal-T1 controller. Aside from ordinary
> > > > > OF-based sub-device registration it also provides a simple API to
> > > > > serialize an access to the external SPI flash from either the MMIO-based
> > > > > SPI interface or embedded SPI controller.
> > > > 
> > > > Not sure why this is being classified as an MFD.
> > > > 
> > > > This is clearly 'just' a memory device.
> > > > 
> > > 
> > > Hm, I see this as a normal MFD device. The Boot controller provides a
> > > set of physically mapped ROMs and a DW APB SSI-based embedded SPI
> > > controller. Yes, the SPI controller is normally utilized to access an external
> > > flash device, and at boot stage it is used for it. But still it's a SPI
> > > controller which driver belongs to the kernel SPI subsystem. Moreover
> > > nothing prevents a platform designer from using it together with custom
> > > GPIO-based chip-selects to have additional devices on the SPI bus.
> > > 
> > > As I said the problem is that an SPI flash might be accessed either with
> > > use of a physically mapped ROM or via the normal DW APB SPI controller.
> > > These two interfaces can't be used simultaneously, because the ROM is
> > > just an rtl state-machine, which is built to translate MMIO operations
> > > through the SPI controller registers to an external SPI-nor at CS0 of
> > > the interface. That's why first I need to make sure the interface is locked,
> > > then being enabled, then the corresponding driver can use it, then get
> > > to unlock. That's the point of having the __bt1_bc_spi_lock() and
> > > bt1_bc_spi_unlock() methods exported from the driver.
> > > 
> > > I've got two drivers for MTD ROM and SPI controller based on that
> > > methods. But I haven't submitted them yet, because they belong to two
> > > different subsystems and I need to have this one being accepted first.
> > 
> > This is not a totally unique device/situation.  I've seen (and NACKed)
> > this type of device before.  You need to explain this to the MTD
> > (SPI-NOR?) maintainers.  They should be in a good position to provide
> > guidance.
> > 
> 
> Sorry, I don't really understand your justification. The boot controller
> exports two types of devices: physically mapped ROMs and an DW APB
> SSI-based SPI controller. Aside from being able to access an externally
> attached SPI flash the SPI controller has normal SPI interface which in
> general can be used to access any other SPI-slave. The complexity of
> the case is that one of physically mapped ROM RTL uses the DW APB SSI
> controller to access an external SPI flash, which when done makes the
> DW APB SSI registers unusable on direct way. That's why I implemented the
> boot controller as an MFD. An alternation caused by this peculiarity
> will be submitted to drivers/mtd/maps/physmap-{core.c,baikal-t1-rom.c}
> later after this change is reviewed and accepted. Similar situation
> concerns a driver of DW APB SSI-based SPI controller. So according to
> the current design the boot controller with it' sub-devices will be
> declared in dts as follows:
> 
> boot: boot@1f040000 {
> 	compatible = "be,bt1-boot-ctl";
> 	reg = <0x1f040000 0x100>;
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	ranges;

What control does this device offer in those 0x100 registers? 

> 	clocks = <&ccu_sys CCU_SYS_APB_CLK>;
> 	clock-names = "pclk";
> 
> 	int_rom: rom@1bfc0000 {
> 		compatible = "be,bt1-int-rom", "mtd-rom";
> 		reg = <0x1bfc0000 0x10000>;
> 		...
> 	};
> 
> 	spi_rom: rom@1c000000 {
> 		compatible = "be,bt1-ssi-rom", "mtd-rom";
> 		reg = <0x1c000000 0x1000000>;
> 		...
> 	};
> 
> 	spi0: spi@1f040100 {
> 		compatible = "be,bt1-boot-ssi";
> 		reg = <0x1f040100 0xf00>;
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		clocks = <&ccu_sys CCU_SYS_SPI_CLK>;
> 		clock-names = "ref";
> 
> 		...
> 	};
> 
> 	boot_rom: rom@1fc00000 {
> 		compatible = "be,bt1-boot-rom", "mtd-rom";
> 		reg = <0x1fc00000 0x400000>;
> 		...
> 	};
> };
> 
> I dare to assume, that by saying: "Despite including the MFD API, I don't
> see it being used at all." you meant that since the driver doesn't
> redistribute any resource by declaring mfd_cell'es, doesn't
> register mfd-based sub-devices, and primary use-case of the boot
> controller is to access flash-devices, it should be just moved to the MTD
> subsystem. I don't think it would be better than to have a common part 
> defined here in MFD while ROM-specific part - in MTD, and SPI-specific - in
> the SPI subsystems. I would consider Baikal-T1 Boot Controller being similar
> to drivers/mfd/qcom-spmi-pmic.c, drivers/mfd/atmel-flexcom.c, etc, but
> instead of having GPIO, RTC, UART, i2c, etc sub-devices (which are also
> fully defied in dts), it exports MMIO-based ROMs and SPI-controller.

Are the ROMs all controlled via SPI?

> Lee, explain me please what is the difference between these MFDs and
> Baikal-T1 Boot Controller, that makes one simple MFDs suitable for the
> MFD subsystem, while another isn't?

Complexity.

[NB: Please Don't assume that just because I accepted a driver into
     MFD 6 years ago, that it would be accepted again today.]

To me this looks like an MTD device which is controlled via SPI.

The way I'm reading this currently, it might serve well to make the
MTD portion(s) children of the SPI controller.  I still do not see a
compelling reason to warrant adding a superfluous MFD driver if at all
avoidable.

> Miquel, Richard, Vignesh and everyone from MTD, who can help could you
> join this discussion and clarify whether the Baikal-T1 Boot Controller
> driver is supposed to be moved to the MTD subsystem? If so, then what is
> the better place to put it within the drivers/mtd/ directory tree?
> 
> > > Recently I've sent an RFC regarding a different question, but it
> > > concerns the Baikal-T1 system controller and the boot controller as being part
> > > of it:
> > > 
> > > https://lkml.org/lkml/2020/3/22/393
> > 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
