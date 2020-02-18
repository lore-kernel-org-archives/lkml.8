Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC6DC34049
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDBB24125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W268SDix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgBRSMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:12:30 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39478 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgBRSM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:12:28 -0500
Received: by mail-pj1-f65.google.com with SMTP id e9so1341836pjr.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKYoguQk13R1R6X/M6A9IECv/eepHjjlH+2aj8UhmqM=;
        b=W268SDix97CRWyl+d0m85sr5bFwu72b2+9zePGaxrsUCg5VAjYivguyWHDaPGajrM+
         fJqMSqkgdGWwdXy3eYD2Qbv5WZ42Smj1AVAFAgVePj6qZg6qD4ASb3ZRhjNGl8KiCWjG
         W1NR9WrNqrIzNA5vXMQ/rwb2jgINDLfcfe12Lo4azuzGlQARbNdw+J1ScWFu/KhMHGIa
         xKNGVCD6VmuvgK9rrOktH/EqSjYkdcTDRlneUPTWnD5WUQblBR9bGrfiHZPqJ93Tgi8r
         rcDTLUJO3SDfFG2OGyqILKvCsndyBqv2h0e/mrr6733q3bZvyV03OOWDKMqwMHtX1vXn
         je0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKYoguQk13R1R6X/M6A9IECv/eepHjjlH+2aj8UhmqM=;
        b=sJWcdT5wvtXBWait/Fgq3q+HObpptf503UQsnxtOopwMmSwKr64WKWdsCgtt1aha+N
         a6sXtYtUrPmY2kDlBRSvZLP1WJX29kxwNcHllwvOYTtI7cEhnn9TWhZecOPjU+hk1Hfi
         ZvxE+P8JrZodYwiddGKgGGrG8wJS32D4lcwKJUAWKP/Tn/IOwUtZiiOLfxWcYTjVaMnm
         J4xju3Y9mgdAg+iHBsgZU1B43hzTWFYKFZq6vNrVXTWoSdhZTdy0XLWuvs7EvJ0vQArx
         OmGgZ20Inv6neM0gwtqghSeLxcWWvcPhqWCC+rKZgJK1zDbF8K2rfkQE1bP4gACiFUCd
         6LnQ==
X-Gm-Message-State: APjAAAVjKPHXpFmi1h7NvuymEcJ3x2a5HGXBsIJnec+7Go/FnCNclWv6
        QRIZ2SsN99f/pv7jnMipIz9J8ZzkbFg=
X-Google-Smtp-Source: APXvYqwlohYw/lEoFIgrL8HOrHiCAH3DKWh2vpNzoHIEq965sJTl1xtu+Y6INsZjy2qs/EPR4tUpKQ==
X-Received: by 2002:a17:90a:af81:: with SMTP id w1mr4288662pjq.14.1582049547643;
        Tue, 18 Feb 2020 10:12:27 -0800 (PST)
Received: from localhost ([103.195.202.120])
        by smtp.gmail.com with ESMTPSA id gc1sm4068991pjb.20.2020.02.18.10.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 10:12:26 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 2/8] drivers: thermal: tsens: Pass around struct tsens_sensor as a constant
Date:   Tue, 18 Feb 2020 23:42:06 +0530
Message-Id: <57f5fd302213d30b53d9d6b3624758180e8df48b.1582048155.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the sensor data is initialised at init time. Lock it down by passing
it to functions as a constant.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens-8960.c   |  2 +-
 drivers/thermal/qcom/tsens-common.c | 14 +++++++-------
 drivers/thermal/qcom/tsens.h        |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index a383a57cfbbc..2a28a5af209e 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -245,7 +245,7 @@ static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
 	return adc_code * slope + offset;
 }
 
-static int get_temp_8960(struct tsens_sensor *s, int *temp)
+static int get_temp_8960(const struct tsens_sensor *s, int *temp)
 {
 	int ret;
 	u32 code, trdy;
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index c8d57ee0a5bb..c2df30a08b9e 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -128,7 +128,7 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
  * Return: Temperature in milliCelsius on success, a negative errno will
  * be returned in error cases
  */
-static int tsens_hw_to_mC(struct tsens_sensor *s, int field)
+static int tsens_hw_to_mC(const struct tsens_sensor *s, int field)
 {
 	struct tsens_priv *priv = s->priv;
 	u32 resolution;
@@ -160,7 +160,7 @@ static int tsens_hw_to_mC(struct tsens_sensor *s, int field)
  *
  * Return: ADC code or temperature in deciCelsius.
  */
-static int tsens_mC_to_hw(struct tsens_sensor *s, int temp)
+static int tsens_mC_to_hw(const struct tsens_sensor *s, int temp)
 {
 	struct tsens_priv *priv = s->priv;
 
@@ -275,7 +275,7 @@ static int tsens_threshold_violated(struct tsens_priv *priv, u32 hw_id,
 }
 
 static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
-				struct tsens_sensor *s, struct tsens_irq_data *d)
+				const struct tsens_sensor *s, struct tsens_irq_data *d)
 {
 	int ret;
 
@@ -346,10 +346,10 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
 
 	for (i = 0; i < priv->num_sensors; i++) {
 		bool trigger = false;
-		struct tsens_sensor *s = &priv->sensor[i];
+		const struct tsens_sensor *s = &priv->sensor[i];
 		u32 hw_id = s->hw_id;
 
-		if (IS_ERR(priv->sensor[i].tzd))
+		if (IS_ERR(s->tzd))
 			continue;
 		if (!tsens_threshold_violated(priv, hw_id, &d))
 			continue;
@@ -457,7 +457,7 @@ void tsens_disable_irq(struct tsens_priv *priv)
 	regmap_field_write(priv->rf[INT_EN], 0);
 }
 
-int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
+int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
 	int hw_id = s->hw_id;
@@ -486,7 +486,7 @@ int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
 	return 0;
 }
 
-int get_temp_common(struct tsens_sensor *s, int *temp)
+int get_temp_common(const struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
 	int hw_id = s->hw_id;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index be364bf1d5a6..70dc34c80537 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -67,7 +67,7 @@ struct tsens_ops {
 	/* mandatory callbacks */
 	int (*init)(struct tsens_priv *priv);
 	int (*calibrate)(struct tsens_priv *priv);
-	int (*get_temp)(struct tsens_sensor *s, int *temp);
+	int (*get_temp)(const struct tsens_sensor *s, int *temp);
 	/* optional callbacks */
 	int (*enable)(struct tsens_priv *priv, int i);
 	void (*disable)(struct tsens_priv *priv);
@@ -494,8 +494,8 @@ struct tsens_priv {
 char *qfprom_read(struct device *dev, const char *cname);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
 int init_common(struct tsens_priv *priv);
-int get_temp_tsens_valid(struct tsens_sensor *s, int *temp);
-int get_temp_common(struct tsens_sensor *s, int *temp);
+int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
+int get_temp_common(const struct tsens_sensor *s, int *temp);
 int tsens_enable_irq(struct tsens_priv *priv);
 void tsens_disable_irq(struct tsens_priv *priv);
 int tsens_set_trips(void *_sensor, int low, int high);
-- 
2.20.1

