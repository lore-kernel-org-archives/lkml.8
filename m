Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA94C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2772E208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lH4OSCkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgGaITV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:19:21 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:57824
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731875AbgGaITU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:19:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tx/MdqxsRz0c25scxqdxVZmsWVboh+4iNaY2UStRqyn/EXzc+Roz3/meA7bpdOsk67sU160AKEp+BIvomomCC9piL7UAuIf0ng8mkP58I8Fq1Jrt7pGF4j1eeAMx2e1yVtAPmsvTMcrBVCQCLr6opgJ0gZ5DXYlBSSNXPGoPIpMzc6fqM8XNaw2VUxfDmzwhFGzvKvGx8bpHbIAWB6rTA8oz/KzA93ZyGGwyoeEoHNRD1L2AyX51Yd7sMEY6DfMZFlbQW/XTIsRQLQs07RILdMtwnPcGlyOe1p3l0J1Ygb54FOddXk4cG5hk7bDE89j//nR3L2lXpKz3BtSzoYZjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wUh/HzaRIAxKzryA+qqA0InzAGpAAfC0xjJpVmQQi4=;
 b=Owq4keTWOzpvCmFq1AgoI7YEI3dG0zwgr7nG8FoXeK4uI7ytwEhWmhBR/lz9Lqe9CpVSs/F5/+jVhhnzMBLw7KYtVVGVYZ/zw0PfItyboosEKGNxmrqFUyDfml4xKs3p6au49v6seGI1aMZAF1qtyIfgQYy0y47ls9aJbI9bGgSd29tUzRVPLoG+u44pHMYGC7wXdAVuVQ557F51obI5bwBrhtK+N4EPQLw8Hux2c/I5kMdaGGUnjvn/WB3PvZ/3N+N+xeFxrcXGxejlAgKW6IzHbdJ9PPtTJ8Xe4K4jx3WFysu3k/LaBjTzGGtqrmUMotA1FpDxYpbuAKK7Vac1Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wUh/HzaRIAxKzryA+qqA0InzAGpAAfC0xjJpVmQQi4=;
 b=lH4OSCkQVdtpZGpe+QumzeVNYBmUsfi2OiyOz34FUyLbUioMgyQdN5Gan17wpHLzKKMBPWvz9UPpDVEDZYNX2s1im8gmcDcMyOvD1Er9itpTZfn1j9TrOw7vi+WUemOBfdhG7EfFIMDgazvB3+McNIjEUczNAOiskj4Hk5FLinE=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by VI1PR04MB3024.eurprd04.prod.outlook.com
 (2603:10a6:802:d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Fri, 31 Jul
 2020 08:19:11 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::5c87:6dce:840d:d4c8]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::5c87:6dce:840d:d4c8%7]) with mapi id 15.20.3216.034; Fri, 31 Jul 2020
 08:19:11 +0000
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     l.stach@pengutronix.de, lukas@mntmn.com, agx@sigxcpu.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, laurentiu.palcu@oss.nxp.com
Subject: [PATCH v9 1/5] drm/imx: compile imx directory by default
Date:   Fri, 31 Jul 2020 11:18:29 +0300
Message-Id: <20200731081836.3048-2-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731081836.3048-1-laurentiu.palcu@oss.nxp.com>
References: <20200731081836.3048-1-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0PR06CA0141.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::46) To VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-141.ea.freescale.net (83.217.231.2) by AM0PR06CA0141.eurprd06.prod.outlook.com (2603:10a6:208:ab::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend Transport; Fri, 31 Jul 2020 08:19:10 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ce09fcc-8eb2-468a-cb6f-08d8352a678b
X-MS-TrafficTypeDiagnostic: VI1PR04MB3024:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB30246ACCC4CF1D0C0C734D7BBE4E0@VI1PR04MB3024.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxPh7SGIeUWNAOrFufhsXO+ACptt8DTRLFwxyK36Tq+6W8reDRu3p9VXGJRF9YVwmjvnqiCirczuNQt+5eR9nXhYgg2oQT/KhB2+USvP7DBBknssFNBnoOfWoY1G3pJaSXuYYaPvk2/n8vWVFpS/3KoDSQ5Pyd8LisosccsntsFfL919OvdpZUqBJDeEldpv3jyJdw7o7EQpAiO8XLwbqruXwjd/BbDVPq2iKF9ciJ6RtFyUHVXY1iDAj27vffei/BnQRdED0MIMhdh4Tgs4gG/WApY9tWLXzlR562HV5xnS2CxJjINVFU9xd8qSykg83ixWR0631pHml2ZykUWnJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(44832011)(956004)(2616005)(5660300002)(66476007)(6666004)(1076003)(66946007)(66556008)(316002)(110136005)(2906002)(186003)(26005)(16526019)(6506007)(52116002)(83380400001)(4326008)(8676002)(6512007)(7416002)(86362001)(6486002)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BfgPHbUoJlrW0xiYFTZ8QYt2cWnhUvDTtfnX4Xzls9KVf5Cy+A8yQCay9wc3OPYtVp7Wbi1Q4dcKG2L/z2QkjWI9ZvXBz5a+Rw2DJC+EX4cvYA/rVMxtpjj4tYrhIpbqBEQCGYJ73e70638nLIp5P9hn5erH/ppC3A+AH0vyJoF4/1SVp+0Ye3bfDpbesnYxmHeSmQxSYXxiZc4acV54JwujjXFzsG40AzbZjRR0XkGWwW+os5YyD0vp8nKU/39aOUcy6w0cE0dOONCWiIeo1icrXA62SUPLToRJdU+2obPT9w7qlIiI4pjsUPRdvbs1yEpubgsb7iKKABDgQoLPh15wAdc96D82ypWB51P7+TAkd0KbiIXaT4yhn3g5nxrGK4lkwdbYOo2FJO5chEol4/o4hTYapS9PcrZtR/gdcbK5F1MYZ2i+LHB7pLynpTPVlXXe4QVMc4jgxMXa/Y5+51VdSNwGlQUS1RK8GZW/MLeWYPChyKuPLC+9NoqW0ohIuYEePqTm1AcuuovpRbodn0Fp/uAVn41n2Gd/gytRycxzaN6QQGK68vcs23W6YTauuC4FU17f5Z9f1Ntk1RxfUx80/NBmRdo1Yx2zt1TaGYseUvZoGC8of3T1E8ivzfHfhd9Asm8nE7tck5ZZfz18Nw==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce09fcc-8eb2-468a-cb6f-08d8352a678b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 08:19:11.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbxfMMVvVTChqf4ZSPAXScykcawadK3KsuzwiZx5O05YCaAKc7gdQ2t8ZF4ahFEDsMXxfnndYCvfWTOG8WykWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Palcu <laurentiu.palcu@nxp.com>

Currently the drm/imx/ directory is compiled only if DRM_IMX is set. Adding a
new IMX related IP in the same directory would need DRM_IMX to be set, which would
bring in also IPUv3 core driver...

The current patch would allow adding new IPs in the imx/ directory without needing
to set DRM_IMX.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/gpu/drm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 2f31579f91d4..81569009f884 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -100,7 +100,7 @@ obj-$(CONFIG_DRM_MSM) += msm/
 obj-$(CONFIG_DRM_TEGRA) += tegra/
 obj-$(CONFIG_DRM_STM) += stm/
 obj-$(CONFIG_DRM_STI) += sti/
-obj-$(CONFIG_DRM_IMX) += imx/
+obj-y 			+= imx/
 obj-$(CONFIG_DRM_INGENIC) += ingenic/
 obj-$(CONFIG_DRM_MEDIATEK) += mediatek/
 obj-$(CONFIG_DRM_MESON)	+= meson/
-- 
2.23.0

