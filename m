Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BF9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82A820829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DkKC+mPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbgGaITt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:19:49 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:57824
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731964AbgGaITr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:19:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YctHcxbiEYpfk0yY9HrNzMu9G5bPbQJh2O9xmeGIYwksvb0OPrvXkL4LW8v6aiTK4/nNi0uI5JvX/3aMyGHwupIPTs1x+KY7EpkN8evOE6h694qpwyeX0xI52duMEe5hEUbK1ByTnwBeZ69rIvokQaWCBBzlA5oQscD+OEZz54cvjlDzumxMxVmQaUmfwj6UXsLWl+rLrQdeZHN18ePDLDDKHH3dc5deR0P+QDGs7RUYNTUc2mF03CBDRTtgtTKM4eV3ix6oT6icNKES64CxFA4TmbqoTJKK+sb+XD4c64vME3Hg0FNyPyfp3KjMuwcgkdo1dFqvcSAz8rrIFi5qug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie3hh13KyuwBTpdWRYIN0u7tCJuqDhobhjFHp+yRONs=;
 b=ZMYften1et+V5rRVatV1RTsIeJ0TI1fPtSKBJkV/krfjMemoxPUMsk6rWdryTcrF+EMjemG+Z5JydT0UwmOK8JO938m1kNHMmjHslX3oDJVRjpj2B2PleUyj2ojwUrdVA1n50nCvkRM+EWgPI5022wmwqWcyXff82kLlachutOT+mkIQTkYxrjnKDvqUzpSUtCCZnOJCr4IIpqZFDEml86LucDaxm+x5a4Y2R36MXliRnv47yt7LXtYlnieiXon9mZTMZfn1rUBfIF0fjfkCs0oMT4ykyY1myFny6jgWtV5p5JyiWAuWHlXZK3XySkpwVUabAwp9gjkcYcjiodQg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie3hh13KyuwBTpdWRYIN0u7tCJuqDhobhjFHp+yRONs=;
 b=DkKC+mPvFJT/N4lG+JSQrXRZG5oQj+291ShKx1CEa7cjXJe3+I7E4mpXqXB2u7pZGuHOyMD/Ju3GBqihqXHjw1JoNQ5GuTHo24fn0uWfV7gb850P2ujqD6g1fCwbJIWag8bPztp9+eIhAOzTrnnusaoZkw+6GOsb/qiWpTavuPo=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by VI1PR04MB3024.eurprd04.prod.outlook.com
 (2603:10a6:802:d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Fri, 31 Jul
 2020 08:19:18 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::5c87:6dce:840d:d4c8]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::5c87:6dce:840d:d4c8%7]) with mapi id 15.20.3216.034; Fri, 31 Jul 2020
 08:19:18 +0000
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     lukas@mntmn.com, agx@sigxcpu.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, laurentiu.palcu@oss.nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 3/5] drm/imx/dcss: use drm_bridge_connector API
Date:   Fri, 31 Jul 2020 11:18:31 +0300
Message-Id: <20200731081836.3048-4-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731081836.3048-1-laurentiu.palcu@oss.nxp.com>
References: <20200731081836.3048-1-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0PR06CA0141.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::46) To VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-141.ea.freescale.net (83.217.231.2) by AM0PR06CA0141.eurprd06.prod.outlook.com (2603:10a6:208:ab::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend Transport; Fri, 31 Jul 2020 08:19:16 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8f95a20-8de3-4bd1-f3d2-08d8352a6b5b
X-MS-TrafficTypeDiagnostic: VI1PR04MB3024:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB3024400D1D66D6BFD9D0E5E7BE4E0@VI1PR04MB3024.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:357;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EqAfFGiKV8z3FlcPYNgS5moUX0UVrnlxRdPVHAPDw/3tXESR2sV+BVwno+xgXy1LQMMcGQqzLxR+PUQWn3612JWjqV1OsoF3I2KvGP7j0J5tHfJUd4GQS6aWLVcInsSbVyHISVEQj7ov04xxEz0YvqqZYVGMDqhCHe7aqmVfJmN6UaJcmDuMadYPD2DXBsDIpfOYYI6yaLmqNnA4ZOMoqy7pVrfjItIBt0tOolqD1gKuPfwdK7pzhKCzKKOORvxu6iayymsJqlKFSZw7tEWUcKnu6wUoT4Ydj6AqfL+Ua8wsqqLqDc+wKXhfch6C71i/XeK28WU8/q/mylFJKq84sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(44832011)(956004)(2616005)(5660300002)(66476007)(6666004)(1076003)(66946007)(66556008)(316002)(110136005)(2906002)(186003)(26005)(16526019)(6506007)(52116002)(83380400001)(4326008)(8676002)(6512007)(7416002)(86362001)(6486002)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yB2Nod6Ti31Ry33rzAjHbs4GY9rWKFUHz26HBmpkWz2GLWPwVGH0m8d+BzqYkLaYNeoRI3h266shVicwKCQxdahXHZEYjxnr6CTncXvD3CFRDdA+77w8IyjVPpkww2+BYYjpBXSmt1/HbGClEx2TaBrNksHW29VSfRht1xiXdbF9mOFkmyxbklfp/wnm68jkamAE7lHdynBXO4HTtA8CMAligP2a4Umivm81R434cECYvgUQ/4pmg2kV1fsVvvvLRzbT2ibtcjKJ3FgXzdliKbLddzowWr+ecyFxtLfDkWpCORLmo6LsGXSEHS9TBLiuNZCArOdc1KXrbQgTFgDyY0sDBaYLYQAzSibt1as1YAgaw06nxKA2ewUsSHtwiKGJnd+c00SHgqJ2PqguIGV1ytIno3HuogSJfRbnc/Gu0md1GZgUaKA5csBxVRoCny3DTzv64QuES4JlSUYNB6d/QoVHnDJNWW60lkVE+lrNcrOUNR/DkuYlj5nq0cRJZDo48QamkKcEHJyD2OQM/gjLan6TQXmcdX3s5FBZHuEAHs7ViQsYxnSBdPPnEOib5USBO4qAK+8Sqa+bcdhuJu9E35g1Fv8t+CKWtrbfivrBG/+On8UKc14ZL5v2UOsdExleiFlb4yA6GnZigZopviE1EQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f95a20-8de3-4bd1-f3d2-08d8352a6b5b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 08:19:18.0751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgviPg5zbmDImMCR2xDgkzzmtlE3uXCYirsWytDjFhgZk1ctnw1LqUHR4OPX3B81aDJqGhmtHFMdU5Vq69hxYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Palcu <laurentiu.palcu@nxp.com>

Make use of drm_bridge_connector API to have the connector initialized by the
display controller.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
---
 drivers/gpu/drm/imx/dcss/dcss-dev.c | 17 +++++++++++++---
 drivers/gpu/drm/imx/dcss/dcss-kms.c | 31 ++++++++++++++++++++++++-----
 drivers/gpu/drm/imx/dcss/dcss-kms.h |  1 +
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
index 83a4840435cf..c849533ca83e 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
@@ -8,9 +8,12 @@
 #include <linux/of_graph.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <drm/drm_bridge_connector.h>
+#include <drm/drm_device.h>
 #include <drm/drm_modeset_helper.h>
 
 #include "dcss-dev.h"
+#include "dcss-kms.h"
 
 static void dcss_clocks_enable(struct dcss_dev *dcss)
 {
@@ -247,9 +250,13 @@ void dcss_dev_destroy(struct dcss_dev *dcss)
 int dcss_dev_suspend(struct device *dev)
 {
 	struct dcss_dev *dcss = dcss_drv_dev_to_dcss(dev);
+	struct drm_device *ddev = dcss_drv_dev_to_drm(dev);
+	struct dcss_kms_dev *kms = container_of(ddev, struct dcss_kms_dev, base);
 	int ret;
 
-	drm_mode_config_helper_suspend(dcss_drv_dev_to_drm(dev));
+	drm_bridge_connector_disable_hpd(kms->connector);
+
+	drm_mode_config_helper_suspend(ddev);
 
 	if (pm_runtime_suspended(dev))
 		return 0;
@@ -266,9 +273,11 @@ int dcss_dev_suspend(struct device *dev)
 int dcss_dev_resume(struct device *dev)
 {
 	struct dcss_dev *dcss = dcss_drv_dev_to_dcss(dev);
+	struct drm_device *ddev = dcss_drv_dev_to_drm(dev);
+	struct dcss_kms_dev *kms = container_of(ddev, struct dcss_kms_dev, base);
 
 	if (pm_runtime_suspended(dev)) {
-		drm_mode_config_helper_resume(dcss_drv_dev_to_drm(dev));
+		drm_mode_config_helper_resume(ddev);
 		return 0;
 	}
 
@@ -278,7 +287,9 @@ int dcss_dev_resume(struct device *dev)
 
 	dcss_ctxld_resume(dcss->ctxld);
 
-	drm_mode_config_helper_resume(dcss_drv_dev_to_drm(dev));
+	drm_mode_config_helper_resume(ddev);
+
+	drm_bridge_connector_enable_hpd(kms->connector);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.c b/drivers/gpu/drm/imx/dcss/dcss-kms.c
index 3ca49d0a3e61..135a62366ab8 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-kms.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-kms.c
@@ -5,6 +5,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
@@ -74,7 +75,7 @@ static const struct drm_encoder_funcs dcss_kms_simple_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
 
-static int dcss_kms_setup_encoder(struct dcss_kms_dev *kms)
+static int dcss_kms_bridge_connector_init(struct dcss_kms_dev *kms)
 {
 	struct drm_device *ddev = &kms->base;
 	struct drm_encoder *encoder = &kms->encoder;
@@ -103,7 +104,23 @@ static int dcss_kms_setup_encoder(struct dcss_kms_dev *kms)
 		return ret;
 	}
 
-	return drm_bridge_attach(encoder, bridge, NULL, 0);
+	ret = drm_bridge_attach(encoder, bridge, NULL,
+				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret < 0) {
+		dev_err(ddev->dev, "Unable to attach bridge %pOF\n",
+			bridge->of_node);
+		return ret;
+	}
+
+	kms->connector = drm_bridge_connector_init(ddev, encoder);
+	if (IS_ERR(kms->connector)) {
+		dev_err(ddev->dev, "Unable to create bridge connector.\n");
+		return PTR_ERR(kms->connector);
+	}
+
+	drm_connector_attach_encoder(kms->connector, encoder);
+
+	return 0;
 }
 
 struct dcss_kms_dev *dcss_kms_attach(struct dcss_dev *dcss)
@@ -131,18 +148,20 @@ struct dcss_kms_dev *dcss_kms_attach(struct dcss_dev *dcss)
 
 	drm->irq_enabled = true;
 
-	ret = dcss_crtc_init(crtc, drm);
+	ret = dcss_kms_bridge_connector_init(kms);
 	if (ret)
 		goto cleanup_mode_config;
 
-	ret = dcss_kms_setup_encoder(kms);
+	ret = dcss_crtc_init(crtc, drm);
 	if (ret)
-		goto cleanup_crtc;
+		goto cleanup_mode_config;
 
 	drm_mode_config_reset(drm);
 
 	drm_kms_helper_poll_init(drm);
 
+	drm_bridge_connector_enable_hpd(kms->connector);
+
 	ret = drm_dev_register(drm, 0);
 	if (ret)
 		goto cleanup_crtc;
@@ -152,6 +171,7 @@ struct dcss_kms_dev *dcss_kms_attach(struct dcss_dev *dcss)
 	return kms;
 
 cleanup_crtc:
+	drm_bridge_connector_disable_hpd(kms->connector);
 	drm_kms_helper_poll_fini(drm);
 	dcss_crtc_deinit(crtc, drm);
 
@@ -167,6 +187,7 @@ void dcss_kms_detach(struct dcss_kms_dev *kms)
 	struct drm_device *drm = &kms->base;
 
 	drm_dev_unregister(drm);
+	drm_bridge_connector_disable_hpd(kms->connector);
 	drm_kms_helper_poll_fini(drm);
 	drm_atomic_helper_shutdown(drm);
 	drm_crtc_vblank_off(&kms->crtc.base);
diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.h b/drivers/gpu/drm/imx/dcss/dcss-kms.h
index 1f51c86c6986..dfe5dd99eea3 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-kms.h
+++ b/drivers/gpu/drm/imx/dcss/dcss-kms.h
@@ -29,6 +29,7 @@ struct dcss_kms_dev {
 	struct drm_device base;
 	struct dcss_crtc crtc;
 	struct drm_encoder encoder;
+	struct drm_connector *connector;
 };
 
 struct dcss_kms_dev *dcss_kms_attach(struct dcss_dev *dcss);
-- 
2.23.0

