Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C779C433F1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F6E207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEnGsBWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgGWNJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbgGWNJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:09:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D18C0619E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:09:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so5149194wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+lee8B7JFfBYPKyFP3yz/BoNx5eAb9WaQRkbumGc3E=;
        b=vEnGsBWqxZP6Q+KXwBLvSyX1MOrqEdZzzqFXcnrqx1GiSKetgbLJOiMySAywIL80yq
         ZpW5g3USJh6jrO++XvlweFAMbDjZnX+Lv5ibi4oNbnAEY160dsY8mvIbjDmrwhhn2cg+
         YwkpCWfCtcW/u/hxnf95mzfHcp7Wq0Sn7CE8BABd4jMGroI16PoBrbXXQch9K/6WV9sE
         Ng754Q4m097X0MDwn1Oh1giyud6/+GDKLTwDPMXaZ9hAxE94yHcxa7WNxn+MxAMYcD98
         mpzJytXYhOZEul8gtsTierUiFbxBjspzIbbKM5J+UuujnJ2rAYZljscT+099Z+2TXElu
         lddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+lee8B7JFfBYPKyFP3yz/BoNx5eAb9WaQRkbumGc3E=;
        b=H+chqN/uHBidWv8ers2vyi88+StV+nGUstQ+ZwK1nuvJIITCSVlJkQFifWUVq2E4iF
         BPErAyq8loBsqCUI2JvBmb0wiQ9Y30l8BqcC2LTCOCZ4XC+kRpNjSpqlSPTJpi/xTKBk
         CjQcxkAmYS/1JRbq/eXABS36FhlKAKejWSqY/EwJBfMLlRDIi00ZUIfKp2zOQgeT5ef2
         y7RSWM2017PM/wnOpMyWHOzF/40Jsr+gnA1B8uaGM80EM9DIWfODAUQiom5n2Vet+z4T
         fWyp/kppXEWT7oL0J+rVcgB2LoS0Kz6piV7X0OlyXvokQXKAmSBLDZh1PLmqq2UoTqPw
         xBFw==
X-Gm-Message-State: AOAM530XVUopvHQxnslESy0+G6S8hFs44yLNaWooNHM+X0UtwOUBo7mw
        aXAfCBZU4xCVaYLq1e/NpBs8dw==
X-Google-Smtp-Source: ABdhPJwgrZG+M6VvSuuefuXl0h1Zce5N82Kr5wnaXUw8uuGBWCxPV5wjRudOmF7cOpH6h97vM6pjZg==
X-Received: by 2002:a1c:1f85:: with SMTP id f127mr1894728wmf.154.1595509786042;
        Thu, 23 Jul 2020 06:09:46 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id w7sm3594632wmc.32.2020.07.23.06.09.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 06:09:45 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] interconnect: qcom: sdm845: Replace xlate with xlate_extended
Date:   Thu, 23 Jul 2020 16:09:39 +0300
Message-Id: <20200723130942.28491-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723130942.28491-1-georgi.djakov@linaro.org>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the qcom_icc_xlate_extended() in order to parse tags, that are
specified as an additional arguments to the path endpoints in DT.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index f6c7b969520d..3b81dbb71b0b 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -469,7 +469,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	provider->set = qcom_icc_set;
 	provider->pre_aggregate = qcom_icc_pre_aggregate;
 	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
+	provider->xlate_extended = qcom_icc_xlate_extended;
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->data = data;
 
