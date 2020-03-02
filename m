Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DCBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A5220842
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="TfoVrxz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgCBSXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:23:11 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:33107 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBSXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:23:09 -0500
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
IronPort-SDR: ugxBR8/1pNkpyAu0zIaDKGZRUE2n9qp+qEZMWsfqH7xdjY9yS+1HmzTnIQmdJU+bU7PBmRoXUX
 qmX3PQO2xYw7uihCtY5Y2tR/PAKvzO2DZbfWb0ufPvs691JuhXgvW4rtn1clWjCe4wKZLXloFO
 ciL1zn8kBiHLSe40rvBZPASDhq3oFflSiGMtnwsUTN2WFgLgBsS2795QWumBzr21VaRYJmr9pP
 xtsPekL5hdVx7IWwEeV2vcPk0uTm1Z7Y6NqBvGPls6VYxtkQyzwNF9OALYWzkTnohBfRioqZ6H
 Dio=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="67603662"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 11:23:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 11:08:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Mar 2020 11:08:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTKFaxtEvYwbgZtBR0dARtbkN4UUaVhDzo8gmVBLCq6u4TcFtlbYS4Wx3AeKwZNd38i5KJ27FCvcxx7XTA5m+5ISr+DAPsGq8f9VT/oml+ZrDl2ohGO9P3f6Zx8tuFjZBF7M28G+yM7ruRvOGLOnyevN8k5sUO7GJJIpALWQQn7QoKcPIvRe1YwWXgxh1llHkkuFyruj9TvGg3XsfBY0NrNhBVBRm3xgX2OFTTU2kxf/Dcs7eLi6u0lnFp+r4i3y3t2nP0FlTjQX6WObRI3rKracmhcjeQdPBd9QFkiiiGvL8cZ5pbxgkenbxnqTZFadznBE5RpltTogBFgRtDF4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zScZ5vVPDckj8PQrRRODhIHnqS19AoMvnVpi2UOGXK4=;
 b=kg8imgV/KZN62sGr4n7w9DYYotR0pah+GcPjvSaJv46Q6jMQRI751tbCeQaPUy+xV4u6dCWFED+PnThzUldJpnmrIlictNEN6mjt0BJxl+3BFLElZj01P1K8uuhSWcRnnzMyOgfG8+i2SOo354JlIepjHWIGa/qixrXUa1lT0zNaj2pYH93KTg9OXosh8MNRJ/j5JoMs5CDzvWAjgYkwjBtGmAQjejrNF+ORmLFUGwLfeqleFr9O1/lgEbQjYFEUuMAJyKA0vkUP+ElC3SIQMe83BqiPltcFMtHSAG5mvt4kbv2dlChCcyL/iRdq65sdqM2/JM3XIL5cJa34Q4b63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zScZ5vVPDckj8PQrRRODhIHnqS19AoMvnVpi2UOGXK4=;
 b=TfoVrxz1epTcnRXfrXQUpprjXJ2WlpHZ6M9/SkNdC8LRaLxzFWKxnrduEjuT8rFWmcEVFUDeXJ6aLZDGTeAEdeIjeEzXa1Zg+kl8E5TbS7CVdN+ohizk4aTiXR6CLjJ1xEm5TIsEfUvksbqMFdpcrI2sxrumNoGw8sfcziJ1HpQ=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4142.namprd11.prod.outlook.com (2603:10b6:208:135::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 18:07:57 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 18:07:56 +0000
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
Subject: [PATCH 21/23] mtd: spi-nor: Move XMC bits out of core.c
Thread-Topic: [PATCH 21/23] mtd: spi-nor: Move XMC bits out of core.c
Thread-Index: AQHV8L2A743YmlVxXEWep2xFHZH2JA==
Date:   Mon, 2 Mar 2020 18:07:56 +0000
Message-ID: <20200302180730.1886678-22-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 653a2264-90de-416b-20d0-08d7bed4a2ce
x-ms-traffictypediagnostic: MN2PR11MB4142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB41424A5F539AD6F7AACED8ECF0E70@MN2PR11MB4142.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(36756003)(26005)(66446008)(107886003)(6486002)(186003)(2616005)(4326008)(478600001)(6512007)(91956017)(64756008)(66946007)(2906002)(71200400001)(76116006)(8936002)(316002)(86362001)(54906003)(6506007)(66556008)(5660300002)(66476007)(7406005)(1076003)(7416002)(81156014)(81166006)(110136005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4142;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ww7DM4YVtsofdBmlI2Zm/wdl2cSdag/15wmKXgD6z14gsfeaQr/+ZJC54UQkZQ42Nex3Uzin2Gxe2A3ziAyDtwd3FsmhGR1TVpxtbnyymcvVR7br6wEjXID2rnN/JkfjxCLdeHjD7uophOLoztulKFOF85aMG7Z/SdhgMOUt445DtfffhzpCjT4nAwcqLd4nBjrm+jL0zGolx+al8i9aQVnW7LS4ebLIDpQksxJMIbS0dHg1fnHUOwDBwOLahhVyhqPs+wlrfvO0OFzUrE0N2toWZ97hVfIdgYAnsdy7woycauCXmM7kTV/NKiCmfzSqu7aze6F5cLHwdzgv17zQU3+td7iAKbYG2r5jQ5JD4oXVd6Quqa64gbkNMq7ydKiTsEVirqLFFqN8mJac3JYcxzLI1zJOP/rYC3TX1zw3BHTVbcCxw61BP9e7nkccFrG3
x-ms-exchange-antispam-messagedata: Xc1QAuKKMRoZvP5mRty7LRAqA3MURp7pNfGMCs4pOQtzLNQ7ven7VDeLe45bbeSa+JV+85AkXsw/lxxz5UxCGMnBwyU+EQrirtj4joZPi6qPMa6k97SfwTI7USqTMlekL9d8bSfVD4TmpeXcRl9e3g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 653a2264-90de-416b-20d0-08d7bed4a2ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:07:56.5279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T45eXIrcDslmRkbUJquqey8NkNr59mC1ADlTiP06T+Rv+8kgVTEx3BPHNM33tn4SNAhT/DgGKYsLVkF+NMUCHgUJ9LbhLVuSv9t1S9Ou9l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

Create a SPI NOR manufacturer driver for XMC chips, and move the
XMC definitions outside of core.c.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/core.c   |  4 +---
 drivers/mtd/spi-nor/core.h   |  1 +
 drivers/mtd/spi-nor/xmc.c    | 23 +++++++++++++++++++++++
 4 files changed, 26 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/xmc.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index fa03513dd160..7ddb742de1fe 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -16,4 +16,5 @@ spi-nor-objs			+=3D spansion.o
 spi-nor-objs			+=3D sst.o
 spi-nor-objs			+=3D winbond.o
 spi-nor-objs			+=3D xilinx.o
+spi-nor-objs			+=3D xmc.o
 obj-$(CONFIG_MTD_SPI_NOR)	+=3D spi-nor.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 3e9f6bafa01b..f4178cd65c45 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1965,9 +1965,6 @@ int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
  * old entries may be missing 4K flag.
  */
 static const struct flash_info spi_nor_ids[] =3D {
-	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
-	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_R=
EAD | SPI_NOR_QUAD_READ) },
-	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_=
READ | SPI_NOR_QUAD_READ) },
 	{ },
 };
