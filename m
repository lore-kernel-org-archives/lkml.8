Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5BFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E880920838
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Vy/3hykt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbgGaITw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:19:52 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:57824
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731603AbgGaITw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:19:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3wxxqEyr/zyJ2VXQJNxqkhKalVJtBjW6NnDN8Q5TTh1DFEm79eFOV7z93c/P12CCasCMfmjgA81Inz2Q9+ilZWYqrTZ+CVKMzIOM+MZ97a/G3n4IAHJzCAwTPfvWZQRHQSfi+T7zAE+Y2hjxoNrPxNwQgf0eYZwYHnq6bglC30fHTzq9iWyFZSM/WmAcVaBS8kuzdf+fRZD187JTbzEyayLaAqEmrbEOjPn3gqxLOYj5JJlQb9TfXkp/hLwgOS2Vnrtkv+6o6VmdvIBcln/7DvJIjnNcbAgHiVx3oTuEBSe3bCP0f2K9DcRas36Bdj/Mx3EFpznLXrirXeiGzCdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXzyakJrfjmRPi7mEVxaXdOgzW9CiHHkBoI7k+SzWLc=;
 b=DOwuslILVl4z1iW43+z1tye7teyKRiTHJSXFLLx+3+rtDFwrNcbdDLPL7YfUaKuPhHKOnYFcE07e5m6nRV4nDalZxICVjdQufaxdHXSFt/rsDCqDYDNGkjGIsAi1KvWRrOx1FQ7ffVMYwHZkvcVTntrAOmSJQXGL0p5mQcg0kScmuAXAqXUQbuXdbEvlj4aylnNQpPBDc1TgNdXyNjeLd+WQM65W1mkBoBcP5PY/dtn6VEic0pyap+cEqMFJ6+1gKqa3X2gJIH+5y16Ojl6to+/LFWvEg67j5jV7qj1sXit/IWANl3f9OFytorRrMi3qc+XflF7LreB8TG0XBojK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXzyakJrfjmRPi7mEVxaXdOgzW9CiHHkBoI7k+SzWLc=;
 b=Vy/3hykt8FZ3k+8ya3yKyFUT4MjbQEXGSSbci0S1LoqGazAhebH6NLZJ1b1Bbpd0bNS/Ungp6LqAAVY4COeCSYUmUAec+Ig5Nhdz+Mt/2QF7xeJVkdBS+taFXm+/aL41u9csPxJ4itWrkyOS6ffqKsntrAQiDmCpy7Buku12etU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by VI1PR04MB3024.eurprd04.prod.outlook.com
 (2603:10a6:802:d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Fri, 31 Jul
 2020 08:19:19 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::5c87:6dce:840d:d4c8]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::5c87:6dce:840d:d4c8%7]) with mapi id 15.20.3216.034; Fri, 31 Jul 2020
 08:19:19 +0000
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     linux-kernel@vger.kernel.org
Cc:     l.stach@pengutronix.de, lukas@mntmn.com, agx@sigxcpu.org,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        laurentiu.palcu@oss.nxp.com
Subject: [PATCH v9 4/5] MAINTAINERS: Add entry for i.MX 8MQ DCSS driver
Date:   Fri, 31 Jul 2020 11:18:32 +0300
Message-Id: <20200731081836.3048-5-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731081836.3048-1-laurentiu.palcu@oss.nxp.com>
References: <20200731081836.3048-1-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0PR06CA0141.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::46) To VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-141.ea.freescale.net (83.217.231.2) by AM0PR06CA0141.eurprd06.prod.outlook.com (2603:10a6:208:ab::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend Transport; Fri, 31 Jul 2020 08:19:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3dc0e74-66c4-4b3d-74c0-08d8352a6c28
X-MS-TrafficTypeDiagnostic: VI1PR04MB3024:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB3024392165453BAC04DDC772BE4E0@VI1PR04MB3024.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzWK7glpufbIexcBP2M4bCe3b/8HMOgdive+nuc3whteTd1mC1BVZt9Prss2gYrs/BPjqzAT2T68k/CsT3BxySpU4ctQL8DEtyDi08LBdtjabSXy+klnjoERfH76Lulq1Bk6t6NoU/+AI8LnR3v7z6XwCmYigLE0st7MtJvo0KVQtBa2QSrTyWnmctnr/dT1qsJBaCL9GjDpSY2RnqDPUFb+M9uPWjECPBIazdHB0tPhxDlnxtEwgDyPJV4FlJcHMspcqtB5OTeJoVmiPDcVZS9RSJ23gumSMhQT90LHSii/kROUUck1oLRlFC617nYgjyPU/vyG38Ltbt52Oy2D2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(44832011)(956004)(2616005)(5660300002)(66476007)(4744005)(6666004)(1076003)(66946007)(66556008)(316002)(2906002)(186003)(26005)(16526019)(6506007)(52116002)(4326008)(8676002)(6512007)(6916009)(86362001)(6486002)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MNEge66a+gZFzmf+2lO0GqXwK1xv99An43IhWnroSDlt26x0RhMcY108qFEv61BBsaya7jaUsfcgFZCUdcmWJ8HE7UkLm/rGMYKWZhEdDTS0WXYmR7HGXdjKpq6oCxp4YGzdih5Tb8Z17VkECI5CCsXfmwOI4ESIB4htXVPUAPCB0jAMucWLnnV9OurQpF5OFIOiarWt+XMfMy60WxayHT7DHn8JIKYAV2pqtH80swlyYjgtP81unSx4Dnmtf7F8uQsyHtXT9TcNeW3QHgau0Z2Vx/YJ1vMivdspJhtL5IZwlG6z4DpW0cjgRfNKrnS70jmn57lEmnQwUKiVmsjX9qYLqOGY9d7UNq+96Qli0i4vnoCapS6ErfgG2VAOqVsWm+yj599rGBd25EQ6bWQSIrO5avtjHQN6WNFn8iddbg6LdVBD6/tY0eh6guLKTe/rA7bSwIz3++k/Q1J7nmYKVx1CyrHmBRyuMccMUnvgMFquwzno6KFJkyabmXTfbV2og6FlCjDlsAwRCmdBWn8WrMhDWdT/tlkSSciOmYOSbfd/M/RBj4fIoTMBM/tqM1Yte8B7Rq7kLR5kYFOixMhT9Pd6k7FkEL7Qztv3UQ1kKrn8DpSxY84PkKiCoc3b2w0udMINzFfcQ6aXPP3x9lM9UQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3dc0e74-66c4-4b3d-74c0-08d8352a6c28
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 08:19:19.3903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlzI8QVHg7O+jDZQtcrZqaBCDt86hIfAB7wAVay5i0Ry5MiBOsmBvp6ZmRm/6UUd3Jo4ZQBetIHwioBWgdRyjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3024
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
index 2c669c07fa35..1a22038f2869 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12281,6 +12281,14 @@ F:	drivers/iio/gyro/fxas21002c_core.c
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
2.23.0

