Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1DAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0DA24673
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="pnTkZw2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgCBSIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:08:20 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:10296 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBSHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:07:50 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: uhxCy27+Ur3i9ItUaTrI/LQaQp2hVJNRwWTHljDJhgyK/fr2+sQO7C/anq9iOQ1zO9Qv5zy9HJ
 bmZuNqMEF30vF1mD7FD9thYIz3G9IZyv/0CFTfpM5qy8dD04CwyyT4sbamWEneV2HJbhGexteE
 ObH1nlprDJf6GcriK0S/pjR0e+WgvndI/gNrXk6E6TIfKe/QuIc6IzHz+7usRVIZc/y2Mt2Mso
 Opqdxt4pkJoeaLWbgG9tZ9hAyPsTYjqPdASvskxm2d3mpb1yHlTVf0V1Mk3N91xSZLiAK1Qr4f
 rwU=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="67338180"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 11:07:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 11:07:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Mar 2020 11:08:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uyeozx439EqpHYRGNCxgo3mqE+BMShQGYRBK6V3TUTBZoJ7kKThocEwj2IWXZ0gwtM9lhBk+ypJilZc8+P9tl4rEnvvsc2lGjXCqrT58raCaQ85sJtMJvFZkGZo/MbMipkMzF7sQF8jBTePYEdo9KXliu2+14PR8IhcFxtCFz+V1ApT2gxp8t4wdOHRKeMKyfQjNSMqiJtXyhdNecbmviE5VsicmHwwmGQQI10mqzc7P01k6mxftNBuLEXjzm7UWuuI2ZEyw9VOU52gXR62W1j1NmC7Pu8eQu2HKJZrPFgBzWXfcshPZNO4YAvYa7OXKaJglFbsV0vW/kwdVuQ8y7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPxrkCkQqNqU+b6FFgkNl9EYaqH0JCZOmu++pJgNvEg=;
 b=nP482CSyhvu59jrbc4BOsmWiUPPqDEK3lEtzrCwlm4sKyVVxIBGcfabPRveI02zKpPunFs8Hn/cDewO7tLDbBoaTprE71rcz2t91t+SW5GZRj8e6OOfJiD/oLfi04LShIyJlhu+2B57ziwQ4+xbZAdJnjebMJUftR5kirKoZw2lqXSuQvVLaH+qujVw8/CbbOYVtEAnxhVf5kA/Z2nek91vxoinnGJ8OV6UygyUcAAwOKlV805HFSnuiJgwubujlmUJDdVsLY8JoXVuy/e2je5Zl9y3HxYMtxzHErRP0ldusDGb4bob4sPkDHBJy1jXwmLi0zW5trMN8jBZVmai6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPxrkCkQqNqU+b6FFgkNl9EYaqH0JCZOmu++pJgNvEg=;
 b=pnTkZw2LPCMYavsvelh8mN7wfcyw1FaPca6/R4mcYltogAiAFx73OEJqK06+wjI0ub1Vlm/aw8ovraxex9xNa3M8Z5HwPnEw1yJBkBaMtW+02Aj1DUHtiwt94OraNUnseEYZs1zwiuJgbRhg4me6QTDYMYFxNjMSWn8mo5aZRyo=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4142.namprd11.prod.outlook.com (2603:10b6:208:135::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 18:07:46 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 18:07:46 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <bbrezillon@kernel.org>, <vigneshr@ti.com>,
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
        <linux-arm-kernel@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 02/23] mtd: spi-nor: Prepare core / manufacturer code split
Thread-Topic: [PATCH 02/23] mtd: spi-nor: Prepare core / manufacturer code
 split
