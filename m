Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13F3C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 05:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999C52072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 05:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFUErapf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgCSFko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 01:40:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46084 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCSFkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 01:40:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id y30so614160pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 22:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VjRbI/Qcy2ZipTYHWuUTokoOEV5DVKKVy86kR+PhWiE=;
        b=FFUErapf5Y2xQAQXCjZUnjfCRN0y0A0wXHXw/sJjUknTYFS2v99P/qu6S388LrmOBm
         WLQv+cq5ggJaBRDLDscsPzceMAR4Ms8QpkQ2bX8IBLhuFHBxHfIPq1m2LbgMU4MM1by+
         NUPMaf8roA6uBTCE3QIQs1E4S6LoODWGK7/yl06GM+eQ75gKvAWjElYhZ6WYdomNYDxg
         XJHKMLQDANCKHRwGmr6mUwcaTQOpMDyIggWwmZmDx0Mesp/M8ucO9QmwOTm3oG8IUdxT
         C+bR2+rPRQYoK3OofEwW0JSBzL1nrf90wfYGe3UDT2fWVttqFZcBgDkUAYwdb++3iwVJ
         9JXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VjRbI/Qcy2ZipTYHWuUTokoOEV5DVKKVy86kR+PhWiE=;
        b=KQcDZeqcDgxn+yUDG07zGAdmyf/lwJt5cUp4wyK8FWGScQIyy9JKQBOZCoE1uLyh9H
         MDvmviOr0T9Q7n67jeYTk9mB5hqiUF7FwEr5Vd5800IrCBTopORe6nymvvks5zeT/xu7
         zQefWTR+9JdOHdsulqLm5iitxhFOkNybrjfg6cZjOvCauxTCqJ5XAm4AoAWCxgFE6eNf
         L0J1a86WFcYYMVr1cuNxpW7x7nAr/IYtr2axIlaBI4FXiBdULVp6ZURiCvvMctS5jUk1
         6j46csYUfgbTDvCpewAuz12wiY31zMzRdCfnxfoPSUsKTWGWmdZwdI9zd2W+/Th+9gbR
         jXDQ==
X-Gm-Message-State: ANhLgQ2C36Vma5MVmY2+CdwyrrptPT2jlcBu8Y1r8cj/n76Eob/Rz8CF
        Lp+GrVZ6vz/cybYhG3zZjU8exQ==
X-Google-Smtp-Source: ADFU+vvvpauezbIT9XfVdGer93wUikobvBaeW9uRALrfaX66+M/F4eSbIFlcahvLdahCTb5waovbRA==
X-Received: by 2002:aa7:8ec1:: with SMTP id b1mr2136428pfr.125.1584596442589;
        Wed, 18 Mar 2020 22:40:42 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l125sm229126pgl.57.2020.03.18.22.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 22:40:41 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH 1/4] clk: qcom: gdsc: Handle GDSC regulator supplies
Date:   Wed, 18 Mar 2020 22:38:59 -0700
Message-Id: <20200319053902.3415984-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200319053902.3415984-1-bjorn.andersson@linaro.org>
References: <20200319053902.3415984-1-bjorn.andersson@linaro.org>
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
 drivers/clk/qcom/gdsc.c | 24 ++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index a250f59708d8..3528789cc9d0 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -13,6 +13,7 @@
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
+#include <linux/regulator/consumer.h>
 #include "gdsc.h"
 
 #define PWR_ON_MASK		BIT(31)
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
 
@@ -371,6 +385,16 @@ int gdsc_register(struct gdsc_desc *desc,
 	if (!data->domains)
 		return -ENOMEM;
 
+	/* Resolve any regulator supplies */
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

