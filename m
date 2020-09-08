Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E14C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8233F21741
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SoxgOgDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgIHItX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:49:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53288 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbgIHItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:49:22 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0888mooZ084528;
        Tue, 8 Sep 2020 03:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599554930;
        bh=gUGWPLTknhIG/cV6SLv5pqNO3E2DIgRX6hAn1d3Vdq0=;
        h=Subject:To:References:From:CC:Date:In-Reply-To;
        b=SoxgOgDrS1JGA/JSvRVQoKg1Pu/mkGYqUYMgh7targDSt5H3KwkSrVmjYZCH2Hl1a
         VrJVcBdMWaMD4b55qUFmUvj0g3fnmskCYpzyAiDyqIce3LH/q90saau2hx5vWR9ZcO
         rjW1xZp7f7U6Kw0ZC9jl0+2b/ist2+KIVpvfXSEM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0888mowc036624;
        Tue, 8 Sep 2020 03:48:50 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 03:48:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 03:48:50 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0888mjbR032303;
        Tue, 8 Sep 2020 03:48:46 -0500
Subject: Re: [PATCH] Platform integrity information in sysfs
To:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
References: <20200903161804.403299-1-daniel.gutson@eclypsium.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Message-ID: <7885ca85-5982-a0d5-2307-d785d4dc0eea@ti.com>
Date:   Tue, 8 Sep 2020 14:18:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903161804.403299-1-daniel.gutson@eclypsium.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/3/20 9:48 PM, Daniel Gutson wrote:
> This patch exports information about the platform integrity
> firmware configuration in the sysfs filesystem.
> In this initial patch, I include some configuration attributes
> for the system SPI chip.
> 

Please avoid first-person singular pronouns instead use imperative mood.

> This initial version exports the BIOS Write Enable (bioswe),
> BIOS Lock Enable (ble), and the SMM BIOS Write Protect (SMM_BWP)
> fields of the BIOS Control register. The idea is to keep adding more
> flags, not only from the BC but also from other registers in following
> versions.
> 
> The goal is that the attributes are avilable to fwupd when SecureBoot
> is turned on.
> 

s/avilable/available

> The patch provides a new misc driver, as proposed in the previous patch,
> that provides a registration function for HW Driver devices to register
> class_attributes.
> In this case, the intel SPI flash chip (intel-spi) registers three

s/intel SPI/Intel SPI

> class_attributes corresponding to the fields mentioned above.
> 
> This version of the patch provides a new API supporting regular
> device attributes rather than custom attributes, and also avoids
> a race condition when exporting the driver sysfs dir and the
> attributes files inside it.
> Also, this patch renames 'platform lockdown' by 'platform integrity'.

Changes wrt to previous versions should not be part of commit message
but instead should be below tearline (b/w "---" and diffstat below)

> 
> Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> ---

Changes wrt previous versions go here...

>  .../ABI/stable/sysfs-class-platform-integrity | 23 +++++
>  MAINTAINERS                                   |  7 ++
>  drivers/misc/Kconfig                          | 11 +++
>  drivers/misc/Makefile                         |  1 +
>  drivers/misc/platform-integrity.c             | 61 +++++++++++++
>  drivers/mtd/spi-nor/controllers/Kconfig       |  1 +
>  .../mtd/spi-nor/controllers/intel-spi-pci.c   | 64 ++++++++++++-
>  .../spi-nor/controllers/intel-spi-platform.c  |  2 +-
>  drivers/mtd/spi-nor/controllers/intel-spi.c   | 89 ++++++++++++++++++-
>  drivers/mtd/spi-nor/controllers/intel-spi.h   |  5 +-
>  include/linux/platform-integrity.h            | 20 +++++
>  11 files changed, 278 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/ABI/stable/sysfs-class-platform-integrity
>  create mode 100644 drivers/misc/platform-integrity.c
>  create mode 100644 include/linux/platform-integrity.h
> 


You forgot to cc linux-mtd lists and hence patch did not show up in my
queue.. MTD Patches are managed via patchoworks and if linux-mtd is not
cc'd then they will most likely be ignored. Please use
scripts/get_maintainer.pl to get list of maintainters and mailing lists
to cc.

Also, this patch needs to be split into at least two patches: one
introducing platform-integrity module and another adding suuport for
intel-spi driver to use the same.

Also, I see there are multiple iterations of the patch posted but are
not versioned. Please use appropriate version number in $subject.

Please read Documentation/process/submitting-patches.rst for more details.


