Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA43C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 470322076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTFVQpH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406498AbgFYTRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390701AbgFYTRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:17:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17A1C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so6643814wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dg6MQg0di+LqjBqONGXXxyBRvWh5krLOCNnRvvUvfe8=;
        b=VTFVQpH1dFYRfxcEVx1bIlmWtAfGkxcoZS/nr0pP6c8NX8FurH4xumCl5GhdhERzRX
         X0KxL66ekXPT18Cyga/sr+tr1CYTt42D4hLtbgE7yywKGiesUCemmKbz+hYBN4VYtJGZ
         6foOfmsUMOd/k+TR1XAcDur1OD9lKNpjlLA0ho0BMJ9jNKELA52kVOvYCl9NC4jCilog
         WNN6v9hYwpbq3/rOXyU2k70kRnhyxyodAQLYKiG7muWYTb7nOEGpM7futwBV6jayL3l6
         6eaeOJE1Xebfw7lDx3cmAjwkTTz0GPJkpiaJsxzbB+es+cm2P0hiSeOKGxuFiSX2ZgOE
         k+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dg6MQg0di+LqjBqONGXXxyBRvWh5krLOCNnRvvUvfe8=;
        b=sGa/GQLY5BqXnxsRI+I04uUsManqsKNB1zuT2Ke+W57gtF63QM1OuNuhGEvimuJYlk
         2mpvC2UyhOYOWZu9HAPzmx5nm6ZsyLsXmoxBSCa0YxDaoYI0tiiot729ol8lR56Jm/M/
         T63AY0CIv+/hr7xt5lh2Df/CenB6anKUT1vKTcR95I3caH+of1Xt3jLagTUYtQnwJjel
         YLffhmmrO+4H4Qeowk30hPRasODLQYMtsN+pET95lcT/hpJMPDmpb6ltqgA7dbIWfJKX
         fUEpLNcMKmlylaM+RtLgE9DXz3SrD3fk+NU6kjU4kiBetueF0nJBrURUYFLKj9mVLm6+
         lBrg==
X-Gm-Message-State: AOAM532QD7sLpjzYjeIabW0XFWL6nO4BwIkk+ktPvqWibiebUTy8/CdM
        wjyajXmPMHRhqbHsE8CEHrA/ZQ==
X-Google-Smtp-Source: ABdhPJwAKgulgVqfj13NpdmZBph65BTuF2FQs3d33CORBUFhvk4113wi68pqZxuDe+nzewP+3ZAlbw==
X-Received: by 2002:a7b:c381:: with SMTP id s1mr5308570wmj.25.1593112634724;
        Thu, 25 Jun 2020 12:17:14 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p13sm22693983wrn.0.2020.06.25.12.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:17:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [RESEND 01/10] regulator: consumer: Supply missing prototypes for 3 core functions
Date:   Thu, 25 Jun 2020 20:16:59 +0100
Message-Id: <20200625191708.4014533-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625191708.4014533-1-lee.jones@linaro.org>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
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

Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
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

