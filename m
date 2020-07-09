Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C41C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B83E2076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3BGIIIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGILHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgGILHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:07:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013C6C03541E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 04:07:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so1355930wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 04:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fdwvmHFIIgaNnK77Gxh46Dh+4af85NxewdzZf8almyY=;
        b=F3BGIIIxCLIBykFtP/eblriQzi1cjmRAs1xHNnvelohkNmxSQjuae+kOtSwEJE17hJ
         mRgWwk9Xpqw1iQEgw16Kj49km1fIluo72cMIe7ktEfxD7FiS3lthmE9xWf8OT5UrO+8A
         HXPBdgCopczix3rGZU9Ck+wiFcSmW9XRpF2erZh9jcjcwNDH3HrYlGC93LP0MVi0gOjS
         JIoInn6K6liNXjY7Euw2fyt1co+efyLYSyIwxnqiq+Aj6sqBOm1yKBtPLm+8C25Q+rIU
         5IXO3eVcsk07Icu+FspMyvR28i4wP9cchjooabnObW2tgTtLAsG/oUZUmNMsOQBwULRB
         XVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fdwvmHFIIgaNnK77Gxh46Dh+4af85NxewdzZf8almyY=;
        b=KbNbWCHp722/wl3a7w9vqwVMML92qZy6zDVsbRlzrO2gDkSBhm6yVWzKtyTIU+FNep
         PRRCF8xo3tGZTVx0WhOcRAYUCdejpXUyT8+rv0jVier/WwnGowoAaTxiRhZA+hRw4s2c
         +UX8Qey6QB1mBIC65nRd22H97S4LDEo2IhSuGvm3zy8UKjX/9ad3IJBFsYSosw3DrEwf
         ICBUaZw4SOBjy1QCW5s2zrXfg7i6CpFNauZqW2czheVk0LwshhlGjmXyOXb976SiYzA9
         PGjJ35gFuHFkw9uOtQABlgpvUti16EnRTH6ga+/kkkoWUeo5TksFu2P5s+/rqeb0VXkT
         uOwA==
X-Gm-Message-State: AOAM532VpeKmOsp4pW62y/jKQrDSjUIqHWVuMI8cTxTjZxTadqlR35JB
        w8Kjl4RWrgXEeTUSCQZAKF2DrA==
X-Google-Smtp-Source: ABdhPJyzyO6OJ0n74t6D1mB7vLxMXi4nDrnvEj3LRHpoi/iVMt8GDCSwSYvn6vh+UXBJPO3jj2VhAw==
X-Received: by 2002:a1c:9911:: with SMTP id b17mr13164196wme.135.1594292835740;
        Thu, 09 Jul 2020 04:07:15 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id q7sm5375578wrs.27.2020.07.09.04.07.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 04:07:15 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     saravanak@google.com, mdtipton@codeaurora.org,
        okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] interconnect: qcom: osm-l3: Use icc_sync_state
Date:   Thu,  9 Jul 2020 14:07:05 +0300
Message-Id: <20200709110705.30359-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709110705.30359-1-georgi.djakov@linaro.org>
References: <20200709110705.30359-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lowering the bandwidth on the bus might have negative consequences if
it's done before all consumers had a chance to cast their vote. Let's
return the maximum amount of bandwidth as initial value. This bandwidth
level would be maintained until all consumers have probed.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/osm-l3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 96fb9ff5ff2e..532d541b71be 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -137,6 +137,13 @@ static int qcom_osm_l3_remove(struct platform_device *pdev)
 	return icc_provider_del(&qp->provider);
 }
 
+static int qcom_osm_l3_get_bw(struct icc_node *node, u32 *bw)
+{
+	*bw = INT_MAX;
+
+	return 0;
+}
+
 static int qcom_osm_l3_probe(struct platform_device *pdev)
 {
 	u32 info, src, lval, i, prev_freq = 0, freq;
@@ -215,6 +222,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 	provider->dev = &pdev->dev;
 	provider->set = qcom_icc_set;
 	provider->aggregate = icc_std_aggregate;
+	provider->get_bw = qcom_osm_l3_get_bw;
 	provider->xlate = of_icc_xlate_onecell;
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->data = data;
@@ -268,6 +276,7 @@ static struct platform_driver osm_l3_driver = {
 	.driver = {
 		.name = "osm-l3",
 		.of_match_table = osm_l3_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(osm_l3_driver);
