Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89144C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2582146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="lKLUQAhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgCBSIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:08:46 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:59720 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgCBSI1 (ORCPT
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
IronPort-SDR: YgKS7ufFDSGg5BzeXgY7Q1JxpT4QNcwZd2KbJdIuH9RxxM0xJDNsgsZuTOTinJuh03ziAFeeib
 G2yTFXB23JxF3o4BdT0PEBR83D1efwo0GCBftabi2iv7RJNDRq47ts2GzNhArGCOthPigkCTeY
 i6MKiE+olZ1Qp7QhDuI8QjopxVZIji5/lANNGHpOk/0o+0wxpE/zqaZP3lo6/0flI/Y5CMEAV/
 EQttI+5aw5t/7nKY2BRFj40gOdeKTpgjOcX/nT4aj+1YMzTpFmhFy7En98tuE8gwd5QputjLW/
 bDU=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="4204996"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 11:08:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 11:08:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 11:07:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgjqYsVwo4vO2MBlESRwGEHCYOqLQkeImUiEW9YKotMquAqDZskBmS4+l9Z5M3tLhQy/u8C3nIR5mVURHc0vmEA5A9Lk52zer830WmM3kxgtp9q2fdW3Eg/rtqJK4Cwu7pZaWqcNDEIF0WR2OkfLfG/J1Ca8ORWksFE2gR7vn7wfbIcnsCoVcGYYriear/GS/XsdgOF8S/94qAgUTxN8wEn6EUESfAKDTldfbg2ZLm4ZukrTiLvtEzuiqS/n+vcU/ymrjwFQr90c7IfGc4Tt8cuafNWBXojZlIqWlyGBfAtQtkih5eFkz2d5EhQ2Po5fcSnlbuzz7IItW8UZGtKWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyXOLHRdFyM28ex9k8Lofr31Ov/C9cxx9a6+q+rBuz8=;
 b=YIT2T+lAi5IS2GMWaMjY3mWjx/umRigrNDouNlSYT8yhP8H9mEsAczXpePz/6iKB7bIyTNK4XZI/COP9inW6SMUlX6rVS+frEnEc2HJijtd8iDhUpHWFfxFR5XaahCixf2wkjrumJYZoikLpbr11jK1ZOiWzpsArBTGV1dFKhC8EL5P0ImDXkKGuXuzxQ5KR4fH2eAoQ00M/GlPM+MDdKDrQ7VUf6munZ+HYq07/H+BZUTVNUbgzNX9qHhHhOtyPA3/RbpSJzG28kJIN2nDUu+xmw0VCOaARL0wDC0hpmsp0QU05qKg1x+9Zsg7Tvi5Aui543Is5Gjh1w5chVsOPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyXOLHRdFyM28ex9k8Lofr31Ov/C9cxx9a6+q+rBuz8=;
 b=lKLUQAhp88/+khPdoxeYqFwObu+vciyC5r1AiHrd54VeLjiIdzTxXPZZI6SYuqpP+KaFl+iubkDhXJLkDPpgAeNws0VH3b1o+vQOL/5NBRGwQkOlwjccBzEYD4gOuEZf42/bUOunyuAtSMK9xkM9rUl3CG7edz9hd5ecwEF7jak=
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
Subject: [PATCH 17/23] mtd: spi-nor: Move SST bits out of core.c
Thread-Topic: [PATCH 17/23] mtd: spi-nor: Move SST bits out of core.c
Thread-Index: AQHV8L1+5i8Ie99Bzkicm+kRWd0nFA==
Date:   Mon, 2 Mar 2020 18:07:54 +0000
Message-ID: <20200302180730.1886678-18-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 387263fe-648f-48dc-2198-08d7bed4a1e3
x-ms-traffictypediagnostic: MN2PR11MB4142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4142B7322A5AFD2442F493ACF0E70@MN2PR11MB4142.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(36756003)(26005)(66446008)(107886003)(6486002)(186003)(2616005)(4326008)(478600001)(6512007)(91956017)(64756008)(66946007)(2906002)(71200400001)(76116006)(8936002)(316002)(30864003)(86362001)(54906003)(6506007)(66556008)(5660300002)(66476007)(7406005)(1076003)(7416002)(81156014)(81166006)(110136005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4142;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: whyKPY4oUZA9TsjjzIbRUNPaV/KItd6VS3Qasi2pGg5C2422VMgCqyuj4DO5ayRdE0n+pe7XADPkMlWjWbwuetPA/u8pgkFT9h4WQirS029Vt58KYvhd1ImvPWuZnq5r2oWQinM+w0oaZo+zLkShXPlLXMBP1JdmGrhpK8rRCVOGw0OgHZmFVw598c1p5kqmkGzIeBWCfXODEmLjQu1YFTi7O43GZ1Umx6zDIRWvgSDXivNTOStM1JW7H6umcot1AL25nHLzKWpHJwbKPzgDM9p/r5RQDrUXBUXzfBje/B+4InVsjm6/vtrbv+iT/iK4wlbO3tK3Q3uYadq6aRqhN+acWh6LvzBQdQchLYfW0WtzYwkPFrmvHnnXD7w5fBHS3qDiyGqt2ZuYiCxrfU6Ouj8h6EmiAr68xLjhy+EoOE3U3BCHffxfuGuIfVO/zrcd
x-ms-exchange-antispam-messagedata: e8VNhxdZV3aR14zSLnmdMmOa1PiSEmI1JtOMrtAs4MrYw67dTJTK2LYTkFytRdr7dfyJyhK5OaZ1Xjc5djPzgSP1QcbSttSGRhsZGo6Bwp3YAeaV/01pUUVDrtyLC8KnbK/iZ3lE4+I1ElAiFgbqzA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 387263fe-648f-48dc-2198-08d7bed4a1e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:07:54.3232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0s5gRWxBUrsMu4CVkT7cF13W8pK9Q4CU1tN+tfBI5zyDxB30BbO6ob0vljISczA2Y33/BaXENHZFak9gnQc4C5S2JnFDV/VH30Q/LmKS7mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

Create a SPI NOR manufacturer driver for SST chips, and move the
SST definitions outside of core.c.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Makefile |   1 +
 drivers/mtd/spi-nor/core.c   | 123 +---------------------------
 drivers/mtd/spi-nor/core.h   |   1 +
 drivers/mtd/spi-nor/sst.c    | 151 +++++++++++++++++++++++++++++++++++
 4 files changed, 156 insertions(+), 120 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/sst.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index cb06ee50bf68..ef7afc654a15 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -12,4 +12,5 @@ spi-nor-objs			+=3D issi.o
 spi-nor-objs			+=3D macronix.o
 spi-nor-objs			+=3D micron-st.o
 spi-nor-objs			+=3D spansion.o
+spi-nor-objs			+=3D sst.o
 obj-$(CONFIG_MTD_SPI_NOR)	+=3D spi-nor.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 448717543d1e..9ff0b09887b4 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2017,25 +2017,6 @@ int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor=
)
  * old entries may be missing 4K flag.
  */
 static const struct flash_info spi_nor_ids[] =3D {
-	/* SST -- large erase sizes are "overlays", "sectors" are 4K */
-	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8, SECT_4K | SST_WRITE) },
-	{ "sst25vf080b", INFO(0xbf258e, 0, 64 * 1024, 16, SECT_4K | SST_WRITE) },
-	{ "sst25vf016b", INFO(0xbf2541, 0, 64 * 1024, 32, SECT_4K | SST_WRITE) },
-	{ "sst25vf032b", INFO(0xbf254a, 0, 64 * 1024, 64, SECT_4K | SST_WRITE) },
-	{ "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128, SECT_4K) },
-	{ "sst25wf512",  INFO(0xbf2501, 0, 64 * 1024,  1, SECT_4K | SST_WRITE) },
-	{ "sst25wf010",  INFO(0xbf2502, 0, 64 * 1024,  2, SECT_4K | SST_WRITE) },
-	{ "sst25wf020",  INFO(0xbf2503, 0, 64 * 1024,  4, SECT_4K | SST_WRITE) },
-	{ "sst25wf020a", INFO(0x621612, 0, 64 * 1024,  4, SECT_4K) },
-	{ "sst25wf040b", INFO(0x621613, 0, 64 * 1024,  8, SECT_4K) },
-	{ "sst25wf040",  INFO(0xbf2504, 0, 64 * 1024,  8, SECT_4K | SST_WRITE) },
-	{ "sst25wf080",  INFO(0xbf2505, 0, 64 * 1024, 16, SECT_4K | SST_WRITE) },
-	{ "sst26wf016b", INFO(0xbf2651, 0, 64 * 1024, 32, SECT_4K |
-			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "sst26vf016b", INFO(0xbf2641, 0, 64 * 1024, 32, SECT_4K |
-			      SPI_NOR_DUAL_READ) },
-	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL=
_READ | SPI_NOR_QUAD_READ) },
-
 	/* Winbond -- w25x "blocks" are 64K, "sectors" are 4KiB */
 	{ "w25x05", INFO(0xef3010, 0, 64 * 1024,  1,  SECT_4K) },
 	{ "w25x10", INFO(0xef3011, 0, 64 * 1024,  2,  SECT_4K) },
