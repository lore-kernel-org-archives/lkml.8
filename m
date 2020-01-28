Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEC7C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F6622522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WDwSAOod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgA1GDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 01:03:17 -0500
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:45797
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbgA1GDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 01:03:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tdd378vpfwRpibcFVIzrF/lLxwEncQG3DWBoUOm+H4o67zYoNLw+lIQgx2M1q8eo4u8wLu6tpMweAl72ef5whINnQjSxdocAmhtF0wcbkv9iRqWwHyNoofhAIflFu41akZY1kg9bY7IN6BldaIaf+efGvVA4yEw/3PWVM2ZtRJ4DexMiQLF6O5SVm48dWhL2srRqA8OaR87GFsZsD1Z5KCUd4dW0FpOCc/ik1sP0OzgqYLBA3BebtpgAGI7HKQtht4hrxj6FSB22Lp27QGL1IzNr2ht0mgOvtbgRc6yJSYToseMkPodN/pNmDT52C9Uu+G2yAWpPDj+BFocz9DgMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ9S4NOrqv+XdB4LZWWwcWAjM2cw8W536sYcTXvBj9c=;
 b=EmZQwaY9bbD9peili14uD4whgirqn4QSoNcdLZ6edqJnQAwbwhy/I7CuYMnjIlJAFv9AcKYmzP9D4F57IGG7BLcqR/pmNCi1HE8QadlldEZGW4putSkRC2HVCOsOmTlcaK5nw9GxYQgm8jDcByy2rniSCLHPtkjKjmqzXDcLa0sA4kabHi7QFc4HfE19o08I8iSjTTZfKf83FziJPjXWrmY3xEuiDYnfv7E5MJrxnNNHnrUvtdYuieNVT+vb39xlkn4/U9oOXlu/kksU3icINxopLNrqT7RsRbuYoU20dHD7hl6oPQ8uf19PdWJ3f8DYhPYWH6oH5/L80nob+F+ISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ9S4NOrqv+XdB4LZWWwcWAjM2cw8W536sYcTXvBj9c=;
 b=WDwSAOodNRcmflPXavE38UGA02J5wRLZ8CtPOZJ8DfPAB0y4p5QDmQdZvGiceETJHNEFJEe+rzTEz6vitCB/T3HAY43KxqPR04r3JwL4lmNuW+zMwr2yOJK1gpnb4J586S02jMvpkYC4MvJa1nWHXt5380fQtStjcDgwci+Wd2U=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5377.eurprd04.prod.outlook.com (20.178.113.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 06:03:13 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 06:03:13 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR04CA0087.apcprd04.prod.outlook.com (2603:1096:202:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.20 via Frontend Transport; Tue, 28 Jan 2020 06:03:09 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
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
Subject: [PATCH V3 1/2] soc: imx: gpcv2: include linux/sizes.h
Thread-Topic: [PATCH V3 1/2] soc: imx: gpcv2: include linux/sizes.h
Thread-Index: AQHV1aCgZCYKcFemkkyL907Q+VitvQ==
Date:   Tue, 28 Jan 2020 06:03:13 +0000
Message-ID: <1580191098-5886-2-git-send-email-peng.fan@nxp.com>
References: <1580191098-5886-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1580191098-5886-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0087.apcprd04.prod.outlook.com
 (2603:1096:202:15::31) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e72f1b57-5527-4d61-8924-08d7a3b7c273
x-ms-traffictypediagnostic: AM0PR04MB5377:|AM0PR04MB5377:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5377AE007EAFD331E4E7F503880A0@AM0PR04MB5377.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2616005)(956004)(52116002)(86362001)(8936002)(8676002)(81156014)(81166006)(36756003)(64756008)(66446008)(66556008)(66476007)(44832011)(2906002)(16526019)(5660300002)(66946007)(478600001)(4744005)(6486002)(110136005)(54906003)(26005)(316002)(71200400001)(6512007)(6506007)(69590400006)(6666004)(186003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5377;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WEbKbUbsocO9NiP5MfCPNT6Ey4AM36InpWb6ovRLJutw5L0NgswVWyQwzyut59CBk5ZgfQUotUsJDPkPwkfXOC8kr7lbSApLRcknyQXn8gEuHIqb84wrSKiECrrF94y1Qy8k1DiydiNHW5pGGNkWHucDzG/ryDwT/96iDt3h9uayfn5ZJzlCQtTWr/gyp2hA+Y4ITPcXEXArwYkvIHenobERWZWjyC6xsRPdDr1YyhrD7ua7OFV8CSpw/d+0pJkO5v4nFiIFrnFBDReLjab/Gum0HVdSK8vtmnzh8l+bKa62acjFwEmKfmceq35CWh5JlUt3ldffPJK7XC+rrxmzOKC7HIPOIa+HeedW80NY1OkMiCiUQcdyHNb1ukQY6h4clmOVKcQGskFatxUib4efQHvJOnrlUQnv3S1fsrfM31yqxoHmN4bLAKWIcGh5VUKt0P7mwINutVSlULV4u0ir5Vn0QQkZifb6drqp4dtBrJlh451BLSpxsp88friu6nP/TTocuqyFys0ltjGNTFEw/nnf2nl/4tuzcqK8cHerrB4=
x-ms-exchange-antispam-messagedata: Kig+At1Ahbgjsr6MxJWHGgUakKZclCZ4YO8JOTpc5kraV0CszALPTPXx7YvVaLZAUV0ceoQLX0I2ouAJYYckHzJgRqO7XGxXIqZ9gWXwTPRz5tLlGkBDu8oNkgIQjfy5XeCp+BVB5ZFZn0IViKC9zw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72f1b57-5527-4d61-8924-08d7a3b7c273
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 06:03:13.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6F+WktEoP7uUb7XrIPbDtOwLWEDaxdMm/GUvqTD2MWzE+EoONOZYOdIwE7U21aE3sxV/fpR+fHjH77K/7eZdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5377
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

