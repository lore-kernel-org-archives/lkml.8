Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113C6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A56206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DKsROce+";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="JcWJjtcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgENFEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:04:07 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:58596 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgENFDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432595; x=1620968595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QamDy4OWnmGDBETtKnaYfVVxvdp1Hscj7dmQmNvd8fw=;
  b=DKsROce+q9sm0JFSlFve3RF5hMaB8qOFRiMiNIz+Yvv3Ef3Z6KkvJbj5
   kKUNUIrAUn2eEmC1B7mva7/xAxu0i4NN5USTi4SqO+cTRmZG7iYBQOKcd
   IHx8Nubc1sBA9eGwm1vqW9MIPizCHxIRevvXrytHsx+W0j4ABWTAhqOfb
   c79nXogpmuApvJfOOdnXAJs0vshTcwHo/49Qgmcq90MwNmuaQyaPWOAfd
   jFumZGoQJf5YPaOVDqxosrhGO7TrqGzcrbdm2cbN366YeU0dOdn5DXj3f
   CjFrwtSe9sBG/Vv8PZhUrH8+lVDxCBFN2SfJQYC+1+qReo5RxoaXe4J2O
   A==;
IronPort-SDR: GSxveSHu2ZNUnYtj6J5rk37ZgOFP1VAr3aMURanOX9RGViOFMjZafKbkF/n6ESFo4ksbRauuT7
 0FJDwwcf+lYuugWVtKRJIpBQBkRx1Ua445H6DXaL6NuQQXLq0yqsof7P+is6fvrIJHnBgo0rMM
 NcCvRaomwonpuoFoQwD+jYqZJh78YmF1ac56lfByrYt+rDRFvPR8fNegXjG63C0eqY2M2TLLxI
 YxDlwYdXQM5OdVak5FTWaChjx0M6izW/jdGXncdfS9jBc3/9WzzczvxpDM963dWx82++QvgQZh
 oKI=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="75847109"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 13 May 2020 22:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFqFmmFaDePyFXt3bdx23ovYMX7glL2fGZo2GpfoD8ka8d1ufPlgXfLtG8OoggeivfuD7sg8uEOvEqjUyvjTrKYid8LcxsOs+bCdw2/QpgQk/ACwa5NzppxzUObqCRuJ4nr+l52W/8gt8VC4/gi3qcdYFCwQKjqUeq4t2Dh73Rhpz0kon4kzqhBIZoqRmF6luqwbLZbBwVYUGHGoc94ndPx2NCMJVSFtCNdhQjgQ8omNelE4FxaFFiPTn90fDJa5KDT68dSa8zcMiTwnY99qJUXG8mdnZr/V2XIEoPY16Ri6Fn+swR7YDobcSv30K9PmXZovZ/6LuFRPL4g8jFEwWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUdoc5A82z4/N8WcEz0MkkqG1tCjekoVIngNSQ+hHBY=;
 b=ieJ+SwKEj60OuBvH+3g2LjIjt6qsAhid+8UL3watU+nztl5kXIRjrIMIJ6Z7At9rqBeBeZrXGqJEjzxveSkKa4heBb55BWxoxzWQMetGqLsRVvU5dUPWXGpRZV1AEaYgkGjyfxEhIQxILPX34gxh0HH5f/lvYcw+2q6WNNPgSWbZMcjzSmYdXhHxjTagPwXMdB6LEtiGzadNE4i+taPZLLbjqBBVs8NbLb0vp10yVBzx2J0WeQ6VUXt79uSCeg2cYQ7qY/99EF2N1zbtpjNuYPd4P3bcShwQgo7mbepooWvsT6BwTjKhCDXLFt9lwlV9FhVGcuqFM11AdEuRblN3ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUdoc5A82z4/N8WcEz0MkkqG1tCjekoVIngNSQ+hHBY=;
 b=JcWJjtcd8hvZgHF7YjDdlVPtPYnRTzPOgwfo7LF3S8weaBR0BIOGjWCVjOwmwac9K4gDEmWE3lcEYAFpXEZAvmpDVbk/LKjNr0FZ/DN7RU4eIFnliIuauJa5cNkh4hHvYM3IELBkxSZlUe1ZhkOlQZWZJ3mYRzvfMlYlT9Q2qoo=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4483.namprd11.prod.outlook.com (2603:10b6:a03:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 05:03:13 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 05:03:13 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 10/16] ARM: dts: at91: sama5d2: Add DMA bindings for the flx1
 I2C function
Thread-Topic: [PATCH 10/16] ARM: dts: at91: sama5d2: Add DMA bindings for the
 flx1 I2C function
