Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163F3C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C524E2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bGSZWQhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgCBSHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:07:51 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:59612 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBSHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:07:50 -0500
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
IronPort-SDR: HPeQzili6Vd210zJC1LxMw2K39zmUueDHCutulADMKeyXrzPgENDQk+vhaxwgpXfSOP7H0MSkc
 +7mSRDgo2detp6uMS8rAf5WG1XPjYB9ZFN0qLK67afiwRqYrUiYKcK4T7ZAZhoqV0sUn2iqJbt
 YHkFafEou07N+wSEaGmWl4QOSpF0HaLSND5/sIZjLfobCrEPMenBfKXiWENb6GSA0II96ZvcCO
 dAjHM0r/fbcQvimKPnJ/k2o+ys9H5LCJuwxJeOgrVpStCEqjNEyEb+pIFVFakXQjNmzlmXKyxG
 SIE=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="4204854"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 11:07:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 11:07:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Mar 2020 11:08:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sfi5VTiEJ2DD5h/8ogchhHpXy7VXytPSV9Oi7pD9/gBPD6z4m2n8PmVkdcQv0kAu6pRCRLtB+XBExObdZXAjtr3HwRBR+DNL4F6zJcMyHOrRHfM6Y+9qCbboMspWBHJCMhlSkmyHr1bjp3SlcsDr2uLIXBSU25B1/02SeXkjYeuHQrbVPq31i98Q3dXkbrvbOZlEI4oY0efh/38nd/ZrAjyrs1T6/CmnjJQkbxqg/PSqFO323taV+o7HLkID1Ss7QaioBJYR7XqLYTHThqTHH85iwS1YRItyscRK5EPYpuoIW8MYn4KC29sKxgpUi5b97/YPbmUoiQ17te08pg+97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbVllX3YOhajiMNUHRnkeg4BAiYDSTHwf4Ya15PmZyg=;
 b=J1kL7WypcLXv2eg3lhcaa82t1vqSvQ+3ymkQ/1d2h/+hHDGQnMzbPfVZxTaWWKPA8S6MouzP0rVRVZLEendueaoOcYgQOwAxhmEWwEWCnAklmRuuLOze1o6pK6s65NdeMdh3mSLjixvVrjrpE6TvuGTYnqfcU5AH1Drz7KBqE5i0UiJQL69XD8skcDWBg4elVAZA0/iOwiu3lPpjs9E3l93837/TvQolorLQ+DwrGhnM8nz3zZ+cgzuQEWCgmpFqtfeQevEJIdLL9SumtCFXjTkIuMCk/3m6ZWBChbA0X4Owz7BkU5whzYHnOJv3R+bW32GsJ2CZIQCUEhNekoLE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbVllX3YOhajiMNUHRnkeg4BAiYDSTHwf4Ya15PmZyg=;
 b=bGSZWQhmQWYxa2etjTD7rVpgi2Pv7tBjybfbS30DOpErb/lq0PObOxzgokMufS4byPt7dmjSx5w0PQGrMGlYmiW4f0iSB6WAE270jWiO9ymv3dsG4fThQgFSK8lJOn+gciDrLsgBVe7UijO8MKk/BJVzE0cGCo4aDIFHJmysjRI=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29)
 by MN2PR11MB4142.namprd11.prod.outlook.com (2603:10b6:208:135::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 18:07:45 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 18:07:45 +0000
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
Subject: [PATCH 01/23] mtd: spi-nor: Stop prefixing generic functions with a
 manufacturer name
Thread-Topic: [PATCH 01/23] mtd: spi-nor: Stop prefixing generic functions
 with a manufacturer name
Thread-Index: AQHV8L153mkdeT8Yk06rHisgydrYfw==
Date:   Mon, 2 Mar 2020 18:07:44 +0000
Message-ID: <20200302180730.1886678-2-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29edb9d2-be08-41d2-0c3e-08d7bed49bf3
x-ms-traffictypediagnostic: MN2PR11MB4142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB41421CE86EFD686811921895F0E70@MN2PR11MB4142.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(36756003)(26005)(66446008)(107886003)(6486002)(186003)(2616005)(4326008)(478600001)(6512007)(91956017)(64756008)(66946007)(2906002)(71200400001)(76116006)(8936002)(316002)(86362001)(54906003)(6506007)(66556008)(5660300002)(66476007)(7406005)(1076003)(7416002)(81156014)(81166006)(110136005)(8676002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4142;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vzNHmBfRbOS8kyakJ07ytOMfbAIAYwZvQ+c4S4M7aqqGofSwOvNLVv0YLsRKcd3Ulnp87sLCVqAKfU4DUjW0qiq8Ii+m68uznyfQwtciKw/3YyZ7zkwAMyIOcR9Hg45xSVIN4tK4FONqG13w84DEORfbxgJqQv2Yl7rtE6Z0elglfcaiEfoJjuhXgoNRRT+WsOrkhMaoREi6QNVnqu7D2G1PYaik6n3KbJeigquFtcgYKn2SD/vnG+h6j4FgTlcTPAlOzrKyfDo/JPn69e3l3OjRB3cwoiRzCSH37fL+YzbKg8k+OlzdZ0AIxBzuQibd0iLafys33S2vj5y3eGdKm5XFoHzvzlIFCIIg0kyTXFlhyAKyysmORctS/CoDXmKV3Uw1JptCS7G05ORZUcNTAWI2wcXzrRXc4V+DZ0B42mQdEpWonBHw++AQZP9NMeg4F60aCKOSzXEErxvMAGddueTQD0EYta8OfqVfCBv9JoC96VrwCAkYLGn1ePzT5i1r
x-ms-exchange-antispam-messagedata: 9zDqoaLC0BS1wCvkE3cNGnx9T618WAOTVjmmo7k4+isVNSB7cXm+RLCqSXyPWbnj20iR6XKk6tks9zrUQCPuMFdLueBuVzquJUyebrWbqfmYffsBSAP2wrfvIjVqtHgzd/8hG8i5Fr4uvnWqGDXv5w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 29edb9d2-be08-41d2-0c3e-08d7bed49bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:07:44.8159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0rmOW1+DlCaC+COxmqb3VG6ZOcZe1XLzUteGuTtpLSMYPTeEvDOOSoFbjWMaqHORFLdxZ6b1EmNtLhCrDpeSl2JM1xc2zjSWMbnVdCg5g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

Replace the manufacturer prefix by something describing more precisely
what those functions do.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
[tudor.ambarus@microchip.com: prepend spi_nor_ to all modified methods.]
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 88 ++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index caf0c109cca0..b15e262765e1 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -568,14 +568,15 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *c=
r)
 }
