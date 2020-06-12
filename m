Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E9AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 04:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A9320801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 04:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gnXZmq2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgFLEFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 00:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgFLEFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 00:05:45 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5180C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 21:05:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bg4so3219071plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 21:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7KT5I7U1YXhD3nQj1u4RH7XpnG0VmMFsKPtB+Swx1E=;
        b=gnXZmq2psjWMV3e8rEyFIJF4IaB8OqsvNdfEdKbLT+8uAGTVbmRjHkxRLpJAQcn28A
         D7vWLI2qJ907fFzOlx224ZlCikagvhMV/WRQ2rbkL1rOz5idaraQIe05eKIHRxS+TIK4
         90TlWIFNforFuw0IOktbYOw9MeBl9jrPFCtCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7KT5I7U1YXhD3nQj1u4RH7XpnG0VmMFsKPtB+Swx1E=;
        b=L3cMXZgqXAR4KVbJg4YQvBBBkgp4XGWBlzoK29efq7X6Dvow/WBxuoupxfsLE36wwQ
         RiSd1cNnqL9Q6PLi/rk7x5jb5DSjNp4Fz0Vn5bYlgpFlmgj+bjROVIyp0d8/kB/uYjTO
         +G7+2BWLyCRpcbjYL81+mQYtEe8kqDtTNjMY9ntUAjA1VRGmZT9xAtvT6v0NUSHMjc6I
         QH6/dYt5eAzi6S5cGsU9/yFRQGG5SwD3l6ycNevEddXfBGT2SM8dInr01DCCDDCouSU2
         QMo4fq/5sQARNtwWAakg+8N5cRX0UOCrUR/T+Mhqtj2qoGMVe5/MM2TkDgrbOXkwukke
         XaiA==
X-Gm-Message-State: AOAM532arG8kYunrPKACsp5K6KAMi801/rJtPdaofiYUquM5XVTn76cU
        Srgb6tmnYRwJ/mYYVoXGYU+7ig==
X-Google-Smtp-Source: ABdhPJxqzcJDHNMHJ1fqwkwHZenKSmgHGRdImTU41q+wNz1qkqCGc7a70RFcGYA+3r2tb28vHV7x+w==
X-Received: by 2002:a17:90a:20c2:: with SMTP id f60mr11663887pjg.29.1591934743371;
        Thu, 11 Jun 2020 21:05:43 -0700 (PDT)
Received: from pihsun-glaptop.lan (180-176-97-18.dynamic.kbronet.com.tw. [180.176.97.18])
        by smtp.googlemail.com with ESMTPSA id u7sm4686983pfu.162.2020.06.11.21.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 21:05:42 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Yicheng Li <yichengli@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 2/3] platform/chrome: cros_ec: Add command for regulator control.
Date:   Fri, 12 Jun 2020 12:05:19 +0800
Message-Id: <20200612040526.192878-3-pihsun@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200612040526.192878-1-pihsun@chromium.org>
References: <20200612040526.192878-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add host commands for voltage regulator control through ChromeOS EC.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes from v5:
* Extract into a separate patch.
---
 drivers/platform/chrome/cros_ec_trace.c       |  5 ++
 .../linux/platform_data/cros_ec_commands.h    | 82 +++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
index 523a39bd0ff6..425e9441b7ca 100644
--- a/drivers/platform/chrome/cros_ec_trace.c
+++ b/drivers/platform/chrome/cros_ec_trace.c
@@ -161,6 +161,11 @@
 	TRACE_SYMBOL(EC_CMD_ADC_READ), \
 	TRACE_SYMBOL(EC_CMD_ROLLBACK_INFO), \
 	TRACE_SYMBOL(EC_CMD_AP_RESET), \
+	TRACE_SYMBOL(EC_CMD_REGULATOR_GET_INFO), \
+	TRACE_SYMBOL(EC_CMD_REGULATOR_ENABLE), \
+	TRACE_SYMBOL(EC_CMD_REGULATOR_IS_ENABLED), \
+	TRACE_SYMBOL(EC_CMD_REGULATOR_SET_VOLTAGE), \
+	TRACE_SYMBOL(EC_CMD_REGULATOR_GET_VOLTAGE), \
 	TRACE_SYMBOL(EC_CMD_CR51_BASE), \
 	TRACE_SYMBOL(EC_CMD_CR51_LAST), \
 	TRACE_SYMBOL(EC_CMD_FP_PASSTHRU), \
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 69210881ebac..a417b51b5764 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -5430,6 +5430,88 @@ struct ec_response_rollback_info {
 /* Issue AP reset */
 #define EC_CMD_AP_RESET 0x0125
 
+/*****************************************************************************/
+/* Voltage regulator controls */
+
+/*
+ * Get basic info of voltage regulator for given index.
+ *
+ * Returns the regulator name and supported voltage list in mV.
+ */
+#define EC_CMD_REGULATOR_GET_INFO 0x012B
+
+/* Maximum length of regulator name */
+#define EC_REGULATOR_NAME_MAX_LEN 16
+
+/* Maximum length of the supported voltage list. */
+#define EC_REGULATOR_VOLTAGE_MAX_COUNT 16
+
+struct ec_params_regulator_get_info {
+	uint32_t index;
+} __ec_align4;
+
+struct ec_response_regulator_get_info {
+	char name[EC_REGULATOR_NAME_MAX_LEN];
+	uint16_t num_voltages;
+	uint16_t voltages_mv[EC_REGULATOR_VOLTAGE_MAX_COUNT];
+} __ec_align1;
+
+/*
+ * Configure the regulator as enabled / disabled.
+ */
+#define EC_CMD_REGULATOR_ENABLE 0x012C
+
+struct ec_params_regulator_enable {
+	uint32_t index;
+	uint8_t enable;
+} __ec_align4;
+
+/*
+ * Query if the regulator is enabled.
+ *
+ * Returns 1 if the regulator is enabled, 0 if not.
+ */
+#define EC_CMD_REGULATOR_IS_ENABLED 0x012D
+
+struct ec_params_regulator_is_enabled {
+	uint32_t index;
+} __ec_align4;
+
+struct ec_response_regulator_is_enabled {
+	uint8_t enabled;
+} __ec_align1;
+
+/*
+ * Set voltage for the voltage regulator within the range specified.
+ *
+ * The driver should select the voltage in range closest to min_mv.
+ *
+ * Also note that this might be called before the regulator is enabled, and the
+ * setting should be in effect after the regulator is enabled.
+ */
+#define EC_CMD_REGULATOR_SET_VOLTAGE 0x012E
+
+struct ec_params_regulator_set_voltage {
+	uint32_t index;
+	uint32_t min_mv;
+	uint32_t max_mv;
+} __ec_align4;
+
+/*
+ * Get the currently configured voltage for the voltage regulator.
+ *
+ * Note that this might be called before the regulator is enabled.
+ */
+#define EC_CMD_REGULATOR_GET_VOLTAGE 0x012F
+
+struct ec_params_regulator_get_voltage {
+	uint32_t index;
+} __ec_align4;
+
+struct ec_response_regulator_get_voltage {
+	uint32_t voltage_mv;
+} __ec_align4;
+
 /*****************************************************************************/
 /* The command range 0x200-0x2FF is reserved for Rotor. */
 
-- 
2.27.0.290.gba653c62da-goog

