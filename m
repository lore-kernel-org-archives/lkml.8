Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ED7C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1A52075A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PgHEbJzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgEFIlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgEFIlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:41:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C9DC061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 01:41:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t40so515267pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9oU+2xjh6A5rfwnEHfgImGeehUIEI1anqo7jHx1yxlM=;
        b=PgHEbJzZnqIODMC59fiZfIp7HHPEvd+jYOcTpax+wc5wBLewywHGLrlGe85NSxZLLV
         zQVYLShifq82eHjHbEJsNur10gdvoZUOUgILT1rCLY4MNAANOip2RdNe0Op47bhtH7Z1
         C6YqgmNYjHdh7pskfIup83Qm41rH2+J1fMpag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9oU+2xjh6A5rfwnEHfgImGeehUIEI1anqo7jHx1yxlM=;
        b=EFq2hqq3dS7G0APGjz9Pr/1RrWBkMSnKM1iNHjS7DsIHu9YxnPsvsikJyriMEZ9Ao5
         8/dlVwr/7/LQXRhFujFCrk9PvxNSzpqRePDyswG3OrLoTth5cDJEj/TPeslyPwKRiTuX
         eu8O56W2Kj1+2kWVzo32ml5kwImloiR2vwgDQ7+5L1p2Vg//docAuy6AcB0EGVizpJpq
         CBvaPtCslwFJcW3VcXpMOQGzmzN2mv3XGoOCGtISvCpbiNy8JjDsBmJVd40clabq6Hdw
         jeIIJeDz+lOvs2YJQ06soFJESC7mxhA+3scBeo+esHkru7fNR1aIVmHSM/Crk4e08Eko
         Sl6Q==
X-Gm-Message-State: AGi0PuYNaG4r+LUNab+6Ea/6xVEwHrEhSkohZyj4E0L7IUH5ypDA3t3y
        lFp7y9P72idiXOA08MePZn7mqkOgTK8=
X-Google-Smtp-Source: APiQypIyK6tkxRLNQCh0M3pL3mSBYDWHoAe/oDkleeplbXW9ygqR/QRSVTYPc0qIo5kngPJGmWsfow==
X-Received: by 2002:a17:902:8ec1:: with SMTP id x1mr6743715plo.325.1588754488855;
        Wed, 06 May 2020 01:41:28 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:a92f:c47d:76a8:b09e])
        by smtp.gmail.com with ESMTPSA id o63sm4297749pjb.40.2020.05.06.01.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 01:41:28 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Eizan Miyamoto <eizan@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/2] [media] mtk-mdp: use pm_runtime in MDP component driver
Date:   Wed,  6 May 2020 18:40:39 +1000
Message-Id: <20200506184018.v2.2.I87cf35a058328c780bd3b8b2191209a5011b7016@changeid>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200506084039.249977-1-eizan@chromium.org>
References: <20200506084039.249977-1-eizan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this change, the MDP components are not fully integrated into
the runtime power management subsystem, and the MDP driver does not
work.

For each of the component device drivers to be able to call
pm_runtime_get/put_sync() a pointer to the component's device struct
had to be added to struct mtk_mdp_comp, set by mtk_mdp_comp_init().

Note that the dev argument to mtk_mdp_comp_clock_on/off() has been
removed. Those functions used to be called from the "master" mdp driver
in mtk_mdp_core.c, but the component's device pointer no longer
corresponds to the mdp master device pointer, which is not the right
device to pass to pm_runtime_put/get_sync() which we had to add to get
the driver to work properly.

Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
---

Changes in v2:
- remove empty mtk_mdp_comp_init
- update documentation for enum mtk_mdp_comp_type
- remove comma after last element of mtk_mdp_comp_driver_dt_match

 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 22 ++++++++++++++-----
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  6 +++--
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c |  6 ++---
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
index 5b4d482df778..228c58f92c8c 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
@@ -15,6 +15,7 @@
 #include <linux/of_platform.h>
 #include <soc/mediatek/smi.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include "mtk_mdp_comp.h"
 #include "mtk_mdp_core.h"
@@ -53,7 +54,7 @@ static const struct of_device_id mtk_mdp_comp_driver_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_mdp_comp_driver_dt_match);
 
