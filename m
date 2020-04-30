Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA920C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 18:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F18320731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 18:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIx1oXjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgD3SBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 14:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbgD3SBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 14:01:30 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02149C08ED7D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:01:30 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id v63so157832pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ptgh2/1279PcmgwwRPQcmLMSq0T7hBYsw3s8yDo8jLI=;
        b=PIx1oXjrOK7BYxhAUE+LXwRfI/GBeEr4ErdwjOYMNGSaB4a9NUgrr9/zN7DYHZ4b8k
         UsSW8WXpaZvTSF5+idEz3jzZUl5Pa1USyJU5gA+OnhVHLwMo0DrUIpQMz4eVor/55qWg
         zOL56wRI1C7ug6sqZeAS8NXsxj22pXkzKJKKCbBhNOeF4RDd8PgMiEzrYoaffwhRuR2e
         ffET6v166TCBaNtoGF7Drj00Faal2lwUAUIcRJUrFn8ANwsfu0JoJv1B0nhNL6vKp5/v
         95hwCTtzAnEnntJCoPCRcdaO4iTJe3nKlRblHnW3mJ6hjs6SRWQqeUy+YrSJRayK0F39
         OilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ptgh2/1279PcmgwwRPQcmLMSq0T7hBYsw3s8yDo8jLI=;
        b=chWhABi8vqZqiKGOqxt6bstKMgJHHJEb7gnYykXT5zb9evBi/QvuACYxaD3XJ6lA1w
         3MxyQZfqKVws/b1uiDMpNPoCL5SD7u6Q6M2aMIsVrjrDVIEqO4o7B1dMHh3cceGQZbv1
         ecxfDxPuE9+VgZ11yLjJNRAk66gZPNQJzguBirikSSyPGi+jr9rA/CY/a/RFWJvhauMn
         F2syPOFsue9O2CcTaqPaTOFU1zdtsaGMukm0GCi0jr6Z7oe36lloxftpZ6ZxJjZWsm7t
         V4YhlxHowb75UZyaWPL/t3rR3udqP4Pzyizzvz32Bo9v+WzlGKpLNpyqZL3QIGqh8de/
         AXFg==
X-Gm-Message-State: AGi0Pub2xl2zeMyQytUzgXXN+SSuzS6n4k0bPud1nN3hvajT154HTm4N
        9xAHRuzrKmPr+YicY2Ym7D1iCQ==
X-Google-Smtp-Source: APiQypJ0DI4Z4f+sjCwlpGCk/Hib857vv5XoecESdXSZl9HnFZ8XO7QR6MZ+M/LyLNg3gwfpVswZYg==
X-Received: by 2002:aa7:9a4c:: with SMTP id x12mr492559pfj.263.1588269689346;
        Thu, 30 Apr 2020 11:01:29 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o68sm357741pfb.206.2020.04.30.11.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:01:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 2/2] remoteproc: qcom: pas: Add SM8250 PAS remoteprocs
Date:   Thu, 30 Apr 2020 11:00:51 -0700
Message-Id: <20200430180051.3795305-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200430180051.3795305-1-bjorn.andersson@linaro.org>
References: <20200430180051.3795305-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio, compute and sensor DSP compatibles to the Qualcomm PAS
binding and driver.

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Renamed adsp power-domains lcd and lmx

 drivers/remoteproc/qcom_q6v5_pas.c | 62 ++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index fc6658b523b6..efbc1777000a 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -508,6 +508,26 @@ static const struct adsp_data sm8150_adsp_resource = {
 		.ssctl_id = 0x14,
 };
 
+static const struct adsp_data sm8250_adsp_resource = {
+	.crash_reason_smem = 423,
+	.firmware_name = "adsp.mdt",
+	.pas_id = 1,
+	.has_aggre2_clk = false,
+	.auto_boot = true,
+	.active_pd_names = (char*[]){
+		"load_state",
+		NULL
+	},
+	.proxy_pd_names = (char*[]){
+		"lcx",
+		"lmx",
+		NULL
+	},
+	.ssr_name = "lpass",
+	.sysmon_name = "adsp",
+	.ssctl_id = 0x14,
+};
+
 static const struct adsp_data msm8998_adsp_resource = {
 		.crash_reason_smem = 423,
 		.firmware_name = "adsp.mdt",
@@ -553,6 +573,25 @@ static const struct adsp_data sm8150_cdsp_resource = {
 	.ssctl_id = 0x17,
 };
 
+static const struct adsp_data sm8250_cdsp_resource = {
+	.crash_reason_smem = 601,
+	.firmware_name = "cdsp.mdt",
+	.pas_id = 18,
+	.has_aggre2_clk = false,
+	.auto_boot = true,
+	.active_pd_names = (char*[]){
+		"load_state",
+		NULL
+	},
+	.proxy_pd_names = (char*[]){
+		"cx",
+		NULL
+	},
+	.ssr_name = "cdsp",
+	.sysmon_name = "cdsp",
+	.ssctl_id = 0x17,
+};
+
 static const struct adsp_data mpss_resource_init = {
 	.crash_reason_smem = 421,
 	.firmware_name = "modem.mdt",
@@ -604,6 +643,26 @@ static const struct adsp_data sm8150_slpi_resource = {
 		.ssctl_id = 0x16,
 };
 
+static const struct adsp_data sm8250_slpi_resource = {
+	.crash_reason_smem = 424,
+	.firmware_name = "slpi.mdt",
+	.pas_id = 12,
+	.has_aggre2_clk = false,
+	.auto_boot = true,
+	.active_pd_names = (char*[]){
+		"load_state",
+		NULL
+	},
+	.proxy_pd_names = (char*[]){
+		"lcx",
+		"lmx",
+		NULL
+	},
+	.ssr_name = "dsps",
+	.sysmon_name = "slpi",
+	.ssctl_id = 0x16,
+};
+
 static const struct adsp_data msm8998_slpi_resource = {
 		.crash_reason_smem = 424,
 		.firmware_name = "slpi.mdt",
@@ -644,6 +703,9 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sm8150-cdsp-pas", .data = &sm8150_cdsp_resource},
 	{ .compatible = "qcom,sm8150-mpss-pas", .data = &mpss_resource_init},
 	{ .compatible = "qcom,sm8150-slpi-pas", .data = &sm8150_slpi_resource},
+	{ .compatible = "qcom,sm8250-adsp-pas", .data = &sm8250_adsp_resource},
+	{ .compatible = "qcom,sm8250-cdsp-pas", .data = &sm8250_cdsp_resource},
+	{ .compatible = "qcom,sm8250-slpi-pas", .data = &sm8250_slpi_resource},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adsp_of_match);
-- 
2.24.0

