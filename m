Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1ECC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F19C2465E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="iHjB61M5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgCBSIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:08:06 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:59670 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbgCBSIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:08:02 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: D1FpkcxzaQiZ0n2nlIrJoRSon9lCUUG2Qy2BIBRoEaDqa+TFUAur0EHwjCvTEbvaFUXgHRXWrj
 O/jHB2I5BXWQIyKl0NlATo8Yzd2cJnrphFmCibOgos3Vcv0pIACv61G8rTZOTVW7HqPJIG8ak9
 il+n+U3wkbDUOJ9LOGL6qQ5eeBk/EnKd4cn9KOrgDGASAZLis4ZcwZd6pq2HmSLlskhAMS6Yme
 fbGg+I6NoJxd1/KX51yvGFFVugAj4GNQs/lSyy76auz/CsS+0OyI4vjEUxjJ2zC3Je5shxt8lb
 AHQ=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="4204955"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 11:07:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 11:08:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 11:07:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gakz15OUFMVAjmHQn8rjHDguQwABQ3waMf/+24rdL3rBMK6qAThAso7kFyhHllsvGc5lUWvyizFG7nQOFIVCRgdyuNwBFJOOiM97ax7E/jO7lqwt7HU4jSQgZhpoUqy/X35te8slkvBSp8Aha90IUozsW71Lgbcrei1w2iXuHZSGw/3ucZI9lG7u5+iBY+9B7mKidnh8b0J2FTQzg5hjaWtlPmR5GKQZztj2Eulqhz5JatPM68qy8/lya0ad2cgaww2+zNJRaxn6/U5dO0Gvqgq68G+wmdFAhFeZK7ihNvO3wql625s6kwNps/qC8vQD2MOIh8nb/7Y74MJJVIXklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsZsP29gg3Xo0UeBFVlT03ptSKcfz0ZHDBXWCEEKbwg=;
 b=e7G3z2KnaARmBepYgP/8j6H4p/k/dCw3Yy59T1rJGs0y3Nsav9RifsSa/vpxoeRCFHc64ZPHFBWc3tBE8Volq2YePwGdVsR4YIt5PjgXKh5hZ8jyDwQvSZlPaZt5QU0bplBGCEs6xx5fbdScQhT3uSU3oN51JavaDSb1H1cQNtpaBHM5s/b4CwobRA1t5VDEKlSyViRf+c0jE2s5c4QFxCn/OL0RBYIz8s8afR1Ti2Jt6Wq7nBcBfsh+HI7x9P2c8gTwRFaKDu1biyKKMyAqrH/uhlo7BBjrjGOQXQEwhHEjQ3CJdUXpERdQROGKWUqZrFp0vGvvydLTv4AUHNFhXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsZsP29gg3Xo0UeBFVlT03ptSKcfz0ZHDBXWCEEKbwg=;
 b=iHjB61M5LmfzG6eZpygDccDFQKIEBeCcgwhdZmXCiwoO/n6Sx5fc98xgCMcsvI6OiRwoGvTjx5zctS9A+sMr9nsTiwmxbVKyIjQrcQMU+XCQLeQ0R5TogrOz6RK0ICZeZ2tbwBEE++WLrgmgJTr4cut6EA13pG9UcisR4cOPxaE=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4142.namprd11.prod.outlook.com (2603:10b6:208:135::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 18:07:48 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 18:07:48 +0000
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
Subject: [PATCH 06/23] mtd: spi-nor: Move Atmel bits out of core.c
Thread-Topic: [PATCH 06/23] mtd: spi-nor: Move Atmel bits out of core.c
Thread-Index: AQHV8L17gM5lW3tn1E2no72hayeDYQ==
Date:   Mon, 2 Mar 2020 18:07:48 +0000
Message-ID: <20200302180730.1886678-7-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2068276-36ed-4435-54e5-08d7bed49dc2
x-ms-traffictypediagnostic: MN2PR11MB4142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4142775DD6B7934538256806F0E70@MN2PR11MB4142.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(36756003)(26005)(66446008)(107886003)(6486002)(186003)(2616005)(4326008)(478600001)(6512007)(91956017)(64756008)(66946007)(2906002)(71200400001)(76116006)(8936002)(316002)(86362001)(54906003)(6506007)(66556008)(5660300002)(66476007)(7406005)(1076003)(7416002)(81156014)(81166006)(110136005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4142;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 82oui1pEy9UD7502+Ou0rb/osSgOO+d0KAUojwwam/6hPMll5OJ/p9JGp2BEgkodCx8koCE+2KGIBB0OAlX/asoONq2rAF/ptq1InsXe+H5new07EcCW3dYknbp82yNH1CvIddjCG8Za+ja/mXsGMhJPfvMX/jepPKBcjck4EDdQUU8Rs3OdlRKNvHnuhNLtX8Oyjr1U1/CWzsMuWk27Kphb4G050RIajz/svZdI8G76t33N6OtC6HDiZ7kaAPoeL2w+yWc1STjj1PK1IAkPN2oe2/pC3JVo/CtMWtfvyKOLWHTgHIvSMZucuMpdOES636Ll6zd5mt4EzZKyji/D1GQ94gozMb6lbcTb+xPo+6e49wRIPNBtjdmXJT1OOoDERxPhUOcFtmIqpxKNmViysZcASUf7oNGOuU7s0tropOFc5uWNdRCROV0rxcmiOR6p
x-ms-exchange-antispam-messagedata: 8HckLX77RboUqqouMJEKOOYrt3NiOml9ISOfcjKrjPbEiIxq0amFQLgMF+b3NAH5GyN2djfhHh5ilVK+rd/l2qy8ui8nR7LkuXju3gEn4PEvQweNvK8hwLzltfzJcKnwlwiW1k7RpMMiJcn2kg+6sw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c2068276-36ed-4435-54e5-08d7bed49dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:07:48.3228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dQGXY7hAC8Azbaye2AH6GntDPb9Q+3SXOFbYi23idKFxXFljgpIfE6liKxf/jcyguuooU0dT09JZcXno6vXLB8dTnHiqFWNlCUHisKdwjpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

Create a SPI NOR manufacturer driver for Atmel chips, and move the
Atmel definitions outside of core.c.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/atmel.c  | 46 ++++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.c   | 32 +++----------------------
 drivers/mtd/spi-nor/core.h   |  3 +++
 4 files changed, 53 insertions(+), 29 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/atmel.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 6bcdb6f1615a..0a243592e416 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
=20
 spi-nor-objs			:=3D core.o sfdp.o
+spi-nor-objs			+=3D atmel.o
 obj-$(CONFIG_MTD_SPI_NOR)	+=3D spi-nor.o
diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
new file mode 100644
index 000000000000..3f5f21a473a6
--- /dev/null
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2005, Intec Automation Inc.
+ * Copyright (C) 2014, Freescale Semiconductor, Inc.
+ */
+
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+static const struct flash_info atmel_parts[] =3D {
+	/* Atmel -- some are (confusingly) marketed as "DataFlash" */
+	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K) },
+	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K) },
+
+	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K) },
+	{ "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64, SECT_4K) },
+	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K) },
+	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K) },
+
+	{ "at25sl321",	INFO(0x1f4216, 0, 64 * 1024, 64,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+
+	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8, SECT_4K) },
+	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16, SECT_4K) },
+	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32, SECT_4K) },
+	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64, SECT_4K) },
+
+	{ "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16, SECT_4K) },
+};
+
+static void atmel_default_init(struct spi_nor *nor)
+{
+	nor->flags |=3D SNOR_F_HAS_LOCK;
+}
+
+static const struct spi_nor_fixups atmel_fixups =3D {
+	.default_init =3D atmel_default_init,
+};
+
+const struct spi_nor_manufacturer spi_nor_atmel =3D {
+	.name =3D "atmel",
+	.parts =3D atmel_parts,
+	.nparts =3D ARRAY_SIZE(atmel_parts),
+	.fixups =3D &atmel_fixups,
+};
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d41ef1795707..45d370229e0a 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2079,25 +2079,6 @@ static struct spi_nor_fixups gd25q256_fixups =3D {
  * old entries may be missing 4K flag.
  */
 static const struct flash_info spi_nor_ids[] =3D {
-	/* Atmel -- some are (confusingly) marketed as "DataFlash" */
-	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K) },
-	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K) },
-
-	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K) },
-	{ "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64, SECT_4K) },
-	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K) },
-	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K) },
-
-	{ "at25sl321",	INFO(0x1f4216, 0, 64 * 1024, 64,
-			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-
-	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8, SECT_4K) },
-	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16, SECT_4K) },
-	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32, SECT_4K) },
-	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64, SECT_4K) },
-
-	{ "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16, SECT_4K) },
-
 	/* EON -- en25xxx */
 	{ "en25f32",    INFO(0x1c3116, 0, 64 * 1024,   64, SECT_4K) },
 	{ "en25p32",    INFO(0x1c2016, 0, 64 * 1024,   64, 0) },
@@ -2472,7 +2453,9 @@ static const struct flash_info spi_nor_ids[] =3D {
 	{ },
 };
=20
-static const struct spi_nor_manufacturer *manufacturers[0];
+static const struct spi_nor_manufacturer *manufacturers[] =3D {
+	&spi_nor_atmel,
+};
=20
 static const struct flash_info *
 spi_nor_search_part_by_id(const struct flash_info *parts, unsigned int npa=
rts,
@@ -3251,11 +3234,6 @@ static int spi_nor_setup(struct spi_nor *nor,
 	return nor->params.setup(nor, hwcaps);
 }
=20
-static void atmel_set_default_init(struct spi_nor *nor)
-{
-	nor->flags |=3D SNOR_F_HAS_LOCK;
-}
-
 static void intel_set_default_init(struct spi_nor *nor)
 {
 	nor->flags |=3D SNOR_F_HAS_LOCK;
@@ -3299,10 +3277,6 @@ static void spi_nor_manufacturer_init_params(struct =
spi_nor *nor)
 {
 	/* Init flash parameters based on MFR */
 	switch (JEDEC_MFR(nor->info)) {
-	case SNOR_MFR_ATMEL:
-		atmel_set_default_init(nor);
-		break;
-
 	case SNOR_MFR_INTEL:
 		intel_set_default_init(nor);
 		break;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 89b8dd1c8213..505e580add68 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -166,6 +166,9 @@ struct spi_nor_manufacturer {
 	const struct spi_nor_fixups *fixups;
 };
=20
+/* Manufacturer drivers. */
+extern const struct spi_nor_manufacturer spi_nor_atmel;
+
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_en4_ex4_set_4byte(struct spi_nor *nor, bool enable);
--=20
2.23.0