-void mtk_mdp_comp_clock_on(struct device *dev, struct mtk_mdp_comp *comp)
+void mtk_mdp_comp_clock_on(struct mtk_mdp_comp *comp)
 {
 	int i, err;
 
@@ -62,25 +63,31 @@ void mtk_mdp_comp_clock_on(struct device *dev, struct mtk_mdp_comp *comp)
 		if (err) {
 			enum mtk_mdp_comp_type comp_type =
 				(enum mtk_mdp_comp_type)
-				of_device_get_match_data(dev);
-			dev_err(dev,
+				of_device_get_match_data(comp->dev);
+			dev_err(comp->dev,
 				"failed to get larb, err %d. type:%d\n",
 				err, comp_type);
 		}
 	}
 
+	err = pm_runtime_get_sync(comp->dev);
+	if (err < 0)
+		dev_err(comp->dev,
+			"failed to runtime get, err %d.\n",
+			err);
+
 	for (i = 0; i < ARRAY_SIZE(comp->clk); i++) {
 		if (IS_ERR(comp->clk[i]))
 			continue;
 		err = clk_prepare_enable(comp->clk[i]);
 		if (err)
-			dev_err(dev,
+			dev_err(comp->dev,
 				"failed to enable clock, err %d. i:%d\n",
 				err, i);
 	}
 }
 
-void mtk_mdp_comp_clock_off(struct device *dev, struct mtk_mdp_comp *comp)
+void mtk_mdp_comp_clock_off(struct mtk_mdp_comp *comp)
 {
 	int i;
 
@@ -92,6 +99,8 @@ void mtk_mdp_comp_clock_off(struct device *dev, struct mtk_mdp_comp *comp)
 
 	if (comp->larb_dev)
 		mtk_smi_larb_put(comp->larb_dev);
+
+	pm_runtime_put_sync(comp->dev);
 }
 
 static int mtk_mdp_comp_bind(struct device *dev, struct device *master,
@@ -101,6 +110,7 @@ static int mtk_mdp_comp_bind(struct device *dev, struct device *master,
 	struct mtk_mdp_dev *mdp = data;
 
 	mtk_mdp_register_component(mdp, comp);
+	pm_runtime_enable(dev);
 
 	return 0;
 }
@@ -111,6 +121,7 @@ static void mtk_mdp_comp_unbind(struct device *dev, struct device *master,
 	struct mtk_mdp_dev *mdp = data;
 	struct mtk_mdp_comp *comp = dev_get_drvdata(dev);
 
+	pm_runtime_disable(dev);
 	mtk_mdp_unregister_component(mdp, comp);
 }
 
@@ -129,6 +140,7 @@ int mtk_mdp_comp_init(struct mtk_mdp_comp *comp, struct device *dev)
 		 (enum mtk_mdp_comp_type)of_device_get_match_data(dev);
 
 	INIT_LIST_HEAD(&comp->node);
+	comp->dev = dev;
 
 	for (i = 0; i < ARRAY_SIZE(comp->clk); i++) {
 		comp->clk[i] = of_clk_get(node, i);
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
index b5a18fe567aa..de158d3712f6 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
@@ -12,17 +12,19 @@
  * @node:	list node to track sibing MDP components
  * @clk:	clocks required for component
  * @larb_dev:	SMI device required for component
+ * @dev:	component's device
  */
 struct mtk_mdp_comp {
 	struct list_head	node;
 	struct clk		*clk[2];
 	struct device		*larb_dev;
+	struct device		*dev;
 };
 
 int mtk_mdp_comp_init(struct mtk_mdp_comp *comp, struct device *dev);
 
-void mtk_mdp_comp_clock_on(struct device *dev, struct mtk_mdp_comp *comp);
-void mtk_mdp_comp_clock_off(struct device *dev, struct mtk_mdp_comp *comp);
+void mtk_mdp_comp_clock_on(struct mtk_mdp_comp *comp);
+void mtk_mdp_comp_clock_off(struct mtk_mdp_comp *comp);
 
 extern struct platform_driver mtk_mdp_component_driver;
 
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index 539a7942e3cb..133d107aa4e6 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -52,20 +52,18 @@ MODULE_DEVICE_TABLE(of, mtk_mdp_of_ids);
 
 static void mtk_mdp_clock_on(struct mtk_mdp_dev *mdp)
 {
-	struct device *dev = &mdp->pdev->dev;
 	struct mtk_mdp_comp *comp_node;
 
 	list_for_each_entry(comp_node, &mdp->comp_list, node)
-		mtk_mdp_comp_clock_on(dev, comp_node);
+		mtk_mdp_comp_clock_on(comp_node);
 }
 
 static void mtk_mdp_clock_off(struct mtk_mdp_dev *mdp)
 {
-	struct device *dev = &mdp->pdev->dev;
 	struct mtk_mdp_comp *comp_node;
 
 	list_for_each_entry(comp_node, &mdp->comp_list, node)
-		mtk_mdp_comp_clock_off(dev, comp_node);
+		mtk_mdp_comp_clock_off(comp_node);
 }
 
 static void mtk_mdp_wdt_worker(struct work_struct *work)
-- 
2.26.2.526.g744177e7f7-goog