@@ -2136,6 +2117,7 @@ static const struct spi_nor_manufacturer *manufacture=
rs[] =3D {
 	&spi_nor_micron,
 	&spi_nor_st,
 	&spi_nor_spansion,
+	&spi_nor_sst,
 };
=20
 static const struct flash_info *
@@ -2236,92 +2218,6 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t=
 from, size_t len,
 	return ret;
 }
=20
-static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
-		size_t *retlen, const u_char *buf)
-{
-	struct spi_nor *nor =3D mtd_to_spi_nor(mtd);
-	size_t actual =3D 0;
-	int ret;
-
-	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
-
-	ret =3D spi_nor_lock_and_prep(nor);
-	if (ret)
-		return ret;
-
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		goto out;
-
-	nor->sst_write_second =3D false;
-
-	/* Start write from odd address. */
-	if (to % 2) {
-		nor->program_opcode =3D SPINOR_OP_BP;
-
-		/* write one byte. */
-		ret =3D spi_nor_write_data(nor, to, 1, buf);
-		if (ret < 0)
-			goto out;
-		WARN(ret !=3D 1, "While writing 1 byte written %i bytes\n", ret);
-		ret =3D spi_nor_wait_till_ready(nor);
-		if (ret)
-			goto out;
-
-		to++;
-		actual++;
-	}
-
-	/* Write out most of the data here. */
-	for (; actual < len - 1; actual +=3D 2) {
-		nor->program_opcode =3D SPINOR_OP_AAI_WP;
-
-		/* write two bytes. */
-		ret =3D spi_nor_write_data(nor, to, 2, buf + actual);
-		if (ret < 0)
-			goto out;
-		WARN(ret !=3D 2, "While writing 2 bytes written %i bytes\n", ret);
-		ret =3D spi_nor_wait_till_ready(nor);
-		if (ret)
-			goto out;
-		to +=3D 2;
-		nor->sst_write_second =3D true;
-	}
-	nor->sst_write_second =3D false;
-
-	ret =3D spi_nor_write_disable(nor);
-	if (ret)
-		goto out;
-
-	ret =3D spi_nor_wait_till_ready(nor);
-	if (ret)
-		goto out;
-
-	/* Write out trailing byte if it exists. */
-	if (actual !=3D len) {
-		ret =3D spi_nor_write_enable(nor);
-		if (ret)
-			goto out;
-
-		nor->program_opcode =3D SPINOR_OP_BP;
-		ret =3D spi_nor_write_data(nor, to, 1, buf + actual);
-		if (ret < 0)
-			goto out;
-		WARN(ret !=3D 1, "While writing 1 byte written %i bytes\n", ret);
-		ret =3D spi_nor_wait_till_ready(nor);
-		if (ret)
-			goto out;
-
-		actual +=3D 1;
-
-		ret =3D spi_nor_write_disable(nor);
-	}
-out:
-	*retlen +=3D actual;
-	spi_nor_unlock_and_unprep(nor);
-	return ret;
-}
-
 /*
  * Write an address range to the nor chip.  Data must be written in
  * FLASH_PAGESIZE chunks.  The address range may be any size provided
@@ -2915,11 +2811,6 @@ static int spi_nor_setup(struct spi_nor *nor,
 	return nor->params.setup(nor, hwcaps);
 }
=20
-static void sst_set_default_init(struct spi_nor *nor)
-{
-	nor->flags |=3D SNOR_F_HAS_LOCK;
-}
-
 static void winbond_set_default_init(struct spi_nor *nor)
 {
 	nor->params.set_4byte =3D winbond_set_4byte;
@@ -2934,10 +2825,6 @@ static void spi_nor_manufacturer_init_params(struct =
spi_nor *nor)
 {
 	/* Init flash parameters based on MFR */
 	switch (JEDEC_MFR(nor->info)) {
-	case SNOR_MFR_SST:
-		sst_set_default_init(nor);
-		break;
-
 	case SNOR_MFR_WINBOND:
 		winbond_set_default_init(nor);
 		break;
@@ -3409,6 +3296,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 	if (info->flags & SPI_NOR_HAS_LOCK)
 		nor->flags |=3D SNOR_F_HAS_LOCK;
=20
+	mtd->_write =3D spi_nor_write;
+
 	/* Init flash parameters based on flash_info struct and SFDP */
 	spi_nor_init_params(nor);
=20
@@ -3429,12 +3318,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *na=
me,
 		mtd->_is_locked =3D spi_nor_is_locked;
 	}
