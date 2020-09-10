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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137A7C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C617A21D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GEZ0H1yH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgIJCWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbgIJCMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:12:03 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFD2C061362
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 17:49:10 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so67225plt.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 17:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSus/y6lL8EmG6yL6JLfCPXtJnmL/oSSFawM27yJogM=;
        b=GEZ0H1yH33wJmSTJONAngV1gVbg+2UBO93tZN3OI1kQsIR3ea6TYmsFIHv97HFfEH+
         s66xIFsN5f+fU1qFmea2N0d1tYwknw6/nVFOT17HFKEBGBIvDpJMtAaY3HbHKFZCkk4T
         +7OWTCqTIb17Cr6ecvTW4AT1MerUKcaH1Z16A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSus/y6lL8EmG6yL6JLfCPXtJnmL/oSSFawM27yJogM=;
        b=EBgYpxQaFE3K5qP/HtuN8JBjDnFcSH5IXTWTTlZ2SJS9G9gNC0oHMhL+kApagLX9K5
         L0AExW5hZ2F3w3duTDwtvnrfsitZmrVLoR1rJ8+6ZL1gHeBQfkthMnW1XT9gE5fdMTq8
         GELFTxjN6DYUq4k9IzJtKOXKgGO6bbjU4qGWvAeBCWqY7U8pTwwFgLe88LMbJHXAMqQs
         cQXC9Pmi5eSy/4vJbVtu1egnjJbFqlhW9YNl2CLfyNfSUfkopRUpBFRYCOVQBZKSBF2p
         IwL3gLYv0rhRIEGIaBLNWf6jsVcsw/pQcE+hLJhiEIMLZV9H2RakuTkctj47qLs1ro2y
         YtWw==
X-Gm-Message-State: AOAM532Q2MZ57GKrSDyUJChuovsjsbRstgV9Mw9ZNxkdesMp9nbLR54J
        u7ltARRJIBGRwnIsP2EucVJNqg==
X-Google-Smtp-Source: ABdhPJzhev1K2Ieq+ndV4g0JOIdTahf8qXpADPs+1HB4t8k9T1I4cYHOsH8u/kttTG7NxupkPXbsFQ==
X-Received: by 2002:a17:90a:644b:: with SMTP id y11mr3066145pjm.13.1599698950272;
        Wed, 09 Sep 2020 17:49:10 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id c7sm3899050pfj.100.2020.09.09.17.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 17:49:09 -0700 (PDT)
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
Subject: [PATCH v3 05/10] phy: qcom-qmp: Get dp_com I/O resource by index
Date:   Wed,  9 Sep 2020 17:48:57 -0700
Message-Id: <20200910004902.2252694-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200910004902.2252694-1-swboyd@chromium.org>
References: <20200910004902.2252694-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dp_com resource is always at index 1 according to the dts files in
the kernel. Get this resource by index so that we don't need to make
future additions to the DT binding use 'reg-names'.

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
 drivers/phy/qualcomm/phy-qcom-qmp.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 40c051813c34..215abd179e74 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -3266,13 +3266,9 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 
 	/* per PHY dp_com; if PHY has dp_com control block */
 	if (cfg->has_phy_dp_com_ctrl) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "dp_com");
-		base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(base))
-			return PTR_ERR(base);
-
-		qmp->dp_com = base;
+		qmp->dp_com = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(qmp->dp_com))
+			return PTR_ERR(qmp->dp_com);
 	}
 
 	mutex_init(&qmp->phy_mutex);
-- 
Sent by a computer, using git, on the internet

