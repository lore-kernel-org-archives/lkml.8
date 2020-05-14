Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F27BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4BB205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TExpFhmn";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="l6S/mtDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgENFDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:03:37 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:35465 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgENFDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432600; x=1620968600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vUqf6TumiNYJCcYJmGOnf7/FQ5Q5D4IFE3s1dX1L0ds=;
  b=TExpFhmnZVxwJmXbxLgePloqKlNCXt6TFLfCvHE3SgcJfhVYAV3FTiv/
   ETzq0y8lqc2uz9BvMfjMXfnm95/Pourbod+7A3lq1kgb5S7MajavhZ3Sk
   /5vPYpCBhao77c3x/1SHaMR+JmUX8e9ezuYfchNCOJDDMjwiqpuIH+K7w
   qG+tu023uGt4LTKcTCaXa7OkeB23g7fRyVFkU6hYVC9RGSW89ZXbR+n1O
   gpaBd7WGyNu3dbCvLWJL2Khx9pcZP9tBvFRR1OZN46S7tvKT4ZhNkL5c2
   u8lbUQGYrciwYp2ehZFwG2AV4+XD74Ljx0WJWK7iMFdqXmrw2ZkDPPGQH
   A==;
IronPort-SDR: 9NRQwqWcUiTU41d1YC1QSBaM98L1wihjjbMcgJa5kIuQSwXOsUD6sO14rkm1VySITYF+1Zl3rH
 fCV7EMsq8Pv/f/sTe2VELAO8XFg4taWve7HxxUXnas3UacNuridutONYxihF5V/idog+ghpiDs
 eljH/pNN6v2eNIL8i3T6Aby7tHmxW0bkMUQfG/TOQCrJ5qwDrH3lgKlr30RC9IBUFtmJbitDD6
 glIxF/CUEM53+JQW0p9tEqF90x1SjcFqGptu+B5cCvmNE+/O1Tv+dgTq4jEcQVeVK/8z7JcyZ+
 3d4=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="79551115"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 May 2020 22:03:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDInjZC+PHMa8o0RtCus31KV6XHKuVYxiVLmNndRU1UQyuj+qiTPY6Ctr89WPqwfHErefk9Ybm86mndtQkyEJ0d61xbzlqleInqF+nSNzb8BfLVdabgkWmhElkLXCOnv7SvS7JFwxvk2icixq2Um+qjR0grUbYsWcHYvaZpU5BbveKDGk5yRGgVCPT+83VsoLX/FjzjLmYxOll9zcqmS/K9UKjO0m9UD4TPh6rRIkVc0CkVHZ24z0/YHiSdhD/hFigYM2zc67vuba/Ba0RxZaVKAYMezTUMZ7g1bsmaqMuoNqCA2RXfWphCV+T/nUwbMv9wOy/D8pF4qCVnLfbnx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlfttCgt/bKbYU9wnQaW7U3ei5oZ24sdu0wo5T+EVnA=;
 b=UY4Q4bvE2Tt/HkrZhu7z5brZeRCvbVDljrQzNZM1Agnj2w2InFKYJvPBJETgl5RphW4RCEI5we2DsKk2YvJPAwKiyu8xX/NlBv1cH0EUDJeoOGbeHq2vnE3SypnFBISI79F7Z9N39TpfbPqNMNheXBdSnWrGi1XTWUa6HwP8ZJVtL4mICjN0P4zBIUehe5DHkyhmomZZy0bBw1S/kAU/o5siDcthqm5JiNIS5w11G7jBla32fj8tx9cim9GilRFaxa0pRj2zM5g+4zA+K4K34RPtDwSsT23Rdxwuwlht8SXuGCNPxkvB05CPhpo1MtGQbURlZmsh8hKcwMvt/KBQsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlfttCgt/bKbYU9wnQaW7U3ei5oZ24sdu0wo5T+EVnA=;
 b=l6S/mtDI263vWe5ANqaq/x/Ooh9uuqqTyk26YaXfC+kfNIb2M55qR7womKGYNH+5B2bMn6CIFnJ55YJ8zs5dn/rPnmIV9ILik2QojC+m2n1DKqQK+YkaZE8/9xMzN9NN1e1QA8B74JlWucfZRt4a5TIWdiKn+U6qJOEWVzEv9Pg=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4136.namprd11.prod.outlook.com (2603:10b6:a03:192::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 05:03:14 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 05:03:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 11/16] ARM: dts: at91: sama5d2: Add DMA bindings for the SPI
 and I2C flx0 functions
Thread-Topic: [PATCH 11/16] ARM: dts: at91: sama5d2: Add DMA bindings for the
 SPI and I2C flx0 functions
