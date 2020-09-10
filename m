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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC63C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C66207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ir+znU6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgIJCO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbgIJCLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:11:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C6FC061363
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 17:49:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kk9so2189217pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 17:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fo29UVf8/PljyIh0V7UDdyn+y8CbTVYNyc4tulVx7PI=;
        b=ir+znU6xL6b1OkCX7R39Z1qLqEWlZGR9wfyOiujIAKUzsKR5IoNbgrnqGkwrZxktmb
         gcICbKw2Zsumywc1HvqqXl6fBgjpDDAFn6XQV2p00uw2cqG14WvaQvXf7E2u15uA+Dbr
         PorV/Eu0oTnYnF62DFpJXiCS2bnEpBx2PKqpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fo29UVf8/PljyIh0V7UDdyn+y8CbTVYNyc4tulVx7PI=;
        b=Kt07+lHcMuPri9X/H5L/gxJBMNsR964Xz/FeUARoGxH+dop+VUlNDFy0l/WQ7VQe6U
         2F+3DXJ1C2BE+Oe6u2+srmTPwjt4lzguld4uZt8vq1yw9futZE/FowubpljuiInN4NPV
         CE59bKuHtlJQICpfL6ajAN89CIMi1L2RbgaY/qkX+QLNjkIkEenIX83EcZTf2pV29W+F
         QtKiRB7NpoD5Jr+Pdu9p2ZDgV9oTK4dy6WL2WIEqsmYB/Dcu0HeQvb1MovS/ErKgmxAX
         /JYshd/1ckgaPiHll1RzUOFmiul5/qn33ZmRLW+pDnfzt0CIBjbv4JpWBKNW0iyrndBR
         H1tw==
X-Gm-Message-State: AOAM532EwjnMlH1TJ7OHjUlKzOg5Sx+Vl3SZvJD8fX3rEGFvJPmak58p
        G8Zct8rfrF84ulup3eN20fZU2g==
X-Google-Smtp-Source: ABdhPJw1oxbn4IRJbY/MRML/Jli8FgJ/MJ0l59c4coFcCsIa5f7pOcW31SOyEPCKfDUGHY+rCf+lWg==
X-Received: by 2002:a17:90a:8909:: with SMTP id u9mr3006045pjn.119.1599698951298;
        Wed, 09 Sep 2020 17:49:11 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id c7sm3899050pfj.100.2020.09.09.17.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 17:49:10 -0700 (PDT)
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
Subject: [PATCH v3 06/10] phy: qcom-qmp: Use devm_platform_ioremap_resource() to simplify
Date:   Wed,  9 Sep 2020 17:48:58 -0700
Message-Id: <20200910004902.2252694-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200910004902.2252694-1-swboyd@chromium.org>
References: <20200910004902.2252694-1-swboyd@chromium.org>
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

