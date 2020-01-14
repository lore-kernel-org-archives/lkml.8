Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B67C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9BF2187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CTycFTIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgANGl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 01:41:59 -0500
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:27269
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727083AbgANGl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:41:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7YpMePCQQCGnAZC0pMT9Rrt9SQ8rOtNcnZoEYw46ds4Yxpzk/spjH9/yUdtk0PbQkq3HfOG8B3nSG4tJot4n00rqVYNpsPxhmaRlEtxCiQbk1M45IWxAXLKtVI5iu8cM7v4KP8XmfBTWMaKt2+PlQRwQ4wDbU0BlxkwYAPOs47rmc6fuULtjJrLt10/utv46dvh9GUbloZOjBR/2YbCVJZARRYf6Egx+W/d47GZtY1Y0P97JXFVuPuCOfqXZ2OnHEZCypf/YxBY2LEew6UqmFFRzb85+5Ei+SmaGJ+0t6GRH6gGsoaY4XTeFO/repHg2jl5QSCoKhVgzt/wkI6GSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVjCQmZghlZKNk2xiESWeIe9k1jk7X3jcT/AWY2e7js=;
 b=R8pBFdlm6T9HBH4X1zr3drAtHDjJ3Nk/f39uUlBVNRXGCpTAx+ydUT16LxKXBNKsru36Pr8OijjGl7HLC5H7zqzOALiy+D4iYbnZM913+SazLTg6L/DSK9saTAcWcLTevOaHVlfG22IExXDsVV0Ety/zNyFyOaBmIhRx+qCTm4qstOXnHH23I/Q2DAM+qdCAZF8JRm6CwBcdhrrmxnb+a9VKJQhlfCixMMjYm+UHEXvV0LGQsQlicwk+tEY81dvxnYMDEkdVdSDUmPPCqwQMGaFY7/Os8R5zvFNkh29KCdgw46XVJiPWPmJdKJYlRwD0WDns0MXwdadM5+lF5cyIgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVjCQmZghlZKNk2xiESWeIe9k1jk7X3jcT/AWY2e7js=;
 b=CTycFTIkzAXA/vugLd6ilL3EEH0TRmIfPNXEPTxKhhZUXLjgV0A+W/jlhnPhenPecDawccur+SefOsUPTa9kFVgS1LZMGWW+AZpU5x5q56VGOTaLvZqcuVAeZsAxn5+cgQOOA7Mzpit7kfYItTakWD7jkEwr/xkXTSadC/yKFgo=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4404.eurprd04.prod.outlook.com (52.135.149.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 06:41:49 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 06:41:49 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0140.apcprd02.prod.outlook.com (2603:1096:202:16::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.10 via Frontend Transport; Tue, 14 Jan 2020 06:41:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: arm-boards: typo fix
Thread-Topic: [PATCH] dt-bindings: arm-boards: typo fix
Thread-Index: AQHVyqWyFUR1J0wI/kyxNhwHRPBOSA==
Date:   Tue, 14 Jan 2020 06:41:49 +0000
Message-ID: <1578983860-23747-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0140.apcprd02.prod.outlook.com
 (2603:1096:202:16::24) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94598f12-5639-4005-3c00-08d798bcd4d1
x-ms-traffictypediagnostic: AM0PR04MB4404:|AM0PR04MB4404:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB44042B159B41BE16E10E312388340@AM0PR04MB4404.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(189003)(316002)(81156014)(478600001)(66946007)(52116002)(110136005)(54906003)(4744005)(81166006)(36756003)(6506007)(8676002)(8936002)(64756008)(66556008)(66476007)(44832011)(186003)(66446008)(71200400001)(5660300002)(16526019)(69590400006)(86362001)(2906002)(6512007)(956004)(6486002)(4326008)(26005)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4404;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BN2zgY/qEzfMQFTaHAMPU9lmlDhr+C6Hty6jSzhapYCE9BtmlV9Ak1JIxljlAyJ9srbWsmiLLTE1mnBchjgzYhqgCfk2Nhs1jFiKDSMtF52dVtx2YuE2Gu14g3zUdLp6/m2LhgIqZUyjJ4JYdfxUmZ2eqYZtklDB01cCP78rvAjmo74sV6dVfkX1UW4BjxI7YJGCZnXDD0ju8MSrjwnghOF0zdsbD9UGRFkSfAhauJ4BN6jXlOs2dGVBt/SSBjSWB2nGq0fx5LTgcnUXXJ35k1glJVOly4nQ88nP7fg2jqmteDex8H/8bEB7p6Pww2zCNbMqCGZg4CdNOUrlHFcV3ntTRuYpeTD106VWmoIbjvIGDuaFc5vNjlo/5He6eBPXoVKm6vhaNNIK9VR9cbcmMZg5a/04itbzdmOCYaLBHVi4y0jm6ajCz1rESGKpsOtjpnWLcfx5CxhYBCcyJIHAeKFZq0C4QAl+kBFFlDJNESkATc2QCQjhkpyk6Q4X4Vvb
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94598f12-5639-4005-3c00-08d798bcd4d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 06:41:49.2307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kZPbzLFxdfQdGtdbK0JrvE7Ki8iEFB6kn6BoWoPQt3CTQkpIYqzVonl5rII6JY/FgOYLTQL8WkrXqV60B8UiXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4404
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Typo fix, "withe" -> "with".

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/arm-boards | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentati=
on/devicetree/bindings/arm/arm-boards
index b2a9f9f8430b..96b1dad58253 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -121,7 +121,7 @@ Required properties (in root node):
 Required nodes:
=20
 - soc: some node of the RealView platforms must be the SoC
-  node that contain the SoC-specific devices, withe the compatible
+  node that contain the SoC-specific devices, with the compatible
   string set to one of these tuples:
    "arm,realview-eb-soc", "simple-bus"
    "arm,realview-pb1176-soc", "simple-bus"
--=20
2.16.4

