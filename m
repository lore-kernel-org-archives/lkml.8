Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94BAC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABADF218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQou9t73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgIHH6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbgIHH57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:57:59 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37472C06179A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 00:57:59 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 7so9467966pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p4U6DywWAGG7hqWgno8xA4KNHg7T7GRWqkUHfcQvB3k=;
        b=YQou9t73q5qKqw0WsgZMOwsCEXbHt8zLCXbEiq5x9ImKUtCw6ZGOQasYp8i6qPO6q8
         MoY4rFNcbXHaH/VVnkF+I/EV8/Xefc6LmJetEQ7Jo+jQhbpad5ca92o+uQTmT+QmPRfB
         miD/PCeXTgw9JjnidrITEqCFnTmMiqveWEvcLy8gFl4sbyW2dWZv9e+ntbOTPEDKyg7O
         jYBlXLUjy4xJ9qRsnzG/BrB89taE/tVr8drt9rN35c2EsGVXFRfs4D1HkNmKNuVrdtgG
         yLlfHFsXKBsPF0n5CbmAHxcfw405bEE7X84CBsTR5maDfD3GJs1CXAb1wJh1Ao7HWp2b
         98Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p4U6DywWAGG7hqWgno8xA4KNHg7T7GRWqkUHfcQvB3k=;
        b=IAapbCQAi3OxI5boecw/3l3NUod8MzJYFEC6ckzorMXz2JT5LajaHoBpYmy1k4LWNC
         6N4//lq8Ez9iSONSheXrcN0Lxy/Y21fk6/tpqWpUqm3zocauRFQDEIXjGmJzn7pQDpuQ
         530WSW+3D6zPBYNzL2/snzAeY5xBXCc6aSaqB8BV+qTIhcCmJo9LPVz7t6N6j2vnanMh
         E7MZCYTP8HatUD42EoW6OWkDDtmS03m8knMGMRSzTYTCiPXq2IqfyQRwhe+QGauEzgUH
         Tmqtl+fFc6m8X3ykfFVKYypBN0d3gGaW/lP5wtCmKVs95tDzV9JnhLP/SxPy1C+c3hZJ
         iTbg==
X-Gm-Message-State: AOAM531F8nLxnWrbhShJaT+7IKVDmrpalAOBg5vWOShVyYjnOIAbUFW5
        oOvuzOR4RtL0C4Y/RxmjKptB
X-Google-Smtp-Source: ABdhPJwRUgI36ssfNhxpK77UGbBRO6qF4+xSHVU9GHpnJGzrN/z7Eow2VJb49MTdxfIMJK78Zg4mjw==
X-Received: by 2002:a17:902:8f8a:b029:d0:cc02:8541 with SMTP id z10-20020a1709028f8ab02900d0cc028541mr29499plo.32.1599551878673;
        Tue, 08 Sep 2020 00:57:58 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id m21sm7560154pfo.13.2020.09.08.00.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:57:58 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 7/7] cpufreq: qcom-hw: Use devm_platform_ioremap_resource() to simplify code
Date:   Tue,  8 Sep 2020 13:27:16 +0530
Message-Id: <20200908075716.30357-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_platform_ioremap_resource() is the combination of
platform_get_resource() and devm_ioremap_resource(). Hence, use it to
simplify the code a bit.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index c3c397cc3dc6..6eeeb2bd4dfa 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -307,7 +307,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	struct of_phandle_args args;
 	struct device_node *cpu_np;
 	struct device *cpu_dev;
-	struct resource *res;
 	void __iomem *base;
 	struct qcom_cpufreq_data *data;
 	const struct of_device_id *match;
@@ -333,13 +332,9 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	index = args.args[0];
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
-	if (!res)
-		return -ENODEV;
-
-	base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!base)
-		return -ENOMEM;
+	base = devm_platform_ioremap_resource(pdev, index);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
-- 
2.17.1

