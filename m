Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEC5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8071C20722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SU2fRu4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388282AbgF3Qb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388192AbgF3QbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:31:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0037CC03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:31:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h22so9705166pjf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zvy3pnrdBE7rKtZhGMaIJc9nAztjPriT4eb+3HACwU8=;
        b=SU2fRu4gMarPK9IcwuRoQjy9vH+xKChjZnAVHGvLqscgK/haRnvHWvQ8aS+RuCr3eB
         NJmXjFhm+ZfC6AkcE7rkJpKHC64ZrF3Gq8FLRTvKBseE3sUylVhXBfFW9EMDpRfjy+z+
         P3dI41B1u1dG5bls5jbgbjVX2uZsyr5e+c16Oqz9iQXhC+mOwc9sdFZ7FZPW7XNl4M+1
         07/QUlZ8CqN0aSqz8eKCa9JNAFydmaWMmgfxZyQjyg0emrjIybWq0uYz9qHXME3MBFCz
         /qbRYGf31hCqxCmcu83oNFUasajy0gM42eVWVCQsVYtvsoDT0Pui0eXWAK9CsYE+QVQd
         ctGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zvy3pnrdBE7rKtZhGMaIJc9nAztjPriT4eb+3HACwU8=;
        b=CC8Jnq0uwPIaya1NECT2Na5ChXD2i/Np7cnG3B1iDl6wYnfcwdDKHOAfVOtJDQ5SG4
         VotdB5+NeR6d+nNu1mawRDdNlvs8iAgdUZ+P0vwQMqzwkG+oCTlUWj/6jPyEUxW5iJmq
         nZigDrlc93BiLWsURCNIClKghRlabCUzrZsV6rHdb3WDpoUy063rV7XVvntHIkBSvF9c
         Dgibz87IqWUoe0otfGvWJ1PaPsLezYw0XyFHZmOoJBnoXtASJDC8n7rCuAUpumlq3fnq
         IXlinvxXuEwk4Jk+Q2WeJWp3wmRWk7gef8Zvmv3yjt6kmHQlwv42km+6gxHUYmbaXXJb
         zwYA==
X-Gm-Message-State: AOAM532mPyiI9BvPJQHNFO3gcWkfuFZzgrsJTPVFO4m1hZcG+Se4oCEq
        Fy4UfsxtfG2MUiuNKdONhWsSww==
X-Google-Smtp-Source: ABdhPJxVhBXvLkZLUZNrDUcMWD7chck0CLy8ssAC74MPRXCiRAAolcbzvIswyBdRxgXLXR6QAAhHTA==
X-Received: by 2002:a17:902:9a94:: with SMTP id w20mr18084177plp.177.1593534681521;
        Tue, 30 Jun 2020 09:31:21 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n4sm3184606pfq.9.2020.06.30.09.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 09:31:21 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, paul@crapouillou.net,
        s-anna@ti.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] remoteproc: ingenic: Move clock handling to prepare/unprepare callbacks
Date:   Tue, 30 Jun 2020 10:31:17 -0600
Message-Id: <20200630163118.3830422-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630163118.3830422-1-mathieu.poirier@linaro.org>
References: <20200630163118.3830422-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves clock related operations to the remoteproc prepare()
and unprepare() callbacks so that the PM runtime framework doesn't
have to be involved needlessly.  This provides a simpler approach and
requires less code.

Based on the work from Paul Cercueil published here:
https://lore.kernel.org/linux-remoteproc/20191116170846.67220-4-paul@crapouillou.net/

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/ingenic_rproc.c | 84 +++++++++---------------------
 1 file changed, 26 insertions(+), 58 deletions(-)

diff --git a/drivers/remoteproc/ingenic_rproc.c b/drivers/remoteproc/ingenic_rproc.c
index 189020d77b25..b0fc8eace6ec 100644
--- a/drivers/remoteproc/ingenic_rproc.c
+++ b/drivers/remoteproc/ingenic_rproc.c
@@ -11,7 +11,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/remoteproc.h>
 
 #include "remoteproc_internal.h"
@@ -62,6 +61,28 @@ struct vpu {
 	struct device *dev;
 };
 