> diff --git a/Documentation/ABI/stable/sysfs-class-platform-integrity b/Documentation/ABI/stable/sysfs-class-platform-integrity
> new file mode 100644
> index 000000000000..b31ec051ca48
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-class-platform-integrity
> @@ -0,0 +1,23 @@
> +What:		/sys/class/platform-integrity/intel-spi/bioswe
> +Date:		September 2020
> +KernelVersion:	5.9.1

5.9 merge window is closed. This won't make it to 5.9... Maybe 5.10

> +Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
> +Description:	If the system firmware set BIOS Write Enable.
> +		0: writes disabled, 1: writes enabled.
> +Users:		https://github.com/fwupd/fwupd
> +
> +What:		/sys/class/platform-integrity/intel-spi/ble

Naming seems inconsistent... Previous entry was bioswe (BIOS write
enable) but this one is called ble (BIOS latch enable). Maybe rename
previous one as bwe to be consistent with other entries?

> +Date:		September 2020
> +KernelVersion:	5.9.1
> +Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
> +Description:	If the system firmware set BIOS Lock Enable.
> +		0: SMM lock disabled, 1: SMM lock enabled.
> +Users:		https://github.com/fwupd/fwupd
> +
> +What:		/sys/class/platform-integrity/intel-spi/smm_bwp
> +Date:		September 2020
> +KernelVersion:	5.9.1
> +Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
> +Description:	If the system firmware set SMM BIOS Write Protect.
> +		0: writes disabled unless in SMM, 1: writes enabled.

Is SMM a standard abbreviation in  Intel world? If not you may want to
expand what it means in Description.

> +Users:		https://github.com/fwupd/fwupd
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e4647c84c987..771eaf715427 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13744,6 +13744,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
>  F:	drivers/iio/chemical/pms7003.c
>  
> +PLATFORM INTEGRITY DATA MODULE
> +M:	Daniel Gutson <daniel.gutson@eclypsium.com>
> +S:	Supported
> +F:	Documentation/ABI/sysfs-class-platform-integrity
> +F:	drivers/misc/platform-integrity.c
> +F:	include/linux/platform-integrity.h
> +
>  PLDMFW LIBRARY
>  M:	Jacob Keller <jacob.e.keller@intel.com>
>  S:	Maintained
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index ce136d685d14..d5d0de5b5706 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -456,6 +456,17 @@ config PVPANIC
>  	  a paravirtualized device provided by QEMU; it lets a virtual machine
>  	  (guest) communicate panic events to the host.
>  
> +config PLATFORM_INTEGRITY_ATTRS
> +	tristate "Platform integrity information in the sysfs"
> +	depends on SYSFS
> +	help
> +	  This kernel module is a helper driver to provide information about
> +	  platform integrity settings and configuration.
> +	  This module is used by other device drivers -such as the intel-spi-
> +	  to publish the information in /sys/class/platform-integrity which is
> +	  consumed by software such as fwupd which can verify the platform
> +	  has been configured in a secure way.
> +

[...]

> diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
> index 5c0e0ec2e6d1..113e349a826b 100644
> --- a/drivers/mtd/spi-nor/controllers/Kconfig
> +++ b/drivers/mtd/spi-nor/controllers/Kconfig
> @@ -29,6 +29,7 @@ config SPI_NXP_SPIFI
>  
>  config SPI_INTEL_SPI
>  	tristate
> +	select PLATFORM_INTEGRITY_ATTRS
>  

Not a good idea to use select clause on symbols that have dependencies
as select will force a symbol to a value without visiting the
dependencies. Instead use depends on


>  config SPI_INTEL_SPI_PCI
>  	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
> diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> index c72aa1ab71ad..e1bca8aedf7c 100644
> --- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> +++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> @@ -10,11 +10,19 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/platform-integrity.h>
>  
>  #include "intel-spi.h"
>  
>  #define BCR		0xdc
>  #define BCR_WPD		BIT(0)
> +#define BCR_BLE		BIT(1)
> +#define BCR_SMM_BWP	BIT(5)
> +
> +struct cnl_spi_attr {
> +	struct device_attribute dev_attr;
> +	u32 mask;
> +};
>  
>  static const struct intel_spi_boardinfo bxt_info = {
>  	.type = INTEL_SPI_BXT,
> @@ -24,6 +32,59 @@ static const struct intel_spi_boardinfo cnl_info = {
>  	.type = INTEL_SPI_CNL,
>  };
>  
> +static ssize_t cnl_spi_attr_show(struct device *dev,
> +	struct device_attribute *attr, char *buf, u32 mask)
> +{

Please be consistent with existing code and use intel_spi_ prefix for
function names.

Also Alignment should match open parenthesis..
Please run scripts/checkpatch.pl --strict on patch and fix all issue
reported.

[...]

Regards
Vignesh