Thread-Index: AQHWKaz4ykI3pcTezkS8vNPyyPejRA==
Date:   Thu, 14 May 2020 05:03:13 +0000
Message-ID: <20200514050301.147442-11-tudor.ambarus@microchip.com>
References: <20200514050301.147442-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200514050301.147442-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b57620c-c9bd-487d-c73f-08d7f7c41b24
x-ms-traffictypediagnostic: BY5PR11MB4483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB44831CF840E9F964A84620FCF0BC0@BY5PR11MB4483.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /+1yZPbkPianGFpkX41VT8fogTmoLr/CzLSMRsngulwEaloqvOpNgQh2F4YkqHSrQ7hE/kRt1Nfj9zCGZab1D0wRXQyxYPZ5K9jMBUSSN24Q/qmdgwGBnUzTfP5zNtsvNa/PjcV2jXix1h/qKkKjtu8fDKq0AX/zdqTMSYgnN946LjEDwbNt3jcuumc01Wlom94aNwOZ4jsTytN6KW7qhlLwEzVxkpb4qmw73rJJcxmMSkhVomw+G747FS0fwXeohteisJpTIUzrLIXw41H4Jitwsqsttz6f+AnfAxKm8PZIKyIjK4KEFHjJ93TyYQ1w5xCgG/r1qbqPKU1Mh8SghmOlCyVwaj5Gta+ljPwbcklfFFsQurZAcl8U7YQQpMSHJFkxHTAwFljW7VWI1MFxnyjczaCCJP+dqHG50BPC4lcCjJYoB/dE4wfJ+xYtExtp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(6506007)(76116006)(6486002)(26005)(66446008)(8676002)(6512007)(86362001)(66946007)(2616005)(64756008)(8936002)(478600001)(66476007)(66556008)(186003)(1076003)(4326008)(2906002)(71200400001)(6636002)(54906003)(316002)(107886003)(5660300002)(36756003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: G0jOGkrDCQ4H8JdGiIZD9dA/Gu/te6RgK6xIvHSghIfjf/X+Iby8ULEYCFvaHgnJ9QUlZfaU23I3PDNOE42CnI52yJWIDbduFc+bYq+gGIThpr0yf/Eiy/uyLD0WDxX6Kfigb8uOCAUigqWR/a78ichM+97ZifDrwUtX7zOs/U7h3vymHJZwC3pw5FwcfwLp5RWFwq9oBKfZ6CPPj1WEmyKjl+c+RiGj+qaNJkXVE1/6teFhkIdve3CSLjVVQqFx6Cptu/LFDiSo/O0nbblUXbUmrCff0f21HPlxQSuG4UDW0FqqjiGc9ivw2uOXZhBtEdaNT+XObH0pEBxGDL1FEBlk/4vPdqK73AlOkcIs3bZsBrPuFrQPRAY6IM9r1iBISmPNn1KjxWmpvQgKsm5IgWDUlQnNuPljhSU2pWGuCQxLpTIL8IdN9XOr8ERcqOS74WvPlI5GG4crLG9bNL3uLAnKeOflu2syKfT9A9CcKbRcmQUq6T6ZjVyW0QEg4sFb
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b57620c-c9bd-487d-c73f-08d7f7c41b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:13.5521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0ucuOWLz/CzMBNQDb66IgaVjRrQ1hTdcN/N8W5Yb0mgomgoDAc0MGl+vMk/zh76tfNgzhefa6N8DTJEgp513SzTBknsiP1bpn++UMPD7KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Spare boards of duplicating the DMA bindings. Describe the flx1
DMA bindings in the SoC dtsi. Users that don't want to use DMA
for their flexcom functions have to overwrite the flexcom DMA
bindings in their board device tree.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 1 -
 arch/arm/boot/dts/sama5d2.dtsi              | 9 +++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dt=
s/at91-sama5d27_som1_ek.dts
index 1aa8b79d618b..0e159f879c15 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -127,7 +127,6 @@
=20
 				i2c3: i2c@600 {
 					dmas =3D <0>, <0>;
-					dma-names =3D "tx", "rx";
 					i2c-analog-filter;
 					i2c-digital-filter;
 					i2c-digital-filter-width-ns =3D <35>;
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dts=
i
index 5a0162915ae7..855846c74a32 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -712,6 +712,15 @@
 					#address-cells =3D <1>;
 					#size-cells =3D <0>;
 					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 20>;
+					dmas =3D <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(13))>,
+					       <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(14))>;
+					dma-names =3D "tx", "rx";
 					atmel,fifo-size =3D <16>;
 					status =3D "disabled";
 				};
--=20
2.23.0
