Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F98C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E0424673
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="L1i4RVYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgCBSIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:08:32 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:59772 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgCBSI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:08:28 -0500
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
IronPort-SDR: 3Qbe2ZTgyWF5fojg50AG0LVPU3vMyog5ITMpDkvaN7IbzNicW8WAM9EK7lv8unflVoyHbLEAou
 DIu10puNlI5ZSMkuYqlGwSvjpYEBIPAV9hgBGl2j0YTbuCV0/VL5sdLlf+VQu+6ih3HpxIPCTG
 iKcUjJLeSAQVlRzalT9Pnezsc/8mv2ZYB4+R1xEu6X8gZzrJJd4iUFxXM/xZ6NLodpK6Uo5lGv
 m52+ysGu+B80KilQzeIrkVtLTJOm/PNKtVWupp4pW9Bz72qYtR10orVmYwmrs8mcoaBsDz4YVt
 +4E=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="4205017"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 11:08:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 11:08:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 11:08:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGUUbDaGs9OLze7QJBdGJ5oGpzFQD9ZIX6fKEIsHJaVVRg66ubX5fLBVSm72u+6+Lk9yi8Rvo+lzUGBtpb/Kaq8f8P7JTzr6SZQvXBGRfJPvzK63WnLGKr+66xFswl0ZdoHAkGFuSK7TT2iZbxKwu4+5iqqlFi3O5a46+wEbUABjjfiUdXWdML90M+ggaWOjL0GouY3hdVNJGSQAEjVbmSenB3idOeidNeserTf+ym+tNo27Ln5pA9TtlEDnPRlFmcKdvpTpky/ueS3VhemRz3yq+jFJ9Y1Wa5XmZQMiSMyoAXLOykiRpdWJ1flA3Nc7GclAcdzbGA78TDub2rrrqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5M9N/1e88yHX3LUSWyHfVlKzNlJzJheDKVqRRt+1ZI=;
 b=jAI9Wef0qJztPfOH2P2Wom2sKTrwyOTYx542F/9w6G8L0WbhA2SzYP1sAurvcsmb/VKyKMcYnthnD8BXNlobFtwpoOb7xfRI4Y3eRQhTAjzRj3gKpcsH0VfmSbwd8u8oD+DlmGYrBew+JQVow/EyOLLsLQNqZSjG98KN87R0rLvDjkoQgzoGA3lS9lbjORgcn5SsLovcGbdghgSQWX2d9Y+TBLemx8nz8Xeq/b/BPPn5Oa0/aH1EbZrLGGPpVgScftzflr+tdpdmQ41+APCeFM2copoEo5qVJw94HxXir+blE+xRMgSie+hxClw3PSVxoJdCpLihsx9KLd+VZR4zHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5M9N/1e88yHX3LUSWyHfVlKzNlJzJheDKVqRRt+1ZI=;
 b=L1i4RVYbGYfIm/PrQ+caP+bkfu9CGgyxwnG1DMPUgGIDq1b0XmDb6aoJ1DDkiDXGCALs73VDD4DePNxDg3fapKQVVMir/YffiDPJ8WtStj7t+0UoK9+2+0P+WrG4h42fDTNdJXiXgHQ+NjMZQCO9cKbkHVz4I1y9SAArUFdeuI4=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4142.namprd11.prod.outlook.com (2603:10b6:208:135::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 18:07:55 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 18:07:55 +0000
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
Subject: [PATCH 18/23] mtd: spi-nor: Move Winbond bits out of core.c
Thread-Topic: [PATCH 18/23] mtd: spi-nor: Move Winbond bits out of core.c
Thread-Index: AQHV8L1/zTBZ4xvLfkW9opCCEvBpqw==
Date:   Mon, 2 Mar 2020 18:07:54 +0000
Message-ID: <20200302180730.1886678-19-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f10e74ed-fd9e-4ff0-ed6e-08d7bed4a21c
x-ms-traffictypediagnostic: MN2PR11MB4142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4142D92516D9DC9D659356D4F0E70@MN2PR11MB4142.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(36756003)(26005)(66446008)(107886003)(6486002)(186003)(2616005)(4326008)(478600001)(6512007)(91956017)(64756008)(66946007)(2906002)(71200400001)(76116006)(8936002)(316002)(30864003)(86362001)(54906003)(6506007)(66556008)(5660300002)(66476007)(7406005)(1076003)(7416002)(81156014)(81166006)(110136005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4142;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 17anQOtIQ3xDHTt/TefWdY58K58GhOqn4CYEJ3VdkMdubKuMyLKo4vFjk6gvo4zfb9nrNjj3vQ0s9KhrJWAihTT4mo4iu89Wb3wLBlvWwZYNa8CcEp/BxwIdOiUe3Hn3/zpR68TRWPVPEyShLGxD8oLokt0cGWvMuTM/DUd9z+LWgP+ZYlJPMi2q87CJ5xgrlVE2K1S+ip3lgPsR7CzJNcYvhv9Sw+Ei36gCgVnNarg8IuJKo3IwltVn0Y3qlv86wvbD25O7cKElIUCBlZPp5SvCPsjXYqCI/F8TO/THAqQxUs5ws7u+/S8a5ZRvxlUB8A174SaYN5fYFNXgMgY4VW5r3zXpcTmjXpF60UzK8t0iSnGYBPdMeUDwarpXltJCh0RGYobtC3DM+0FPklQ/XtxtPzj0ZZvcjUWy395O6Rn4k8UCMFK8ew1EOXganTO1
x-ms-exchange-antispam-messagedata: XqAosfgbhRaYCYyoQwuWqOwDDgJaPOGMcWy6UTj6E7klzpQRNatAYSNdpcqq7Bfki7M5TrWsGjL15qQDA5zDC9fxQz/vfuvIisV+LL6vNvWMdpJiRFlCy+6vU3TGwJzRFCfmMMqVPoWmyxxmJpXDQg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f10e74ed-fd9e-4ff0-ed6e-08d7bed4a21c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:07:54.8949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vA3umaxuJL+PfUQOG4G+D8sqmTIWOGyNlX2dEBfGnpc9o9GzoZBxRYPqBDafXxJKG4yfK46S2HeFVhL4dD/LXpF+K21Px56tVHpEP3U01uI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

Create a SPI NOR manufacturer driver for Winbond chips, and move the
Winbond definitions outside of core.c.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Makefile  |   1 +
 drivers/mtd/spi-nor/core.c    | 115 +---------------------------------
 drivers/mtd/spi-nor/core.h    |   1 +
 drivers/mtd/spi-nor/winbond.c | 113 +++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+), 114 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/winbond.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index ef7afc654a15..33b6f834a14f 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -13,4 +13,5 @@ spi-nor-objs			+=3D macronix.o
 spi-nor-objs			+=3D micron-st.o
 spi-nor-objs			+=3D spansion.o
 spi-nor-objs			+=3D sst.o
+spi-nor-objs			+=3D winbond.o
 obj-$(CONFIG_MTD_SPI_NOR)	+=3D spi-nor.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 9ff0b09887b4..c99f063b0781 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -487,38 +487,6 @@ int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
 	return ret;
 }
