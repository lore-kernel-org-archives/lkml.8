Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151BCC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8AC24673
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="D3zLGa43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgCBSIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:08:07 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:59670 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgCBSIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:08:00 -0500
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
IronPort-SDR: 2N+dXd6n5sbCiWGv+TWhSqqOPcVcplrhFc9ZCc/UmBHJILb/R6jjr8Ya+lbfB/61oeQFRr7ac8
 9uXGvtQbnn4bc+9EzompxLr1ymuVPRpGlRZ/t+V0oyFgOAbqPSyG8Pzs3zuJx3BZbLVDNVA/gk
 WEc0c948H94OQ0+sesfRSSDeztkVrMY0ZjuXlPjkHQJqThkKIKZXlSb4it6UYN+kLmcKuj6qYk
 x6vqXC4P9zgQ7NnCXyXFxArJs55OVgV9UjVOwT0hTAQe206UYOi48QJT+ibRBzuSPmAIGLxAZz
 78c=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="4204943"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 11:07:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 11:08:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Mar 2020 11:08:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKQLD1pJ3i81w50ObxYtB0vp3WpvAdHQ1Y4bFBAU6cLuT5Yr5OnPqPeBPqbfL1iB3mTjfH5Ju3ENl4A/rs1+wEhrlqwQDjXJfHtyKclzmf1+YliqdSIlUGJ55m77LS+SiBhIMx4tU8cjNCl5wbKhK7Zw0xonZ7dLVvcMoIpF9CQTeygpbsFsakn36gtszNkh+gK6V/815ua3WLYsa2BaUbBeNjkWGTeDKkcx+C/FOjFozPWyB9fIvc2zPXfqHcCiiyDY5dOx7DCOdQliyVf7ID4byYw+nl60DejxhXb7Wn+8NgtQ6Hh03GbXzwMAYULZL098QBpyXLDHtmdXwjRfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lUEBMcmd/HbwHIGyv4eWYi0VKABXF+ytWSpmFpOUy4=;
 b=INl3IwtErQaFpJuebID771dAM3vo0AZ57Rw9OLZTc//11NJ3QzTlwtoxNrO8I0qpKzEnZGv6DCikE6PiT3WdRC2/Jw9LbXKJpbvsWaKj76WdtuwyHMAq+T5ZC1SNaqDLFXLLbeboNHYA0uul8YAyOp+Aq3zYJXE6pPP3KfAYJAyXZbgzXn1aSKEEtKzKRO4aF0UxImayMB1OIxlEdOuE97QT2cuUUFYy6PHlIFiQCCYRnr2Z0wg+/lFlcJEN7dtU25HvMnaI9Is44b73UBVW1T/kVjgFyj+0nyAjbB3CPsWsgL3Kzc1kJ/BVzfBCRW7G+oRGoOYROhgtnk+5DBr/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lUEBMcmd/HbwHIGyv4eWYi0VKABXF+ytWSpmFpOUy4=;
 b=D3zLGa43B94fUye0nTP1K51sInFU22AjZi/qVjQhFtVmLpGSX8zvg/FmvqvFsaTOv6oRo+byHBUZ/rF+KCUIvnw17qqYNdu45a9dZe0PyT1o8HwdL1vV6pGqJsY3ihRyJDjeQP0dV7XyS4gwvwqG37QgmgATGY7g6F1OWTbZAnY=
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
Subject: [PATCH 05/23] mtd: spi-nor: Add the concept of SPI NOR manufacturer
 driver
Thread-Topic: [PATCH 05/23] mtd: spi-nor: Add the concept of SPI NOR
 manufacturer driver
