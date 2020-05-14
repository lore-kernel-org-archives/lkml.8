Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1634EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F4099206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2d0n+g2L";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Oeo0u/A/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgENFDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:03:51 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:35471 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgENFDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589432601; x=1620968601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Qtw8WyIBpRyf9s4WJQQZLKYcduXMVC0l968XR9oamU=;
  b=2d0n+g2LIT9FMy9qIUQrKt4TsD2T4opzdkU/tkbrBTJCa9qd4V/jiPHk
   FwSWEjwLTk19Rlx18AyhFkSWvScdkKJqLFG+oSxjNEJlb1/3W1ZSwkQmH
   /uz/l5DFPotee0tjQAKa69CFXbdo2i2TkdzCLtWBSRBtbOUZI8sYxOYU1
   f9hg4rI0cRut4juoRhL44wBd2FzNMn4LRlFTDFtjsEomgPHmfUQ0h+lLy
   oJwchVCXr8zFTXeWtb34/EmqOVly+wacx8E2Bde7Nh78sdh30n5PUrnv2
   d3qWHmMJEzwA0vSWXM0Rho/hncV0GI+SI7jTpXtB4JFYzACt0ZxKuCcM+
   g==;
IronPort-SDR: UpcwKiGBOWuZ+83MnuTLHv3U3ywQO58kegbGi6Dt+lYTc8Tq1HK/m+zHfzVKkjMlhcSAMnjszU
 JwBXSi3zScwCafq7jkImom91R4cHxPIEo9iad05zEowXtkxYxfz4O6r0eDMBDM5TQMs7+nKXiP
 i7epjZqnOxfbbsOEbdQD0mTOPTQUq/KvrRgcM/drKtG0832oellS2/trFYyRk3ekoCXkgxEQB+
 dIbPTwVsHXUXgghsVYtLVFXGo8/z8wF0CGRxQ3I7qrUQsWim+rNvkXDEnT46eDBZJQMcIppEt0
 dto=
X-IronPort-AV: E=Sophos;i="5.73,390,1583218800"; 
   d="scan'208";a="79551128"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 22:03:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 22:03:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 13 May 2020 22:03:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VN/hjzMp9Q/5DKRp+05MjsX9KAJCvQN6L5yCuD8I5VteaRLiKdVPrHI7p1JG+VYQLvwaQ7dYY/GLzWw+SSAkHZ8rnCK5NtwS/ValFkjunfIGx7SzYQCyXlyuSzEd3qzx7Ae8HrfaNV/AYP27EcM9qBKw1IyQPKImxP6GiVAJWFFUFd67DmZOEQmMtT8tTAv/pfdNuSRZ2zdv5smiv3hwWFJ/86oF6lQGXFffokpMnUQnhaN6af+R+3lPCc7tDj0sFyuh+e8MZJAjOtmd54FpWBsNFGHOIf9gSXm0qCGZuQE009E/pk+dDjv5TM9zTZbwhEiDN62xX7m3Vv2V4m8bIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4grfYYfXHkKtzPg9SswqCLnAlHDofbIxigWygQqcD/A=;
 b=bYgr1b3r6ywba6Upe9BQyPh9YRzUJUJic7BATgPz6uGCAEcEAFW53KNQ2JwkcPz3GO2IItEZUBWrhc2G8n01jKNwv32WEmrwM4O6g4yq4ehvwz6I8bRtBvQk+tvNot+ve09pcRUIrwjojm/qoA0iliqeiZH5lYeZTX4SX2WX/YRFkXyS3RvE48SOcmb0HCNQxrjakHKcqfjbuUXGjTQyU41Gd7KbJgFrrQQzrADrrY2zG+hdybvimJ0aoQgJZNhh0QNi+n7fNySRx7jpFgcO/qOg2LYBM0Fa6Ce9+ETEFoaKoSvzbPg3ebE+lq3gPZvtKcDyvA5Q3laWpCjrezPHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4grfYYfXHkKtzPg9SswqCLnAlHDofbIxigWygQqcD/A=;
 b=Oeo0u/A/6qIB69cemUypyuMPU2u/pKrpijn9UhBWcvPsPa7bVIiCzuW4DfuY17gGW2GEoayFrY6ZUQy78C7urXYjXiTpKDThCofFB0bD0tMosgn+/Nm7v3zLiuThZTExJMkiITaKOV883Rk4Nn6G7g3RX7alSxlfQs4QyMnJQck=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4040.namprd11.prod.outlook.com (2603:10b6:a03:186::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Thu, 14 May
 2020 05:03:18 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 05:03:18 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Codrin.Ciubotariu@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 16/16] ARM: dts: at91: sama5d2_ptc_ek: Add comments to
 describe the aliases
