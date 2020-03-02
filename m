Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70393C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A91A20873
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hfca6cKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgCBSxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:53:12 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:37214 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBSxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:53:12 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 8h8gj8OOmddjnw/dPgB2GLd62NeuxXroNGSuetyLczaaPK9k2ykI2YUvciPQ9E+H523vUQdptN
 aH8jH3YImHLSNtoDkqIR/2q+eeo1oJPQlTSrBnXjHZL3ORuYS/xa3mqrTdfh7mtw1oeIxGDBV7
 oyZBrEj8GQblOBn7go2vUil9+feVEc7tnyUIqmNBCvPJy22tMGyNflDV1iiWwKeE2A3oyqcuIZ
 kwMcU7Qr8pY7XpzDZRgMO2qWAFLyk2QaKWvtyZaPmOnffQxv1DauBZAD4c9WHzmikArZyBCb18
 I7Y=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="70461878"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 11:53:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 11:08:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Mar 2020 11:08:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAX44FB0BDMqE4/lBIa7Y0KN5FITiVgpe1rigCgXxuqiXvTCJnCTQogvc1UBEsVwN+0VHRx9cdQo7bJTzIfJSqxWo5Ar2Oufovj/+tDn/2VtO8KN1R4wNJ3rsSQ11+a5guJhh93dVFoIRHO8w6HGioX6Ea10UB7WjCaMMtwC9hrCYPwyafNJyfyu5WYz1Wk0snrFk21YJiHlyJ/sgO97ZcSF+74IyzkCFhha1Tsm+kdfH30mAN+adZxhRz3aISTttwfDbqbppEImyICd3z9qGAc+vwaFAnnJsxA+aePQcSSYmAfncA/RuvdtLyLOgEnDFLUShTT9ZGS6wKvdSrM9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paDq6mHJO/I0pzPb1Iqxv9HaPjyjU3MU4fSNJjAOGms=;
 b=ZhXUw+XiIS6KHmnDwVBYYkJpULo5Jn+I1vEVhuUITRqwAIxb3IPFGNUIandFHhC3HkI/X46X3ZriAQ9f/CoEma+GmB6uHLscCXkklUDCFnmI+ZhNM8QLEWmD7TG5CGHJItU/Lh7etMhrJerQpZYjB0FnNf/44kq37niRMWBGpYeKxeZRZmdEjMgJzv/GY2kjrpsXBKyVpwPGuSu8M4DVs79tGmwpkfJId+mWdm7NHEAZLg+27hpyZwcyLekJrqf5TT94f7t8Hsruj+RAji81IbwASLkYs4ALQDNCm0w+/9LMOOmsE6zftaVEBG+VNJUIrpeW4v3nb6Ud4BMuGndadA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paDq6mHJO/I0pzPb1Iqxv9HaPjyjU3MU4fSNJjAOGms=;
 b=hfca6cKo4Ypc8iTAmN+ISxWYslTK7URvSl89e0e4Uu91eKcJK9LzCQ6r7eCIReegOfH7y+geGTCG2GvS4U0tMh4HPaB6u+63E+BKRRxLwgywUUe1FTC2VXuVOLFRdolNuYSigq637hpeS0s0E4raXS+s07j0IAB17MaIpPtvueg=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4142.namprd11.prod.outlook.com (2603:10b6:208:135::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 18:07:57 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 18:07:57 +0000
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
Subject: [PATCH 23/23] mtd: spi-nor: Trim what is exposed in spi-nor.h
Thread-Topic: [PATCH 23/23] mtd: spi-nor: Trim what is exposed in spi-nor.h
Thread-Index: AQHV8L2AZ1MCmcT0i0aq/5KMkd3Rpw==
Date:   Mon, 2 Mar 2020 18:07:57 +0000
Message-ID: <20200302180730.1886678-24-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b5f6ae2-a0e8-45f6-fc28-08d7bed4a357
x-ms-traffictypediagnostic: MN2PR11MB4142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4142805C4C9FCC0889D1804FF0E70@MN2PR11MB4142.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(36756003)(26005)(66446008)(107886003)(6486002)(186003)(2616005)(4326008)(478600001)(6512007)(91956017)(64756008)(66946007)(2906002)(71200400001)(76116006)(8936002)(316002)(30864003)(86362001)(54906003)(6506007)(66556008)(5660300002)(66476007)(7406005)(1076003)(7416002)(81156014)(81166006)(110136005)(8676002)(31153001)(579004)(559001)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4142;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ZIqy1yfNN3uVWNoaMKTCArk3Ha3Qc6S5bXWimxHg5H9YPZepQK4BGvIVSqTKRMWaRESf5Ekgr7MGK9MdVy4KBPhCn3rpq/kEHPqQiL27VbLSexqGW38uCqO17nJzmTApx/pXc4nlf4rkxKvMgY4iM2di9NJ9pdYP+V959S7UB//81Trymx+Ptqisjqg7CiqEr6pkBnHtknTEWDvpSNoG4x/7z7DI7H7kT/OjYxrgunCQ3wSKVil9YAxCNJavYW2977UnktXYZocWEP1PpKDKToKntfzkPPg9CdGWmgIjAyAskaCXzNIOlq7ryuNXIpaEbgy4wkICBYrRZ9XFx5rMpP7fmGSAefGRzQfnZ1uF1vDj1hiClY/5MyyigSBJJfKUGoGe3w1bnVWJmMi5V+okpCbGPKqS+N8zVkrD5uxbHBc8ODn+s16mqK4foEE0OSiAoFFyznAxRUglz14QPJpeTSiNehZcph/IbcX6X0FUEdTJE/wSmYOGcm1IMVe6/KvOO51bEX5yniwzdR2cD2Wug==
x-ms-exchange-antispam-messagedata: uBGAspqRw5+bkpKNRNJ7kVWBSu7p4CEolwE09aSD26CKf3COhKGo6AlcVQlUjI7gsPrHXITVllmraPTRasjgr9o9vkUReDbdVa5k6XgLHRWHjjw4D0bbVsEbTAe6n5uRlwRiW0fL2hUBURR2VUc8vw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5f6ae2-a0e8-45f6-fc28-08d7bed4a357
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:07:57.6922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aLq1pRyTeUT/A+dE3ehl0Kgo9TdTEOFrF3PtEpVrIhfIG7Mzb3/NMzCiWxIwY8sTiTeUC1m2Z2j6jd/pp2rYGlNy+S/aj1glcOeafsb+5d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The SPI NOR controllers drivers must not be able to use structures that
are meant just for the SPI NOR core.

struct spi_nor_flash_parameter is filled at run-time with info gathered
from flash_info, manufacturer and sfdp data. struct spi_nor_flash_parameter
should be opaque to the SPI NOR controller drivers, make sure it is.

spi_nor_option_flags, spi_nor_read_command, spi_nor_pp_command,
spi_nor_read_command_index and spi_nor_pp_command_index are defined for the
core use, make sure they are opaque to the SPI NOR controller drivers.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c       |  86 ++++++----
 drivers/mtd/spi-nor/core.h       | 214 +++++++++++++++++++++++++
 drivers/mtd/spi-nor/gigadevice.c |   2 +-
 drivers/mtd/spi-nor/issi.c       |   2 +-
 drivers/mtd/spi-nor/macronix.c   |   4 +-
 drivers/mtd/spi-nor/micron-st.c  |   4 +-
 drivers/mtd/spi-nor/sfdp.c       |  10 ++
 drivers/mtd/spi-nor/spansion.c   |   2 +-
 drivers/mtd/spi-nor/winbond.c    |   2 +-
 drivers/mtd/spi-nor/xilinx.c     |   4 +-
 include/linux/mtd/spi-nor.h      | 259 +------------------------------
 11 files changed, 294 insertions(+), 295 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index a2e1917b608d..860dac1dff90 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -802,7 +802,7 @@ static int spi_nor_write_16bit_sr_and_check(struct spi_=
nor *nor, u8 sr1)
 		ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
 		if (ret)
 			return ret;
-	} else if (nor->params.quad_enable) {
+	} else if (nor->params->quad_enable) {
 		/*
 		 * If the Status Register 2 Read command (35h) is not
 		 * supported, we should at least be sure we don't
@@ -810,7 +810,7 @@ static int spi_nor_write_16bit_sr_and_check(struct spi_=
nor *nor, u8 sr1)
 		 *
 		 * We can safely assume that when the Quad Enable method is
 		 * set, the value of the QE bit is one, as a consequence of the
-		 * nor->params.quad_enable() call.
+		 * nor->params->quad_enable() call.
 		 *
 		 * We can safely assume that the Quad Enable bit is present in
 		 * the Status Register 2 at BIT(1). According to the JESD216
@@ -1075,6 +1075,11 @@ static u8 spi_nor_convert_3to4_erase(u8 opcode)
 				      ARRAY_SIZE(spi_nor_3to4_erase));
 }
=20
+static bool spi_nor_has_uniform_erase(const struct spi_nor *nor)
+{
+	return !!nor->params->erase_map.uniform_erase_type;
+}
+
 static void spi_nor_set_4byte_opcodes(struct spi_nor *nor)
 {
 	nor->read_opcode =3D spi_nor_convert_3to4_read(nor->read_opcode);
@@ -1082,7 +1087,7 @@ static void spi_nor_set_4byte_opcodes(struct spi_nor =
*nor)
 	nor->erase_opcode =3D spi_nor_convert_3to4_erase(nor->erase_opcode);
=20
 	if (!spi_nor_has_uniform_erase(nor)) {
-		struct spi_nor_erase_map *map =3D &nor->params.erase_map;
+		struct spi_nor_erase_map *map =3D &nor->params->erase_map;
 		struct spi_nor_erase_type *erase;
 		int i;
=20
@@ -1119,10 +1124,10 @@ void spi_nor_unlock_and_unprep(struct spi_nor *nor)
=20
 static u32 spi_nor_convert_addr(struct spi_nor *nor, loff_t addr)
 {
-	if (!nor->params.convert_addr)
+	if (!nor->params->convert_addr)
 		return addr;
=20
-	return nor->params.convert_addr(nor, addr);
+	return nor->params->convert_addr(nor, addr);
 }
=20
 /*
@@ -1227,6 +1232,16 @@ spi_nor_find_best_erase_type(const struct spi_nor_er=
ase_map *map,
 	return NULL;
 }
=20
+static u64 spi_nor_region_is_last(const struct spi_nor_erase_region *regio=
n)
+{
+	return region->offset & SNOR_LAST_REGION;
+}
+
+static u64 spi_nor_region_end(const struct spi_nor_erase_region *region)
+{
+	return (region->offset & ~SNOR_ERASE_FLAGS_MASK) + region->size;
+}
+
 /**
  * spi_nor_region_next() - get the next spi nor region
  * @region:	pointer to a structure that describes a SPI NOR erase region
@@ -1331,7 +1346,7 @@ static int spi_nor_init_erase_cmd_list(struct spi_nor=
 *nor,
 				       struct list_head *erase_list,
 				       u64 addr, u32 len)
 {
-	const struct spi_nor_erase_map *map =3D &nor->params.erase_map;
+	const struct spi_nor_erase_map *map =3D &nor->params->erase_map;
 	const struct spi_nor_erase_type *erase, *prev_erase =3D NULL;
 	struct spi_nor_erase_region *region;
 	struct spi_nor_erase_command *cmd =3D NULL;
@@ -1817,7 +1832,7 @@ static int spi_nor_lock(struct mtd_info *mtd, loff_t =
ofs, uint64_t len)
 	if (ret)
 		return ret;
=20
-	ret =3D nor->params.locking_ops->lock(nor, ofs, len);
+	ret =3D nor->params->locking_ops->lock(nor, ofs, len);
=20
 	spi_nor_unlock_and_unprep(nor);
 	return ret;
@@ -1832,7 +1847,7 @@ static int spi_nor_unlock(struct mtd_info *mtd, loff_=
t ofs, uint64_t len)
 	if (ret)
 		return ret;
=20
-	ret =3D nor->params.locking_ops->unlock(nor, ofs, len);
+	ret =3D nor->params->locking_ops->unlock(nor, ofs, len);
=20
 	spi_nor_unlock_and_unprep(nor);
 	return ret;
@@ -1847,7 +1862,7 @@ static int spi_nor_is_locked(struct mtd_info *mtd, lo=
ff_t ofs, uint64_t len)
 	if (ret)
 		return ret;
=20
-	ret =3D nor->params.locking_ops->is_locked(nor, ofs, len);
+	ret =3D nor->params->locking_ops->is_locked(nor, ofs, len);
=20
 	spi_nor_unlock_and_unprep(nor);
 	return ret;
@@ -2312,7 +2327,7 @@ static int spi_nor_spimem_check_pp(struct spi_nor *no=
r,
 static void
 spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
 {
-	struct spi_nor_flash_parameter *params =3D  &nor->params;
+	struct spi_nor_flash_parameter *params =3D nor->params;
 	unsigned int cap;
=20
 	/* DTR modes are not supported yet, mask them all. */
@@ -2411,7 +2426,7 @@ static int spi_nor_select_read(struct spi_nor *nor,
 	if (cmd < 0)
 		return -EINVAL;
=20
-	read =3D &nor->params.reads[cmd];
+	read =3D &nor->params->reads[cmd];
 	nor->read_opcode =3D read->opcode;
 	nor->read_proto =3D read->proto;
=20
@@ -2442,7 +2457,7 @@ static int spi_nor_select_pp(struct spi_nor *nor,
 	if (cmd < 0)
 		return -EINVAL;
=20
-	pp =3D &nor->params.page_programs[cmd];
+	pp =3D &nor->params->page_programs[cmd];
 	nor->program_opcode =3D pp->opcode;
 	nor->write_proto =3D pp->proto;
 	return 0;
@@ -2503,7 +2518,7 @@ spi_nor_select_uniform_erase(struct spi_nor_erase_map=
 *map,
=20
 static int spi_nor_select_erase(struct spi_nor *nor)
 {
-	struct spi_nor_erase_map *map =3D &nor->params.erase_map;
+	struct spi_nor_erase_map *map =3D &nor->params->erase_map;
 	const struct spi_nor_erase_type *erase =3D NULL;
 	struct mtd_info *mtd =3D &nor->mtd;
 	u32 wanted_size =3D nor->info->sector_size;
@@ -2552,7 +2567,7 @@ static int spi_nor_select_erase(struct spi_nor *nor)
 static int spi_nor_default_setup(struct spi_nor *nor,
 				 const struct spi_nor_hwcaps *hwcaps)
 {
-	struct spi_nor_flash_parameter *params =3D &nor->params;
+	struct spi_nor_flash_parameter *params =3D nor->params;
 	u32 ignored_mask, shared_mask;
 	int err;
=20
@@ -2613,10 +2628,10 @@ static int spi_nor_default_setup(struct spi_nor *no=
r,
 static int spi_nor_setup(struct spi_nor *nor,
 			 const struct spi_nor_hwcaps *hwcaps)
 {
-	if (!nor->params.setup)
+	if (!nor->params->setup)
 		return 0;
=20
-	return nor->params.setup(nor, hwcaps);
+	return nor->params->setup(nor, hwcaps);
 }
=20
 /**
@@ -2646,13 +2661,13 @@ static void spi_nor_sfdp_init_params(struct spi_nor=
 *nor)
 {
 	struct spi_nor_flash_parameter sfdp_params;
=20
-	memcpy(&sfdp_params, &nor->params, sizeof(sfdp_params));
+	memcpy(&sfdp_params, nor->params, sizeof(sfdp_params));
=20
 	if (spi_nor_parse_sfdp(nor, &sfdp_params)) {
 		nor->addr_width =3D 0;
 		nor->flags &=3D ~SNOR_F_4B_OPCODES;
 	} else {
-		memcpy(&nor->params, &sfdp_params, sizeof(nor->params));
+		memcpy(nor->params, &sfdp_params, sizeof(*nor->params));
 	}
 }
=20
@@ -2663,7 +2678,7 @@ static void spi_nor_sfdp_init_params(struct spi_nor *=
nor)
  */
 static void spi_nor_info_init_params(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params =3D &nor->params;
+	struct spi_nor_flash_parameter *params =3D nor->params;
 	struct spi_nor_erase_map *map =3D &params->erase_map;
 	const struct flash_info *info =3D nor->info;
 	struct device_node *np =3D spi_nor_get_flash_node(nor);
@@ -2782,8 +2797,8 @@ static void spi_nor_late_init_params(struct spi_nor *=
nor)
 	 * NOR protection support. When locking_ops are not provided, we pick
 	 * the default ones.
 	 */
-	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params.locking_ops)
-		nor->params.locking_ops =3D &spi_nor_sr_locking_ops;
+	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
+		nor->params->locking_ops =3D &spi_nor_sr_locking_ops;
 }
=20
 /**
@@ -2823,8 +2838,12 @@ static void spi_nor_late_init_params(struct spi_nor =
*nor)
  * ->default_init() hook or the SFDP parser do not set specific params.
  *		spi_nor_late_init_params()
  */
-static void spi_nor_init_params(struct spi_nor *nor)
+static int spi_nor_init_params(struct spi_nor *nor)
 {
+	nor->params =3D devm_kzalloc(nor->dev, sizeof(*nor->params), GFP_KERNEL);
+	if (!nor->params)
+		return -ENOMEM;
+
 	spi_nor_info_init_params(nor);
=20
 	spi_nor_manufacturer_init_params(nor);
@@ -2836,6 +2855,8 @@ static void spi_nor_init_params(struct spi_nor *nor)
 	spi_nor_post_sfdp_fixups(nor);
=20
 	spi_nor_late_init_params(nor);
+
+	return 0;
 }
=20
 /**
@@ -2846,14 +2867,14 @@ static void spi_nor_init_params(struct spi_nor *nor=
)
  */
 static int spi_nor_quad_enable(struct spi_nor *nor)
 {
-	if (!nor->params.quad_enable)
+	if (!nor->params->quad_enable)
 		return 0;
=20
 	if (!(spi_nor_get_protocol_width(nor->read_proto) =3D=3D 4 ||
 	      spi_nor_get_protocol_width(nor->write_proto) =3D=3D 4))
 		return 0;
=20
-	return nor->params.quad_enable(nor);
+	return nor->params->quad_enable(nor);
 }
=20
 /**
@@ -2868,7 +2889,7 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
 static int spi_nor_unlock_all(struct spi_nor *nor)
 {
 	if (nor->flags & SNOR_F_HAS_LOCK)
-		return spi_nor_unlock(&nor->mtd, 0, nor->params.size);
+		return spi_nor_unlock(&nor->mtd, 0, nor->params->size);
=20
 	return 0;
 }
@@ -2899,7 +2920,7 @@ static int spi_nor_init(struct spi_nor *nor)
 		 */
 		WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
 			  "enabling reset hack; may not recover from unexpected reboots\n");
-		nor->params.set_4byte(nor, true);
+		nor->params->set_4byte(nor, true);
 	}
=20
 	return 0;
@@ -2923,7 +2944,7 @@ void spi_nor_restore(struct spi_nor *nor)
 	/* restore the addressing mode */
 	if (nor->addr_width =3D=3D 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
 	    nor->flags & SNOR_F_BROKEN_RESET)
-		nor->params.set_4byte(nor, false);
+		nor->params->set_4byte(nor, false);
 }
 EXPORT_SYMBOL_GPL(spi_nor_restore);
=20
@@ -3028,7 +3049,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 	struct device *dev =3D nor->dev;
 	struct mtd_info *mtd =3D &nor->mtd;
 	struct device_node *np =3D spi_nor_get_flash_node(nor);
-	struct spi_nor_flash_parameter *params =3D &nor->params;
 	int ret;
 	int i;
=20
@@ -3079,7 +3099,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 	mtd->_write =3D spi_nor_write;
=20
 	/* Init flash parameters based on flash_info struct and SFDP */
-	spi_nor_init_params(nor);
+	ret =3D spi_nor_init_params(nor);
+	if (ret)
+		return ret;
=20
 	if (!mtd->name)
 		mtd->name =3D dev_name(dev);
@@ -3087,12 +3109,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *n=
ame,
 	mtd->type =3D MTD_NORFLASH;
 	mtd->writesize =3D 1;
 	mtd->flags =3D MTD_CAP_NORFLASH;
-	mtd->size =3D params->size;
+	mtd->size =3D nor->params->size;
 	mtd->_erase =3D spi_nor_erase;
 	mtd->_read =3D spi_nor_read;
 	mtd->_resume =3D spi_nor_resume;
=20
-	if (nor->params.locking_ops) {
+	if (nor->params->locking_ops) {
 		mtd->_lock =3D spi_nor_lock;
 		mtd->_unlock =3D spi_nor_unlock;
 		mtd->_is_locked =3D spi_nor_is_locked;
@@ -3115,7 +3137,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 		mtd->flags |=3D MTD_NO_ERASE;
=20
 	mtd->dev.parent =3D dev;
-	nor->page_size =3D params->page_size;
+	nor->page_size =3D nor->params->page_size;
 	mtd->writebufsize =3D nor->page_size;
=20
 	if (of_property_read_bool(np, "broken-flash-reset"))
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 3541a84c03d8..7654b6f3b966 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -11,6 +11,220 @@
=20
 #define SPI_NOR_MAX_ID_LEN	6
=20
+enum spi_nor_option_flags {
+	SNOR_F_USE_FSR		=3D BIT(0),
+	SNOR_F_HAS_SR_TB	=3D BIT(1),
+	SNOR_F_NO_OP_CHIP_ERASE	=3D BIT(2),
+	SNOR_F_READY_XSR_RDY	=3D BIT(3),
+	SNOR_F_USE_CLSR		=3D BIT(4),
+	SNOR_F_BROKEN_RESET	=3D BIT(5),
+	SNOR_F_4B_OPCODES	=3D BIT(6),
+	SNOR_F_HAS_4BAIT	=3D BIT(7),
+	SNOR_F_HAS_LOCK		=3D BIT(8),
+	SNOR_F_HAS_16BIT_SR	=3D BIT(9),
+	SNOR_F_NO_READ_CR	=3D BIT(10),
+	SNOR_F_HAS_SR_TB_BIT6	=3D BIT(11),
+};
+
+struct spi_nor_read_command {
+	u8			num_mode_clocks;
+	u8			num_wait_states;
+	u8			opcode;
+	enum spi_nor_protocol	proto;
+};
+
+struct spi_nor_pp_command {
+	u8			opcode;
+	enum spi_nor_protocol	proto;
+};
+
+enum spi_nor_read_command_index {
+	SNOR_CMD_READ,
+	SNOR_CMD_READ_FAST,
+	SNOR_CMD_READ_1_1_1_DTR,
+
+	/* Dual SPI */
+	SNOR_CMD_READ_1_1_2,
+	SNOR_CMD_READ_1_2_2,
+	SNOR_CMD_READ_2_2_2,
+	SNOR_CMD_READ_1_2_2_DTR,
+
+	/* Quad SPI */
+	SNOR_CMD_READ_1_1_4,
+	SNOR_CMD_READ_1_4_4,
+	SNOR_CMD_READ_4_4_4,
+	SNOR_CMD_READ_1_4_4_DTR,
+
+	/* Octal SPI */
+	SNOR_CMD_READ_1_1_8,
+	SNOR_CMD_READ_1_8_8,
+	SNOR_CMD_READ_8_8_8,
+	SNOR_CMD_READ_1_8_8_DTR,
+
+	SNOR_CMD_READ_MAX
+};
+
+enum spi_nor_pp_command_index {
+	SNOR_CMD_PP,
+
+	/* Quad SPI */
+	SNOR_CMD_PP_1_1_4,
+	SNOR_CMD_PP_1_4_4,
+	SNOR_CMD_PP_4_4_4,
+
+	/* Octal SPI */
+	SNOR_CMD_PP_1_1_8,
+	SNOR_CMD_PP_1_8_8,
+	SNOR_CMD_PP_8_8_8,
+
+	SNOR_CMD_PP_MAX
+};
+
+/**
+ * struct spi_nor_erase_type - Structure to describe a SPI NOR erase type
+ * @size:		the size of the sector/block erased by the erase type.
+ *			JEDEC JESD216B imposes erase sizes to be a power of 2.
+ * @size_shift:		@size is a power of 2, the shift is stored in
+ *			@size_shift.
+ * @size_mask:		the size mask based on @size_shift.
+ * @opcode:		the SPI command op code to erase the sector/block.
+ * @idx:		Erase Type index as sorted in the Basic Flash Parameter
+ *			Table. It will be used to synchronize the supported
+ *			Erase Types with the ones identified in the SFDP
+ *			optional tables.
+ */
+struct spi_nor_erase_type {
+	u32	size;
+	u32	size_shift;
+	u32	size_mask;
+	u8	opcode;
+	u8	idx;
+};
+
+/**
+ * struct spi_nor_erase_command - Used for non-uniform erases
+ * The structure is used to describe a list of erase commands to be execut=
ed
+ * once we validate that the erase can be performed. The elements in the l=
ist
+ * are run-length encoded.
+ * @list:		for inclusion into the list of erase commands.
+ * @count:		how many times the same erase command should be
+ *			consecutively used.
+ * @size:		the size of the sector/block erased by the command.
+ * @opcode:		the SPI command op code to erase the sector/block.
+ */
+struct spi_nor_erase_command {
+	struct list_head	list;
+	u32			count;
+	u32			size;
+	u8			opcode;
+};
+
+/**
+ * struct spi_nor_erase_region - Structure to describe a SPI NOR erase reg=
ion
+ * @offset:		the offset in the data array of erase region start.
+ *			LSB bits are used as a bitmask encoding flags to
+ *			determine if this region is overlaid, if this region is
+ *			the last in the SPI NOR flash memory and to indicate
+ *			all the supported erase commands inside this region.
+ *			The erase types are sorted in ascending order with the
+ *			smallest Erase Type size being at BIT(0).
+ * @size:		the size of the region in bytes.
+ */
+struct spi_nor_erase_region {
+	u64		offset;
+	u64		size;
+};
+
+#define SNOR_ERASE_TYPE_MAX	4
+#define SNOR_ERASE_TYPE_MASK	GENMASK_ULL(SNOR_ERASE_TYPE_MAX - 1, 0)
+
+#define SNOR_LAST_REGION	BIT(4)
+#define SNOR_OVERLAID_REGION	BIT(5)
+
+#define SNOR_ERASE_FLAGS_MAX	6
+#define SNOR_ERASE_FLAGS_MASK	GENMASK_ULL(SNOR_ERASE_FLAGS_MAX - 1, 0)
+
+/**
+ * struct spi_nor_erase_map - Structure to describe the SPI NOR erase map
+ * @regions:		array of erase regions. The regions are consecutive in
+ *			address space. Walking through the regions is done
+ *			incrementally.
+ * @uniform_region:	a pre-allocated erase region for SPI NOR with a unifor=
m
+ *			sector size (legacy implementation).
+ * @erase_type:		an array of erase types shared by all the regions.
+ *			The erase types are sorted in ascending order, with the
+ *			smallest Erase Type size being the first member in the
+ *			erase_type array.
+ * @uniform_erase_type:	bitmask encoding erase types that can erase the
+ *			entire memory. This member is completed at init by
+ *			uniform and non-uniform SPI NOR flash memories if they
+ *			support at least one erase type that can erase the
+ *			entire memory.
+ */
+struct spi_nor_erase_map {
+	struct spi_nor_erase_region	*regions;
+	struct spi_nor_erase_region	uniform_region;
+	struct spi_nor_erase_type	erase_type[SNOR_ERASE_TYPE_MAX];
+	u8				uniform_erase_type;
+};
+
+/**
+ * struct spi_nor_locking_ops - SPI NOR locking methods
+ * @lock:	lock a region of the SPI NOR.
+ * @unlock:	unlock a region of the SPI NOR.
+ * @is_locked:	check if a region of the SPI NOR is completely locked
+ */
+struct spi_nor_locking_ops {
+	int (*lock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
+	int (*unlock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
+	int (*is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
+};
+
+/**
+ * struct spi_nor_flash_parameter - SPI NOR flash parameters and settings.
+ * Includes legacy flash parameters and settings that can be overwritten
+ * by the spi_nor_fixups hooks, or dynamically when parsing the JESD216
+ * Serial Flash Discoverable Parameters (SFDP) tables.
+ *
+ * @size:		the flash memory density in bytes.
+ * @page_size:		the page size of the SPI NOR flash memory.
+ * @hwcaps:		describes the read and page program hardware
+ *			capabilities.
+ * @reads:		read capabilities ordered by priority: the higher index
+ *                      in the array, the higher priority.
+ * @page_programs:	page program capabilities ordered by priority: the
+ *                      higher index in the array, the higher priority.
+ * @erase_map:		the erase map parsed from the SFDP Sector Map Parameter
+ *                      Table.
+ * @quad_enable:	enables SPI NOR quad mode.
+ * @set_4byte:		puts the SPI NOR in 4 byte addressing mode.
+ * @convert_addr:	converts an absolute address into something the flash
+ *                      will understand. Particularly useful when pagesize=
 is
+ *                      not a power-of-2.
+ * @setup:              configures the SPI NOR memory. Useful for SPI NOR
+ *                      flashes that have peculiarities to the SPI NOR sta=
ndard
+ *                      e.g. different opcodes, specific address calculati=
on,
+ *                      page size, etc.
+ * @locking_ops:	SPI NOR locking methods.
+ */
+struct spi_nor_flash_parameter {
+	u64				size;
+	u32				page_size;
+
+	struct spi_nor_hwcaps		hwcaps;
+	struct spi_nor_read_command	reads[SNOR_CMD_READ_MAX];
+	struct spi_nor_pp_command	page_programs[SNOR_CMD_PP_MAX];
+
+	struct spi_nor_erase_map        erase_map;
+
+	int (*quad_enable)(struct spi_nor *nor);
+	int (*set_4byte)(struct spi_nor *nor, bool enable);
+	u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
+	int (*setup)(struct spi_nor *nor, const struct spi_nor_hwcaps *hwcaps);
+
+	const struct spi_nor_locking_ops *locking_ops;
+};
+
 /**
  * struct spi_nor_fixups - SPI NOR fixup hooks
  * @default_init: called after default flash parameters init. Used to twea=
k
diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadev=
ice.c
index 7930e4490dab..447d84bb2128 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -16,7 +16,7 @@ static void gd25q256_default_init(struct spi_nor *nor)
 	 * indicate the quad_enable method for this case, we need
 	 * to set it in the default_init fixup hook.
 	 */
-	nor->params.quad_enable =3D spi_nor_sr1_bit6_quad_enable;
+	nor->params->quad_enable =3D spi_nor_sr1_bit6_quad_enable;
 }
=20
 static struct spi_nor_fixups gd25q256_fixups =3D {
diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 3a1c34c41388..ffcb60e54a80 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -68,7 +68,7 @@ static const struct flash_info issi_parts[] =3D {
=20
 static void issi_default_init(struct spi_nor *nor)
 {
-	nor->params.quad_enable =3D spi_nor_sr1_bit6_quad_enable;
+	nor->params->quad_enable =3D spi_nor_sr1_bit6_quad_enable;
 }
=20
 static const struct spi_nor_fixups issi_fixups =3D {
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.=
c
index 1ae609c44676..d73bd0363144 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -82,8 +82,8 @@ static const struct flash_info macronix_parts[] =3D {
=20
 static void macronix_default_init(struct spi_nor *nor)
 {
-	nor->params.quad_enable =3D spi_nor_sr1_bit6_quad_enable;
-	nor->params.set_4byte =3D spi_nor_en4_ex4_set_4byte;
+	nor->params->quad_enable =3D spi_nor_sr1_bit6_quad_enable;
+	nor->params->set_4byte =3D spi_nor_en4_ex4_set_4byte;
 }
=20
 static const struct spi_nor_fixups macronix_fixups =3D {
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-s=
t.c
index 8017ca58b3a5..5be817d2f27c 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -106,8 +106,8 @@ static void micron_st_default_init(struct spi_nor *nor)
 {
 	nor->flags |=3D SNOR_F_HAS_LOCK;
 	nor->flags &=3D ~SNOR_F_HAS_16BIT_SR;
-	nor->params.quad_enable =3D NULL;
-	nor->params.set_4byte =3D spi_nor_en4_ex4_wen_set_4byte;
+	nor->params->quad_enable =3D NULL;
+	nor->params->set_4byte =3D spi_nor_en4_ex4_wen_set_4byte;
 }
=20
 static const struct spi_nor_fixups micron_st_fixups =3D {
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index b790c3ec871f..6829dc7e4f74 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -734,6 +734,16 @@ static const u32 *spi_nor_get_map_in_use(struct spi_no=
r *nor, const u32 *smpt,
 	return ret;
 }
=20
+static void spi_nor_region_mark_end(struct spi_nor_erase_region *region)
+{
+	region->offset |=3D SNOR_LAST_REGION;
+}
+
+static void spi_nor_region_mark_overlay(struct spi_nor_erase_region *regio=
n)
+{
+	region->offset |=3D SNOR_OVERLAID_REGION;
+}
+
 /**
  * spi_nor_region_check_overlay() - set overlay bit when the region is ove=
rlaid
  * @region:	pointer to a structure that describes a SPI NOR erase region
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.=
c
index 16683983a20e..6756202ace4b 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -74,7 +74,7 @@ static const struct flash_info spansion_parts[] =3D {
=20
 static void spansion_post_sfdp_fixups(struct spi_nor *nor)
 {
-	if (nor->params.size <=3D SZ_16M)
+	if (nor->params->size <=3D SZ_16M)
 		return;
=20
 	nor->flags |=3D SNOR_F_4B_OPCODES;
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 1e77dffbf729..f15be50024d1 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -97,7 +97,7 @@ static int winbond_set_4byte(struct spi_nor *nor, bool en=
able)
=20
 static void winbond_default_init(struct spi_nor *nor)
 {
-	nor->params.set_4byte =3D winbond_set_4byte;
+	nor->params->set_4byte =3D winbond_set_4byte;
 }
=20
 static const struct spi_nor_fixups winbond_fixups =3D {
diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
index fcf635d89f65..1138bdbf4199 100644
--- a/drivers/mtd/spi-nor/xilinx.c
+++ b/drivers/mtd/spi-nor/xilinx.c
@@ -70,7 +70,7 @@ static int xilinx_nor_setup(struct spi_nor *nor,
 		nor->mtd.erasesize =3D 8 * nor->page_size;
 	} else {
 		/* Flash in Default addressing mode */
-		nor->params.convert_addr =3D s3an_convert_addr;
+		nor->params->convert_addr =3D s3an_convert_addr;
 		nor->mtd.erasesize =3D nor->info->sector_size;
 	}
=20
@@ -79,7 +79,7 @@ static int xilinx_nor_setup(struct spi_nor *nor,
=20
 static void xilinx_post_sfdp_fixups(struct spi_nor *nor)
 {
-	nor->params.setup =3D xilinx_nor_setup;
+	nor->params->setup =3D xilinx_nor_setup;
 }
=20
 static const struct spi_nor_fixups xilinx_fixups =3D {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index dde2988a809e..d3d34c4eea48 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -227,110 +227,6 @@ static inline u8 spi_nor_get_protocol_width(enum spi_=
nor_protocol proto)
 	return spi_nor_get_protocol_data_nbits(proto);
 }
=20
-enum spi_nor_option_flags {
-	SNOR_F_USE_FSR		=3D BIT(0),
-	SNOR_F_HAS_SR_TB	=3D BIT(1),
-	SNOR_F_NO_OP_CHIP_ERASE	=3D BIT(2),
-	SNOR_F_READY_XSR_RDY	=3D BIT(3),
-	SNOR_F_USE_CLSR		=3D BIT(4),
-	SNOR_F_BROKEN_RESET	=3D BIT(5),
-	SNOR_F_4B_OPCODES	=3D BIT(6),
-	SNOR_F_HAS_4BAIT	=3D BIT(7),
-	SNOR_F_HAS_LOCK		=3D BIT(8),
-	SNOR_F_HAS_16BIT_SR	=3D BIT(9),
-	SNOR_F_NO_READ_CR	=3D BIT(10),
-	SNOR_F_HAS_SR_TB_BIT6	=3D BIT(11),
-
-};
-
-/**
- * struct spi_nor_erase_type - Structure to describe a SPI NOR erase type
- * @size:		the size of the sector/block erased by the erase type.
- *			JEDEC JESD216B imposes erase sizes to be a power of 2.
- * @size_shift:		@size is a power of 2, the shift is stored in
- *			@size_shift.
- * @size_mask:		the size mask based on @size_shift.
- * @opcode:		the SPI command op code to erase the sector/block.
- * @idx:		Erase Type index as sorted in the Basic Flash Parameter
- *			Table. It will be used to synchronize the supported
- *			Erase Types with the ones identified in the SFDP
- *			optional tables.
- */
-struct spi_nor_erase_type {
-	u32	size;
-	u32	size_shift;
-	u32	size_mask;
-	u8	opcode;
-	u8	idx;
-};
-
-/**
- * struct spi_nor_erase_command - Used for non-uniform erases
- * The structure is used to describe a list of erase commands to be execut=
ed
- * once we validate that the erase can be performed. The elements in the l=
ist
- * are run-length encoded.
- * @list:		for inclusion into the list of erase commands.
- * @count:		how many times the same erase command should be
- *			consecutively used.
- * @size:		the size of the sector/block erased by the command.
- * @opcode:		the SPI command op code to erase the sector/block.
- */
-struct spi_nor_erase_command {
-	struct list_head	list;
-	u32			count;
-	u32			size;
-	u8			opcode;
-};
-
-/**
- * struct spi_nor_erase_region - Structure to describe a SPI NOR erase reg=
ion
- * @offset:		the offset in the data array of erase region start.
- *			LSB bits are used as a bitmask encoding flags to
- *			determine if this region is overlaid, if this region is
- *			the last in the SPI NOR flash memory and to indicate
- *			all the supported erase commands inside this region.
- *			The erase types are sorted in ascending order with the
- *			smallest Erase Type size being at BIT(0).
- * @size:		the size of the region in bytes.
- */
-struct spi_nor_erase_region {
-	u64		offset;
-	u64		size;
-};
-
-#define SNOR_ERASE_TYPE_MAX	4
-#define SNOR_ERASE_TYPE_MASK	GENMASK_ULL(SNOR_ERASE_TYPE_MAX - 1, 0)
-
-#define SNOR_LAST_REGION	BIT(4)
-#define SNOR_OVERLAID_REGION	BIT(5)
-
-#define SNOR_ERASE_FLAGS_MAX	6
-#define SNOR_ERASE_FLAGS_MASK	GENMASK_ULL(SNOR_ERASE_FLAGS_MAX - 1, 0)
-
-/**
- * struct spi_nor_erase_map - Structure to describe the SPI NOR erase map
- * @regions:		array of erase regions. The regions are consecutive in
- *			address space. Walking through the regions is done
- *			incrementally.
- * @uniform_region:	a pre-allocated erase region for SPI NOR with a unifor=
m
- *			sector size (legacy implementation).
- * @erase_type:		an array of erase types shared by all the regions.
- *			The erase types are sorted in ascending order, with the
- *			smallest Erase Type size being the first member in the
- *			erase_type array.
- * @uniform_erase_type:	bitmask encoding erase types that can erase the
- *			entire memory. This member is completed at init by
- *			uniform and non-uniform SPI NOR flash memories if they
- *			support at least one erase type that can erase the
- *			entire memory.
- */
-struct spi_nor_erase_map {
-	struct spi_nor_erase_region	*regions;
-	struct spi_nor_erase_region	uniform_region;
-	struct spi_nor_erase_type	erase_type[SNOR_ERASE_TYPE_MAX];
-	u8				uniform_erase_type;
-};
-
 /**
  * struct spi_nor_hwcaps - Structure for describing the hardware capabilie=
s
  * supported by the SPI controller (bus master).
@@ -406,61 +302,7 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_ALL		(SNOR_HWCAPS_READ_MASK |	\
 				 SNOR_HWCAPS_PP_MASK)
=20
-struct spi_nor_read_command {
-	u8			num_mode_clocks;
-	u8			num_wait_states;
-	u8			opcode;
-	enum spi_nor_protocol	proto;
-};
-
-struct spi_nor_pp_command {
-	u8			opcode;
-	enum spi_nor_protocol	proto;
-};
-
-enum spi_nor_read_command_index {
-	SNOR_CMD_READ,
-	SNOR_CMD_READ_FAST,
-	SNOR_CMD_READ_1_1_1_DTR,
-
-	/* Dual SPI */
-	SNOR_CMD_READ_1_1_2,
-	SNOR_CMD_READ_1_2_2,
-	SNOR_CMD_READ_2_2_2,
-	SNOR_CMD_READ_1_2_2_DTR,
-
-	/* Quad SPI */
-	SNOR_CMD_READ_1_1_4,
-	SNOR_CMD_READ_1_4_4,
-	SNOR_CMD_READ_4_4_4,
-	SNOR_CMD_READ_1_4_4_DTR,
-
-	/* Octal SPI */
-	SNOR_CMD_READ_1_1_8,
-	SNOR_CMD_READ_1_8_8,
-	SNOR_CMD_READ_8_8_8,
-	SNOR_CMD_READ_1_8_8_DTR,
-
-	SNOR_CMD_READ_MAX
-};
-
-enum spi_nor_pp_command_index {
-	SNOR_CMD_PP,
-
-	/* Quad SPI */
-	SNOR_CMD_PP_1_1_4,
-	SNOR_CMD_PP_1_4_4,
-	SNOR_CMD_PP_4_4_4,
-
-	/* Octal SPI */
-	SNOR_CMD_PP_1_1_8,
-	SNOR_CMD_PP_1_8_8,
-	SNOR_CMD_PP_8_8_8,
-
-	SNOR_CMD_PP_MAX
-};
-
-/* Forward declaration that will be used in 'struct spi_nor_flash_paramete=
r' */
+/* Forward declaration that is used in 'struct spi_nor_controller_ops' */
 struct spi_nor;
=20
 /**
@@ -491,74 +333,14 @@ struct spi_nor_controller_ops {
 	int (*erase)(struct spi_nor *nor, loff_t offs);
 };
=20
-/**
- * struct spi_nor_locking_ops - SPI NOR locking methods
- * @lock:	lock a region of the SPI NOR.
- * @unlock:	unlock a region of the SPI NOR.
- * @is_locked:	check if a region of the SPI NOR is completely locked
- */
-struct spi_nor_locking_ops {
-	int (*lock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
-	int (*unlock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
-	int (*is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
-};
-
-/**
- * struct spi_nor_flash_parameter - SPI NOR flash parameters and settings.
- * Includes legacy flash parameters and settings that can be overwritten
- * by the spi_nor_fixups hooks, or dynamically when parsing the JESD216
- * Serial Flash Discoverable Parameters (SFDP) tables.
- *
- * @size:		the flash memory density in bytes.
- * @page_size:		the page size of the SPI NOR flash memory.
- * @hwcaps:		describes the read and page program hardware
- *			capabilities.
- * @reads:		read capabilities ordered by priority: the higher index
- *                      in the array, the higher priority.
- * @page_programs:	page program capabilities ordered by priority: the
- *                      higher index in the array, the higher priority.
- * @erase_map:		the erase map parsed from the SFDP Sector Map Parameter
- *                      Table.
- * @quad_enable:	enables SPI NOR quad mode.
- * @set_4byte:		puts the SPI NOR in 4 byte addressing mode.
- * @convert_addr:	converts an absolute address into something the flash
- *                      will understand. Particularly useful when pagesize=
 is
- *                      not a power-of-2.
- * @setup:              configures the SPI NOR memory. Useful for SPI NOR
- *                      flashes that have peculiarities to the SPI NOR sta=
ndard
- *                      e.g. different opcodes, specific address calculati=
on,
- *                      page size, etc.
- * @locking_ops:	SPI NOR locking methods.
- */
-struct spi_nor_flash_parameter {
-	u64				size;
-	u32				page_size;
-
-	struct spi_nor_hwcaps		hwcaps;
-	struct spi_nor_read_command	reads[SNOR_CMD_READ_MAX];
-	struct spi_nor_pp_command	page_programs[SNOR_CMD_PP_MAX];
=20
-	struct spi_nor_erase_map        erase_map;
-
-	int (*quad_enable)(struct spi_nor *nor);
-	int (*set_4byte)(struct spi_nor *nor, bool enable);
-	u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
-	int (*setup)(struct spi_nor *nor, const struct spi_nor_hwcaps *hwcaps);
-
-	const struct spi_nor_locking_ops *locking_ops;
-};
-
-/**
- * struct flash_info - Forward declaration of a structure used internally =
by
- *		       spi_nor_scan()
+/*
+ * Forward declarations that are used internally by the core and manufactu=
rer
+ * drivers.
  */
 struct flash_info;
-
-/**
- * struct spi_nor_manufacturer - Forward declaration of a structure used
- * internally by the core and manufacturer drivers.
- */
 struct spi_nor_manufacturer;
+struct spi_nor_flash_parameter;
=20
 /**
  * struct spi_nor - Structure for defining a the SPI NOR layer
@@ -613,7 +395,7 @@ struct spi_nor {
=20
 	const struct spi_nor_controller_ops *controller_ops;
=20
-	struct spi_nor_flash_parameter params;
+	struct spi_nor_flash_parameter *params;
=20
 	struct {
 		struct spi_mem_dirmap_desc *rdesc;
@@ -623,35 +405,6 @@ struct spi_nor {
 	void *priv;
 };
=20
-static u64 __maybe_unused
-spi_nor_region_is_last(const struct spi_nor_erase_region *region)
-{
-	return region->offset & SNOR_LAST_REGION;
-}
-
-static u64 __maybe_unused
-spi_nor_region_end(const struct spi_nor_erase_region *region)
-{
-	return (region->offset & ~SNOR_ERASE_FLAGS_MASK) + region->size;
-}
-
-static void __maybe_unused
-spi_nor_region_mark_end(struct spi_nor_erase_region *region)
-{
-	region->offset |=3D SNOR_LAST_REGION;
-}
-
-static void __maybe_unused
-spi_nor_region_mark_overlay(struct spi_nor_erase_region *region)
-{
-	region->offset |=3D SNOR_OVERLAID_REGION;
-}
-
-static bool __maybe_unused spi_nor_has_uniform_erase(const struct spi_nor =
*nor)
-{
-	return !!nor->params.erase_map.uniform_erase_type;
-}
-
 static inline void spi_nor_set_flash_node(struct spi_nor *nor,
 					  struct device_node *np)
 {
--=20
2.23.0