Thread-Index: AQHV8L16wSAEEGeSkUG/roNIw5wY/w==
Date:   Mon, 2 Mar 2020 18:07:47 +0000
Message-ID: <20200302180730.1886678-6-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6316ea15-86e9-4c9d-b5fc-08d7bed49d74
x-ms-traffictypediagnostic: MN2PR11MB4142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB414240D4B41A983BBA7ADE92F0E70@MN2PR11MB4142.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(36756003)(26005)(66446008)(107886003)(6486002)(186003)(2616005)(4326008)(478600001)(6512007)(91956017)(64756008)(66946007)(2906002)(71200400001)(76116006)(8936002)(316002)(86362001)(54906003)(6506007)(66556008)(5660300002)(66476007)(7406005)(1076003)(7416002)(81156014)(81166006)(110136005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4142;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: drbK37Y8tETWkbvEZavHb5DAvNm6kcE0RLcmHprmNKRHS8auCX3/yQiRhxcN1sX2w4n7CSUixxHBdF8k8eWpq4GSc+ZGXhbIUstCeLOFtzRg1KF0duVqJ93r/+3u3uYw6KPZtU7rY8/1KB1XTn7KdAAjU5bgL3mM0Yg63qRpMBFUcr56i9y1YLMjok4Ux7GGb0PY1+Z42AhpqRGciJdl1FEuE5sVqBRCU3zvvFxdK5KhAB3dWFp2YN/4h3aNlHNix0U89ckPHqX6hZUYRs8L32IFBkcEySDdGzlowCwUOo/oMALksxOpQhz/FXFfl7CmM69bMdKQWYKesTspxPZMg7UfEBd+uWSkkNZt3tO7vEIY/1HvyOjrIxAWt75JCMwwth2UeEfXtGPSsTO02xfrwm+SqB5zbBRdb9RMPLV4iuIWXpag4P+74QrTWcxti2pr
x-ms-exchange-antispam-messagedata: OoiHIOXIA4vKE/JFNAUWJ6X/100xRWkRdWE45m1P4Ne5lt313CqAc4QB8WxX14NzcqOjZvw+JXzIIKUOsY0C2bPNEB5PMMdCuGcPri3QW7pNkzpq7AuXDdxyz7v+Y2KKcPI5hQq5WqBL3D/xk6LLww==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6316ea15-86e9-4c9d-b5fc-08d7bed49d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:07:47.8061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgbxlqhsZdGr7ZokvONWEWiYzQZoslSgB6Iq83FQwMFKq27SN8XV0gNswYfJiEiBRZrWPPSIvBljtUB/ZHviIiw6wqiJP6KQxdkznKt2wfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

Declare a spi_nor_manufacturer struct and add basic building blocks to
move manufacturer specific code outside of the core.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c  | 78 +++++++++++++++++++++++++++++++------
 drivers/mtd/spi-nor/core.h  | 14 +++++++
 include/linux/mtd/spi-nor.h |  8 ++++
 3 files changed, 89 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 16cf9d4b1a73..d41ef1795707 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2472,8 +2472,26 @@ static const struct flash_info spi_nor_ids[] =3D {
 	{ },
 };
=20
+static const struct spi_nor_manufacturer *manufacturers[0];
+
+static const struct flash_info *
+spi_nor_search_part_by_id(const struct flash_info *parts, unsigned int npa=
rts,
+			  const u8 *id)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < nparts; i++) {
+		if (parts[i].id_len &&
+		    !memcmp(parts[i].id, id, parts[i].id_len))
+			return &parts[i];
+	}
+
+	return NULL;
+}
+
 static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 {
+	const struct flash_info *info;
 	u8 *id =3D nor->bouncebuf;
 	unsigned int i;
 	int ret;
@@ -2495,11 +2513,21 @@ static const struct flash_info *spi_nor_read_id(str=
uct spi_nor *nor)
 		return ERR_PTR(ret);
 	}
=20
-	for (i =3D 0; i < ARRAY_SIZE(spi_nor_ids) - 1; i++) {
-		if (spi_nor_ids[i].id_len &&
-		    !memcmp(spi_nor_ids[i].id, id, spi_nor_ids[i].id_len))
-			return &spi_nor_ids[i];
+	for (i =3D 0; i < ARRAY_SIZE(manufacturers); i++) {
+		info =3D spi_nor_search_part_by_id(manufacturers[i]->parts,
+						 manufacturers[i]->nparts,
+						 id);
+		if (info) {
+			nor->manufacturer =3D manufacturers[i];
+			return info;
+		}
 	}
+
+	info =3D spi_nor_search_part_by_id(spi_nor_ids,
+					 ARRAY_SIZE(spi_nor_ids) - 1, id);
+	if (info)
+		return info;
+
 	dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
 		SPI_NOR_MAX_ID_LEN, id);
 	return ERR_PTR(-ENODEV);
@@ -2985,6 +3013,16 @@ int spi_nor_post_bfpt_fixups(struct spi_nor *nor,
 			     const struct sfdp_bfpt *bfpt,
 			     struct spi_nor_flash_parameter *params)
 {
+	int ret;
+
+	if (nor->manufacturer && nor->manufacturer->fixups &&
+	    nor->manufacturer->fixups->post_bfpt) {
+		ret =3D nor->manufacturer->fixups->post_bfpt(nor, bfpt_header,
+							   bfpt, params);
+		if (ret)
+			return ret;
+	}
+
 	if (nor->info->fixups && nor->info->fixups->post_bfpt)
 		return nor->info->fixups->post_bfpt(nor, bfpt_header, bfpt,
 						    params);
@@ -3294,6 +3332,10 @@ static void spi_nor_manufacturer_init_params(struct =
spi_nor *nor)
 		break;
 	}