=20
@@ -1988,6 +1985,7 @@ static const struct spi_nor_manufacturer *manufacture=
rs[] =3D {
 	&spi_nor_sst,
 	&spi_nor_winbond,
 	&spi_nor_xilinx,
+	&spi_nor_xmc,
 };
=20
 static const struct flash_info *
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index abd5332afaf5..3541a84c03d8 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -173,6 +173,7 @@ extern const struct spi_nor_manufacturer spi_nor_spansi=
on;
 extern const struct spi_nor_manufacturer spi_nor_sst;
 extern const struct spi_nor_manufacturer spi_nor_winbond;
 extern const struct spi_nor_manufacturer spi_nor_xilinx;
+extern const struct spi_nor_manufacturer spi_nor_xmc;
=20
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
new file mode 100644
index 000000000000..2c7773b68993
--- /dev/null
+++ b/drivers/mtd/spi-nor/xmc.c
@@ -0,0 +1,23 @@
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
+static const struct flash_info xmc_parts[] =3D {
+	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
+	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+};
+
+const struct spi_nor_manufacturer spi_nor_xmc =3D {
+	.name =3D "xmc",
+	.parts =3D xmc_parts,
+	.nparts =3D ARRAY_SIZE(xmc_parts),
+};
--=20
2.23.0