Thread-Index: AQHWKaz4isj8YfZrvECnXEeQAJYBzg==
Date:   Thu, 14 May 2020 05:03:14 +0000
Message-ID: <20200514050301.147442-12-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 0dd843bd-f163-4406-2d60-08d7f7c41bb7
x-ms-traffictypediagnostic: BY5PR11MB4136:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB41368F272B8DB40C672EB59CF0BC0@BY5PR11MB4136.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wfc/hLlefIPrKmzBY6AIMnoJSdZrEi4azmpLmazGWTCXak+uANW199ssAW/pe9R6iMkMY+1DP6D+K3AL7RhRM2XnJ/Vg5Fby3h68kiL5BPrQOraDQ7JAJCFPds3hBIZhcOTNn0v8mEqIgBnlalDBGwZdqo18brKNfvFBP699Lr8QxHz0YJNRIqnlW9AleYJ+GzolROej3FbTBrqsTDXL1rled+km8nN8x1LN5YlNcuj0jnP3IVnLr8/9aN14Y5rd+CN4j5Rw6x8frY3J9RAPzdtm3wo2MZkSSgYah4F9R+0tJxk04Vojl5bldjsOcWyzQuNJo2bcqN23kVZMhcQMiKnDgIxjkgH9XgIJdxNsOODDF/ECjKYFTBB6ssZkJqM9G8SqcOWzpsTn0VGuKtQRaltbbuO2OAy55GUuNZ0aVJ4NRssm4ZkuWdwVuolN+O4g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(6486002)(76116006)(66446008)(6506007)(26005)(6512007)(186003)(2616005)(66476007)(66946007)(478600001)(64756008)(86362001)(8936002)(66556008)(8676002)(107886003)(4326008)(2906002)(71200400001)(110136005)(54906003)(6636002)(316002)(5660300002)(36756003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: P7NBZ5fgfWP4gLrEJwZIevJvdRhb+xaRk+Gmg7x6WEIFKe5dmAPSt5+EzLs+smMM1MUVIJ2dE63T9VKPHNaQDp9hE6sJeuSzAPtJFBPVbsOPNX9QY56qvfcwwCZoKPQ1h56fcSBZDvTxCoYozO5LlzMAGECyaCp+5b5zCrCGBrBDtD6RXFCoftlL9glt+NRdAhwOl8V7remWIxXtPpCYB8fvwAUHqBxQ7lePX2e+r8z3iIhnJXxMZ6Qjkvhxbv/+xcXCp05rbh3/DZtavAg0AeOhHV0tTmVSfrdifcsHck1gp2J5uAFYjIYxvwyuhtyElsFRHYLvbF0NdjVy0oBasPbPWSCdLGY8V1AnXWeVgUxnkVUe1qvSMbHYgSZpTBfgVe30DiwrtihhIm6qAQkh3IzX9SfthEOIpxF8yLZggGmksKSJDzvUrZ+537Izffoz+f4Dxq436D6eW4IeeJwFqfUuzTyEgR8l7NevX3Xuewak/E9m6D14dx+ckUGbmRCi
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd843bd-f163-4406-2d60-08d7f7c41bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:14.4995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7pUxGqF2RPGoYXmwhlwVM7I+AKFXWKn5n+SVlWRzMr1DdB45uP+f3x6HTpbin7apcRsMDpswS1+exHYzlGQ4ZiYXmvApVOhZ/hNGJDFhcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Spare boards of duplicating the DMA bindings. Describe the flx0
DMA bindings in the SoC dtsi. Users that don't want to use DMA
for their flexcom functions have to overwrite the flexcom DMA
bindings in their board device tree.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_icp.dts    |  1 +
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts |  1 -
 arch/arm/boot/dts/sama5d2.dtsi            | 18 ++++++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at9=
1-sama5d2_icp.dts
index 559d8ae93af9..8d19925fc09e 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -105,6 +105,7 @@
 	status =3D "okay";
=20
 	spi2: spi@400 {
+		dmas =3D <0>, <0>;
 		cs-gpios =3D <&pioA PIN_PC0 GPIO_ACTIVE_LOW>;
 		pinctrl-names =3D "default";
 		pinctrl-0 =3D <&pinctrl_mikrobus2_spi &pinctrl_ksz_spi_cs>;
diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/=
at91-sama5d2_ptc_ek.dts
index 8ad3a9c6c536..0e0341c83aa5 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -192,7 +192,6 @@
=20
 				i2c2: i2c@600 {
 					dmas =3D <0>, <0>;
-					dma-names =3D "tx", "rx";
 					pinctrl-names =3D "default", "gpio";
 					pinctrl-0 =3D <&pinctrl_flx0_default>;
 					pinctrl-1 =3D <&pinctrl_flx0_gpio>;
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dts=
i
index 855846c74a32..5bba8024f485 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -661,6 +661,15 @@
 					interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH 7>;
 					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 19>;
 					clock-names =3D "spi_clk";
+					dmas =3D <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(11))>,
+					       <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(12))>;
+					dma-names =3D "tx", "rx";
 					atmel,fifo-size =3D <16>;
 					status =3D "disabled";
 				};
@@ -672,6 +681,15 @@
 					#address-cells =3D <1>;
 					#size-cells =3D <0>;
 					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 19>;
+					dmas =3D <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(11))>,
+					       <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(12))>;
+					dma-names =3D "tx", "rx";
 					atmel,fifo-size =3D <16>;
 					status =3D "disabled";
 				};
--=20
2.23.0