=20
+	if (nor->manufacturer && nor->manufacturer->fixups &&
+	    nor->manufacturer->fixups->default_init)
+		nor->manufacturer->fixups->default_init(nor);
+
 	if (nor->info->fixups && nor->info->fixups->default_init)
 		nor->info->fixups->default_init(nor);
 }
@@ -3453,6 +3495,10 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor =
*nor)
 	if (nor->info->flags & SPI_S3AN)
 		s3an_post_sfdp_fixups(nor);
=20
+	if (nor->manufacturer && nor->manufacturer->fixups &&
+	    nor->manufacturer->fixups->post_sfdp)
+		nor->manufacturer->fixups->post_sfdp(nor);
+
 	if (nor->info->fixups && nor->info->fixups->post_sfdp)
 		nor->info->fixups->post_sfdp(nor);
 }
@@ -3615,15 +3661,25 @@ void spi_nor_restore(struct spi_nor *nor)
 }
 EXPORT_SYMBOL_GPL(spi_nor_restore);
=20
-static const struct flash_info *spi_nor_match_id(const char *name)
+static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
+						 const char *name)
 {
-	const struct flash_info *id =3D spi_nor_ids;
+	unsigned int i, j;
=20
-	while (id->name) {
-		if (!strcmp(name, id->name))
-			return id;
-		id++;
+	for (i =3D 0; i < ARRAY_SIZE(spi_nor_ids) - 1; i++) {
+		if (!strcmp(name, spi_nor_ids[i].name))
+			return &spi_nor_ids[i];
 	}
+
+	for (i =3D 0; i < ARRAY_SIZE(manufacturers); i++) {
+		for (j =3D 0; j < manufacturers[i]->nparts; j++) {
+			if (!strcmp(name, manufacturers[i]->parts[j].name)) {
+				nor->manufacturer =3D manufacturers[i];
+				return &manufacturers[i]->parts[j];
+			}
+		}
+	}
+
 	return NULL;
 }
=20
@@ -3670,7 +3726,7 @@ static const struct flash_info *spi_nor_get_flash_inf=
o(struct spi_nor *nor,
 	const struct flash_info *info =3D NULL;
=20
 	if (name)
-		info =3D spi_nor_match_id(name);
+		info =3D spi_nor_match_id(nor, name);
 	/* Try to auto-detect if chip name wasn't specified or not found */
 	if (!info)
 		info =3D spi_nor_read_id(nor);
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 7e2d88edf1f1..89b8dd1c8213 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -152,6 +152,20 @@ struct flash_info {
 		.addr_width =3D 3,					\
 		.flags =3D SPI_NOR_NO_FR | SPI_S3AN,
=20
+/**
+ * struct spi_nor_manufacturer - SPI NOR manufacturer object
+ * @name: manufacturer name
+ * @parts: array of parts supported by this manufacturer
+ * @nparts: number of entries in the parts array
+ * @fixups: hooks called at various points in time during spi_nor_scan()
+ */
+struct spi_nor_manufacturer {
+	const char *name;
+	const struct flash_info *parts;
+	unsigned int nparts;
+	const struct spi_nor_fixups *fixups;
+};
+
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_en4_ex4_set_4byte(struct spi_nor *nor, bool enable);
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index de90724f62f1..dde2988a809e 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -554,6 +554,12 @@ struct spi_nor_flash_parameter {
  */
 struct flash_info;
=20
+/**
+ * struct spi_nor_manufacturer - Forward declaration of a structure used
+ * internally by the core and manufacturer drivers.
+ */
+struct spi_nor_manufacturer;
+
 /**
  * struct spi_nor - Structure for defining a the SPI NOR layer
  * @mtd:		point to a mtd_info structure
@@ -564,6 +570,7 @@ struct flash_info;
  *                      layer is not DMA-able
  * @bouncebuf_size:	size of the bounce buffer
  * @info:		spi-nor part JDEC MFR id and other info
+ * @manufacturer:	spi-nor manufacturer
  * @page_size:		the page size of the SPI NOR
  * @addr_width:		number of address bytes
  * @erase_opcode:	the opcode for erasing a sector
@@ -591,6 +598,7 @@ struct spi_nor {
 	u8			*bouncebuf;
 	size_t			bouncebuf_size;
 	const struct flash_info	*info;
+	const struct spi_nor_manufacturer *manufacturer;
 	u32			page_size;
 	u8			addr_width;
 	u8			erase_opcode;
--=20
2.23.0
