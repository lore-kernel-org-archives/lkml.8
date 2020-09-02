Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2D2C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B3320773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HDg7f1G5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgIBXCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 19:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgIBXC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 19:02:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0D7C061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 16:02:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b124so578293pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 16:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fo29UVf8/PljyIh0V7UDdyn+y8CbTVYNyc4tulVx7PI=;
        b=HDg7f1G5aO4bdVrUsKV65hlrChf4DEJoiAQKM72+sfHccEtiSaoo0TpUruopFki4I8
         5pnYD1GT+UG8DL6N9MixoVeMQfyJfnwRYP5rw7uQa/Qvxfcs/uuqk4+1gACXywtLfIvq
         WwPBP+NiY+dJufBivyw3Oyiloc9Ebtgxfs9Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fo29UVf8/PljyIh0V7UDdyn+y8CbTVYNyc4tulVx7PI=;
        b=nxx8lnivyY1TIisCdORSruvVLOKAFp/KcFFS5p7XF+7bdwuT1MqTh4rWF0RYNgLCFy
         wl16HiVUGkXOKnuXintZu/H1PTofYAL/ze7Av34JEk46ClsEMsC20Y25XDzNx9t69pKK
         mM6J6b7Dy5ymOIfwGm0anpA2m965nL6aI6jck/71+iq4cQgeb/4+kWyVvHphPEtsjIGG
         bPvBUp7Z6h+5h8s/sgvFMrVlrqrH64AiCQCavn76NRxL/iE8DTL9OMgQNv1YjcrtIog4
         uvQv9eo2Bhj/QsS3eA076m9HCRdZAviNl/7+BTNN9f0NG+3EQes7RRKYvh1rAXQVB3bG
         mQUw==
X-Gm-Message-State: AOAM5304hkySmBGTy80JZIrL3c1Xgqqq84f1TpwBEF0NuyOcN76d9kE9
        ZDPJ697THeAfutTI1Uc8jjqpKw==
X-Google-Smtp-Source: ABdhPJwju4TDd3bk4ZVsTie2kudOhcLdJ2xkXNuB5Q0DlANdCq9I04Dh+KPA+Wgv76q/d/ItqxKDKg==
X-Received: by 2002:a63:6782:: with SMTP id b124mr201237pgc.308.1599087745106;
        Wed, 02 Sep 2020 16:02:25 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id x12sm410277pjq.43.2020.09.02.16.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 16:02:24 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>
Subject: [PATCH v2 06/10] phy: qcom-qmp: Use devm_platform_ioremap_resource() to simplify
Date:   Wed,  2 Sep 2020 16:02:11 -0700
Message-Id: <20200902230215.3452712-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200902230215.3452712-1-swboyd@chromium.org>
References: <20200902230215.3452712-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use the wrapper API here to save some lines and remove the need
for the 'base' and 'res' local variable.

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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
 drivers/phy/qualcomm/phy-qcom-qmp.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 215abd179e74..ecfcc97277f9 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -3235,10 +3235,8 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 {
 	struct qcom_qmp *qmp;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct device_node *child;
 	struct phy_provider *phy_provider;
-	void __iomem *base;
 	void __iomem *serdes;
 	const struct qmp_phy_cfg *cfg;
 	int num, id;
@@ -3256,13 +3254,10 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 	if (!cfg)
 		return -EINVAL;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
 	/* per PHY serdes; usually located at base address */
-	serdes = base;
+	serdes = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(serdes))
+		return PTR_ERR(serdes);
 
 	/* per PHY dp_com; if PHY has dp_com control block */
 	if (cfg->has_phy_dp_com_ctrl) {
-- 
Sent by a computer, using git, on the internet

