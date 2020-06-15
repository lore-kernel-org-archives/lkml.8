Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3490C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9A720714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="GNlhtnZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgFOMEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:04:00 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28697 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729878AbgFOMD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:03:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592222636; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=wbbp8bYWZqAOe5JcmZIlj4Iv82ohOVVmmL+p25cvTyM=; b=GNlhtnZH4JhwjQN5q1+WjADQyPiJD9t5vKwaa3bsQXf6Z0UONF4LM7G1zlHLAIWEhBrWKNfU
 1SXmvDhTn531vwuGE9U2RYCxTQUr5kBKEQiCI7S+TL7zbE/eIXbmGo7Xdwgh/LYTeuJ70aSq
 blNaP9KtQ7o4P18NbqaTzDF19IE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5ee76392a3d8a4474332b41d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Jun 2020 12:03:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 13E01C433C8; Mon, 15 Jun 2020 12:03:30 +0000 (UTC)
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12D46C433CA;
        Mon, 15 Jun 2020 12:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12D46C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org, robdclark@gmail.com,
        robdclark@chromium.org, stanimir.varbanov@linaro.org
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-media@vger.kernel.org
Subject: [PATCH v6 5/6] media: venus: core: Add support for opp tables/perf voting
Date:   Mon, 15 Jun 2020 17:32:43 +0530
Message-Id: <1592222564-13556-6-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to add OPP tables and perf voting on the OPP powerdomain.
This is needed so venus votes on the corresponding performance state
for the OPP powerdomain along with setting the core clock rate.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-media@vger.kernel.org
---
No functional change in v6, rebased over 5.8-rc1
Bindings update to add optional PD https://lore.kernel.org/patchwork/patch/1241077/

 drivers/media/platform/qcom/venus/core.c       | 43 +++++++++++++++++---
 drivers/media/platform/qcom/venus/core.h       |  5 +++
 drivers/media/platform/qcom/venus/pm_helpers.c | 54 ++++++++++++++++++++++++--
 3 files changed, 92 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 203c653..630f61b 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/v4l2-mem2mem.h>
@@ -216,21 +217,37 @@ static int venus_probe(struct platform_device *pdev)
 	if (!core->pm_ops)
 		return -ENODEV;
 
+	core->opp_table = dev_pm_opp_set_clkname(dev, "core");
+	if (IS_ERR(core->opp_table))
+		return PTR_ERR(core->opp_table);
+
+	if (core->res->opp_pmdomain) {
+		ret = dev_pm_opp_of_add_table(dev);
+		if (!ret) {
+			core->has_opp_table = true;
+		} else if (ret != -ENODEV) {
+			dev_err(dev, "invalid OPP table in device tree\n");
+			return ret;
+		}
+	}
+
 	if (core->pm_ops->core_get) {
 		ret = core->pm_ops->core_get(dev);
 		if (ret)
-			return ret;
+			goto err_opp_cleanup;
 	}
 
 	ret = dma_set_mask_and_coherent(dev, core->res->dma_mask);
 	if (ret)
-		return ret;
+		goto err_opp_cleanup;
 
 	if (!dev->dma_parms) {
 		dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
 					      GFP_KERNEL);
-		if (!dev->dma_parms)
-			return -ENOMEM;
+		if (!dev->dma_parms) {
+			ret = -ENOMEM;
+			goto err_opp_cleanup;
+		}
 	}
 	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
 
@@ -242,11 +259,11 @@ static int venus_probe(struct platform_device *pdev)
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 					"venus", core);
 	if (ret)
-		return ret;
+		goto err_opp_cleanup;
 
 	ret = hfi_create(core, &venus_core_ops);
 	if (ret)
-		return ret;
+		goto err_opp_cleanup;
 
 	pm_runtime_enable(dev);
 
@@ -302,6 +319,10 @@ static int venus_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 	pm_runtime_disable(dev);
 	hfi_destroy(core);
+err_opp_cleanup:
+	if (core->has_opp_table)
+		dev_pm_opp_of_remove_table(dev);
+	dev_pm_opp_put_clkname(core->opp_table);
 	return ret;
 }
 
@@ -326,6 +347,10 @@ static int venus_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 
+	if (core->has_opp_table)
+		dev_pm_opp_of_remove_table(dev);
+	dev_pm_opp_put_clkname(core->opp_table);
+
 	if (pm_ops->core_put)
 		pm_ops->core_put(dev);
 
@@ -355,6 +380,10 @@ static __maybe_unused int venus_runtime_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* Drop the performance state vote */
+	if (core->opp_pmdomain)
+		dev_pm_opp_set_rate(dev, 0);
+
 	if (pm_ops->core_power)
 		ret = pm_ops->core_power(dev, POWER_OFF);
 
@@ -520,6 +549,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
+	.opp_pmdomain = (const char *[]) { "opp-pd", NULL },
 	.vcodec_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
