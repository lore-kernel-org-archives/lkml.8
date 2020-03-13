Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D38C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 06:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE682072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 06:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b+CM0tdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCMGKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 02:10:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49844 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgCMGKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 02:10:15 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02D68FsQ036412;
        Fri, 13 Mar 2020 01:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584079695;
        bh=7hMhQU6W5PizIodHl1k5zdVR6Ov/YWaMnAHEZuZ14wg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=b+CM0tdCtny7NjFpwamCeKHuqXv+KlTF+1tFAMmDT5cct4OMc8fwZ1ySq1IiRKVQe
         sH1EK7k0tUGl/oqR5aCWvr2Z1jCILvnJuv0Q6lMtAQLm7PankjeqrcHFo83avJyofU
         pNWKYoooSa6TDc3BZ2uCdnUM1Xct3SCPpl+BvK9I=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02D68Fbg123665
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Mar 2020 01:08:15 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 13
 Mar 2020 01:08:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 13 Mar 2020 01:08:14 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02D685dR123842;
        Fri, 13 Mar 2020 01:08:06 -0500
Subject: Re: [PATCH 02/23] mtd: spi-nor: Prepare core / manufacturer code
 split
To:     <Tudor.Ambarus@microchip.com>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <matthias.bgg@gmail.com>, <vz@mleia.com>,
        <michal.simek@xilinx.com>, <ludovic.barre@st.com>,
        <john.garry@huawei.com>, <tglx@linutronix.de>,
        <nishkadg.linux@gmail.com>, <michael@walle.cc>,
        <dinguyen@kernel.org>, <thor.thayer@linux.intel.com>,
        <swboyd@chromium.org>, <opensource@jilayne.com>,
        <mika.westerberg@linux.intel.com>, <kstewart@linuxfoundation.org>,
        <allison@lohutok.net>, <jethro@fortanix.com>, <info@metux.net>,
        <alexander.sverdlin@nokia.com>, <rfontana@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
 <20200302180730.1886678-3-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <c5ef3581-e589-1206-3856-dc4000c0b511@ti.com>
Date:   Fri, 13 Mar 2020 11:38:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200302180730.1886678-3-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/03/20 11:37 pm, Tudor.Ambarus@microchip.com wrote:
> From: Boris Brezillon <bbrezillon@kernel.org>
> 
> Move all SPI NOR controller drivers to a controllers/ sub-directory
> so that we only have SPI NOR related source files under
> drivers/mtd/spi-nor/.
> 
> Rename spi-nor.c into core.c, we are about to split this file in multiple
> source files (one per manufacturer, plus one for the SFDP parsing logic).
> 
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>


But there are at least two drivers being moved from spi-nor to spi/
which would conflict with this change.

Regards
Vignesh

