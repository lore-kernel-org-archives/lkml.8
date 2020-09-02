Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CE2C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F3D20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K4g8otJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgIBXDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 19:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgIBXCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 19:02:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B623BC061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 16:02:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 5so510144pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 16:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ReQxmAY0XLGu4xlFoP8MkkA+httZz7j6v/IQOYimHkQ=;
        b=K4g8otJW0E9wNY7YOjmJvvQwzfV/cxt8c8JdEjAqsRf6k2JXkfk5PoYTEimA7OSMg8
         VlqdB2lWJ75x09Z2nu1XeP6dDaiwqaKJjFDI1BP15J1Ip+C+TaAxF1Fk/1WDearpy9mW
         lAliQrDffpLVL928QNiTAo42kzSOK2WserSco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ReQxmAY0XLGu4xlFoP8MkkA+httZz7j6v/IQOYimHkQ=;
        b=kkKpRHGhxFdfTzJLgFAgtpkSzflR0ET1CRmDaTFSElHPNpFaPZrIzKOzoittiS4iiV
         Jri8NyhixN6SkEDIT/4MbcoLST1E7XWaRz6Bl8WphtezAhG1qRXw9KVk7N20nKZWMq11
         XraQMtI+J/PVQFPLtVlSnSG54YzieFyJGvlACJJFbYXaeIwN1AqVmLoMSy7X+b2fBdtZ
         dQ01YAt4dNcKdFP6v8pf2Xe9Zhrkar1dBL6KdOPneuRbnZifVw1lCs3FbNkj9S4+4L3E
         1UeaZCd9549NtBqlHjFMrcN6k7Hs7vrsWUDxjcSKROsxCAGy5CVkFkzH37zor6vwG5W/
         Ffiw==
X-Gm-Message-State: AOAM532dn+6Cp8Hau5xJp5y5qtgYHZN4ULndN6kMuRyZguOZLpbKJuy8
        f2Q9X7DZ1MqSqabc+7HYFJYbKw==
X-Google-Smtp-Source: ABdhPJz710h0ob6rAZi0gAmUP2063DYIgqyaJA+mJdlSf2zU/LxK/6afH2RgwNpEOjpiknSgzXFADQ==
X-Received: by 2002:a17:902:d904:: with SMTP id c4mr166902plz.115.1599087742035;
        Wed, 02 Sep 2020 16:02:22 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id x12sm410277pjq.43.2020.09.02.16.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 16:02:21 -0700 (PDT)
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
Subject: [PATCH v2 03/10] phy: qcom-qmp: Remove 'initialized' in favor of 'init_count'
Date:   Wed,  2 Sep 2020 16:02:08 -0700
Message-Id: <20200902230215.3452712-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200902230215.3452712-1-swboyd@chromium.org>
References: <20200902230215.3452712-1-swboyd@chromium.org>
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

