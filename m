Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA33C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D3D2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k1J3sN0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgIJDXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbgIJDXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:23:01 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81B2C06135E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 17:49:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 34so3278008pgo.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 17:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ReQxmAY0XLGu4xlFoP8MkkA+httZz7j6v/IQOYimHkQ=;
        b=k1J3sN0sWEU5XfqO61nZD/yFIdQSDgiPAVunvU+PmSRlDKVd3tg1pCSnEutnHWko6e
         8Kdl+l7X2SYWbVHbsecO+oOJxHLPOTmBVsh1XKC1A3Q0+fryfCYYggwJ009niKyu3XWs
         BWA24Q/oMTvo6XenZ9B9v82imDaYDfbKlMpy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ReQxmAY0XLGu4xlFoP8MkkA+httZz7j6v/IQOYimHkQ=;
        b=BHVJeO1nGPQMr2wjK75wkDbMpVw5Wp7EnFtX3lXXCNeP80+ARxzUVhIGvoG9ZaVFWa
         XQyL0x/YVq+YVk5lCy80HjpLNidXgVJJUWub1FKre7fZ0m7on4CRH7AkK7HRxBmHLGUE
         Mah1slRGD8GuppLnSzvmTOAOFYWKtyqSzgK0nAOqUVz10a/AxoRNSn0gEZgthd7aYRBe
         Acvb9k5KHOU1BtqMvTvww9tJ9CDG/BWMONEtfNfLzAXUXUgkjl9jKC48ONaofw3wJOeW
         KVHHCt4l+IBuoJ6E9AI0uwl5/jTp4+8yhYxkzw4zuyLq95fdNIfp/z5qmH/0+K44bmpc
         h9Qw==
X-Gm-Message-State: AOAM530g0ar9MtJYNxNvB1DSFBsoa9WJqmNnV6oG62VvhNo1dqDmp2xw
        ejZlyM1BGqGq8aiPDcFgyx4uSQ==
X-Google-Smtp-Source: ABdhPJxwm25YjsmYTmeysQc8B83R4lNCe6FD8p/QRsUWpFZGTzV8n4W4KXR4srjeMv3t2bSAC0lIrQ==
X-Received: by 2002:a63:348d:: with SMTP id b135mr2392054pga.89.1599698948187;
        Wed, 09 Sep 2020 17:49:08 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id c7sm3899050pfj.100.2020.09.09.17.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 17:49:07 -0700 (PDT)
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
Subject: [PATCH v3 03/10] phy: qcom-qmp: Remove 'initialized' in favor of 'init_count'
Date:   Wed,  9 Sep 2020 17:48:55 -0700
Message-Id: <20200910004902.2252694-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200910004902.2252694-1-swboyd@chromium.org>
References: <20200910004902.2252694-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already track if any phy inside the qmp wrapper has been initialized
by means of the struct qcom_qmp::init_count member. Let's drop the
duplicate 'initalized' member to simplify the code a bit.

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
 drivers/phy/qualcomm/phy-qcom-qmp.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 7ee9e966dc6d..4a23ba9361b3 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1844,7 +1844,6 @@ struct qmp_phy {
  * @phys: array of per-lane phy descriptors
  * @phy_mutex: mutex lock for PHY common block initialization
  * @init_count: phy common block initialization count
- * @phy_initialized: indicate if PHY has been initialized
  * @ufs_reset: optional UFS PHY reset handle
  */
 struct qcom_qmp {
@@ -1861,7 +1860,6 @@ struct qcom_qmp {
 
 	struct mutex phy_mutex;
 	int init_count;
-	bool phy_initialized;
 
 	struct reset_control *ufs_reset;
 };
@@ -2748,7 +2746,6 @@ static int qcom_qmp_phy_enable(struct phy *phy)
 		dev_err(qmp->dev, "phy initialization timed-out\n");
 		goto err_pcs_ready;
 	}
-	qmp->phy_initialized = true;
 	return 0;
 
 err_pcs_ready:
@@ -2792,8 +2789,6 @@ static int qcom_qmp_phy_disable(struct phy *phy)
 
 	qcom_qmp_phy_com_exit(qmp);
 
-	qmp->phy_initialized = false;
-
 	return 0;
 }
 
@@ -2868,7 +2863,7 @@ static int __maybe_unused qcom_qmp_phy_runtime_suspend(struct device *dev)
 	if (cfg->type != PHY_TYPE_USB3)
 		return 0;
 
-	if (!qmp->phy_initialized) {
+	if (!qmp->init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
 	}
@@ -2894,7 +2889,7 @@ static int __maybe_unused qcom_qmp_phy_runtime_resume(struct device *dev)
 	if (cfg->type != PHY_TYPE_USB3)
 		return 0;
 
-	if (!qmp->phy_initialized) {
+	if (!qmp->init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
 	}
-- 
Sent by a computer, using git, on the internet