@@ -565,6 +595,7 @@ static const struct venus_resources sc7180_res = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
+	.opp_pmdomain = (const char *[]) { "opp-pd", NULL },
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_4XX,
 	.vmem_id = VIDC_RESOURCE_NONE,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 7118612..b0cc544 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -62,6 +62,7 @@ struct venus_resources {
 	unsigned int vcodec_clks_num;
 	const char * const vcodec_pmdomains[VIDC_PMDOMAINS_NUM_MAX];
 	unsigned int vcodec_pmdomains_num;
+	const char **opp_pmdomain;
 	unsigned int vcodec_num;
 	enum hfi_version hfi_version;
 	u32 max_load;
@@ -145,8 +146,12 @@ struct venus_core {
 	struct clk *vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
 	struct icc_path *video_path;
 	struct icc_path *cpucfg_path;
+	struct opp_table *opp_table;
+	bool has_opp_table;
 	struct device_link *pd_dl_venus;
 	struct device *pmdomains[VIDC_PMDOMAINS_NUM_MAX];
+	struct device_link *opp_dl_venus;
+	struct device *opp_pmdomain;
 	struct video_device *vdev_dec;
 	struct video_device *vdev_enc;
 	struct v4l2_device v4l2_dev;
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index abf9315..bfe7421 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -9,6 +9,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/types.h>
 #include <media/v4l2-mem2mem.h>
@@ -66,10 +67,9 @@ static void core_clks_disable(struct venus_core *core)
 
 static int core_clks_set_rate(struct venus_core *core, unsigned long freq)
 {
-	struct clk *clk = core->clks[0];
 	int ret;
 
-	ret = clk_set_rate(clk, freq);
+	ret = dev_pm_opp_set_rate(core->dev, freq);
 	if (ret)
 		return ret;
 
@@ -740,13 +740,16 @@ static int venc_power_v4(struct device *dev, int on)
 
 static int vcodec_domains_get(struct device *dev)
 {
+	int ret;
+	struct opp_table *opp_table;
+	struct device **opp_virt_dev;
 	struct venus_core *core = dev_get_drvdata(dev);
 	const struct venus_resources *res = core->res;
 	struct device *pd;
 	unsigned int i;
 
 	if (!res->vcodec_pmdomains_num)
-		return -ENODEV;
+		goto skip_pmdomains;
 
 	for (i = 0; i < res->vcodec_pmdomains_num; i++) {
 		pd = dev_pm_domain_attach_by_name(dev,
@@ -763,7 +766,41 @@ static int vcodec_domains_get(struct device *dev)
 	if (!core->pd_dl_venus)
 		return -ENODEV;
 
+skip_pmdomains:
+	if (!core->has_opp_table)
+		return 0;
+
+	/* Attach the power domain for setting performance state */
+	opp_table = dev_pm_opp_attach_genpd(dev, res->opp_pmdomain, &opp_virt_dev);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		goto opp_attach_err;
+	}
+
+	core->opp_pmdomain = *opp_virt_dev;
+	core->opp_dl_venus = device_link_add(dev, core->opp_pmdomain,
+					     DL_FLAG_RPM_ACTIVE |
+					     DL_FLAG_PM_RUNTIME |
+					     DL_FLAG_STATELESS);
+	if (!core->opp_dl_venus) {
+		ret = -ENODEV;
+		goto opp_dl_add_err;
+	}
+
 	return 0;
+
+opp_dl_add_err:
+	dev_pm_domain_detach(core->opp_pmdomain, true);
+opp_attach_err:
+	if (core->pd_dl_venus) {
+		device_link_del(core->pd_dl_venus);
+		for (i = 0; i < res->vcodec_pmdomains_num; i++) {
+			if (IS_ERR_OR_NULL(core->pmdomains[i]))
+				continue;
+			dev_pm_domain_detach(core->pmdomains[i], true);
+		}
+	}
+	return ret;
 }
 
 static void vcodec_domains_put(struct device *dev)
@@ -773,7 +810,7 @@ static void vcodec_domains_put(struct device *dev)
 	unsigned int i;
 
 	if (!res->vcodec_pmdomains_num)
-		return;
+		goto skip_pmdomains;
 
 	if (core->pd_dl_venus)
 		device_link_del(core->pd_dl_venus);
@@ -783,6 +820,15 @@ static void vcodec_domains_put(struct device *dev)
 			continue;
 		dev_pm_domain_detach(core->pmdomains[i], true);
 	}
+
+skip_pmdomains:
+	if (!res->opp_pmdomain)
+		return;
+
+	if (core->opp_dl_venus)
+		device_link_del(core->opp_dl_venus);
+
+	dev_pm_domain_detach(core->opp_pmdomain, true);
 }
 
 static int core_get_v4(struct device *dev)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