=20
 /**
- * macronix_set_4byte() - Set 4-byte address mode for Macronix flashes.
+ * spi_nor_en4_ex4_set_4byte() - Enter/Exit 4-byte mode for Macronix like
+ * flashes.
  * @nor:	pointer to 'struct spi_nor'.
  * @enable:	true to enter the 4-byte address mode, false to exit the 4-byt=
e
  *		address mode.
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int macronix_set_4byte(struct spi_nor *nor, bool enable)
+static int spi_nor_en4_ex4_set_4byte(struct spi_nor *nor, bool enable)
 {
 	int ret;
=20
@@ -604,14 +605,15 @@ static int macronix_set_4byte(struct spi_nor *nor, bo=
ol enable)
 }
=20
 /**
- * st_micron_set_4byte() - Set 4-byte address mode for ST and Micron flash=
es.
+ * spi_nor_en4_ex4_wen_set_4byte() - Set 4-byte address mode for ST and Mi=
cron
+ * flashes.
  * @nor:	pointer to 'struct spi_nor'.
  * @enable:	true to enter the 4-byte address mode, false to exit the 4-byt=
e
  *		address mode.
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int st_micron_set_4byte(struct spi_nor *nor, bool enable)
+static int spi_nor_en4_ex4_wen_set_4byte(struct spi_nor *nor, bool enable)
 {
 	int ret;
=20
@@ -619,7 +621,7 @@ static int st_micron_set_4byte(struct spi_nor *nor, boo=
l enable)
 	if (ret)
 		return ret;
=20
-	ret =3D macronix_set_4byte(nor, enable);
+	ret =3D spi_nor_en4_ex4_set_4byte(nor, enable);
 	if (ret)
 		return ret;
=20
@@ -703,7 +705,7 @@ static int winbond_set_4byte(struct spi_nor *nor, bool =
enable)
 {
 	int ret;
=20
-	ret =3D macronix_set_4byte(nor, enable);
+	ret =3D spi_nor_en4_ex4_set_4byte(nor, enable);
 	if (ret || enable)
 		return ret;
=20
@@ -755,13 +757,13 @@ static int spi_nor_xread_sr(struct spi_nor *nor, u8 *=
sr)
 }
=20
 /**
- * s3an_sr_ready() - Query the Status Register of the S3AN flash to see if=
 the
- * flash is ready for new commands.
+ * spi_nor_xsr_ready() - Query the Status Register of the S3AN flash to se=
e if
+ * the flash is ready for new commands.
  * @nor:	pointer to 'struct spi_nor'.
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int s3an_sr_ready(struct spi_nor *nor)
+static int spi_nor_xsr_ready(struct spi_nor *nor)
 {
 	int ret;
=20
@@ -892,7 +894,7 @@ static int spi_nor_ready(struct spi_nor *nor)
 	int sr, fsr;
=20
 	if (nor->flags & SNOR_F_READY_XSR_RDY)
-		sr =3D s3an_sr_ready(nor);
+		sr =3D spi_nor_xsr_ready(nor);
 	else
 		sr =3D spi_nor_sr_ready(nor);
 	if (sr < 0)
@@ -1784,8 +1786,8 @@ static int spi_nor_erase(struct mtd_info *mtd, struct=
 erase_info *instr)
 	return ret;
 }
=20
-static void stm_get_locked_range(struct spi_nor *nor, u8 sr, loff_t *ofs,
-				 uint64_t *len)
+static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t=
 *ofs,
+					uint64_t *len)
 {
 	struct mtd_info *mtd =3D &nor->mtd;
 	u8 mask =3D SR_BP2 | SR_BP1 | SR_BP0;
@@ -1813,8 +1815,8 @@ static void stm_get_locked_range(struct spi_nor *nor,=
 u8 sr, loff_t *ofs,
  * Return 1 if the entire region is locked (if @locked is true) or unlocke=
d (if
  * @locked is false); 0 otherwise
  */
