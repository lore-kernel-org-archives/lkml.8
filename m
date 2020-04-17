Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217C4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D1821D91
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="civ0gk1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgDQHBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgDQHBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:01:12 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E636C061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 00:01:11 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x3so633113pfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 00:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yknmXxbqGxVfxrNz0jvbTW2mgVTxtXbV4FI/gCIqcjM=;
        b=civ0gk1keolqnPGVaUGkyNSJDvVGU8ajyEYU3VaMBeM0lgdwWv5cMHq80pGerPytVm
         XBJXBtZa38KYD3dTapc4WNr9WFNQbJBFIu7KWxHcnyby2tihC4fsexPQQCQClq40NVyV
         aVve2BQivQFk9fn4IjdsAfwQLVfheYEWGhHWn9wpcpRkv8qBSsux16mO8yrr41qZJ8ZI
         vQbG4WQTcBVJ/ais/d6KHidfArAzBMss1PQEPe8ebx3Cg1V+QwasTyRFb2vm4SdaQSSL
         BO/MjafY2c6wQkij+Bv8W+OCVT+iSYl8CJdx3YADy4+60SCTiGfHILXYq+H175/xlLQj
         3/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yknmXxbqGxVfxrNz0jvbTW2mgVTxtXbV4FI/gCIqcjM=;
        b=MXL+aTERhfNUcmNKHhGVCwgxoL7swKVUy6pJAZszREfDkFBhvlzbLsiBYNESxS+W/v
         vda/IOi5r8NU3DaIVm2cOX0zLXxosMC1ZY92y8NbUPVAxydXShodM4qULrE/l5t5fXML
         G1f2gUQDX/Wx0B4GDlEBTd1TOrSZbTY62ceK/rr90gIVdrHrmAYewNUBv8QfHYoOAxMI
         JXm66VkK9eZGvR6k7eaF2guzN0cqFnTmPcUgxfNw3DaTqCp+WNy7QyceFaUAJp1h2NbL
         8L3yrc74t+jmJqZwT93beEjT6is7g9OJdaaxkLFm5ry+Fd9lkTME38fjOOHvbEgFRRIu
         TcYA==
X-Gm-Message-State: AGi0PuZIz2O8i7NaC7+4HPMWFyZCvqDj7wHZrt98TfqJuiaIUJqjoOYv
        vpWwpsKwIFnGFXzxBCGRMrJfYA==
X-Google-Smtp-Source: APiQypLVvbrjumlCLlmTCPuXNewSaDSHjE0x0aDETbToJCw1qIkwOjllFHprFIl39+UtGyokRT4g1Q==
X-Received: by 2002:a05:6a00:2cf:: with SMTP id b15mr1777440pft.174.1587106870611;
        Fri, 17 Apr 2020 00:01:10 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c125sm18561609pfa.142.2020.04.17.00.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 00:01:09 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] clk: qcom: gdsc: Handle GDSC regulator supplies
Date:   Fri, 17 Apr 2020 00:00:41 -0700
Message-Id: <20200417070044.1376212-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200417070044.1376212-1-bjorn.andersson@linaro.org>
References: <20200417070044.1376212-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain GDSCs, such as the GPU_GX on MSM8996, requires that the upstream
regulator supply is powered in order to be turned on.

It's not guaranteed that the bootloader will leave these supplies on and
the driver core will attempt to enable any GDSCs before allowing the
individual drivers to probe defer on the PMIC regulator driver not yet
being present.

So the gdsc driver needs to be made aware of supplying regulators and
probe defer on their absence, and it needs to enable and disable the
regulator accordingly.

Voltage adjustments of the supplying regulator are deferred to the
client drivers themselves.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Sorted includes
- Dropped unnecessary comment

 drivers/clk/qcom/gdsc.c | 23 +++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index a250f59708d8..04944f11659b 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -11,6 +11,7 @@
 #include <linux/ktime.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
 #include "gdsc.h"
@@ -112,6 +113,12 @@ static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status)
 	int ret;
 	u32 val = (status == GDSC_ON) ? 0 : SW_COLLAPSE_MASK;
 
+	if (status == GDSC_ON && sc->rsupply) {
+		ret = regulator_enable(sc->rsupply);
+		if (ret < 0)
+			return ret;
+	}
+
 	ret = regmap_update_bits(sc->regmap, sc->gdscr, SW_COLLAPSE_MASK, val);
 	if (ret)
 		return ret;
@@ -143,6 +150,13 @@ static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status)
 
 	ret = gdsc_poll_status(sc, status);
 	WARN(ret, "%s status stuck at 'o%s'", sc->pd.name, status ? "ff" : "n");
+
+	if (!ret && status == GDSC_OFF && sc->rsupply) {
+		ret = regulator_disable(sc->rsupply);
+		if (ret < 0)
+			return ret;
+	}
+
 	return ret;
 }
 
@@ -371,6 +385,15 @@ int gdsc_register(struct gdsc_desc *desc,
 	if (!data->domains)
 		return -ENOMEM;
 
+	for (i = 0; i < num; i++) {
+		if (!scs[i] || !scs[i]->supply)
+			continue;
+
+		scs[i]->rsupply = devm_regulator_get(dev, scs[i]->supply);
+		if (IS_ERR(scs[i]->rsupply))
+			return PTR_ERR(scs[i]->rsupply);
+	}
+
 	data->num_domains = num;
 	for (i = 0; i < num; i++) {
 		if (!scs[i])
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 64cdc8cf0d4d..c36fc26dcdff 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -10,6 +10,7 @@
 #include <linux/pm_domain.h>
 
 struct regmap;
+struct regulator;
 struct reset_controller_dev;
 
 /**
@@ -52,6 +53,9 @@ struct gdsc {
 	struct reset_controller_dev	*rcdev;
 	unsigned int			*resets;
 	unsigned int			reset_count;
+
+	const char 			*supply;
+	struct regulator		*rsupply;
 };
 
 struct gdsc_desc {
-- 
2.24.0