Thread-Topic: [PATCH 16/16] ARM: dts: at91: sama5d2_ptc_ek: Add comments to
 describe the aliases
Thread-Index: AQHWKaz7B/63x91lDEatHaURenNffw==
Date:   Thu, 14 May 2020 05:03:17 +0000
Message-ID: <20200514050301.147442-17-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 690dd394-b430-4c24-69dc-08d7f7c41dd2
x-ms-traffictypediagnostic: BY5PR11MB4040:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB404066C81030D8415CA161AAF0BC0@BY5PR11MB4040.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d714Tu0dkBDofQB+QkFSqHG7fgYvxr0hbaawdDCVfFE59czXDY5e54Y11tWK792n6og+q9EQobs2RWp3eESHQSMrVnX+gFT30CgpYvPQ+upokE4MTpJGqpISokHofR9WU/HEIhFyvIJPyk8pmy/fG4ULNDUCGvZ2ZKoZaf6x7Zgpa+iAlY1oFBMme/4H7uiP++ksTo8jBRcCgNCqPdOIU/wuZxaIxzwGMUkb8uensEBB8CCMx3sql7rK1GDOA83ylj04vxF77rmjWLDwNfJB230qffa69cn4rwpMpgtAj9cGol7x1bsHnXOaAMOapuNFyp05xHPALSQ7G2b7+hXee8nsJ28EarNZkmbG46eQn0qfLC2CvsemryDO51r2wU0+iXZn3v9ua70M91Lnmj0Hcpmjqywcs4Ks6+W9HTfqGWv50DHN4olW7+sjo+41hVoh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(366004)(39860400002)(346002)(136003)(186003)(8936002)(36756003)(6512007)(5660300002)(66476007)(316002)(66446008)(66556008)(6636002)(4744005)(110136005)(4326008)(54906003)(8676002)(1076003)(2616005)(64756008)(107886003)(66946007)(26005)(86362001)(6506007)(76116006)(478600001)(6486002)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7WQ/5S21oHpPIyvNp9ulQxwCm25WkQtwbzq+TjI2F28lNz2Kd++l1MWUu3jVM/fNczxW3BnM6FiMqQ93Ls9qme/1+vGg2P9ljRNA2N+XK8ZqxKAG6BBI41Gx2dKUYRtnU9GnA4bdF1eAmEICgQEBH6LorTNUTOk2/FnkO/jtPTpiqOgVpNNyEZq4J5oBkPfNXcu6gRcf2Ic7H5+Bb3cpEjnWqvL/DcJcbEKie3roVHCLBBSEqNopsR5TTnDUU9Dim7hKj/od656rtF11HUhPktCBNhzzPmeRv5HSRhOJxTpkmp91+DeDCZ/3xQal1Dypy3MtXZvl4otdzrozke1RR9qpYf47WUDdWFah8RcQG+pbnd+sc4iaKhue8rmMiPbubqRBHg757/NeuaFLgF7DvMmGUlIpdBtbXzYUFIWdqNd0I4e1Gu+CmAIEgQXnmdvJUXJAEZVPZUJpjkSLDniPuPg0X8tQ3L7WFuFQsQJE7s45KwjlsLtLIGoMJtXv3Up/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 690dd394-b430-4c24-69dc-08d7f7c41dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 05:03:18.0215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBLPV8C1NQATB2yHexbOQwS8/YXaotFFhi1QCfi+j5++BVkWJnr1hlYxFqhrxrI3pFViklJNAoyehVGlE4nX39Mx485sitGsYuR+fBoNWqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Indicate which i2c alias is for which connector on the board.
Specify that serial0 is for DBGU. This eases tester's life.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/=
at91-sama5d2_ptc_ek.dts
index 0e0341c83aa5..45c671a2bcf2 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -18,9 +18,9 @@
 	compatible =3D "atmel,sama5d2-ptc_ek", "atmel,sama5d2", "atmel,sama5";
=20
 	aliases {
-		serial0 =3D &uart0;
-		i2c0	=3D &i2c0;
-		i2c1	=3D &i2c1;
+		serial0 =3D &uart0;	/* DBGU */
+		i2c0	=3D &i2c0;	/* mikroBUS 1 */
+		i2c1	=3D &i2c1;	/* XPRO EXT1 */
 		i2c2	=3D &i2c2;
 	};
=20
--=20
2.23.0
