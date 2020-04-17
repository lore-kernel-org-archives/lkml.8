Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C515C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB9621D91
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4bjOMVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgDQHBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgDQHBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:01:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A68CC03C1A7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 00:01:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x3so633146pfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 00:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffzp9Kx/9Feguerds3JewgyWlb5mJPvucz6Zy5UrO6o=;
        b=N4bjOMVjFE/KTqsJdI5p3UEjAQyPEEG3xNNkG7mjkY+SgnYGVah4pKGM5vT0VDIwJW
         t1O/6ZzeIOKlb8zO6NYN4egOsRzoR9IPAwBQRa3+Uz3cUG6tK+FRLaATtPAXqiSWFH5r
         vfTNkDd+vAbkBkgk7ywi19rXrO533ygRQENPZgaEOhxfQWC1yxNHPVHvwZP2UcyNWh+P
         y7VywLugAVhSTTvEVo7foEyI5z2IA2euN/pNz7SPJuPB3Ioyq28xbQN7I3If+mZ4ny68
         vX2AWm9oU0RGdVUDq3D9ivUaYspy/QdnYInQ/piPO3GwjHYYGVgcC/bOQFQPzH94nHEs
         RoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffzp9Kx/9Feguerds3JewgyWlb5mJPvucz6Zy5UrO6o=;
        b=jrQs6p7oWkT0DjbGJmGHEH4PSoG1QV+V4hEksN6ula+7EpNlRHgQ8DO2XHde7sWl3x
         VXd5M3NFmhgE+F4ozwtbcY+AncFRZZlQAUcvjVXbUtOMSxsYbEBskKLHBcR/JzZCySNi
         7u+jysNjKK/vFjp5FUT0r9NoQ+rKJbhG72S/oygVH/Sq7modnxUNKTWOR9hO0workhyg
         rZvE9kdPAcBwFMA9NKzkrW52d8Se/W9UO+LvWi6fh8PD1kLFL1Eiqs+TgYYhTSxqjxTr
         8eoYaqRuqu9i9tR8AFRxwuGYQxYXJ2GlQCYMJ+M4NVxEWteSbs9MeJPfrDoHXG43HQtg
         A0SA==
X-Gm-Message-State: AGi0Pub1Hb8cFp9RkA3aemzcQ/MGw95UKZptXR2m3bzDZsIcpW2T1cog
        3Ks1QHuJ0ArJ4mGFDtaubuzYOw==
X-Google-Smtp-Source: APiQypK+WugUyCOVGXvV9lrDjeTm6cJ1Ol1CBO5gmJifWOcICb4insgy672g8q2pfzAGGWrwFoOSgw==
X-Received: by 2002:aa7:94a8:: with SMTP id a8mr1730586pfl.44.1587106871993;
        Fri, 17 Apr 2020 00:01:11 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c125sm18561609pfa.142.2020.04.17.00.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 00:01:11 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] clk: qcom: mmcc-msm8996: Properly describe GPU_GX gdsc
Date:   Fri, 17 Apr 2020 00:00:42 -0700
Message-Id: <20200417070044.1376212-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200417070044.1376212-1-bjorn.andersson@linaro.org>
References: <20200417070044.1376212-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU_GX GDSC depends on both GPU GDSC being enabled and that the
VDD_GX rail is powered, so update the description of the node to cover
these requirements.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- vdd_gfx -> vdd-gfx

 Documentation/devicetree/bindings/clock/qcom,mmcc.yaml | 4 ++++
 drivers/clk/qcom/mmcc-msm8996.c                        | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
index acc31b3991bd..1b16a863b355 100644
--- a/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
@@ -67,6 +67,10 @@ properties:
     description:
        Protected clock specifier list as per common clock binding
 
+  vdd-gfx-supply:
+    description:
+      Regulator supply for the GPU_GX GDSC
+
 required:
   - compatible
   - reg
diff --git a/drivers/clk/qcom/mmcc-msm8996.c b/drivers/clk/qcom/mmcc-msm8996.c
index 6c7592ddf8bb..3b3aac07fb2d 100644
--- a/drivers/clk/qcom/mmcc-msm8996.c
+++ b/drivers/clk/qcom/mmcc-msm8996.c
@@ -3064,7 +3064,9 @@ static struct gdsc gpu_gx_gdsc = {
 		.name = "gpu_gx",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &gpu_gdsc.pd,
 	.flags = CLAMP_IO,
+	.supply = "vdd-gfx",
 };
 
 static struct clk_regmap *mmcc_msm8996_clocks[] = {
-- 
2.24.0