-static int stm_check_lock_status_sr(struct spi_nor *nor, loff_t ofs, uint6=
4_t len,
-				    u8 sr, bool locked)
+static int spi_nor_check_lock_status_sr(struct spi_nor *nor, loff_t ofs,
+					uint64_t len, u8 sr, bool locked)
 {
 	loff_t lock_offs;
 	uint64_t lock_len;
@@ -1822,7 +1824,7 @@ static int stm_check_lock_status_sr(struct spi_nor *n=
or, loff_t ofs, uint64_t le
 	if (!len)
 		return 1;
=20
-	stm_get_locked_range(nor, sr, &lock_offs, &lock_len);
+	spi_nor_get_locked_range_sr(nor, sr, &lock_offs, &lock_len);
=20
 	if (locked)
 		/* Requested range is a sub-range of locked range */
@@ -1832,16 +1834,16 @@ static int stm_check_lock_status_sr(struct spi_nor =
*nor, loff_t ofs, uint64_t le
 		return (ofs >=3D lock_offs + lock_len) || (ofs + len <=3D lock_offs);
 }
=20
-static int stm_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
-			    u8 sr)
+static int spi_nor_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t =
len,
+				u8 sr)
 {
-	return stm_check_lock_status_sr(nor, ofs, len, sr, true);
+	return spi_nor_check_lock_status_sr(nor, ofs, len, sr, true);
 }
=20
-static int stm_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t le=
n,
-			      u8 sr)
+static int spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_=
t len,
+				  u8 sr)
 {
-	return stm_check_lock_status_sr(nor, ofs, len, sr, false);
+	return spi_nor_check_lock_status_sr(nor, ofs, len, sr, false);
 }
=20
 /*
@@ -1876,7 +1878,7 @@ static int stm_is_unlocked_sr(struct spi_nor *nor, lo=
ff_t ofs, uint64_t len,
  *
  * Returns negative on errors, 0 on success.
  */
-static int stm_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
 	struct mtd_info *mtd =3D &nor->mtd;
 	int ret, status_old, status_new;
@@ -1894,16 +1896,16 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs=
, uint64_t len)
 	status_old =3D nor->bouncebuf[0];
=20
 	/* If nothing in our range is unlocked, we don't need to do anything */
-	if (stm_is_locked_sr(nor, ofs, len, status_old))
+	if (spi_nor_is_locked_sr(nor, ofs, len, status_old))
 		return 0;
=20
 	/* If anything below us is unlocked, we can't use 'bottom' protection */
-	if (!stm_is_locked_sr(nor, 0, ofs, status_old))
+	if (!spi_nor_is_locked_sr(nor, 0, ofs, status_old))
 		can_be_bottom =3D false;
=20
 	/* If anything above us is unlocked, we can't use 'top' protection */
-	if (!stm_is_locked_sr(nor, ofs + len, mtd->size - (ofs + len),
-				status_old))
+	if (!spi_nor_is_locked_sr(nor, ofs + len, mtd->size - (ofs + len),
+				  status_old))
 		can_be_top =3D false;
