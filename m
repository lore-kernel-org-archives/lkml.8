Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD033C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C44020842
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Y9364sZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgCBSXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:23:13 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:33107 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbgCBSXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:23:11 -0500
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
IronPort-SDR: Et8wgwFivVl09Ms2xzqKkIR1c5Ozvp3GWoLf0y0aQ2WqPmKFpHLzFguQJncCSi5xQHIS8BSlUv
 oGYl4o7iw7nEz8zgMyeiCs65NHgJS7bxBt+hgthAla2YFrJyBhWQZ00dxHbvH4g3kLYwRUEH6B
 Gw+1z/D3qjXs3aJZO42+WPYlQ8JdflIKocbK6vRr09D3ZnYcl7bn9UVSZFZTRl8NkWOV6aR0Ga
 bltvwYEdQZ3itEIpqNduT5iSapOQQflRQjX4VEVKE2zPcEYPA7/+j8Wtn4p9DyVckjaTfK3BDF
 ezY=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="67603667"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 11:23:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 11:08:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 11:08:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbBPIs3LzbShjBsYoD6vOKMSHB2Pu7lv82wqc7fXTH6XvYP2dJ6r39BsfuLdN6sWVmf1AkAXie2OmynN7DlFzRNGETFTh7u3a4FdEzs61/a0qR41jy/d8ZdXYk+X6MN+bky5AA/ihT4iNIXj9eSHgcTo5PHDqee4IsrswDLvRndQ96qGJXnPYEUnQFFheJeDBg9rRjCPYaC32A0rIiT5Yi9YL0R63WIutCRJJB7nzDe/ZSIW6R9O4APYfaDN5hvjABBYzM46qzsocPOmV6vJ9e9lTSl5mfgzI/LJpPzDOxUrTe6bOPv4DnGffM6tlF4CCKXmJKGDJ2O0W7Cy/Xjigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgxP/0qrLREtX2VdVJrzjCW/rVhmsK0LisXVTin0iQA=;
 b=dmXkRXOi9LTPTkO9gMcItae0yF+v34N+nhQ2eIpuiXRnJGe19qlHpIOmh645wbJKK5+vnrywVU6sxyox/uOMzFVvdrema4b/mabZNaVWOBsF4CUslm2fOXLi9iNcKtebWuvviycbzOwG7/sxUHTF4gVVsmFbeUv2hmpylViF1Y3OJ0izW+UtdEPnGTrfjDT9V31V9gXgKR9DhOviMYfsiu6XRKE2IiDMBY+hGw3XWRf2Ldvs15S8ZIn46d1OgFjS8Hk6heyt2ayj1BUkp8ejxGiy/II8dFBLB1hOtYL+sN8AC12CcRu3I+0oEcErXary1uyl69Q87DYjy8IZg51IwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgxP/0qrLREtX2VdVJrzjCW/rVhmsK0LisXVTin0iQA=;
 b=Y9364sZLpSWxaqJcX81GBriBHNeR/oSxLI12T97OVepEDAluYQzFnZuGDz9acopgXuYM+6GvNSJ7aO3zj/nnGTdbr0bPGgyVxHAVsnZUqCbRQwJXG+/M7jzkanq/1tAOqfX7wzpAn64qAOuuYconUSm0MvzN62q0JGlsB0DSIGI=
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
Subject: [PATCH 22/23] mtd: spi-nor: Get rid of the now empty spi_nor_ids[]
 table
Thread-Topic: [PATCH 22/23] mtd: spi-nor: Get rid of the now empty
 spi_nor_ids[] table