> ---
>  drivers/mtd/spi-nor/Kconfig                   | 83 +------------------
>  drivers/mtd/spi-nor/Makefile                  | 10 +--
>  drivers/mtd/spi-nor/controllers/Kconfig       | 83 +++++++++++++++++++
>  drivers/mtd/spi-nor/controllers/Makefile      |  9 ++
>  .../spi-nor/{ => controllers}/aspeed-smc.c    |  0
>  .../{ => controllers}/cadence-quadspi.c       |  0
>  .../mtd/spi-nor/{ => controllers}/hisi-sfc.c  |  0
>  .../spi-nor/{ => controllers}/intel-spi-pci.c |  0
>  .../{ => controllers}/intel-spi-platform.c    |  0
>  .../mtd/spi-nor/{ => controllers}/intel-spi.c |  0
>  .../mtd/spi-nor/{ => controllers}/intel-spi.h |  0
>  .../spi-nor/{ => controllers}/mtk-quadspi.c   |  0
>  .../mtd/spi-nor/{ => controllers}/nxp-spifi.c |  0
>  drivers/mtd/spi-nor/{spi-nor.c => core.c}     |  0
>  14 files changed, 95 insertions(+), 90 deletions(-)
>  create mode 100644 drivers/mtd/spi-nor/controllers/Kconfig
>  create mode 100644 drivers/mtd/spi-nor/controllers/Makefile
>  rename drivers/mtd/spi-nor/{ => controllers}/aspeed-smc.c (100%)
>  rename drivers/mtd/spi-nor/{ => controllers}/cadence-quadspi.c (100%)
>  rename drivers/mtd/spi-nor/{ => controllers}/hisi-sfc.c (100%)
>  rename drivers/mtd/spi-nor/{ => controllers}/intel-spi-pci.c (100%)
>  rename drivers/mtd/spi-nor/{ => controllers}/intel-spi-platform.c (100%)
>  rename drivers/mtd/spi-nor/{ => controllers}/intel-spi.c (100%)
>  rename drivers/mtd/spi-nor/{ => controllers}/intel-spi.h (100%)
>  rename drivers/mtd/spi-nor/{ => controllers}/mtk-quadspi.c (100%)
>  rename drivers/mtd/spi-nor/{ => controllers}/nxp-spifi.c (100%)
>  rename drivers/mtd/spi-nor/{spi-nor.c => core.c} (100%)
> 
> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
> index c1eda67d1ad2..6e816eafb312 100644
> --- a/drivers/mtd/spi-nor/Kconfig
> +++ b/drivers/mtd/spi-nor/Kconfig
> @@ -24,87 +24,6 @@ config MTD_SPI_NOR_USE_4K_SECTORS
>  	  Please note that some tools/drivers/filesystems may not work with
>  	  4096 B erase size (e.g. UBIFS requires 15 KiB as a minimum).
>  
> -config SPI_ASPEED_SMC
> -	tristate "Aspeed flash controllers in SPI mode"
> -	depends on ARCH_ASPEED || COMPILE_TEST
> -	depends on HAS_IOMEM && OF
> -	help
> -	  This enables support for the Firmware Memory controller (FMC)
> -	  in the Aspeed AST2500/AST2400 SoCs when attached to SPI NOR chips,
> -	  and support for the SPI flash memory controller (SPI) for
> -	  the host firmware. The implementation only supports SPI NOR.
> -
> -config SPI_CADENCE_QUADSPI
> -	tristate "Cadence Quad SPI controller"
> -	depends on OF && (ARM || ARM64 || COMPILE_TEST)
> -	help
> -	  Enable support for the Cadence Quad SPI Flash controller.
> -
> -	  Cadence QSPI is a specialized controller for connecting an SPI
> -	  Flash over 1/2/4-bit wide bus. Enable this option if you have a
> -	  device with a Cadence QSPI controller and want to access the
> -	  Flash as an MTD device.
> -
> -config SPI_HISI_SFC
> -	tristate "Hisilicon FMC SPI-NOR Flash Controller(SFC)"
> -	depends on ARCH_HISI || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	help
> -	  This enables support for HiSilicon FMC SPI-NOR flash controller.
> -
> -config SPI_MTK_QUADSPI
> -	tristate "MediaTek Quad SPI controller"
> -	depends on HAS_IOMEM
> -	help
> -	  This enables support for the Quad SPI controller in master mode.
> -	  This controller does not support generic SPI. It only supports
> -	  SPI NOR.
> -
> -config SPI_NXP_SPIFI
> -	tristate "NXP SPI Flash Interface (SPIFI)"
> -	depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
> -	depends on HAS_IOMEM
> -	help
> -	  Enable support for the NXP LPC SPI Flash Interface controller.
> -
> -	  SPIFI is a specialized controller for connecting serial SPI
> -	  Flash. Enable this option if you have a device with a SPIFI
> -	  controller and want to access the Flash as a mtd device.
> -
> -config SPI_INTEL_SPI
> -	tristate
> -
> -config SPI_INTEL_SPI_PCI
> -	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
> -	depends on X86 && PCI
> -	select SPI_INTEL_SPI
> -	help
> -	  This enables PCI support for the Intel PCH/PCU SPI controller in
> -	  master mode. This controller is present in modern Intel hardware
> -	  and is used to hold BIOS and other persistent settings. Using
> -	  this driver it is possible to upgrade BIOS directly from Linux.
> -
> -	  Say N here unless you know what you are doing. Overwriting the
> -	  SPI flash may render the system unbootable.
> -
> -	  To compile this driver as a module, choose M here: the module
> -	  will be called intel-spi-pci.
> -
> -config SPI_INTEL_SPI_PLATFORM
> -	tristate "Intel PCH/PCU SPI flash platform driver (DANGEROUS)"
> -	depends on X86
> -	select SPI_INTEL_SPI
> -	help
> -	  This enables platform support for the Intel PCH/PCU SPI
> -	  controller in master mode. This controller is present in modern
> -	  Intel hardware and is used to hold BIOS and other persistent
> -	  settings. Using this driver it is possible to upgrade BIOS
> -	  directly from Linux.
> -
> -	  Say N here unless you know what you are doing. Overwriting the
> -	  SPI flash may render the system unbootable.
> -
> -	  To compile this driver as a module, choose M here: the module
> -	  will be called intel-spi-platform.
> +source "drivers/mtd/spi-nor/controllers/Kconfig"
>  
>  endif # MTD_SPI_NOR
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index 9c5ed03cdc19..d6fc70ab4a32 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -1,10 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> +
> +spi-nor-objs			:= core.o
>  obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
> -obj-$(CONFIG_SPI_ASPEED_SMC)	+= aspeed-smc.o
> -obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= cadence-quadspi.o
> -obj-$(CONFIG_SPI_HISI_SFC)	+= hisi-sfc.o
> -obj-$(CONFIG_SPI_MTK_QUADSPI)    += mtk-quadspi.o
> -obj-$(CONFIG_SPI_NXP_SPIFI)	+= nxp-spifi.o
> -obj-$(CONFIG_SPI_INTEL_SPI)	+= intel-spi.o
> -obj-$(CONFIG_SPI_INTEL_SPI_PCI)	+= intel-spi-pci.o
> -obj-$(CONFIG_SPI_INTEL_SPI_PLATFORM)	+= intel-spi-platform.o
> diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
> new file mode 100644
> index 000000000000..a02feb201a5b
> --- /dev/null
> +++ b/drivers/mtd/spi-nor/controllers/Kconfig
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config SPI_ASPEED_SMC
> +	tristate "Aspeed flash controllers in SPI mode"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	depends on HAS_IOMEM && OF
> +	help
> +	  This enables support for the Firmware Memory controller (FMC)
> +	  in the Aspeed AST2500/AST2400 SoCs when attached to SPI NOR chips,
> +	  and support for the SPI flash memory controller (SPI) for
> +	  the host firmware. The implementation only supports SPI NOR.
> +
> +config SPI_CADENCE_QUADSPI
> +	tristate "Cadence Quad SPI controller"
> +	depends on OF && (ARM || ARM64 || COMPILE_TEST)
> +	help
> +	  Enable support for the Cadence Quad SPI Flash controller.
> +
> +	  Cadence QSPI is a specialized controller for connecting an SPI
> +	  Flash over 1/2/4-bit wide bus. Enable this option if you have a
> +	  device with a Cadence QSPI controller and want to access the
> +	  Flash as an MTD device.
> +
> +config SPI_HISI_SFC
> +	tristate "Hisilicon FMC SPI-NOR Flash Controller(SFC)"
> +	depends on ARCH_HISI || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This enables support for HiSilicon FMC SPI-NOR flash controller.
> +
> +config SPI_MTK_QUADSPI
> +	tristate "MediaTek Quad SPI controller"
> +	depends on HAS_IOMEM
> +	help
> +	  This enables support for the Quad SPI controller in master mode.
> +	  This controller does not support generic SPI. It only supports
> +	  SPI NOR.
> +
> +config SPI_NXP_SPIFI
> +	tristate "NXP SPI Flash Interface (SPIFI)"
> +	depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
> +	depends on HAS_IOMEM
> +	help
> +	  Enable support for the NXP LPC SPI Flash Interface controller.
> +
> +	  SPIFI is a specialized controller for connecting serial SPI
> +	  Flash. Enable this option if you have a device with a SPIFI
> +	  controller and want to access the Flash as a mtd device.
> +
> +config SPI_INTEL_SPI
> +	tristate
> +
> +config SPI_INTEL_SPI_PCI
> +	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
> +	depends on X86 && PCI
> +	select SPI_INTEL_SPI
> +	help
> +	  This enables PCI support for the Intel PCH/PCU SPI controller in
> +	  master mode. This controller is present in modern Intel hardware
> +	  and is used to hold BIOS and other persistent settings. Using
> +	  this driver it is possible to upgrade BIOS directly from Linux.
> +
> +	  Say N here unless you know what you are doing. Overwriting the
> +	  SPI flash may render the system unbootable.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called intel-spi-pci.
> +
> +config SPI_INTEL_SPI_PLATFORM
> +	tristate "Intel PCH/PCU SPI flash platform driver (DANGEROUS)"
> +	depends on X86
> +	select SPI_INTEL_SPI
> +	help
> +	  This enables platform support for the Intel PCH/PCU SPI
> +	  controller in master mode. This controller is present in modern
> +	  Intel hardware and is used to hold BIOS and other persistent
> +	  settings. Using this driver it is possible to upgrade BIOS
> +	  directly from Linux.
> +
> +	  Say N here unless you know what you are doing. Overwriting the
> +	  SPI flash may render the system unbootable.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called intel-spi-platform.
> diff --git a/drivers/mtd/spi-nor/controllers/Makefile b/drivers/mtd/spi-nor/controllers/Makefile
> new file mode 100644
> index 000000000000..c9a39992d63d
> --- /dev/null
> +++ b/drivers/mtd/spi-nor/controllers/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_SPI_ASPEED_SMC)	+= aspeed-smc.o
> +obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= cadence-quadspi.o
> +obj-$(CONFIG_SPI_HISI_SFC)	+= hisi-sfc.o
> +obj-$(CONFIG_SPI_MTK_QUADSPI)    += mtk-quadspi.o
> +obj-$(CONFIG_SPI_NXP_SPIFI)	+= nxp-spifi.o
> +obj-$(CONFIG_SPI_INTEL_SPI)	+= intel-spi.o
> +obj-$(CONFIG_SPI_INTEL_SPI_PCI)	+= intel-spi-pci.o
> +obj-$(CONFIG_SPI_INTEL_SPI_PLATFORM)	+= intel-spi-platform.o
> diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> similarity index 100%
> rename from drivers/mtd/spi-nor/aspeed-smc.c
> rename to drivers/mtd/spi-nor/controllers/aspeed-smc.c
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
> similarity index 100%
> rename from drivers/mtd/spi-nor/cadence-quadspi.c
> rename to drivers/mtd/spi-nor/controllers/cadence-quadspi.c
> diff --git a/drivers/mtd/spi-nor/hisi-sfc.c b/drivers/mtd/spi-nor/controllers/hisi-sfc.c
> similarity index 100%
> rename from drivers/mtd/spi-nor/hisi-sfc.c
> rename to drivers/mtd/spi-nor/controllers/hisi-sfc.c
> diff --git a/drivers/mtd/spi-nor/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> similarity index 100%
> rename from drivers/mtd/spi-nor/intel-spi-pci.c
> rename to drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> diff --git a/drivers/mtd/spi-nor/intel-spi-platform.c b/drivers/mtd/spi-nor/controllers/intel-spi-platform.c
> similarity index 100%
> rename from drivers/mtd/spi-nor/intel-spi-platform.c
> rename to drivers/mtd/spi-nor/controllers/intel-spi-platform.c
> diff --git a/drivers/mtd/spi-nor/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
> similarity index 100%
> rename from drivers/mtd/spi-nor/intel-spi.c
> rename to drivers/mtd/spi-nor/controllers/intel-spi.c
> diff --git a/drivers/mtd/spi-nor/intel-spi.h b/drivers/mtd/spi-nor/controllers/intel-spi.h
> similarity index 100%
> rename from drivers/mtd/spi-nor/intel-spi.h
> rename to drivers/mtd/spi-nor/controllers/intel-spi.h
> diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/controllers/mtk-quadspi.c
> similarity index 100%
> rename from drivers/mtd/spi-nor/mtk-quadspi.c
> rename to drivers/mtd/spi-nor/controllers/mtk-quadspi.c
> diff --git a/drivers/mtd/spi-nor/nxp-spifi.c b/drivers/mtd/spi-nor/controllers/nxp-spifi.c
> similarity index 100%
> rename from drivers/mtd/spi-nor/nxp-spifi.c
> rename to drivers/mtd/spi-nor/controllers/nxp-spifi.c
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/core.c
> similarity index 100%
> rename from drivers/mtd/spi-nor/spi-nor.c
> rename to drivers/mtd/spi-nor/core.c
> 

-- 
Regards
Vignesh
