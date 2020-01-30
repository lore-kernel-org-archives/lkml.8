Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C2AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54AE214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYp7PeVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgA3N1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:27:46 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35384 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgA3N1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:27:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so1665784pgk.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 05:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdqL+x3UnmB9p8cvhtPjpe4pu+I9XE06RhosU/aRLBE=;
        b=HYp7PeVAZksaW1u+cvxO61DyoWNCC8cM05jGQztTJWPBrPgZhbYY+vtSf/heqTV4pQ
         xpXDWt9jcY8YxTt7iesR+dTkiat5PVN24d2264YAInQ8f+BzMttqB9adIDAf2xVtauvb
         tFEk5ALuumssLlS0ETq9FXAhVWWqT7nCts2fK8+7Zxav7HznrkoSZSujfyscpOkMqrqK
         jztv9N4l+77Bk4qnuGpQU/ta68yBF7a4lUDSK7u6h8ImJVs5jBEyqkYfK76GI0byWM4s
         Bw7SEq5qQloamU/RTopzSEBTkTCecktw5WLWsUG7hRkzMgqmRBbZXBUccMAmz/xiMQjG
         LPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdqL+x3UnmB9p8cvhtPjpe4pu+I9XE06RhosU/aRLBE=;
        b=jR1MZ2ePa8oAu5nBJczmsXvKKonNfrRpmPw/p+nt3OR1+4uB1Cqt2t+Uezf97JJ8bV
         Hx+uwkg+ULFNCiiLlP4b8m7aLAZDoUOagTatBWi7FDY73jg72gKPvl/EfHH/UbeWGDCP
         d/X0dMKqXELKR9pVIp4OGrdPZ329ZvPu1lnfqOY5QDrm8Kevs7ICH4TgGNe2zlYmWfG1
         Df5fdWOrs2rxVAZMDUrXeznEl2d6WdMBKxV9XGBd+iLesZFUSiw1uIlw4I0zzwgJjFD+
         CvCjJpmCPKiIGZqCXqC3VQKHsS6RZCty8Ac5NzccfetVi1K4X7xsPfb/wgbuKdF6EiIw
         67FQ==
X-Gm-Message-State: APjAAAV8sNQ7d+vWEZbjGAhQbtxXiCNmXLWfgdrnDx898tNgYW3ZbbAh
        UUKtaS6+EM+fQswNiW/1evOwMWGnyqix0Q==
X-Google-Smtp-Source: APXvYqwB7UPg0gz3fV4XjUVNVNhXYeDqUrc2+r90qXlJVZZVahoX7LFYttoPXw62+c1Kwls7LPcvMw==
X-Received: by 2002:a63:1c1d:: with SMTP id c29mr4805414pgc.14.1580390861276;
        Thu, 30 Jan 2020 05:27:41 -0800 (PST)
Received: from localhost ([45.127.45.97])
        by smtp.gmail.com with ESMTPSA id r145sm6884089pfr.5.2020.01.30.05.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 05:27:40 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 6/7] drivers: thermal: tsens: kernel-doc fixup
Date:   Thu, 30 Jan 2020 18:57:09 +0530
Message-Id: <1fccb71bd5d54842d2c54d175c080d0edeabca26.1580390127.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1580390127.git.amit.kucheria@linaro.org>
References: <cover.1580390127.git.amit.kucheria@linaro.org>
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
---
 drivers/thermal/qcom/tsens.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index cf0511a947d4..dd163b27add4 100644
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

