Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAAFC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7748520BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VNowW2ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbgIJCZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730187AbgIJCMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:12:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3F5C06135B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 17:49:07 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so2177643pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 17:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6TZt2amfy5qzjmnWe5xTFuhN9jzSvSMQp9lB8VeO0GI=;
        b=VNowW2ly+OWfn5GZCmTDhCW9xLT4atxeanWR69s2Rzr4xxAn6MOwk/5Z3N1pfmDbYm
         s3aKeV7ebDpugOu0L1SpWSxEYCYuN3cmSv1/YT6Wr6t0hN00I2/5e0ohYQ3gQHei8Cu2
         qGNS0CCGRFY/gn/VDGEkQt97AGutqkEmhdKGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6TZt2amfy5qzjmnWe5xTFuhN9jzSvSMQp9lB8VeO0GI=;
        b=OUOUAH17ATdkqsHMXqX4DvNFktxWlTV8te1vlsIYSEmB7ODvuOu2QnQrvzlhfR8T2u
         1yH+XpGwCJcifyjkmhj+4E2hxg5wcSAbJ7fzZIMbxQGHgyx1MVIWFyKZRx5UDHztx5RI
         6LqhYTW0f9LUwbqq1g3kwV+jOEb+d3NG6N1r/+E1vtgYoxXW3d4mT4gpd2LsFWSd859y
         71axIUfBxBELSXor/E+xKBbAV6URt8t012aaVnYFC5G657uAunrSGof41plI+AXLBMX/
         S4OVSPtzx2N0BzzaJbvqrFd2kLVI0psn4ZmO8Br+/MBcBI3E7B/3Pm+yGrArC1gwejwb
         LIUw==
X-Gm-Message-State: AOAM531MjhxSaSeVj08bpFFjY+jozN8n7oqtQAfmI6pUj6+TBWanRI5G
        xYW5wMPbDvxWhuPjI2rFDf4RCw==
X-Google-Smtp-Source: ABdhPJweiVf7XGI9JekQmbo0Ln+nbnNIqf+ht1aIYPxTWmEQOz0wAdQpZJbtlAi9hvBRiBFId7uBwQ==
X-Received: by 2002:a17:90b:4018:: with SMTP id ie24mr3066548pjb.9.1599698946895;
        Wed, 09 Sep 2020 17:49:06 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id c7sm3899050pfj.100.2020.09.09.17.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 17:49:06 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>
Subject: [PATCH v3 02/10] phy: qcom-qmp: Move phy mode into struct qmp_phy
Date:   Wed,  9 Sep 2020 17:48:54 -0700
Message-Id: <20200910004902.2252694-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200910004902.2252694-1-swboyd@chromium.org>
References: <20200910004902.2252694-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phy mode pertains to the phy itself, i.e. 'struct qmp_phy', not the
wrapper, i.e. 'struct qcom_qmp'. Move the phy mode into the phy
structure to more accurately reflect what is going on. This also cleans
up 'struct qcom_qmp' so that it can eventually be the place where qmp
wrapper wide data is located, paving the way for the USB3+DP combo phy.

Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Cc: Chandan Uddaraju <chandanu@codeaurora.org>
Cc: Vara Reddy <varar@codeaurora.org>
Cc: Tanmay Shah <tanmay@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Manu Gautam <mgautam@codeaurora.org>
Cc: Sandeep Maheswaram <sanm@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Jonathan Marek <jonathan@marek.ca>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 562053ce9455..7ee9e966dc6d 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1812,6 +1812,7 @@ struct qmp_phy_cfg {
  * @index: lane index
  * @qmp: QMP phy to which this lane belongs
  * @lane_rst: lane's reset controller
+ * @mode: current PHY mode
  */
 struct qmp_phy {
 	struct phy *phy;
@@ -1825,6 +1826,7 @@ struct qmp_phy {
 	unsigned int index;
 	struct qcom_qmp *qmp;
 	struct reset_control *lane_rst;
+	enum phy_mode mode;
 };
 
 /**
@@ -1843,7 +1845,6 @@ struct qmp_phy {
  * @phy_mutex: mutex lock for PHY common block initialization
  * @init_count: phy common block initialization count
  * @phy_initialized: indicate if PHY has been initialized
- * @mode: current PHY mode
  * @ufs_reset: optional UFS PHY reset handle
  */
 struct qcom_qmp {
@@ -1861,7 +1862,6 @@ struct qcom_qmp {
 	struct mutex phy_mutex;
 	int init_count;
 	bool phy_initialized;
-	enum phy_mode mode;
 
 	struct reset_control *ufs_reset;
 };
@@ -2801,9 +2801,8 @@ static int qcom_qmp_phy_set_mode(struct phy *phy,
 				 enum phy_mode mode, int submode)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	struct qcom_qmp *qmp = qphy->qmp;
 
-	qmp->mode = mode;
+	qphy->mode = mode;
 
 	return 0;
 }
@@ -2816,8 +2815,8 @@ static void qcom_qmp_phy_enable_autonomous_mode(struct qmp_phy *qphy)
 	void __iomem *pcs_misc = qphy->pcs_misc;
 	u32 intr_mask;
 
-	if (qmp->mode == PHY_MODE_USB_HOST_SS ||
-	    qmp->mode == PHY_MODE_USB_DEVICE_SS)
+	if (qphy->mode == PHY_MODE_USB_HOST_SS ||
+	    qphy->mode == PHY_MODE_USB_DEVICE_SS)
 		intr_mask = ARCVR_DTCT_EN | ALFPS_DTCT_EN;
 	else
 		intr_mask = ARCVR_DTCT_EN | ARCVR_DTCT_EVENT_SEL;
@@ -2863,7 +2862,7 @@ static int __maybe_unused qcom_qmp_phy_runtime_suspend(struct device *dev)
 	struct qmp_phy *qphy = qmp->phys[0];
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
-	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qmp->mode);
+	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qphy->mode);
 
 	/* Supported only for USB3 PHY */
 	if (cfg->type != PHY_TYPE_USB3)
@@ -2889,7 +2888,7 @@ static int __maybe_unused qcom_qmp_phy_runtime_resume(struct device *dev)
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	int ret = 0;
 
-	dev_vdbg(dev, "Resuming QMP phy, mode:%d\n", qmp->mode);
+	dev_vdbg(dev, "Resuming QMP phy, mode:%d\n", qphy->mode);
 
 	/* Supported only for USB3 PHY */
 	if (cfg->type != PHY_TYPE_USB3)
-- 
Sent by a computer, using git, on the internet

