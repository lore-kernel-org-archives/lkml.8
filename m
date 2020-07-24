Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833B4C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A69B2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RA9SUATS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgGXIEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGXIEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:04:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C5DC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 01:04:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so4818327pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 01:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uqirvcFMc70uC94GyEknvwJsqOJX3sShmxejjT9FWhA=;
        b=RA9SUATSXAXcFwNQmkQO44BYBHtivdwf9c36nd4KOMg+YMlimEGNcxYbm0lm9oOPKd
         2Xj1L8KbVYuJtzH2KW7Sf7dTjxIszT3OzNaj6CAYZ8ADakNuUyq1zj3bohEXiZOXSkzg
         OvlfNZT5Nh6cvFcNqcYK1GjM0FxrSAUGcL63I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uqirvcFMc70uC94GyEknvwJsqOJX3sShmxejjT9FWhA=;
        b=Uy+ESTAWROG/DGLDBTpd+r4TFzrT0EjOv4ILpwmhBr8bTzrjcPm1hByrjukpCdi6Pp
         UBrie2934Czghuhm5uH/83vTA8iQJtsFUFiRNLvcDJNFPN/unYbNu/yBjmBOVxmfR6Kx
         /h9vXaF/j1eUjp5ZDJeqqiABMgc1fpEAfT/uXxRPiySls8rJCz5yyTqFu17S7WqPOBWH
         iOKC/JdDCI7mSGsy7M/fnebnkZfeA4tF0ZrWzgCUBDgUMjBC0TjRyFpjJMoWVve9lJVK
         1WF4aZsvGN/ZoNrmTcrPtPY+edySxkjJVH9dvFbVxoo8Q08aqwGykmO6JdAP2BdSBsfH
         VJ7w==
X-Gm-Message-State: AOAM531T2uh9R13YkTXf5CqmkmB/cFWE9gxuIDagCKz8rqXc6zVzLuMG
        GWgiDD+J7TJve0QWErDv5ZLfSg==
X-Google-Smtp-Source: ABdhPJz8do2aMWZiBjG+9jYtdOHslug9YNp9NdrXqG/FEyORXA8aCULw37pV0rsyD5EAgMgRBHyD7w==
X-Received: by 2002:a62:758b:: with SMTP id q133mr7918437pfc.289.1595577846817;
        Fri, 24 Jul 2020 01:04:06 -0700 (PDT)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id l17sm5578583pgn.48.2020.07.24.01.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 01:04:05 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Yicheng Li <yichengli@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] platform/chrome: cros_ec: Fix host command for regulator control.
Date:   Fri, 24 Jul 2020 16:03:55 +0800
Message-Id: <20200724080358.619245-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the host command number 0x012B conflicts with other EC host
command, add one to all regulator control related host command.

Also fix a wrong alignment on struct and sync the comment with the one
in ChromeOS EC codebase.

Fixes: dff08caf35ec ("platform/chrome: cros_ec: Add command for regulator control.")
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
The original numbers were chosen before the 0x012B is used in ChromeOS
EC codebase. Since the original kernel patch got accepted before the
corresponding commit in ChromeOS EC codebase got merged, the host
command number was used by other commit first.

Since now the commit in ChromeOS EC codebase
(https://crrev.com/c/2247431) with updated host command numbers got
merged, need this patch to sync up the host command numbers with
ChromeOS EC codebase. Sorry for the confusion.
---
 include/linux/platform_data/cros_ec_commands.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index a417b51b5764..91e77f53414d 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -5438,7 +5438,7 @@ struct ec_response_rollback_info {
  *
  * Returns the regulator name and supported voltage list in mV.
  */
-#define EC_CMD_REGULATOR_GET_INFO 0x012B
+#define EC_CMD_REGULATOR_GET_INFO 0x012C
 
 /* Maximum length of regulator name */
 #define EC_REGULATOR_NAME_MAX_LEN 16
@@ -5454,12 +5454,12 @@ struct ec_response_regulator_get_info {
 	char name[EC_REGULATOR_NAME_MAX_LEN];
 	uint16_t num_voltages;
 	uint16_t voltages_mv[EC_REGULATOR_VOLTAGE_MAX_COUNT];
-} __ec_align1;
+} __ec_align2;
 
 /*
  * Configure the regulator as enabled / disabled.
  */
-#define EC_CMD_REGULATOR_ENABLE 0x012C
+#define EC_CMD_REGULATOR_ENABLE 0x012D
 
 struct ec_params_regulator_enable {
 	uint32_t index;
@@ -5471,7 +5471,7 @@ struct ec_params_regulator_enable {
  *
  * Returns 1 if the regulator is enabled, 0 if not.
  */
-#define EC_CMD_REGULATOR_IS_ENABLED 0x012D
+#define EC_CMD_REGULATOR_IS_ENABLED 0x012E
 
 struct ec_params_regulator_is_enabled {
 	uint32_t index;
@@ -5489,7 +5489,7 @@ struct ec_response_regulator_is_enabled {
  * Also note that this might be called before the regulator is enabled, and the
  * setting should be in effect after the regulator is enabled.
  */
-#define EC_CMD_REGULATOR_SET_VOLTAGE 0x012E
+#define EC_CMD_REGULATOR_SET_VOLTAGE 0x012F
 
 struct ec_params_regulator_set_voltage {
 	uint32_t index;
@@ -5500,9 +5500,10 @@ struct ec_params_regulator_set_voltage {
 /*
  * Get the currently configured voltage for the voltage regulator.
  *
- * Note that this might be called before the regulator is enabled.
+ * Note that this might be called before the regulator is enabled, and this
+ * should return the configured output voltage if the regulator is enabled.
  */
-#define EC_CMD_REGULATOR_GET_VOLTAGE 0x012F
+#define EC_CMD_REGULATOR_GET_VOLTAGE 0x0130
 
 struct ec_params_regulator_get_voltage {
 	uint32_t index;

base-commit: 8d9f8d57e023893bfa708d83e3a787e77766a378
-- 
2.28.0.rc0.142.g3c755180ce-goog

