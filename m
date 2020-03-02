Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228EEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC81322B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="pA8QzWmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgCBSIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:08:30 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:59750 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgCBSI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:08:27 -0500
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
IronPort-SDR: ydkqTzXy0vbMtm8KMVuB96dT/fn2oyoEMA0rvpcnOW1kHagL7+65iehfzFDUN77xa/vOTiqhrZ
 /c8myP9s1/F16KurdsU9QdTCFrTEDuSFL1xxQ6rb/n35ELXN9yw5uGZU+CUrExRK9HE573+ggm
 UcB+YFqUyFHqxXECuG7SgHNPDXk2wfEjs68fFr5HOfh+r/uL1NGloUZ1uiZpYb1R7cO/q3qf0J
 LdMtoANHhG/iBZdx9DX/tzvhixfa8e8WjiJhDSmZfwB8ul5wT9OCgeBlg1ptIpanBkGQwAhrQc
 vXE=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="4205008"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 11:08:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 11:07:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 11:07:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2qv2jjZKoROfzyo35rGjQDs4egjHT5O2NVIjyY9h0wNjZt0ZlmZxvHs/up05HrwyutENPk+FB7o5AN+gBPvfnRGURvzbKRi5rrZXPmrK2w0nJ5Jy2PPmFI0NUSYJ1TVJfE+5Edn2xQc7xX4g47Il160OlbxlJnZyfZVo2YQ/sdybH4zPZ74niwZ1SFyG9mTrlAHLygoczRMlV3PO3myZqIeO2UOfkPCj/kijJVHpewJ5kza2jqM7Q8jOuFgl13e72jsFkJs2nnvjHEecdApjGdawYhxxXiFscyWoVmLNsf/qMs63Vk5yh8mcORbwkOPI9KygWZFH4Iu9lQqF/aE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyL46znEwB0pSUFlCem0wP7Ouwgre+peQRwCwj64oTc=;
 b=a0fTxQCWxFWGbDSkCSVHCtQeipitQUCvJ+v3I1fPn/2GLvgDMdCw2cCyuct+oOLn7yowPJY79VRJuP+vAaCZB84KwUCFEC0UexwYT4GOiTzxYBdWJi6lQ8DNFQRSvMc4G7rQAi7R/Cdikr/qzDWucrpHl2ZRkBLlDI8hru/olj5W43JFnGJatuIAR4EmGlgLzEM7laF/2gz+Vnckq3RAmUH9zvXkGMv/PtFbh3KzMHaiwD5Ex3dXnz9J6CUzkl2HJ+s8Ogj4KBqwYbX5qleaAk+eFUp4sLViVLXd0No1OsI85rX8vi+vpWA55aHWUu5uOuibj/SU7EQs88+1IXwqaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyL46znEwB0pSUFlCem0wP7Ouwgre+peQRwCwj64oTc=;
 b=pA8QzWmuX/m+B1uiYNmSTS6lHijVnBR6bBih5c8+dmegxECNrMoJPaX2lOuPDrBHXjPhtzjvAtCRYEZA488abiPMbjtSKxdTBm1UNEgESDU3FLMfkEfPh9ETn1dF3i5UC+z5lCMNEMqtvzuHTc5HeB8EclaxHbs1tGXsTbem/3w=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4142.namprd11.prod.outlook.com (2603:10b6:208:135::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 18:07:49 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 18:07:49 +0000
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
Subject: [PATCH 07/23] mtd: spi-nor: Move Eon bits out of core.c
Thread-Topic: [PATCH 07/23] mtd: spi-nor: Move Eon bits out of core.c
Thread-Index: AQHV8L17Dh4AT5j9xkG018/Co+tCLg==
Date:   Mon, 2 Mar 2020 18:07:48 +0000
Message-ID: <20200302180730.1886678-8-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8add0dc4-176a-4766-5f2d-08d7bed49e1d
x-ms-traffictypediagnostic: MN2PR11MB4142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4142F1B1B81BB6155C90390AF0E70@MN2PR11MB4142.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(36756003)(26005)(66446008)(107886003)(6486002)(186003)(2616005)(4326008)(478600001)(6512007)(91956017)(64756008)(66946007)(2906002)(71200400001)(76116006)(8936002)(316002)(86362001)(54906003)(6506007)(66556008)(5660300002)(66476007)(7406005)(1076003)(7416002)(81156014)(81166006)(110136005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4142;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8KiaTgpQ86gZJeMYOxXYtP9YVbtTM7J+pZzSNc4vJB5D8siNpMHH5aDrPE2m90sZT/pQHwdxhBz3R8xG7mcEHN+BespwJMvuEelY5dZbi9HMh7hKsoCkHHkj0AgRNSm/hQ3rMPuWxn6LlE0KbFn3ylInNSk6u8kJ07/Fgaw78F2zf3jAI6WvtrhBgYQ1R7+ZxXbymI4zrGbf3yb/CBPEFAqiksWpzILS/xQYHGzDLZbsWc8quHn0s8spGoAL83zj0mhSOs4FF/dqjnOfNi0LojXNdIJjBJolvCOnmNOjCKoctaz3LVWms6/h+BLlsxZCUuhj8b7rEMZHjfh/sAGPABmFy0VMNh4kvMm4h9NwGblglXtm6FY4v8U7eMWpqqQmuO5lBFhN0J1kwO9kjHmGV9OTkMWbvbMIbV2k5MzwSqBTepxu9sKfJqV7McoqFQfo
x-ms-exchange-antispam-messagedata: 6ul6w3GuhMDDi4UgnjgIkMI3psnHgMZHysUIqHapNgAvdz+vZYNNHe2ve16oT1L/GWhfUgkDcHlQ3dV1of+0uM+4uRiEjDSlemCzk/k/4iwJdZ2gAuUHzJkIa1D+VROgWe2SSXLPFVe9ino+G7mK+A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8add0dc4-176a-4766-5f2d-08d7bed49e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:07:48.8905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FpV5Ff93DyrEVLBhWCfx2aGSE4BnbAOdHy1CXox2JLMFMmn79tUNkX1sHLtCVtv40lISPbwFCgz0ujThUkhq9UuZXf6hJzniAV2BYEmjuyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

Create a SPI NOR manufacturer driver for Eon chips, and move the
Eon definitions outside of core.c.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/core.c   | 18 +-----------------
 drivers/mtd/spi-nor/core.h   |  1 +
 drivers/mtd/spi-nor/eon.c    | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 37 insertions(+), 17 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/eon.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 0a243592e416..e1bc8ccfe14d 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -2,4 +2,5 @@
=20
 spi-nor-objs			:=3D core.o sfdp.o
 spi-nor-objs			+=3D atmel.o
+spi-nor-objs			+=3D eon.o
 obj-$(CONFIG_MTD_SPI_NOR)	+=3D spi-nor.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 45d370229e0a..67a3493939f6 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2079,23 +2079,6 @@ static struct spi_nor_fixups gd25q256_fixups =3D {
  * old entries may be missing 4K flag.
  */
 static const struct flash_info spi_nor_ids[] =3D {
-	/* EON -- en25xxx */
-	{ "en25f32",    INFO(0x1c3116, 0, 64 * 1024,   64, SECT_4K) },
-	{ "en25p32",    INFO(0x1c2016, 0, 64 * 1024,   64, 0) },
-	{ "en25q32b",   INFO(0x1c3016, 0, 64 * 1024,   64, 0) },
-	{ "en25p64",    INFO(0x1c2017, 0, 64 * 1024,  128, 0) },
-	{ "en25q64",    INFO(0x1c3017, 0, 64 * 1024,  128, SECT_4K) },
-	{ "en25q80a",   INFO(0x1c3014, 0, 64 * 1024,   16,
-			SECT_4K | SPI_NOR_DUAL_READ) },
-	{ "en25qh16",   INFO(0x1c7015, 0, 64 * 1024,   32,
-			SECT_4K | SPI_NOR_DUAL_READ) },
-	{ "en25qh32",   INFO(0x1c7016, 0, 64 * 1024,   64, 0) },
-	{ "en25qh64",   INFO(0x1c7017, 0, 64 * 1024,  128,
-			SECT_4K | SPI_NOR_DUAL_READ) },
-	{ "en25qh128",  INFO(0x1c7018, 0, 64 * 1024,  256, 0) },
-	{ "en25qh256",  INFO(0x1c7019, 0, 64 * 1024,  512, 0) },
-	{ "en25s64",	INFO(0x1c3817, 0, 64 * 1024,  128, SECT_4K) },
-
 	/* ESMT */
 	{ "f25l32pa", INFO(0x8c2016, 0, 64 * 1024, 64, SECT_4K | SPI_NOR_HAS_LOCK=
) },
 	{ "f25l32qa", INFO(0x8c4116, 0, 64 * 1024, 64, SECT_4K | SPI_NOR_HAS_LOCK=
) },
@@ -2455,6 +2438,7 @@ static const struct flash_info spi_nor_ids[] =3D {
=20
 static const struct spi_nor_manufacturer *manufacturers[] =3D {
 	&spi_nor_atmel,
+	&spi_nor_eon,
 };
=20
 static const struct flash_info *
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 505e580add68..1ac226c456e1 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -168,6 +168,7 @@ struct spi_nor_manufacturer {
=20
 /* Manufacturer drivers. */
 extern const struct spi_nor_manufacturer spi_nor_atmel;
+extern const struct spi_nor_manufacturer spi_nor_eon;
=20
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/eon.c b/drivers/mtd/spi-nor/eon.c
new file mode 100644
index 000000000000..ddb8e3650835
--- /dev/null
+++ b/drivers/mtd/spi-nor/eon.c
@@ -0,0 +1,34 @@
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
+static const struct flash_info eon_parts[] =3D {
+	/* EON -- en25xxx */
+	{ "en25f32",    INFO(0x1c3116, 0, 64 * 1024,   64, SECT_4K) },
+	{ "en25p32",    INFO(0x1c2016, 0, 64 * 1024,   64, 0) },
+	{ "en25q32b",   INFO(0x1c3016, 0, 64 * 1024,   64, 0) },
+	{ "en25p64",    INFO(0x1c2017, 0, 64 * 1024,  128, 0) },
+	{ "en25q64",    INFO(0x1c3017, 0, 64 * 1024,  128, SECT_4K) },
+	{ "en25q80a",   INFO(0x1c3014, 0, 64 * 1024,   16,
+			     SECT_4K | SPI_NOR_DUAL_READ) },
+	{ "en25qh16",   INFO(0x1c7015, 0, 64 * 1024,   32,
+			     SECT_4K | SPI_NOR_DUAL_READ) },
+	{ "en25qh32",   INFO(0x1c7016, 0, 64 * 1024,   64, 0) },
+	{ "en25qh64",   INFO(0x1c7017, 0, 64 * 1024,  128,
+			     SECT_4K | SPI_NOR_DUAL_READ) },
+	{ "en25qh128",  INFO(0x1c7018, 0, 64 * 1024,  256, 0) },
+	{ "en25qh256",  INFO(0x1c7019, 0, 64 * 1024,  512, 0) },
+	{ "en25s64",	INFO(0x1c3817, 0, 64 * 1024,  128, SECT_4K) },
+};
+
+const struct spi_nor_manufacturer spi_nor_eon =3D {
+	.name =3D "eon",
+	.parts =3D eon_parts,
+	.nparts =3D ARRAY_SIZE(eon_parts),
+};
--=20
2.23.0
