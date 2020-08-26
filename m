Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA8DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 02:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9CF20737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 02:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iwx2R9/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgHZCr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 22:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgHZCrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 22:47:19 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3764CC061786
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 19:47:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j11so193321plk.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 19:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vzQChbfbYS4hco2RAd/KrgYyVQ6hSX7dHhXL97tH/c=;
        b=Iwx2R9/iC6n3XnuyyLgUWbBd4Pm7eWvZgp9huOXEV830Gujc7Ni42rN6iQrXhbbOx6
         2h6vzR0YZ/Yh4KG6aHkpKLbFXAQhXC52aYRqQhszY/UDUxRqLTE87B5OWvkvPwSGom0s
         YhJaBA45BqaeicmSTyLFrC3680lblbaYcElUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vzQChbfbYS4hco2RAd/KrgYyVQ6hSX7dHhXL97tH/c=;
        b=YV5MvSGyAv5QJXR2uprQQjc59XH7SRYwVNkbWqiJ392u0iTufdwKes46zqnqxpiXod
         YtJU/tegvOan6Rp802+0xnpjbZFVR9QJTcaXs3o6ccAEe+c4JGJ5C7y72y5zRnwbjE2v
         66PlykTfFFlXJJ2Pw3G9v3GKdagN1ghbR5nUHgpFiLqdYRRM9NsgwX5mZRQE1XuJ7Oza
         71zy1LwWjQDBEmh9rikyrK0JDjVQ7VRl12CLWM9XFKWuI1fCWM9Cl39DYHZ9Dm6b3AXW
         ZG6fQnRALZ64yM+yab58ekSTlU51uFeIFARxZCP12bWhYWaZaOiG1shNI0FdMx0cE8kf
         6C6g==
X-Gm-Message-State: AOAM532RSB1PlZmKgUJamwpH1BgBFUJ8p0n1Ik9op26OKne8oZU3vogV
        gO07tLXbLj5t96su4WudAfrn4g==
X-Google-Smtp-Source: ABdhPJwSttmVN2zzl8N971OZrMNJiHix7A6CnBxgs04+hU0Q00WUnZBV+Eq+NcQ64SGk4bA/sNhKeQ==
X-Received: by 2002:a17:902:b18e:: with SMTP id s14mr10093400plr.160.1598410037022;
        Tue, 25 Aug 2020 19:47:17 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id u65sm684381pfb.102.2020.08.25.19.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 19:47:16 -0700 (PDT)
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
Subject: [PATCH v1 3/9] phy: qcom-qmp: Remove 'initialized' in favor of 'init_count'
Date:   Tue, 25 Aug 2020 19:47:05 -0700
Message-Id: <20200826024711.220080-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200826024711.220080-1-swboyd@chromium.org>
References: <20200826024711.220080-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already track if any phy inside the qmp wrapper has been initialized
by means of the struct qcom_qmp::init_count member. Let's drop the
duplicate 'initialized' member to simplify the code a bit.

Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Cc: Chandan Uddaraju <chandanu@codeaurora.org>
Cc: Vara Reddy <varar@codeaurora.org>
Cc: Tanmay Shah <tanmay@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
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