=20
-	/* sst nor chips use AAI word program */
-	if (info->flags & SST_WRITE)
-		mtd->_write =3D sst_write;
-	else
-		mtd->_write =3D spi_nor_write;
-
 	if (info->flags & USE_FSR)
 		nor->flags |=3D SNOR_F_USE_FSR;
 	if (info->flags & SPI_NOR_HAS_TB) {
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 8e45617578f3..7bc0f6a15b36 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -179,6 +179,7 @@ extern const struct spi_nor_manufacturer spi_nor_macron=
ix;
 extern const struct spi_nor_manufacturer spi_nor_micron;
 extern const struct spi_nor_manufacturer spi_nor_st;
 extern const struct spi_nor_manufacturer spi_nor_spansion;
+extern const struct spi_nor_manufacturer spi_nor_sst;
=20
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
new file mode 100644
index 000000000000..e0af6d25d573
--- /dev/null
+++ b/drivers/mtd/spi-nor/sst.c
@@ -0,0 +1,151 @@
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
+static const struct flash_info sst_parts[] =3D {
+	/* SST -- large erase sizes are "overlays", "sectors" are 4K */
+	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8,
+			      SECT_4K | SST_WRITE) },
+	{ "sst25vf080b", INFO(0xbf258e, 0, 64 * 1024, 16,
+			      SECT_4K | SST_WRITE) },
+	{ "sst25vf016b", INFO(0xbf2541, 0, 64 * 1024, 32,
+			      SECT_4K | SST_WRITE) },
+	{ "sst25vf032b", INFO(0xbf254a, 0, 64 * 1024, 64,
+			      SECT_4K | SST_WRITE) },
+	{ "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128, SECT_4K) },
+	{ "sst25wf512",  INFO(0xbf2501, 0, 64 * 1024,  1,
+			      SECT_4K | SST_WRITE) },
+	{ "sst25wf010",  INFO(0xbf2502, 0, 64 * 1024,  2,
+			      SECT_4K | SST_WRITE) },
+	{ "sst25wf020",  INFO(0xbf2503, 0, 64 * 1024,  4,
+			      SECT_4K | SST_WRITE) },
+	{ "sst25wf020a", INFO(0x621612, 0, 64 * 1024,  4, SECT_4K) },
+	{ "sst25wf040b", INFO(0x621613, 0, 64 * 1024,  8, SECT_4K) },
+	{ "sst25wf040",  INFO(0xbf2504, 0, 64 * 1024,  8,
+			      SECT_4K | SST_WRITE) },
+	{ "sst25wf080",  INFO(0xbf2505, 0, 64 * 1024, 16,
+			      SECT_4K | SST_WRITE) },
+	{ "sst26wf016b", INFO(0xbf2651, 0, 64 * 1024, 32,
+			      SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ) },
+	{ "sst26vf016b", INFO(0xbf2641, 0, 64 * 1024, 32,
+			      SECT_4K | SPI_NOR_DUAL_READ) },
+	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128,
+			      SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ) },
+};
+
+static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
+		     size_t *retlen, const u_char *buf)
+{
+	struct spi_nor *nor =3D mtd_to_spi_nor(mtd);
+	size_t actual =3D 0;
+	int ret;
+
+	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
+
+	ret =3D spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		goto out;
+
+	nor->sst_write_second =3D false;
+
+	/* Start write from odd address. */
+	if (to % 2) {
+		nor->program_opcode =3D SPINOR_OP_BP;
+
+		/* write one byte. */
+		ret =3D spi_nor_write_data(nor, to, 1, buf);
+		if (ret < 0)
+			goto out;
+		WARN(ret !=3D 1, "While writing 1 byte written %i bytes\n", ret);
+		ret =3D spi_nor_wait_till_ready(nor);
+		if (ret)
+			goto out;
+
+		to++;
+		actual++;
+	}
+
+	/* Write out most of the data here. */
+	for (; actual < len - 1; actual +=3D 2) {
+		nor->program_opcode =3D SPINOR_OP_AAI_WP;
+
+		/* write two bytes. */
+		ret =3D spi_nor_write_data(nor, to, 2, buf + actual);
+		if (ret < 0)
+			goto out;
+		WARN(ret !=3D 2, "While writing 2 bytes written %i bytes\n", ret);
+		ret =3D spi_nor_wait_till_ready(nor);
+		if (ret)
+			goto out;
+		to +=3D 2;
+		nor->sst_write_second =3D true;
+	}
+	nor->sst_write_second =3D false;
+
+	ret =3D spi_nor_write_disable(nor);
+	if (ret)
+		goto out;
+
+	ret =3D spi_nor_wait_till_ready(nor);
+	if (ret)
+		goto out;
+
+	/* Write out trailing byte if it exists. */
+	if (actual !=3D len) {
+		ret =3D spi_nor_write_enable(nor);
+		if (ret)
+			goto out;
+
+		nor->program_opcode =3D SPINOR_OP_BP;
+		ret =3D spi_nor_write_data(nor, to, 1, buf + actual);
+		if (ret < 0)
+			goto out;
+		WARN(ret !=3D 1, "While writing 1 byte written %i bytes\n", ret);
+		ret =3D spi_nor_wait_till_ready(nor);
+		if (ret)
+			goto out;
+
+		actual +=3D 1;
+
+		ret =3D spi_nor_write_disable(nor);
+	}
+out:
+	*retlen +=3D actual;
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+static void sst_default_init(struct spi_nor *nor)
+{
+	nor->flags |=3D SNOR_F_HAS_LOCK;
+}
+
+static void sst_post_sfdp_fixups(struct spi_nor *nor)
+{
+	if (nor->info->flags & SST_WRITE)
+		nor->mtd._write =3D sst_write;
+}
+
+static const struct spi_nor_fixups sst_fixups =3D {
+	.default_init =3D sst_default_init,
+	.post_sfdp =3D sst_post_sfdp_fixups,
+};
+
+const struct spi_nor_manufacturer spi_nor_sst =3D {
+	.name =3D "sst",
+	.parts =3D sst_parts,
+	.nparts =3D ARRAY_SIZE(sst_parts),
+	.fixups =3D &sst_fixups,
+};
--=20
2.23.0