Thread-Index: AQHV8L15nmnasgoh8EaqP5eIJ1zhFQ==
Date:   Mon, 2 Mar 2020 18:07:45 +0000
Message-ID: <20200302180730.1886678-3-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd8f7729-a5e2-46b4-c54d-08d7bed49cae
x-ms-traffictypediagnostic: MN2PR11MB4142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4142F599D5197D258DCF9832F0E70@MN2PR11MB4142.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(36756003)(26005)(66446008)(107886003)(6486002)(186003)(2616005)(4326008)(478600001)(6512007)(91956017)(64756008)(66946007)(2906002)(71200400001)(76116006)(8936002)(316002)(30864003)(86362001)(54906003)(6506007)(66556008)(5660300002)(66476007)(7406005)(1076003)(7416002)(81156014)(81166006)(110136005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4142;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gGGNcJiFiEaJME6HBC1zqZyw4UjhiMxiI2KRyOC/JZhdiV3dAKnOSr7+3at57xrF8n6hQJKv5A1l6i0R7u0GAZimLGd3qMvPw/rPVpLvr+RgWrzEs2YTauOGwp1AbnW4ajqt+B8zBuzOi6vZEL+oh0ArRvylnP5b7EqCObGL0zhxLsO/g/MRGhlYY6/agkqslzlGAOn4nzA+rfzLDr7TeHxmKX5Csi2ZGvWAsjB5Einh5TjyfwA/iwsUSOeZhtDUlya9FBMEAkKaU44+FjNB6soLufjEtav3KzGBkpL9EM0c1+r7luqGRfmDq9TAa1297tqpKsdaTLGYdJGj24umeO301ww/LvRuvEm8eVT5rh/EbizfH+5dQdRdDEbBtrGpKBjyu/tULn9xiRdTqgnQIEBidxyOsPJuts92DDhM2CjewWCbJmMrrVKfhUvxotqU
x-ms-exchange-antispam-messagedata: /JaGTzZKH+W755wTw/FVm36Xauo+5NXX4HzeCk79UIz3hU3HhTPl3ar9my33QUpO0t/nEpLGqlW3/6gdnlXy+2tBr0Aolo/Dd0yxPs6W0b3Nvn7wdANCHLDdPhwzFZtlPyBJ/yewwbXXGoqPUSCP6Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8f7729-a5e2-46b4-c54d-08d7bed49cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:07:45.3916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1iO0e1XQ+CvS1E+ksDIl0zkowoV7v3SXtJhUnkJbWP6hGde/4cLITcJK9AwwjBU6f4Bd0AVJEHJV7NhYrwWulB10YTO7WHWuz8Y36sr6H+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

Move all SPI NOR controller drivers to a controllers/ sub-directory
so that we only have SPI NOR related source files under
drivers/mtd/spi-nor/.

Rename spi-nor.c into core.c, we are about to split this file in multiple
source files (one per manufacturer, plus one for the SFDP parsing logic).

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Kconfig                   | 83 +------------------
 drivers/mtd/spi-nor/Makefile                  | 10 +--
 drivers/mtd/spi-nor/controllers/Kconfig       | 83 +++++++++++++++++++
 drivers/mtd/spi-nor/controllers/Makefile      |  9 ++
 .../spi-nor/{ =3D> controllers}/aspeed-smc.c    |  0
 .../{ =3D> controllers}/cadence-quadspi.c       |  0
 .../mtd/spi-nor/{ =3D> controllers}/hisi-sfc.c  |  0
 .../spi-nor/{ =3D> controllers}/intel-spi-pci.c |  0
 .../{ =3D> controllers}/intel-spi-platform.c    |  0
 .../mtd/spi-nor/{ =3D> controllers}/intel-spi.c |  0
 .../mtd/spi-nor/{ =3D> controllers}/intel-spi.h |  0
 .../spi-nor/{ =3D> controllers}/mtk-quadspi.c   |  0
 .../mtd/spi-nor/{ =3D> controllers}/nxp-spifi.c |  0
 drivers/mtd/spi-nor/{spi-nor.c =3D> core.c}     |  0
 14 files changed, 95 insertions(+), 90 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/controllers/Kconfig
 create mode 100644 drivers/mtd/spi-nor/controllers/Makefile
 rename drivers/mtd/spi-nor/{ =3D> controllers}/aspeed-smc.c (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/cadence-quadspi.c (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/hisi-sfc.c (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/intel-spi-pci.c (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/intel-spi-platform.c (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/intel-spi.c (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/intel-spi.h (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/mtk-quadspi.c (100%)
 rename drivers/mtd/spi-nor/{ =3D> controllers}/nxp-spifi.c (100%)
 rename drivers/mtd/spi-nor/{spi-nor.c =3D> core.c} (100%)

diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index c1eda67d1ad2..6e816eafb312 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -24,87 +24,6 @@ config MTD_SPI_NOR_USE_4K_SECTORS
 	  Please note that some tools/drivers/filesystems may not work with
 	  4096 B erase size (e.g. UBIFS requires 15 KiB as a minimum).
=20
-config SPI_ASPEED_SMC
-	tristate "Aspeed flash controllers in SPI mode"
-	depends on ARCH_ASPEED || COMPILE_TEST
-	depends on HAS_IOMEM && OF
-	help
-	  This enables support for the Firmware Memory controller (FMC)
-	  in the Aspeed AST2500/AST2400 SoCs when attached to SPI NOR chips,
-	  and support for the SPI flash memory controller (SPI) for
-	  the host firmware. The implementation only supports SPI NOR.
-
-config SPI_CADENCE_QUADSPI
-	tristate "Cadence Quad SPI controller"
-	depends on OF && (ARM || ARM64 || COMPILE_TEST)
-	help
-	  Enable support for the Cadence Quad SPI Flash controller.
-
-	  Cadence QSPI is a specialized controller for connecting an SPI
-	  Flash over 1/2/4-bit wide bus. Enable this option if you have a
-	  device with a Cadence QSPI controller and want to access the
-	  Flash as an MTD device.
-
-config SPI_HISI_SFC
-	tristate "Hisilicon FMC SPI-NOR Flash Controller(SFC)"
-	depends on ARCH_HISI || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  This enables support for HiSilicon FMC SPI-NOR flash controller.
-
-config SPI_MTK_QUADSPI
-	tristate "MediaTek Quad SPI controller"
-	depends on HAS_IOMEM
-	help
-	  This enables support for the Quad SPI controller in master mode.
-	  This controller does not support generic SPI. It only supports
-	  SPI NOR.
-
-config SPI_NXP_SPIFI
-	tristate "NXP SPI Flash Interface (SPIFI)"
-	depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
-	depends on HAS_IOMEM
-	help
-	  Enable support for the NXP LPC SPI Flash Interface controller.
-
-	  SPIFI is a specialized controller for connecting serial SPI
-	  Flash. Enable this option if you have a device with a SPIFI
-	  controller and want to access the Flash as a mtd device.
-
-config SPI_INTEL_SPI
-	tristate
-
-config SPI_INTEL_SPI_PCI
-	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
-	depends on X86 && PCI
-	select SPI_INTEL_SPI
-	help
-	  This enables PCI support for the Intel PCH/PCU SPI controller in
-	  master mode. This controller is present in modern Intel hardware
-	  and is used to hold BIOS and other persistent settings. Using
-	  this driver it is possible to upgrade BIOS directly from Linux.
-
-	  Say N here unless you know what you are doing. Overwriting the
-	  SPI flash may render the system unbootable.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel-spi-pci.
-
-config SPI_INTEL_SPI_PLATFORM
-	tristate "Intel PCH/PCU SPI flash platform driver (DANGEROUS)"
-	depends on X86
-	select SPI_INTEL_SPI
-	help
-	  This enables platform support for the Intel PCH/PCU SPI
-	  controller in master mode. This controller is present in modern
-	  Intel hardware and is used to hold BIOS and other persistent
-	  settings. Using this driver it is possible to upgrade BIOS
-	  directly from Linux.
-
-	  Say N here unless you know what you are doing. Overwriting the
-	  SPI flash may render the system unbootable.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel-spi-platform.
+source "drivers/mtd/spi-nor/controllers/Kconfig"
=20
 endif # MTD_SPI_NOR
diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 9c5ed03cdc19..d6fc70ab4a32 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -1,10 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
+
+spi-nor-objs			:=3D core.o
 obj-$(CONFIG_MTD_SPI_NOR)	+=3D spi-nor.o
-obj-$(CONFIG_SPI_ASPEED_SMC)	+=3D aspeed-smc.o
-obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+=3D cadence-quadspi.o
-obj-$(CONFIG_SPI_HISI_SFC)	+=3D hisi-sfc.o
-obj-$(CONFIG_SPI_MTK_QUADSPI)    +=3D mtk-quadspi.o
-obj-$(CONFIG_SPI_NXP_SPIFI)	+=3D nxp-spifi.o
-obj-$(CONFIG_SPI_INTEL_SPI)	+=3D intel-spi.o
-obj-$(CONFIG_SPI_INTEL_SPI_PCI)	+=3D intel-spi-pci.o
-obj-$(CONFIG_SPI_INTEL_SPI_PLATFORM)	+=3D intel-spi-platform.o
diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/=
controllers/Kconfig
new file mode 100644
index 000000000000..a02feb201a5b
--- /dev/null
+++ b/drivers/mtd/spi-nor/controllers/Kconfig
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config SPI_ASPEED_SMC
+	tristate "Aspeed flash controllers in SPI mode"
+	depends on ARCH_ASPEED || COMPILE_TEST
+	depends on HAS_IOMEM && OF
+	help
+	  This enables support for the Firmware Memory controller (FMC)
+	  in the Aspeed AST2500/AST2400 SoCs when attached to SPI NOR chips,
+	  and support for the SPI flash memory controller (SPI) for
+	  the host firmware. The implementation only supports SPI NOR.
+
+config SPI_CADENCE_QUADSPI
+	tristate "Cadence Quad SPI controller"
+	depends on OF && (ARM || ARM64 || COMPILE_TEST)
+	help
+	  Enable support for the Cadence Quad SPI Flash controller.
+
+	  Cadence QSPI is a specialized controller for connecting an SPI
+	  Flash over 1/2/4-bit wide bus. Enable this option if you have a
+	  device with a Cadence QSPI controller and want to access the
+	  Flash as an MTD device.
+
+config SPI_HISI_SFC
+	tristate "Hisilicon FMC SPI-NOR Flash Controller(SFC)"
+	depends on ARCH_HISI || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This enables support for HiSilicon FMC SPI-NOR flash controller.
+
+config SPI_MTK_QUADSPI
+	tristate "MediaTek Quad SPI controller"
+	depends on HAS_IOMEM
+	help
+	  This enables support for the Quad SPI controller in master mode.
+	  This controller does not support generic SPI. It only supports
+	  SPI NOR.
+
+config SPI_NXP_SPIFI
+	tristate "NXP SPI Flash Interface (SPIFI)"
+	depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
+	depends on HAS_IOMEM
+	help
+	  Enable support for the NXP LPC SPI Flash Interface controller.
+
+	  SPIFI is a specialized controller for connecting serial SPI
+	  Flash. Enable this option if you have a device with a SPIFI
+	  controller and want to access the Flash as a mtd device.
+
+config SPI_INTEL_SPI
+	tristate
+
+config SPI_INTEL_SPI_PCI
+	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
+	depends on X86 && PCI
+	select SPI_INTEL_SPI
+	help
+	  This enables PCI support for the Intel PCH/PCU SPI controller in
+	  master mode. This controller is present in modern Intel hardware
+	  and is used to hold BIOS and other persistent settings. Using
+	  this driver it is possible to upgrade BIOS directly from Linux.
+
+	  Say N here unless you know what you are doing. Overwriting the
+	  SPI flash may render the system unbootable.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel-spi-pci.
+
+config SPI_INTEL_SPI_PLATFORM
+	tristate "Intel PCH/PCU SPI flash platform driver (DANGEROUS)"
+	depends on X86
+	select SPI_INTEL_SPI
+	help
+	  This enables platform support for the Intel PCH/PCU SPI
+	  controller in master mode. This controller is present in modern
+	  Intel hardware and is used to hold BIOS and other persistent
+	  settings. Using this driver it is possible to upgrade BIOS
+	  directly from Linux.
+
+	  Say N here unless you know what you are doing. Overwriting the
+	  SPI flash may render the system unbootable.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel-spi-platform.
diff --git a/drivers/mtd/spi-nor/controllers/Makefile b/drivers/mtd/spi-nor=
/controllers/Makefile
new file mode 100644
index 000000000000..c9a39992d63d
--- /dev/null
+++ b/drivers/mtd/spi-nor/controllers/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SPI_ASPEED_SMC)	+=3D aspeed-smc.o
+obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+=3D cadence-quadspi.o
+obj-$(CONFIG_SPI_HISI_SFC)	+=3D hisi-sfc.o
+obj-$(CONFIG_SPI_MTK_QUADSPI)    +=3D mtk-quadspi.o
+obj-$(CONFIG_SPI_NXP_SPIFI)	+=3D nxp-spifi.o
+obj-$(CONFIG_SPI_INTEL_SPI)	+=3D intel-spi.o
+obj-$(CONFIG_SPI_INTEL_SPI_PCI)	+=3D intel-spi-pci.o
+obj-$(CONFIG_SPI_INTEL_SPI_PLATFORM)	+=3D intel-spi-platform.o
diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/control=
lers/aspeed-smc.c
similarity index 100%
rename from drivers/mtd/spi-nor/aspeed-smc.c
rename to drivers/mtd/spi-nor/controllers/aspeed-smc.c
diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/co=
ntrollers/cadence-quadspi.c
similarity index 100%
rename from drivers/mtd/spi-nor/cadence-quadspi.c
rename to drivers/mtd/spi-nor/controllers/cadence-quadspi.c
diff --git a/drivers/mtd/spi-nor/hisi-sfc.c b/drivers/mtd/spi-nor/controlle=
rs/hisi-sfc.c
similarity index 100%
rename from drivers/mtd/spi-nor/hisi-sfc.c
rename to drivers/mtd/spi-nor/controllers/hisi-sfc.c
diff --git a/drivers/mtd/spi-nor/intel-spi-pci.c b/drivers/mtd/spi-nor/cont=
rollers/intel-spi-pci.c
similarity index 100%
rename from drivers/mtd/spi-nor/intel-spi-pci.c
rename to drivers/mtd/spi-nor/controllers/intel-spi-pci.c
diff --git a/drivers/mtd/spi-nor/intel-spi-platform.c b/drivers/mtd/spi-nor=
/controllers/intel-spi-platform.c
similarity index 100%
rename from drivers/mtd/spi-nor/intel-spi-platform.c
rename to drivers/mtd/spi-nor/controllers/intel-spi-platform.c
diff --git a/drivers/mtd/spi-nor/intel-spi.c b/drivers/mtd/spi-nor/controll=
ers/intel-spi.c
similarity index 100%
rename from drivers/mtd/spi-nor/intel-spi.c
rename to drivers/mtd/spi-nor/controllers/intel-spi.c
diff --git a/drivers/mtd/spi-nor/intel-spi.h b/drivers/mtd/spi-nor/controll=
ers/intel-spi.h
similarity index 100%
rename from drivers/mtd/spi-nor/intel-spi.h
rename to drivers/mtd/spi-nor/controllers/intel-spi.h
diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/contro=
llers/mtk-quadspi.c
similarity index 100%
rename from drivers/mtd/spi-nor/mtk-quadspi.c
rename to drivers/mtd/spi-nor/controllers/mtk-quadspi.c
diff --git a/drivers/mtd/spi-nor/nxp-spifi.c b/drivers/mtd/spi-nor/controll=
ers/nxp-spifi.c
similarity index 100%
rename from drivers/mtd/spi-nor/nxp-spifi.c
rename to drivers/mtd/spi-nor/controllers/nxp-spifi.c
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/core.c
similarity index 100%
rename from drivers/mtd/spi-nor/spi-nor.c
rename to drivers/mtd/spi-nor/core.c
--=20
2.23.0