Thread-Index: AQHV8L2Ao5pXiJSCo0+Lr0LSsFFLlA==
Date:   Mon, 2 Mar 2020 18:07:57 +0000
Message-ID: <20200302180730.1886678-23-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f086245d-cb62-4cdd-8d3f-08d7bed4a306
x-ms-traffictypediagnostic: MN2PR11MB4142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4142EF77AA6FBC2B4F03AAE0F0E70@MN2PR11MB4142.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(36756003)(26005)(66446008)(107886003)(6486002)(186003)(2616005)(4326008)(478600001)(6512007)(91956017)(64756008)(66946007)(2906002)(71200400001)(76116006)(8936002)(316002)(86362001)(54906003)(6506007)(66556008)(5660300002)(66476007)(7406005)(1076003)(7416002)(81156014)(81166006)(110136005)(8676002)(26583001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4142;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8DyBiWuLtupwp5M+h1SfOK0RS6z/zXM5w1X9iGEjEv3RdFt/+KbnaE7lRggGXhT6ZMJaUo5pXLJpmT4SGzeQCV+LsY+ti6Vu/Kq7xWV1AKCGwBRnjOWPmz1HbmFTPmgNZT7OGtiBo8ADm5/yxskrBXt8O6YqRZccUJG4u6iMryYFC9/8TnaNniSJU5poCUFPv/3PEgsDZw+h+LZEGEOfe/Jwq6I4LaETeHEFSC1TxjjZ+N8jZT3w+xfoiHTztOJZtfEe1rr9t1Fp+B8vUAcAqU3sDEPqrfB+g40y+RIDifv9imGNuRECQJaEfNkiRFu1i4sTYJb64d3orOkDJba2PIZm2qDBKPsYdYGX7yqhQz7UO8P81HR+S82Ic1tx0DhF6D1MHa1A6eg7nng0xqysm/TLF5LP/1Cs04lQU04eTO5jEfrXK0/GKKRtVCFD0F/LsyK9fHdSemR1Pwr51WBmFjMGzEJMptHXlN+83HNYuw+FEFGj6jQ1q97RN8Rxt1hl
x-ms-exchange-antispam-messagedata: nbRyvy0kRzWsH24VUoZHBR+WeVsE6hjfvWnWYxpRPJrYSHwB1F9SLcxfXmmH4ldTDcBf//CJNC9LqauEZuO+h7O3zShMi6N4H8meZZL389szMedXjwLXsfVMPbJ3iM4nvncn3KRRfz4jp5cHifK0xw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f086245d-cb62-4cdd-8d3f-08d7bed4a306
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:07:57.0426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f5vfbYniA3sHIKzQ7h85mmQdxw3fAZxfIcRwP08w+kvxOZU4MiGwiC+3ychKLi3ZUIMc7t/brvzTlUXafiLc8Ve7lVRBDROSy6Fwt4eXVN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

All entries have been moved to manufacturer drivers. Get rid of this
empty table.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f4178cd65c45..a2e1917b608d 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1953,21 +1953,6 @@ int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor=
)
 	return 0;
 }
=20
-/* NOTE: double check command sets and memory organization when you add
- * more nor chips.  This current list focusses on newer chips, which
- * have been converging on command sets which including JEDEC ID.
- *
- * All newly added entries should describe *hardware* and should use SECT_=
4K
- * (or SECT_4K_PMC) if hardware supports erasing 4 KiB sectors. For usage
- * scenarios excluding small sectors there is config option that can be
- * disabled: CONFIG_MTD_SPI_NOR_USE_4K_SECTORS.
- * For historical (and compatibility) reasons (before we got above config)=
 some
- * old entries may be missing 4K flag.
- */
-static const struct flash_info spi_nor_ids[] =3D {
-	{ },
-};
-
 static const struct spi_nor_manufacturer *manufacturers[] =3D {
 	&spi_nor_atmel,
 	&spi_nor_catalyst,
@@ -2037,11 +2022,6 @@ static const struct flash_info *spi_nor_read_id(stru=
ct spi_nor *nor)
 		}
 	}
=20
-	info =3D spi_nor_search_part_by_id(spi_nor_ids,
-					 ARRAY_SIZE(spi_nor_ids) - 1, id);
-	if (info)
-		return info;
-
 	dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
 		SPI_NOR_MAX_ID_LEN, id);
 	return ERR_PTR(-ENODEV);
@@ -2952,11 +2932,6 @@ static const struct flash_info *spi_nor_match_id(str=
uct spi_nor *nor,
 {
 	unsigned int i, j;
=20
-	for (i =3D 0; i < ARRAY_SIZE(spi_nor_ids) - 1; i++) {
-		if (!strcmp(name, spi_nor_ids[i].name))
-			return &spi_nor_ids[i];
-	}
-
 	for (i =3D 0; i < ARRAY_SIZE(manufacturers); i++) {
 		for (j =3D 0; j < manufacturers[i]->nparts; j++) {
 			if (!strcmp(name, manufacturers[i]->parts[j].name)) {
--=20
2.23.0