+static int ingenic_rproc_prepare(struct rproc *rproc)
+{
+	struct vpu *vpu = rproc->priv;
+	int ret;
+
+	/* The clocks must be enabled for the firmware to be loaded in TCSM */
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(vpu->clks), vpu->clks);
+	if (ret)
+		dev_err(vpu->dev, "Unable to start clocks: %d", ret);
+
+	return ret;
+}
+
+static int ingenic_rproc_unprepare(struct rproc *rproc)
+{
+	struct vpu *vpu = rproc->priv;
+
+	clk_bulk_disable_unprepare(ARRAY_SIZE(vpu->clks), vpu->clks);
+
+	return 0;
+}
+
 static int ingenic_rproc_start(struct rproc *rproc)
 {
 	struct vpu *vpu = rproc->priv;
@@ -115,6 +136,8 @@ static void *ingenic_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
 }
 
 static struct rproc_ops ingenic_rproc_ops = {
+	.prepare = ingenic_rproc_prepare,
+	.unprepare = ingenic_rproc_unprepare,
 	.start = ingenic_rproc_start,
 	.stop = ingenic_rproc_stop,
 	.kick = ingenic_rproc_kick,
@@ -135,16 +158,6 @@ static irqreturn_t vpu_interrupt(int irq, void *data)
 	return rproc_vq_interrupt(rproc, vring);
 }
 
-static void ingenic_rproc_disable_clks(void *data)
-{
-	struct vpu *vpu = data;
-
-	pm_runtime_resume(vpu->dev);
-	pm_runtime_disable(vpu->dev);
-
-	clk_bulk_disable_unprepare(ARRAY_SIZE(vpu->clks), vpu->clks);
-}
-
 static int ingenic_rproc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -206,35 +219,13 @@ static int ingenic_rproc_probe(struct platform_device *pdev)
 
 	disable_irq(vpu->irq);
 
-	/* The clocks must be enabled for the firmware to be loaded in TCSM */
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(vpu->clks), vpu->clks);
-	if (ret) {
-		dev_err(dev, "Unable to start clocks\n");
-		return ret;
-	}
-
-	pm_runtime_irq_safe(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-	pm_runtime_get_sync(dev);
-	pm_runtime_use_autosuspend(dev);
-
-	ret = devm_add_action_or_reset(dev, ingenic_rproc_disable_clks, vpu);
-	if (ret) {
-		dev_err(dev, "Unable to register action\n");
-		goto out_pm_put;
-	}
-
 	ret = devm_rproc_add(dev, rproc);
 	if (ret) {
 		dev_err(dev, "Failed to register remote processor\n");
-		goto out_pm_put;
+		return ret;
 	}
 
-out_pm_put:
-	pm_runtime_put_autosuspend(dev);
-
-	return ret;
+	return 0;
 }
 
 static const struct of_device_id ingenic_rproc_of_matches[] = {
@@ -243,33 +234,10 @@ static const struct of_device_id ingenic_rproc_of_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, ingenic_rproc_of_matches);
 
-static int __maybe_unused ingenic_rproc_suspend(struct device *dev)
-{
-	struct vpu *vpu = dev_get_drvdata(dev);
-
-	clk_bulk_disable(ARRAY_SIZE(vpu->clks), vpu->clks);
-
-	return 0;
-}
-
-static int __maybe_unused ingenic_rproc_resume(struct device *dev)
-{
-	struct vpu *vpu = dev_get_drvdata(dev);
-
-	return clk_bulk_enable(ARRAY_SIZE(vpu->clks), vpu->clks);
-}
-
-static const struct dev_pm_ops __maybe_unused ingenic_rproc_pm = {
-	SET_RUNTIME_PM_OPS(ingenic_rproc_suspend, ingenic_rproc_resume, NULL)
-};
-
 static struct platform_driver ingenic_rproc_driver = {
 	.probe = ingenic_rproc_probe,
 	.driver = {
 		.name = "ingenic-vpu",
-#ifdef CONFIG_PM
-		.pm = &ingenic_rproc_pm,
-#endif
 		.of_match_table = ingenic_rproc_of_matches,
 	},
 };
-- 
2.25.1

