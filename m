Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F9CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4DD20775
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FzK8AnU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406378AbgFYQhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404328AbgFYQg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:36:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09077C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so6200725wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHyTnFgFhenMvt82ZPvmID/k33g654vFpjxfq56glsw=;
        b=FzK8AnU0x8SaPN9hkqDc4OZY4o+OqxxYwOVuP5tgHwZy56E0V7VKPPd1SUF+EQ8QVq
         mVglrjvkMeNBBXl4+XwQaqKiwd+O+7lzdJVEU1GOSsY1J5BrJKz0QX2holhriq6vaYRV
         HoWTnJf+JS2towXY3YhxVhGHVonJy0o4fxau2JaDJiULGHxaRf+9lftb1jMv/c58RNNz
         r6mJu4Jpw088ypgdxZuWBZTWC9Ic1GN4zPVZKg9NLkXRi6xhfc6/asVLYjCa/hCQKpnc
         9WtyAyhezLrDl8mVmKUOXMBZWTkOdXnwK7bA0IKzfN7TMz1RzhOBSPq36Xn+JwncLwQN
         IShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHyTnFgFhenMvt82ZPvmID/k33g654vFpjxfq56glsw=;
        b=X5jxmbjueQz1h1FOc3ndToTIBn5cr9/xn+/wlxeF19zSfEAfM9TNYQ6R5D6z/Qssep
         6323XMlFMfLTf3k6ubz5fcQ3fyvoHeXr1atYmRcHK97H63/IWYx3aVz9+XibzI2FZG7W
         z56TKt2i+YqYOnVRihHQBUrqazRTsHPtN8hWWD4WxrKfLkXykTTOaBWFBMM6WoU2Xnup
         VekPCplXjPCMvL/kLqQX+N4utq1FpKLQNFdnyUBFYkFUp5NHuS++vvjYPxSk1Siiqx8v
         ZCwogvhVgDYUibc3XJ0RCvDkbre3RicOPJyevFEAlN2BuzCOz8nWlbxY/eTrZmEeZ/zL
         Z9Tw==
X-Gm-Message-State: AOAM532TrXpv/FWsHzs7J4UYA1GCmVsFE7ReYnOBYIi0Ox9zTTJP5PsY
        2c5sg98f27W5ql/7NOjakehIFA==
X-Google-Smtp-Source: ABdhPJyVaKgIFOh4fci2JoxsGrqpAosiXDp3roJ2/u2guPJCC0MBxFkIz4vGYBqu4hPheEIXpNi6aQ==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr4353457wme.42.1593102984711;
        Thu, 25 Jun 2020 09:36:24 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id a15sm36729089wrh.54.2020.06.25.09.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:36:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 01/10] regulator: consumer: Supply missing prototypes for 3 core functions
Date:   Thu, 25 Jun 2020 17:36:05 +0100
Message-Id: <20200625163614.4001403-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163614.4001403-1-lee.jones@linaro.org>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regulator_suspend_enable(), regulator_suspend_disable() and
regulator_set_suspend_voltage() are all exported members of the
API, but are all missing prototypes.

Fixes the following W=1 warning(s):

 drivers/regulator/core.c:3805:5: warning: no previous prototype for ‘regulator_suspend_enable’ [-Wmissing-prototypes]
 3805 | int regulator_suspend_enable(struct regulator_dev *rdev,
 | ^~~~~~~~~~~~~~~~~~~~~~~~
 drivers/regulator/core.c:3812:5: warning: no previous prototype for ‘regulator_suspend_disable’ [-Wmissing-prototypes]
 3812 | int regulator_suspend_disable(struct regulator_dev *rdev,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/regulator/core.c:3851:5: warning: no previous prototype for ‘regulator_set_suspend_voltage’ [-Wmissing-prototypes]
 3851 | int regulator_set_suspend_voltage(struct regulator *regulator, int min_uV,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/regulator/consumer.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 6a92fd3105a31..2024944fd2f78 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -32,10 +32,12 @@
 #define __LINUX_REGULATOR_CONSUMER_H_
 
 #include <linux/err.h>
+#include <linux/suspend.h>
 
 struct device;
 struct notifier_block;
 struct regmap;
+struct regulator_dev;
 
 /*
  * Regulator operating modes.
@@ -277,6 +279,14 @@ int regulator_unregister_notifier(struct regulator *regulator,
 void devm_regulator_unregister_notifier(struct regulator *regulator,
 					struct notifier_block *nb);
 
+/* regulator suspend */
+int regulator_suspend_enable(struct regulator_dev *rdev,
+			     suspend_state_t state);
+int regulator_suspend_disable(struct regulator_dev *rdev,
+			      suspend_state_t state);
+int regulator_set_suspend_voltage(struct regulator *regulator, int min_uV,
+				  int max_uV, suspend_state_t state);
+
 /* driver data - core doesn't touch */
 void *regulator_get_drvdata(struct regulator *regulator);
 void regulator_set_drvdata(struct regulator *regulator, void *data);
-- 
2.25.1

