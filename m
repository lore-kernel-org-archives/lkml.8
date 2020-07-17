Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D3BC433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4942F22BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AdZdJgtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGQOmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:42:35 -0400
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:27969
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726198AbgGQOme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:42:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHWjwAVyj2dbkmqDdGARhMqStluHnsrpo/0QR+agJZ6oSTK7XuRCwBV/Aib/vDBJ4gPfYZu32pX2WXWdpgT/jdHzBlwF8Lqu5y4F6kLeFpMM1Nfh+UOL7JlieHscGKqAV/MdxKatLGK2TCqUYOzq9RtJ3AZnaBTolDrg/HiJAa5V3X5UXm1oCefq5MkFCAJ9w2FMPkrD10g4LkL43rbVjDZg6XSHyOhrFaCNHmyCq57ZGIjGHuTsUAKgTlH5a/ndQnNPaHr+UYKD8xLDy0Wb8wdXfdj6J/oSYASzps++TrsFWlL5pRUGW3r5/JRG58yh9I/V6Bx5kuziGl19SEfzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyzuNVSeSns+E+AQauhB/wefi28qCEL38cLXPoy0QG8=;
 b=LMQXs7hccjKcg2PRcaQCjpGCDD4nXj2SHJyeO68sJyIwgRI3tqfsfHF1B2I+oF2lvWdm68YD54wMUMaifMLolHtB3xWxMF1QeMqhUGb7p5FBysjQNGSDfTsS8VQx+70I78r36XUfRqYwKeje83WX1CH1OHLAtAENRwA4ZOZFMqi+5Tztz+FlQgfJwO1Y5Piumu27eAQAd9Ez3OJxWAPy2ok2kQ1tDYu/WZwuvQwBsDcLVcnmqxTIZpTtkDY2xuhVYDgEf3OBWSnSHGASnh0ociZVyiKkV2uTCrwoHD+6VqqpBtBKGQ8gibejMTpZDOkheUf3H7v+IGoXFdQ+bOTyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyzuNVSeSns+E+AQauhB/wefi28qCEL38cLXPoy0QG8=;
 b=AdZdJgtc++G0Ml2ZRYGLwoIy1YLqU9NKuGEgP+p8yOAGDaLrJz07V261U0w5mOT5wTpZz9fOy5oRLp1Vh8mb+L6XjMXCxOYgM8oQWSCkF47M0f3ub4qqZXOujQqhout/cDavNHtutO7mRFQNN/2DwdNFoCG5gmsndmquOmzQGfU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by VI1PR04MB6959.eurprd04.prod.outlook.com
 (2603:10a6:803:139::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 14:42:30 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::4c0:79dd:b734:9ea7]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::4c0:79dd:b734:9ea7%5]) with mapi id 15.20.3174.029; Fri, 17 Jul 2020
 14:42:30 +0000
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     linux-kernel@vger.kernel.org
Cc:     l.stach@pengutronix.de, lukas@mntmn.com, agx@sigxcpu.org,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        laurentiu.palcu@oss.nxp.com
Subject: [PATCH v6 3/4] MAINTAINERS: Add entry for i.MX 8MQ DCSS driver
Date:   Fri, 17 Jul 2020 17:41:28 +0300
Message-Id: <20200717144132.2206-4-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717144132.2206-1-laurentiu.palcu@oss.nxp.com>
References: <20200717144132.2206-1-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM4PR05CA0035.eurprd05.prod.outlook.com (2603:10a6:205::48)
 To VI1PR0402MB3902.eurprd04.prod.outlook.com (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-141.ea.freescale.net (83.217.231.2) by AM4PR05CA0035.eurprd05.prod.outlook.com (2603:10a6:205::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend Transport; Fri, 17 Jul 2020 14:42:29 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95c06b47-1e9d-4ecc-d46d-08d82a5fa1ff
X-MS-TrafficTypeDiagnostic: VI1PR04MB6959:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6959779853BE2922DAA9C6B3BE7C0@VI1PR04MB6959.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tZ6IE4qqyCiztOMOgLu4LLthdpQguMjHPK0Ya3dcPncElipyX+CN3SpFhpw/jG0DyThFlTS0EI8FDzd3B0ZmKRBqpnIIMhprnxf7w3RFVEbF0Kmtc3uVMhz5SpF6J7UKLqgypfsNaHoYHn4lfX42xjrCQNWCssLO3hANw0PF7PVSHNwFlRXwAzh+ufeI9p6cNm/mMTO1t1yo8Yn2aAlLeOqLN2J4HVQSphjpTxON7j6SYuLPaFI2ueMOTCdejsqvtqMHU3ozgwnCXUDCfNF37ZuvYM2CdSBFxB9APt6+8IId0mo1MnXTISWvDDd5gQL7oAywDYHot6r867ruDikOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(186003)(44832011)(16526019)(1076003)(8936002)(2906002)(6506007)(86362001)(26005)(6916009)(6486002)(2616005)(5660300002)(66946007)(4744005)(478600001)(66476007)(66556008)(6512007)(4326008)(316002)(956004)(8676002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: D2qnPhEkfPoyknCv3FD3b5ElJfmLfwG32tdQlj+MsGa5QsDaDwBXqP5+isMiofHCCtMBWHq21sFp6/KQuU/zxSl3ET28/4ta/jXd9CFIUBqLd6ze7n00cTVwB5WUCm+taQo+22eYEUwrn/na9NC4XvNtD2zGOfzVA8TCSKHbTdCwCfXVVrXnSEyCt+kW5ekHd+j+R8Nf7Om3AQtCedah4+NdAn/iBkbsNex8NPMfAOt33Zk0dRp+r3ZmQhEpHdKdNHQKa8gbR3JD8WBReI0qEKKRa8wMMoUojPGpsRqO9DHZDkMYh6GXP+VjBIJXN+VbHKqZftXnI+UhhQjulHKow8f1/GiGUfflFOvjSz+FlppJsjXd4fOLV9aOxm2n8YyO4TIDNDHEwamKQsPD5fkGhCkdWkrGsQn8x5gxvdFAy0e59X6udu/qQ1K3WsZFfr7almt/oGnYbP2hN6NrduvLF4XFKyxx8Um42Yq0/+myyXE=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c06b47-1e9d-4ecc-d46d-08d82a5fa1ff
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 14:42:30.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hA97j33sJlpjaE1dm2zWGAWtECPI3wZO3DueZRWirUn0HGvXN4KtfA19QMberx3LWW91hmhkUM0r7dLqsQaxtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6959
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Palcu <laurentiu.palcu@nxp.com>

The driver is part of DRM subsystem and is located in drivers/gpu/drm/imx/dcss.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dad5a62d21a7..200c5985b41f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12276,6 +12276,14 @@ F:	drivers/iio/gyro/fxas21002c_core.c
 F:	drivers/iio/gyro/fxas21002c_i2c.c
 F:	drivers/iio/gyro/fxas21002c_spi.c
 
+NXP i.MX 8MQ DCSS DRIVER
+M:	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
+R:	Lucas Stach <l.stach@pengutronix.de>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
+F:	drivers/gpu/drm/imx/dcss/
+
 NXP SGTL5000 DRIVER
 M:	Fabio Estevam <festevam@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-- 
2.17.1

