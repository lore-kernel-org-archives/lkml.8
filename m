Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868F6C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A4D21927
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rGY+AuTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgA0JpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:45:01 -0500
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:24557
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729308AbgA0JpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:45:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwF6rZUPqgoz8FaQ6kO6qKxYVwpGnx130jIi56hUEFUMA5hac0aVe2SimhNV4bGArPpzaQgiqZrEUyUucpe2CcqGyPshkW+IYKmQmUf8BrYnXKM42xvhFdmZpV5nm/tuIoHeoopYpskqS3bFZ+vMdsdUL9SeH1YNy4cIR523FcO1HwexnNw5Eql+Rso4nhCDkn3s7/PF4k6N/H49JRu2nTvn50uEyokdWCt0vJqxf6rBRcNd2Y25GMSwyFUfEji9bS77237Ue2+ZO2aSYn1HnG+PUdOqh7cjJht5SaW8FaxQMfVYxJWoeCObOyvNzjfZ9goxN0JIJEpSUVg8YT8U7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlZpygzK/k9J+YwhyuXjvtbmE4EeQxGwrIc6hX/MHzw=;
 b=MUFqxE6SXbT4PdGnPTsb/FcieUhi0Cx6E6h35QLvVXJ6+iNwXz54hLzvlwDoGo4g69PQJ1fcZSOQy2dPPIwWFQpRXU03H6GOTOlIJKhM/0fEGCA6Q1GPaoVPsLdZplAHJMKIxtZz5W3TRuodHbutKx9TiLlFcO3sKdjr2tQBK2d+7mXAv2wevBBwuEXMM2O376qfTyae035NmG8lTAqEF/a2QD3H7dL/wJmPJEWn7Xm+1Q/PaA7STHjW3gg/hDqrXaBDVQqyv4qPVw4MH6EUJnFtlsUCdPp/pe16w62iJApSGwKFv5NOIHlLDP71iP3R5UeBaVKJ46Z49+Jd2eBMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlZpygzK/k9J+YwhyuXjvtbmE4EeQxGwrIc6hX/MHzw=;
 b=rGY+AuTd8LdaKlydd1s59ooOrPMETmWJCZjkZ1PSdUytLpzdSyJkSbOvDitZQGzUNzRfyDODbAAn2L3EvFoX4vrLu6VlKZH+kSmuhzLjFKsQlYr7atjOk8Qqa8n2XiT4f4uDubmFyCdiqap4j/AmOIWj+hyzCpvlq5VPM7mJIOA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6436.eurprd04.prod.outlook.com (20.179.252.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Mon, 27 Jan 2020 09:44:57 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 09:44:57 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0401CA0005.apcprd04.prod.outlook.com (2603:1096:202:2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.24 via Frontend Transport; Mon, 27 Jan 2020 09:44:53 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/5] soc: Makefile: increase build coverage for i.MX
Thread-Topic: [PATCH V2 4/5] soc: Makefile: increase build coverage for i.MX
Thread-Index: AQHV1PZv67IYkgl6NE6QVwElj/wbFg==
Date:   Mon, 27 Jan 2020 09:44:57 +0000
Message-ID: <1580117979-4629-5-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 1756bc26-8351-4701-3d61-08d7a30d91d4
x-ms-traffictypediagnostic: AM0PR04MB6436:|AM0PR04MB6436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB64369A7905D637E4976265A7880B0@AM0PR04MB6436.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(81166006)(81156014)(8676002)(71200400001)(8936002)(2906002)(6512007)(4326008)(44832011)(7416002)(69590400006)(86362001)(36756003)(110136005)(54906003)(316002)(52116002)(4744005)(66446008)(5660300002)(478600001)(6506007)(64756008)(66476007)(66946007)(6486002)(2616005)(956004)(186003)(16526019)(26005)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6436;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPHtDDTg61CwNCPOz39WpAsub7Cg20d5cpTDmLNvPGn32cCIdRsWHSD/hEugA8EcfZVwPjmYf6LJEsqpd1yzXjOQoGXoVRFndiKgMN4CK9JZQxKGHP8Hys6md9VNu8O+Fa8J2EiyxF1JltuUKZSQw33dytTyK1UZxboSlwHW6rLeDgvwe6HLXZTphAcvFDiLhLuJyDiuVqtm5zzMIVO9Hpylx8jHUCTaS8XgyDv5A4B9H9clX64ZQZd0pnrqIPks7rcCGpnoA+02dvG7cpUQaG+PIIAWXw/Et6S+iNxCb6Ya3yYfpC5xhZlJkW0SsJKEEwhe1VFuTun+7kw4Zp/bGWezauNoP0wE+eCtOepprUx6+DEB31ULBoRPZsZ2liP7WupiOb+1QppgdSYkcQJ+2LdKX9hjYmxRbFvL7I4XDyW+joaDwDxkq7PDUaUksjOOj5LWG6y7HJlRBMvj+/HAKaK4knS0pdvpGcEeWQzMjYr16Ye1ztcnJGOJ40XrJsXJ
x-ms-exchange-antispam-messagedata: lkhDd0SG+CF2gXYVxT1vCr0EeMYVKm48YB0njpM6SSCjqT4eJ5UcQSp9AzDYv1TX/GhwDCbUhCCAsMnfnUtVmp5kgs5NglmRE2GU8SlQYrvmi+xNBGZybvYvJ3CuswBsMG8GNNU7EkLhIrWM0nBIhQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1756bc26-8351-4701-3d61-08d7a30d91d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 09:44:57.6889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WIWVsyS49WD02XEXSPJciPsCTvAkmjZZdfvPPVNAweeljz2GH2PHmtrLWRVUnsqxJrVWMbj2ks9gskDI8P4IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6436
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Increase build coverage for i.MX SoC drivers.

Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 2ec355003524..614986cd1713 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_ARCH_DOVE)		+=3D dove/
 obj-$(CONFIG_MACH_DOVE)		+=3D dove/
 obj-y				+=3D fsl/
 obj-$(CONFIG_ARCH_GEMINI)	+=3D gemini/
-obj-$(CONFIG_ARCH_MXC)		+=3D imx/
+obj-y				+=3D imx/
 obj-$(CONFIG_ARCH_IXP4XX)	+=3D ixp4xx/
 obj-$(CONFIG_SOC_XWAY)		+=3D lantiq/
 obj-y				+=3D mediatek/
--=20
2.16.4

