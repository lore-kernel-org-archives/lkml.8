Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642DEC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314C6214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C5frdMUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgA0Joq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:44:46 -0500
Received: from mail-eopbgr00053.outbound.protection.outlook.com ([40.107.0.53]:17984
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729308AbgA0Jop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:44:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSJQqDielwbzq8UT51dL6rlTv0PbluwFluumvFjMKwZxi0AQOQ78B0KlEte44e2reINDtGRNXDTuboCRE62YPLsQ3YC+2h/i5PBHubC/ed2Fj8ul2isjNzBA2vkVMpU0nTKUa5M4iAVe+D6z0uLiCYOL+vfurfw+5fwwhVsrJpL6bQ/cjoM3DDf5AzTR8KwjDdJ8B4PuflUv2rkEERj2WoOO6RjQowGHVL374lO1D7WLSVNItet9Ytc2KZffcHTiEWGnZY9nNZt11WlA9ht/87hKvgD0huKA/FCeO1fxch//WvJ9zAOFnbJwfceRcUWvnMVWBIl1W2KyF8eU316rdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ9S4NOrqv+XdB4LZWWwcWAjM2cw8W536sYcTXvBj9c=;
 b=ZdzAXtTJWzpUMC1a6DZ90e5niXXqmMwYp4zXawNrdvtZ0RRS1YhT5c7wrTnmokkc9zhcmMynIOcLTH0x1lhSyoQlzruTUHYttWX6wCvw820bycRIUx+khqEX95s2SDa0cxnlbOrgk0BYEqkR1bVezLIBLnpWqkQhvi1bvU0YxL+3ky3dBq+HyeiujdhJuT9YNMVjfGPQc+IMvYdYUn5ab6zahwDY3es8v0LFLkLiWHZ6uW3mxy+exdOUTOYyhsehCYTycm0FYYhR4R2CpsKQT/8EzMM/qyKg1AsR8XCJk0RagSNtHeXAM/QL1Uywd9qyANCg3MXrG8ABmDAZFx6IWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ9S4NOrqv+XdB4LZWWwcWAjM2cw8W536sYcTXvBj9c=;
 b=C5frdMUTcIjXlyOLFjcgP2ExsycqPEyRsPMQmnT8WCIOVSYt3T7zBGLGUodt7yjwjmN1mMxH4erhBI2nfqEIsRTSRJlqXXdwhle6dBM+uOHwh57vkEYLSRAenNXfyQQ1nTJz5QHziJ+J8UuDz2obOc6agq4CG0fRSDCmX13xwaE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6436.eurprd04.prod.outlook.com (20.179.252.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Mon, 27 Jan 2020 09:44:43 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 09:44:43 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0401CA0005.apcprd04.prod.outlook.com (2603:1096:202:2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.24 via Frontend Transport; Mon, 27 Jan 2020 09:44:38 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/5] soc: imx: gpcv2: include linux/sizes.h
Thread-Topic: [PATCH V2 1/5] soc: imx: gpcv2: include linux/sizes.h
Thread-Index: AQHV1PZmB0n1COSBrkG3iskArlzskw==
Date:   Mon, 27 Jan 2020 09:44:42 +0000
Message-ID: <1580117979-4629-2-git-send-email-peng.fan@nxp.com>
References: <1580117979-4629-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1580117979-4629-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:202:2::15) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7376cc7-7380-42ae-d314-08d7a30d890f
x-ms-traffictypediagnostic: AM0PR04MB6436:|AM0PR04MB6436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6436F12AA0C8FF60F62F6A86880B0@AM0PR04MB6436.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(81166006)(81156014)(8676002)(6666004)(71200400001)(8936002)(2906002)(6512007)(4326008)(44832011)(7416002)(69590400006)(86362001)(36756003)(110136005)(54906003)(316002)(52116002)(4744005)(66446008)(5660300002)(478600001)(6506007)(64756008)(66476007)(66946007)(6486002)(2616005)(956004)(186003)(16526019)(26005)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6436;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2bh9ZLZ1BvTFPwH37aZ819lo57e/YFCUMD/EkjE/qbHi+R2okVCsZNTJel+zXswZST4SpZqRIsUEgxM4ecspFwaRyZkndlnz5mjVn4ApQIMzLnB6Vt+ne0DEQSP4NQDVv8IdnZiszx8Kq6kx8fEVUDBodtqKZ49GKdhUiylC6MS4K/34v1w0SexhV60R9Oo1lDBsGkrw+VLtflxVkj8O9FajBNME4/QuxAVzawNYjkeV2KoZD0oFqq0V1QGswgp/iVkzEXpqtlWvuKncj7wOMKApGrymnGaaw7+HKIH/o52mEdw4SUZcoV9enjW+ooGK2srzWVpU6UeL/A2H8FCoMy/5mE/q2gKiphQ45xcLcxmxSvN+H+f8ZjghxiSM8Vsp8OTSOarVZe7HfPoQs61X3lettDyL23vtv65Vqacg0eV0vM0phdTim2TGaz24b+CUka8Tjw78XcJC8nQCOtnv1wwly5gFtLW6D7c+HtLVcldUag4P8kRrcGsUPIFNeL79
x-ms-exchange-antispam-messagedata: XPvEaZrQ8D32/uGRQ9KtWUZt6rs67Rx4jMTPVI0QT87myQIIDkPeUbgPC01qy0aP5SLzewI3gm/QOY6mYZG22lTojh5X1a6rS1ce07xL3AaTOhZCdjMq9wKt8l2C9XvJOosWar8qgX6GzAqqV2598Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7376cc7-7380-42ae-d314-08d7a30d890f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 09:44:42.9370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mx7xria066zQQ6cCZGP3w02FZacdh8iKCR1y9NczoSKy4h1Uoj+ZpUcxY8QnF63QVAEgNkAjCjpGkF271KRjag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6436
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

This header is included indirectly on arm/arm64 but not on x86 so
CONFIG_COMPILE_TEST breaks. Fix by including <linux/sizes.h> directly.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index b0dffb06c05d..6cf8a7a412bd 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -14,6 +14,7 @@
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/sizes.h>
 #include <dt-bindings/power/imx7-power.h>
 #include <dt-bindings/power/imx8mq-power.h>
=20
--=20
2.16.4

