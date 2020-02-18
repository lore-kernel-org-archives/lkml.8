Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D0CC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5693D21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cZf5qStk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgBRSMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:12:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37263 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgBRSMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:12:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id z12so11351339pgl.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzP6DDxjNOEcRZc6aP2dcvH1CJqWKtefu5asJA+DstU=;
        b=cZf5qStkhDbF+2285LVwTF25BVh9UjH/fnLeRooy56tUNVAhSwMt3dFT7KK5QHfbKn
         YOa5d7141qV+nMVIFog2MWchsku1UWXSC14D8Z7+Zt9t+EBvT9fytkk/dcq9kegDWOi6
         G5kiHKRudS09kb7+8HVKHOSvnTemXYK4JBUwdnuTBosulCv1XxM9dRcqTKuI4f9BAGnb
         3cn7d5GHivpsGz4GZdP+jtxsV06IKzBiGEmuRob0eDLeeWJkvIpqjEpE+qbhZEpgVxCC
         v6vjaZzp3/XALSSX2zxRJvS/139lii4oiJGEn8XFs9blYtIuhqVShVLBKpcu5/ZvlcH/
         zguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzP6DDxjNOEcRZc6aP2dcvH1CJqWKtefu5asJA+DstU=;
        b=SLimhkSQ+hr6AlSuqpX5usXC5I/C2VTU1UhZ7sxv2U1dRTbBOe3hY/KTEnHECPJuTL
         nSuMnWQ9LzgPjJCzbzQjAqZnRmBr8hzzD39Cn6kk+SQEvUAz95C29fuMCjMXu1Xa3rwu
         LzoP0DGgKQcq8cqg3bzu/LliYbZ+SIYlM3/UthbjNqUqBHNx481mIw+GHDQEpbOiWPkX
         E4fViTfDMAoDbfyBM+3W/Un0pLA9sZMkzb6PJOGJWaQoSwM3e4EwhwH4HrQ/8Kirq9n1
         CSw7MHa2BerPLjrkvvFVU+Amnq7He890sgNqua7+AAmiB2+heGeRpTMJl5ww2jhYTcHX
         sJZw==
X-Gm-Message-State: APjAAAVQnHxcs3ks/dQxdhRP9EIxPjTGyNd9/qTZ0MQTjLuSDiMd/lzo
        FiWzwt+mKXDViICYGVMzj62kA3nBEQs=
X-Google-Smtp-Source: APXvYqzRmHIQixHL/dT3g9+URkrEvbTD1662LCKASj2k0uJ6uY3NugxAdfAfz04HmHTeYWl0Y6pjGA==
X-Received: by 2002:a62:1402:: with SMTP id 2mr22863254pfu.126.1582049568452;
        Tue, 18 Feb 2020 10:12:48 -0800 (PST)
Received: from localhost ([103.195.202.120])
        by smtp.gmail.com with ESMTPSA id j17sm4952292pfa.16.2020.02.18.10.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 10:12:47 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 7/8] drivers: thermal: tsens: kernel-doc fixup
Date:   Tue, 18 Feb 2020 23:42:11 +0530
Message-Id: <8990f5cd5ec2bc2aa0f13c0ad5cd41b8d1a5632e.1582048155.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document ul_lock, threshold and control structure members and make
the following kernel-doc invocation happy:

$ scripts/kernel-doc -v -none drivers/thermal/qcom/*

drivers/thermal/qcom/qcom-spmi-temp-alarm.c:105: info: Scanning doc for qpnp_tm_get_temp_stage
drivers/thermal/qcom/tsens-common.c:18: info: Scanning doc for struct tsens_irq_data
drivers/thermal/qcom/tsens-common.c:130: info: Scanning doc for tsens_hw_to_mC
drivers/thermal/qcom/tsens-common.c:163: info: Scanning doc for tsens_mC_to_hw
drivers/thermal/qcom/tsens-common.c:245: info: Scanning doc for tsens_set_interrupt
drivers/thermal/qcom/tsens-common.c:268: info: Scanning doc for tsens_threshold_violated
drivers/thermal/qcom/tsens-common.c:362: info: Scanning doc for tsens_critical_irq_thread
drivers/thermal/qcom/tsens-common.c:438: info: Scanning doc for tsens_irq_thread
drivers/thermal/qcom/tsens.h:41: info: Scanning doc for struct tsens_sensor
drivers/thermal/qcom/tsens.h:59: info: Scanning doc for struct tsens_ops
drivers/thermal/qcom/tsens.h:494: info: Scanning doc for struct tsens_features
drivers/thermal/qcom/tsens.h:513: info: Scanning doc for struct tsens_plat_data
drivers/thermal/qcom/tsens.h:529: info: Scanning doc for struct tsens_context

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index ad7574fe0811..f49e516b3458 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -526,6 +526,8 @@ struct tsens_plat_data {
 
 /**
  * struct tsens_context - Registers to be saved/restored across a context loss
+ * @threshold: Threshold register value
+ * @control: Control register value
  */
 struct tsens_context {
 	int	threshold;
@@ -540,6 +542,7 @@ struct tsens_context {
  * @srot_map: pointer to SROT register address space
  * @tm_offset: deal with old device trees that don't address TM and SROT
  *             address space separately
+ * @ul_lock: lock while processing upper/lower threshold interrupts
  * @crit_lock: lock while processing critical threshold interrupts
  * @rf: array of regmap_fields used to store value of the field
  * @ctx: registers to be saved and restored during suspend/resume
-- 
2.20.1