=20
 	if (!can_be_bottom && !can_be_top)
@@ -1958,11 +1960,11 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs=
, uint64_t len)
 }
=20
 /*
- * Unlock a region of the flash. See stm_lock() for more info
+ * Unlock a region of the flash. See spi_nor_sr_lock() for more info
  *
  * Returns negative on errors, 0 on success.
  */
-static int stm_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len=
)
 {
 	struct mtd_info *mtd =3D &nor->mtd;
 	int ret, status_old, status_new;
@@ -1980,16 +1982,16 @@ static int stm_unlock(struct spi_nor *nor, loff_t o=
fs, uint64_t len)
 	status_old =3D nor->bouncebuf[0];
=20
 	/* If nothing in our range is locked, we don't need to do anything */
-	if (stm_is_unlocked_sr(nor, ofs, len, status_old))
+	if (spi_nor_is_unlocked_sr(nor, ofs, len, status_old))
 		return 0;
=20
 	/* If anything below us is locked, we can't use 'top' protection */
-	if (!stm_is_unlocked_sr(nor, 0, ofs, status_old))
+	if (!spi_nor_is_unlocked_sr(nor, 0, ofs, status_old))
 		can_be_top =3D false;
=20
 	/* If anything above us is locked, we can't use 'bottom' protection */
-	if (!stm_is_unlocked_sr(nor, ofs + len, mtd->size - (ofs + len),
-				status_old))
+	if (!spi_nor_is_unlocked_sr(nor, ofs + len, mtd->size - (ofs + len),
+				    status_old))
 		can_be_bottom =3D false;
=20
 	if (!can_be_bottom && !can_be_top)
@@ -2046,13 +2048,13 @@ static int stm_unlock(struct spi_nor *nor, loff_t o=
fs, uint64_t len)
 }
=20
 /*
- * Check if a region of the flash is (completely) locked. See stm_lock() f=
or
- * more info.
+ * Check if a region of the flash is (completely) locked. See spi_nor_sr_l=
ock()
+ * for more info.
  *
  * Returns 1 if entire region is locked, 0 if any portion is unlocked, and
  * negative on errors.
  */
-static int stm_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
+static int spi_nor_sr_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t =
len)
 {
 	int ret;
=20
@@ -2060,13 +2062,13 @@ static int stm_is_locked(struct spi_nor *nor, loff_=
t ofs, uint64_t len)
 	if (ret)
 		return ret;
=20
-	return stm_is_locked_sr(nor, ofs, len, nor->bouncebuf[0]);
+	return spi_nor_is_locked_sr(nor, ofs, len, nor->bouncebuf[0]);
 }
=20
-static const struct spi_nor_locking_ops stm_locking_ops =3D {
-	.lock =3D stm_lock,
-	.unlock =3D stm_unlock,
-	.is_locked =3D stm_is_locked,
+static const struct spi_nor_locking_ops spi_nor_sr_locking_ops =3D {
+	.lock =3D spi_nor_sr_lock,
+	.unlock =3D spi_nor_sr_unlock,
+	.is_locked =3D spi_nor_sr_is_locked,
 };
=20
 static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
@@ -4655,7 +4657,7 @@ static void issi_set_default_init(struct spi_nor *nor=
)
 static void macronix_set_default_init(struct spi_nor *nor)
 {
 	nor->params.quad_enable =3D spi_nor_sr1_bit6_quad_enable;
-	nor->params.set_4byte =3D macronix_set_4byte;
+	nor->params.set_4byte =3D spi_nor_en4_ex4_set_4byte;
 }
=20
 static void sst_set_default_init(struct spi_nor *nor)
@@ -4668,7 +4670,7 @@ static void st_micron_set_default_init(struct spi_nor=
 *nor)
 	nor->flags |=3D SNOR_F_HAS_LOCK;
 	nor->flags &=3D ~SNOR_F_HAS_16BIT_SR;
 	nor->params.quad_enable =3D NULL;
-	nor->params.set_4byte =3D st_micron_set_4byte;
+	nor->params.set_4byte =3D spi_nor_en4_ex4_wen_set_4byte;
 }
=20
 static void winbond_set_default_init(struct spi_nor *nor)
@@ -4895,7 +4897,7 @@ static void spi_nor_late_init_params(struct spi_nor *=
nor)
 	 * the default ones.
 	 */
 	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params.locking_ops)
-		nor->params.locking_ops =3D &stm_locking_ops;
+		nor->params.locking_ops =3D &spi_nor_sr_locking_ops;
 }
=20
 /**
--=20
2.23.0