=20
-/**
- * winbond_set_4byte() - Set 4-byte address mode for Winbond flashes.
- * @nor:	pointer to 'struct spi_nor'.
- * @enable:	true to enter the 4-byte address mode, false to exit the 4-byt=
e
- *		address mode.
- *
- * Return: 0 on success, -errno otherwise.
- */
-static int winbond_set_4byte(struct spi_nor *nor, bool enable)
-{
-	int ret;
-
-	ret =3D spi_nor_en4_ex4_set_4byte(nor, enable);
-	if (ret || enable)
-		return ret;
-
-	/*
-	 * On Winbond W25Q256FV, leaving 4byte mode causes the Extended Address
-	 * Register to be set to 1, so all 3-byte-address reads come from the
-	 * second 16M. We must clear the register to enable normal behavior.
-	 */
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
-	ret =3D spi_nor_write_ear(nor, 0);
-	if (ret)
-		return ret;
-
-	return spi_nor_write_disable(nor);
-}
-
 /**
  * spi_nor_xread_sr() - Read the Status Register on S3AN flashes.
  * @nor:	pointer to 'struct spi_nor'.
@@ -2017,73 +1985,6 @@ int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor=
)
  * old entries may be missing 4K flag.
  */
 static const struct flash_info spi_nor_ids[] =3D {
-	/* Winbond -- w25x "blocks" are 64K, "sectors" are 4KiB */
-	{ "w25x05", INFO(0xef3010, 0, 64 * 1024,  1,  SECT_4K) },
-	{ "w25x10", INFO(0xef3011, 0, 64 * 1024,  2,  SECT_4K) },
-	{ "w25x20", INFO(0xef3012, 0, 64 * 1024,  4,  SECT_4K) },
-	{ "w25x40", INFO(0xef3013, 0, 64 * 1024,  8,  SECT_4K) },
-	{ "w25x80", INFO(0xef3014, 0, 64 * 1024,  16, SECT_4K) },
-	{ "w25x16", INFO(0xef3015, 0, 64 * 1024,  32, SECT_4K) },
-	{
-		"w25q16dw", INFO(0xef6015, 0, 64 * 1024,  32,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{ "w25x32", INFO(0xef3016, 0, 64 * 1024,  64, SECT_4K) },
-	{
-		"w25q16jv-im/jm", INFO(0xef7015, 0, 64 * 1024,  32,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{ "w25q20cl", INFO(0xef4012, 0, 64 * 1024,  4, SECT_4K) },
-	{ "w25q20bw", INFO(0xef5012, 0, 64 * 1024,  4, SECT_4K) },
-	{ "w25q20ew", INFO(0xef6012, 0, 64 * 1024,  4, SECT_4K) },
-	{ "w25q32", INFO(0xef4016, 0, 64 * 1024,  64, SECT_4K) },
-	{
-		"w25q32dw", INFO(0xef6016, 0, 64 * 1024,  64,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		"w25q32jv", INFO(0xef7016, 0, 64 * 1024,  64,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		"w25q32jwm", INFO(0xef8016, 0, 64 * 1024,  64,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{ "w25x64", INFO(0xef3017, 0, 64 * 1024, 128, SECT_4K) },
-	{ "w25q64", INFO(0xef4017, 0, 64 * 1024, 128, SECT_4K) },
-	{
-		"w25q64dw", INFO(0xef6017, 0, 64 * 1024, 128,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		"w25q128fw", INFO(0xef6018, 0, 64 * 1024, 256,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		"w25q128jv", INFO(0xef7018, 0, 64 * 1024, 256,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{ "w25q80", INFO(0xef5014, 0, 64 * 1024,  16, SECT_4K) },
-	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16, SECT_4K) },
-	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256, SECT_4K) },
-	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512,
-			  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			  SPI_NOR_4B_OPCODES) },
-	{ "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 512,
-			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "w25q256jw", INFO(0xef6019, 0, 64 * 1024, 512,
-			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
-			SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
-
 	/* Catalyst / On Semiconductor -- non-JEDEC */
 	{ "cat25c11", CAT25_INFO(  16, 8, 16, 1, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR=
) },
 	{ "cat25c03", CAT25_INFO(  32, 8, 16, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR=
) },
@@ -2118,6 +2019,7 @@ static const struct spi_nor_manufacturer *manufacture=
rs[] =3D {
 	&spi_nor_st,
 	&spi_nor_spansion,
 	&spi_nor_sst,
+	&spi_nor_winbond,
 };
=20
 static const struct flash_info *
@@ -2811,11 +2713,6 @@ static int spi_nor_setup(struct spi_nor *nor,
 	return nor->params.setup(nor, hwcaps);
 }
=20
-static void winbond_set_default_init(struct spi_nor *nor)
-{
-	nor->params.set_4byte =3D winbond_set_4byte;
-}
-
 /**
  * spi_nor_manufacturer_init_params() - Initialize the flash's parameters =
and
  * settings based on MFR register and ->default_init() hook.
@@ -2823,16 +2720,6 @@ static void winbond_set_default_init(struct spi_nor =
*nor)
  */
 static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
 {
-	/* Init flash parameters based on MFR */
-	switch (JEDEC_MFR(nor->info)) {
-	case SNOR_MFR_WINBOND:
-		winbond_set_default_init(nor);
-		break;
-
-	default:
-		break;
-	}
-
 	if (nor->manufacturer && nor->manufacturer->fixups &&
 	    nor->manufacturer->fixups->default_init)
 		nor->manufacturer->fixups->default_init(nor);
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 7bc0f6a15b36..01e0b8e2b191 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -180,6 +180,7 @@ extern const struct spi_nor_manufacturer spi_nor_micron=
;
 extern const struct spi_nor_manufacturer spi_nor_st;
 extern const struct spi_nor_manufacturer spi_nor_spansion;
 extern const struct spi_nor_manufacturer spi_nor_sst;
+extern const struct spi_nor_manufacturer spi_nor_winbond;
=20
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
new file mode 100644
index 000000000000..1e77dffbf729
--- /dev/null
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -0,0 +1,113 @@
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
+static const struct flash_info winbond_parts[] =3D {
+	/* Winbond -- w25x "blocks" are 64K, "sectors" are 4KiB */
+	{ "w25x05", INFO(0xef3010, 0, 64 * 1024,  1,  SECT_4K) },
+	{ "w25x10", INFO(0xef3011, 0, 64 * 1024,  2,  SECT_4K) },
+	{ "w25x20", INFO(0xef3012, 0, 64 * 1024,  4,  SECT_4K) },
+	{ "w25x40", INFO(0xef3013, 0, 64 * 1024,  8,  SECT_4K) },
+	{ "w25x80", INFO(0xef3014, 0, 64 * 1024,  16, SECT_4K) },
+	{ "w25x16", INFO(0xef3015, 0, 64 * 1024,  32, SECT_4K) },
+	{ "w25q16dw", INFO(0xef6015, 0, 64 * 1024,  32,
+			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "w25x32", INFO(0xef3016, 0, 64 * 1024,  64, SECT_4K) },
+	{ "w25q16jv-im/jm", INFO(0xef7015, 0, 64 * 1024,  32,
+				 SECT_4K | SPI_NOR_DUAL_READ |
+				 SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK |
+				 SPI_NOR_HAS_TB) },
+	{ "w25q20cl", INFO(0xef4012, 0, 64 * 1024,  4, SECT_4K) },
+	{ "w25q20bw", INFO(0xef5012, 0, 64 * 1024,  4, SECT_4K) },
+	{ "w25q20ew", INFO(0xef6012, 0, 64 * 1024,  4, SECT_4K) },
+	{ "w25q32", INFO(0xef4016, 0, 64 * 1024,  64, SECT_4K) },
+	{ "w25q32dw", INFO(0xef6016, 0, 64 * 1024,  64,
+			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "w25q32jv", INFO(0xef7016, 0, 64 * 1024,  64,
+			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+	},
+	{ "w25q32jwm", INFO(0xef8016, 0, 64 * 1024,  64,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "w25x64", INFO(0xef3017, 0, 64 * 1024, 128, SECT_4K) },
+	{ "w25q64", INFO(0xef4017, 0, 64 * 1024, 128, SECT_4K) },
+	{ "w25q64dw", INFO(0xef6017, 0, 64 * 1024, 128,
+			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "w25q128fw", INFO(0xef6018, 0, 64 * 1024, 256,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "w25q128jv", INFO(0xef7018, 0, 64 * 1024, 256,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "w25q80", INFO(0xef5014, 0, 64 * 1024,  16, SECT_4K) },
+	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16, SECT_4K) },
+	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256, SECT_4K) },
+	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512,
+			  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			  SPI_NOR_4B_OPCODES) },
+	{ "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 512,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "w25q256jw", INFO(0xef6019, 0, 64 * 1024, 512,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
+			    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
+};
+
+/**
+ * winbond_set_4byte() - Set 4-byte address mode for Winbond flashes.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @enable:	true to enter the 4-byte address mode, false to exit the 4-byt=
e
+ *		address mode.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int winbond_set_4byte(struct spi_nor *nor, bool enable)
+{
+	int ret;
+
+	ret =3D spi_nor_en4_ex4_set_4byte(nor, enable);
+	if (ret || enable)
+		return ret;
+
+	/*
+	 * On Winbond W25Q256FV, leaving 4byte mode causes the Extended Address
+	 * Register to be set to 1, so all 3-byte-address reads come from the
+	 * second 16M. We must clear the register to enable normal behavior.
+	 */
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	ret =3D spi_nor_write_ear(nor, 0);
+	if (ret)
+		return ret;
+
+	return spi_nor_write_disable(nor);
+}
+
+static void winbond_default_init(struct spi_nor *nor)
+{
+	nor->params.set_4byte =3D winbond_set_4byte;
+}
+
+static const struct spi_nor_fixups winbond_fixups =3D {
+	.default_init =3D winbond_default_init,
+};
+
+const struct spi_nor_manufacturer spi_nor_winbond =3D {
+	.name =3D "winbond",
+	.parts =3D winbond_parts,
+	.nparts =3D ARRAY_SIZE(winbond_parts),
+	.fixups =3D &winbond_fixups,
+};
+
--=20
2.23.0
