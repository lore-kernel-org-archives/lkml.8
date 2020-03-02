Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF80FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A777D2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BcnxeJ5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgCBSIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:08:01 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:31575 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbgCBSH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:07:58 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ir1sRq5CHqUc8w8XpAlETMjUgg2nqqKiqMxqQQnN+kI1Nx+BixCtjB6ipV4P/2DtIALY7LLsrp
 eK0BzbLpJjCizHqkhRyJVlMp6C8QuCa27B12onNEJNavatJqzrTAStepYXVE4CO+R9EIvCl85d
 TaPutvRp4ZhvHcN5xrwRVizeVM/7G/RT4JsKMeAqvlFrvYKQidXWA1of5czV9A76cbYSULlMD+
 9Pv2V3GqK66JXH5dwcq389R7XkVqfNp3DZoF6Kq3x5kqF4hsZoQd2cbjK3A1kKQVgJcP/BQ457
 Q8M=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="67601716"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 11:07:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 11:07:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 11:07:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqYA5Aysul55Fkr0QNtW69CNPiPHlvU6AQ5/EmVvDJrRJFzbke/I2zR+NKNoXwOq5mw/XyrG+IF+tgOzhZlH0IxUfTdu7ya+C5H3RvEeb2UEEcAAuqvluxanexDW9CUIyEW+GTDq4ORijueKfz1dB8I2yR8tt0U5aLSH+s/brB7hMep5114FKSIn0NruSOrLKTkhnUmo+b0VfXPhBiUCOoBfowhxdauHa6UHSZSIJ8LipU/W5kvSB+G5TryQ17+F2GDNeGuBV0QE/M2PRq4JTYJY7Ip8ROQZ6ywcchSHlkGUBUULSWdl1U4gzWofhTwQCdDHHk08nxpyci5HIVS80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+qSak5xs4cVCUwM0lIrfQmNKhPeH8NwgE4MxqkZCHo=;
 b=iSgvY8O0Kjmh9Gc4o7eJcdBWuYDBtq1U61Tn4Ph5+xALJx7iaDlxJa0C7bOsxa2BIg/aVX+S6ECGquAimW67ivHYgXdxZlGaBuB6vTUiHjpwJ/goI2bR0FggWOwkZkJ8WlrNla9/xRUdX6mdbd2R3PpPq+sTR0wxnEYORwMkSttvIwLCisCiBbaVu4TuWCAJ/wX6MLayttktpXh7RxV7+Rii62ibNLQTh+pDpMfQlUlZRLeg5Tml9k83UP5c6vDcRXFUOsCv6PKxnJCO/bpZYMPIiO5id5MZ5M8k9tVNRcXuzXawGHx4Hx5PBNbiDY9hdiZUo5OhyXjRj/GqqKkLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+qSak5xs4cVCUwM0lIrfQmNKhPeH8NwgE4MxqkZCHo=;
 b=BcnxeJ5bXxmC6fOrjxVkNYHjxreEYqfwVNFRpgimWbrfgqx0mD7XgOqExvoW6vCzu4OSKsWnuBvKGFJvhJ31k841j//vqxjxOEh3IuMbn5EVhgcbTyiZ9EP0w4ag0tFKxP+Cl9YLyNfJZGdNi+NMZgSHRYibCpYy9v/qI5VUOvw=
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
Subject: [PATCH 08/23] mtd: spi-nor: Move ESMT bits out of core.c
Thread-Topic: [PATCH 08/23] mtd: spi-nor: Move ESMT bits out of core.c
Thread-Index: AQHV8L17GIvmS/f6zEOqYBeDtEU3XQ==
Date:   Mon, 2 Mar 2020 18:07:49 +0000
Message-ID: <20200302180730.1886678-9-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11ee166a-0b9e-4d93-8471-08d7bed49e6c
x-ms-traffictypediagnostic: MN2PR11MB4142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4142DDBF2E550981A7EE3A3FF0E70@MN2PR11MB4142.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(36756003)(26005)(66446008)(107886003)(6486002)(186003)(2616005)(4326008)(478600001)(6512007)(91956017)(64756008)(66946007)(2906002)(71200400001)(76116006)(8936002)(316002)(86362001)(54906003)(6506007)(66556008)(5660300002)(66476007)(7406005)(1076003)(7416002)(81156014)(81166006)(110136005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4142;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rTYQfk3ArjFupYtRS/3APEMwZeizfxv1bFjmPbxzR+3MfxpOloa8ukKcPM2r1xweq3hphPZwRUK4FSOs0Ubx9KnilIn6KhaV/DL2POTW41ML3+zYdVGlkLTOODox0LTDe98dJElut4XuKFVPJqLQ2jFe6UZN0WpVCVBpGXbiVBJmyteltDlJIK1+noj05xDVwHmGcpufy+4Krfqsy63PhDky0twoomjrLrjpRADSEeRiRvaAFJM4xaOm7JDX6QpNaYJEeUjexsLbfBbyWRGW/Q3JuECL0i6JMozRT2ROcd4NLhkznhDEGnduJR6P2e9T2faO6vU29XbxmJbFHdRlos3SmIc0kSMlFrC9JUdTRwqcZ1qBd/iZOXJCwy3kfb5VauxrkmkS+NTalyw6Zj12MZos6mCL+F71vjXQfTsjer1UAlITR0vPi300J97JHYnE
x-ms-exchange-antispam-messagedata: 2+Z1n+paUUvVyW8ibUYqdCZ99hxH9z9N0z+H3y6T4BHO786hpxKWgocKHcF+ixjfg5JcePhCL0Gw4tsyf+TJwCI3wp+LlV0SXQr58sWf4yiQDl/Ypv9WAV3kuJ8fXj8h+fd8YYbJYNMGTJSRtqJqfw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ee166a-0b9e-4d93-8471-08d7bed49e6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:07:49.4651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kAe5MkJHJUcfO3UqOJfz2s8eRTonOPHj0fAiRPgIG7I/K1J6R7sVP2X3Kv9ry117Ir3Emb/1CCQ9671yrboIQyrg2/B1vUIZus5E3APPVKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

Create a SPI NOR manufacturer driver for ESMT chips, and move the
ESMT definitions outside of core.c.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/core.c   |  6 +-----
 drivers/mtd/spi-nor/core.h   |  1 +
 drivers/mtd/spi-nor/esmt.c   | 25 +++++++++++++++++++++++++
 4 files changed, 28 insertions(+), 5 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/esmt.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index e1bc8ccfe14d..4e5ef10e4fd7 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -3,4 +3,5 @@
 spi-nor-objs			:=3D core.o sfdp.o
 spi-nor-objs			+=3D atmel.o
 spi-nor-objs			+=3D eon.o
+spi-nor-objs			+=3D esmt.o
 obj-$(CONFIG_MTD_SPI_NOR)	+=3D spi-nor.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 67a3493939f6..30a0ddc6de81 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2079,11 +2079,6 @@ static struct spi_nor_fixups gd25q256_fixups =3D {
  * old entries may be missing 4K flag.
  */
 static const struct flash_info spi_nor_ids[] =3D {
-	/* ESMT */
-	{ "f25l32pa", INFO(0x8c2016, 0, 64 * 1024, 64, SECT_4K | SPI_NOR_HAS_LOCK=
) },
-	{ "f25l32qa", INFO(0x8c4116, 0, 64 * 1024, 64, SECT_4K | SPI_NOR_HAS_LOCK=
) },
-	{ "f25l64qa", INFO(0x8c4117, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_HAS_LOC=
K) },
-
 	/* Everspin */
 	{ "mr25h128", CAT25_INFO( 16 * 1024, 1, 256, 2, SPI_NOR_NO_ERASE | SPI_NO=
R_NO_FR) },
 	{ "mr25h256", CAT25_INFO( 32 * 1024, 1, 256, 2, SPI_NOR_NO_ERASE | SPI_NO=
R_NO_FR) },
@@ -2439,6 +2434,7 @@ static const struct flash_info spi_nor_ids[] =3D {
 static const struct spi_nor_manufacturer *manufacturers[] =3D {
 	&spi_nor_atmel,
 	&spi_nor_eon,
+	&spi_nor_esmt,
 };
=20
 static const struct flash_info *
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 1ac226c456e1..23ce99fb8087 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -169,6 +169,7 @@ struct spi_nor_manufacturer {
 /* Manufacturer drivers. */
 extern const struct spi_nor_manufacturer spi_nor_atmel;
 extern const struct spi_nor_manufacturer spi_nor_eon;
+extern const struct spi_nor_manufacturer spi_nor_esmt;
=20
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/esmt.c b/drivers/mtd/spi-nor/esmt.c
new file mode 100644
index 000000000000..c93170008118
--- /dev/null
+++ b/drivers/mtd/spi-nor/esmt.c
@@ -0,0 +1,25 @@
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
+static const struct flash_info esmt_parts[] =3D {
+	/* ESMT */
+	{ "f25l32pa", INFO(0x8c2016, 0, 64 * 1024, 64,
+			   SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "f25l32qa", INFO(0x8c4116, 0, 64 * 1024, 64,
+			   SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "f25l64qa", INFO(0x8c4117, 0, 64 * 1024, 128,
+			   SECT_4K | SPI_NOR_HAS_LOCK) },
+};
+
+const struct spi_nor_manufacturer spi_nor_esmt =3D {
+	.name =3D "esmt",
+	.parts =3D esmt_parts,
+	.nparts =3D ARRAY_SIZE(esmt_parts),
+};
--=20
2.23.0
