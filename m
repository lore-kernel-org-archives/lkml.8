Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EECC3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6682146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mZ77aYJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgCBSIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:08:44 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:59750 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbgCBSI1 (ORCPT
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
IronPort-SDR: 1nYaE80exlDZZGoy0sJsLgj6w5RFKPzUPvcZMrsiXcfOfOq4w1ul62zyXFefL6QOBk6uHwr+H+
 /QjG9arlTQ6kC+WE3cNiG820Z1OlUioSklmbl2MKzu8zgeVaIt2HZ6HT5yhF3d2u5qpIdhjq8i
 TF2agwbC/99N+R2fffat39rFDJhjwB2U7g/klXmIS9udMsL4l9OYxX933T8c2ZAsMOAPy9+wXe
 byquWC5DrBRF5L9HYcuxyTbpvvh3bwFs3MuuqJhwyP2dZ85z4L2qnyVwjjWuCerxlZPXAyQ/9s
 blg=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="4204979"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 11:07:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 11:07:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 11:07:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/2TdvHXIC1kwkz2uqyRQ0QhqgJLo2UiyKkCj/U2DpI8UwVap2t0RfR3lM1z2d+6O1A7qHGzjV9fQlSBv4Jc6ZZQM06KjmCfgTQKmnoocSVLz77ZlO7ID+wnGy26gg4d70OE1OIe9Zyh/yqvOKdobDGJWVFhu6qzVJwxl6mibC1Qql8S6JAxoiAcAg8FDaQc2JvLITBgJoku3kFFQFqIGWU+lFZwiztW8KOHW26AgRPj7FFNsHcOlSsI0oYM9jjzQQrzj6g7y4jEQ/yCHzt2Rr9OzkA5ZuMbZAzXf5/NdpIC7qet7gEZPsfIOx4xcd9JVJusYTrYY02URU5S0+SSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQNxp4/ODycXKKWExtuP8d3tzJEpIVsJwFcPOHPtdiU=;
 b=hSf204sI3UmKSftOHgkOHIH2t27G7PeAoZBEhX2Mly4z8txoGjFdzlRL7jbLbjx440O7k/t4QKD9nQ4XR5qKZba6pwysnkHnvCxO6LgOAWBjixU5d4iXyG9y5J8SU3cfaNc7kn8JTuvCMfwMJjSchUfauXHEqBL6fZT/zulksg9YZ/kuvLf62NOUZ/G1Mbr0ah7ee2KeKJf1ejOHnqjWjLSEF3lfcqf13CBEpdBmwsGXusIj6cpJqJ3MG+iuhhl72vuYtUfGnvVe9gGbpHlD6iH/tp6tWw9Prur++V5yYUIe/aBQFM3g9doGG0aR7T9LuGQOyjb+6TpLUyGGYfXECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQNxp4/ODycXKKWExtuP8d3tzJEpIVsJwFcPOHPtdiU=;
 b=mZ77aYJ+eRREU0KWiHW+nEyvFRRz0p6cvIAnlm5iIDFK/B81MiCkxdC/JXOY7G0kh27uwqG+UiQEnxZxi7q5zHNe7NsLOIoiDv7FCjhvowRd0/fXYTT9IHjXtvAW7C8xS6ojy4DXSUZsUX/btA4o2Q9tJpAk01SDK7YcVzl8tmg=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4142.namprd11.prod.outlook.com (2603:10b6:208:135::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 18:07:52 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 18:07:52 +0000
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
Subject: [PATCH 12/23] mtd: spi-nor: Move Intel bits out of core.c
Thread-Topic: [PATCH 12/23] mtd: spi-nor: Move Intel bits out of core.c
Thread-Index: AQHV8L19tRI2pepxgUmer4ve1YM+Ww==
Date:   Mon, 2 Mar 2020 18:07:51 +0000
Message-ID: <20200302180730.1886678-13-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ff69d23-3630-49fe-df19-08d7bed4a033
x-ms-traffictypediagnostic: MN2PR11MB4142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4142EEE16E90847884C1B677F0E70@MN2PR11MB4142.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(36756003)(26005)(66446008)(107886003)(6486002)(186003)(2616005)(4326008)(478600001)(6512007)(91956017)(64756008)(66946007)(2906002)(71200400001)(76116006)(8936002)(316002)(86362001)(54906003)(6506007)(66556008)(5660300002)(66476007)(7406005)(1076003)(7416002)(81156014)(81166006)(110136005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4142;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QosRsB37Eog11MyfspnZMxAD931GMLMSmhKObsuGSKyRsHc7c5/xOUJR+tfktR5W5Un7kl72PFkeNDyoB3cFt0EkmcHLpydjVapnnAZkxcy6UwE0HCv0XyTXtje4l/ZklQ5/lNGtMk+l8Ofu7ivWOib5dhc0CfBKHcS2QTjzWYGi56F1dSo29ttMKN2lasGDY5MTrzUKgq93I0XobMS/ZX8J47d+YljYZ4eg63rFarsusTZB2eDfUN4SPmqIJ1T25c6zrX8/84KWPtBw/EgnML+xEJcxwW/XaTwCNJ5LA0QnETcH+qfqTmlRdXl2s/J3BCfc1uafMaEYtummZO/uMEejww0tpzziBOTgv8Jcdj8o8/qlShIUKUS0Ldf0jsaJMuvUo/0JibfPZpTGD6GKkK5r0UdVJaCLpi17MaaNUIlSiYcNHepFf4aKPwCqW2KV
x-ms-exchange-antispam-messagedata: Z1XhK57Te0p/eUDsW3EYUAExzGn0IbcUYjLe33QTtZ2fUpzX163F1HgRjHPu7hI6IeHC2I+xWLwBsyTDmxZqW/+hsx/1M9MqTc6p96sTvh6x03nW95RhGvIV6YrRc9rwLrrU3751VZ9d3ldUNxhJYw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff69d23-3630-49fe-df19-08d7bed4a033
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:07:51.5759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yete0sVdh66DphObvTLX9PwnrmZ13j7W97BxCdmO0Q8vCXSf9A8Qy+CFvR9vfOr9UOURlRzVKRUMwFODCpcIsOr3HFxhQ+SC/t+mJNSBTc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

Create a SPI NOR manufacturer driver for Intel chips, and move the
Intel definitions outside of core.c.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/core.c   | 15 +--------------
 drivers/mtd/spi-nor/core.h   |  1 +
 drivers/mtd/spi-nor/intel.c  | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 14 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/intel.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 38f704be4b03..8eb741a27fa7 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -7,4 +7,5 @@ spi-nor-objs			+=3D esmt.o
 spi-nor-objs			+=3D everspin.o
 spi-nor-objs			+=3D fujitsu.o
 spi-nor-objs			+=3D gigadevice.o
+spi-nor-objs			+=3D intel.o
 obj-$(CONFIG_MTD_SPI_NOR)	+=3D spi-nor.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 8520423b1104..2f47852a3a01 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2064,11 +2064,6 @@ static struct spi_nor_fixups mx25l25635_fixups =3D {
  * old entries may be missing 4K flag.
  */
 static const struct flash_info spi_nor_ids[] =3D {
-	/* Intel/Numonyx -- xxxs33b */
-	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, 0) },
-	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, 0) },
-	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, 0) },
-
 	/* ISSI */
 	{ "is25cd512",  INFO(0x7f9d20, 0, 32 * 1024,   2, SECT_4K) },
 	{ "is25lq040b", INFO(0x9d4013, 0, 64 * 1024,   8,
@@ -2370,6 +2365,7 @@ static const struct spi_nor_manufacturer *manufacture=
rs[] =3D {
 	&spi_nor_everspin,
 	&spi_nor_fujitsu,
 	&spi_nor_gigadevice,
+	&spi_nor_intel,
 };
=20
 static const struct flash_info *
@@ -3149,11 +3145,6 @@ static int spi_nor_setup(struct spi_nor *nor,
 	return nor->params.setup(nor, hwcaps);
 }
=20
-static void intel_set_default_init(struct spi_nor *nor)
-{
-	nor->flags |=3D SNOR_F_HAS_LOCK;
-}
-
 static void issi_set_default_init(struct spi_nor *nor)
 {
 	nor->params.quad_enable =3D spi_nor_sr1_bit6_quad_enable;
@@ -3192,10 +3183,6 @@ static void spi_nor_manufacturer_init_params(struct =
spi_nor *nor)
 {
 	/* Init flash parameters based on MFR */
 	switch (JEDEC_MFR(nor->info)) {
-	case SNOR_MFR_INTEL:
-		intel_set_default_init(nor);
-		break;
-
 	case SNOR_MFR_ISSI:
 		issi_set_default_init(nor);
 		break;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index c44802a05532..c4c23efaa68b 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -173,6 +173,7 @@ extern const struct spi_nor_manufacturer spi_nor_esmt;
 extern const struct spi_nor_manufacturer spi_nor_everspin;
 extern const struct spi_nor_manufacturer spi_nor_fujitsu;
 extern const struct spi_nor_manufacturer spi_nor_gigadevice;
+extern const struct spi_nor_manufacturer spi_nor_intel;
=20
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/intel.c b/drivers/mtd/spi-nor/intel.c
new file mode 100644
index 000000000000..d8196f101368
--- /dev/null
+++ b/drivers/mtd/spi-nor/intel.c
@@ -0,0 +1,32 @@
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
+static const struct flash_info intel_parts[] =3D {
+	/* Intel/Numonyx -- xxxs33b */
+	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, 0) },
+	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, 0) },
+	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, 0) },
+};
+
+static void intel_default_init(struct spi_nor *nor)
+{
+	nor->flags |=3D SNOR_F_HAS_LOCK;
+}
+
+static const struct spi_nor_fixups intel_fixups =3D {
+	.default_init =3D intel_default_init,
+};
+
+const struct spi_nor_manufacturer spi_nor_intel =3D {
+	.name =3D "intel",
+	.parts =3D intel_parts,
+	.nparts =3D ARRAY_SIZE(intel_parts),
+	.fixups =3D &intel_fixups,
+};
--=20
2.23.0
