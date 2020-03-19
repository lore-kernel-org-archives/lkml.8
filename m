Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55397C43332
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 05:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2784120724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 05:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RvT93Q2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCSFkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 01:40:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39708 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgCSFkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 01:40:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id m1so568540pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 22:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cyCIYRiG58oI2Jq7ZJtWmwccOTnDPz2E+ahBUJwhepg=;
        b=RvT93Q2HIVa2wQjAavOrQcjjvBzoTD2d/Vi0v4ILPVwAzX0dg8fy+LstszJeJ9LYsG
         h9Urt8EI4rk4+e+JOpzUihNvclfFm64LFGjzHeJcniNPXN0peBt+C/ibQMaALx8sQD57
         3PRx+NHS2yn3f097HiMTm8+qbDWAyTyHFLatvInITefZQ3pMOrsrYk7Oj++eHChUG5tD
         +KN0ICuFOTKxbEUJIGQmAsNH6J0MBbMjRdAXsvjYCye+2g0ymTjeM3oqw6cXinUmNni3
         Nma7XDkNIdwNBj70L4W7Ro3j8nxaMs8rq2kOlT0ehEWqTQhq8eelvuXlDq1su585cyIo
         cXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cyCIYRiG58oI2Jq7ZJtWmwccOTnDPz2E+ahBUJwhepg=;
        b=mN45Q3ytBCI61ilct6UG2ne59hTFm8KGwoj8+2wupvWtijSPNRE+sAh5ld3QB4ROaA
         ZNVkGMrft03Yin+785ai2+Irf3ReOrSMtoRHaS4O5b66j9el5YFs2Q2irgUORcFC9TSd
         0tTdUkvxqWWn8m9VzlkVtWI2uFfdHJyuQ8BIg77FDeKCTAFfQjQfvAUG+x1Jv9R9hJf9
         eEKkbYg2xJ2CGNatBww8kNGjbqyYZZ3GCMrpUKakrwjfSvnxjQjxZDo7i0J61gQpI3Mc
         om8keH0VzuVsEH9u4UTU0giWYO7op2nE+/ecHQ9WwudJcwZHY4f1zQVurAKmPHk9iXOX
         u74A==
X-Gm-Message-State: ANhLgQ03qFC9M/izfDbfGNHWeT34fo218/JkzPCP7zfcpjJWLdTHJvTX
        hT5WmUzPrBmttwbNkBHUsQ8c3A==
X-Google-Smtp-Source: ADFU+vsVQv/9+mfD/f1ED3jkHlTd7vOGHMk8SR9Qw3XEQH2G5U8b3qmKmp8Edz2JQuozbGE0tbBmxg==
X-Received: by 2002:a17:90a:2663:: with SMTP id l90mr1852159pje.188.1584596443916;
        Wed, 18 Mar 2020 22:40:43 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l125sm229126pgl.57.2020.03.18.22.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 22:40:43 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>
Subject: [PATCH 2/4] clk: qcom: mmcc-msm8996: Properly describe GPU_GX gdsc
Date:   Wed, 18 Mar 2020 22:39:00 -0700
Message-Id: <20200319053902.3415984-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200319053902.3415984-1-bjorn.andersson@linaro.org>
References: <20200319053902.3415984-1-bjorn.andersson@linaro.org>
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
 Documentation/devicetree/bindings/clock/qcom,mmcc.yaml | 4 ++++
 drivers/clk/qcom/mmcc-msm8996.c                        | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
index 85518494ce43..65d9aa790581 100644
--- a/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
@@ -67,6 +67,10 @@ properties:
     description:
        Protected clock specifier list as per common clock binding
 
+  vdd_gfx-supply:
+    description:
+      Regulator supply for the GPU_GX GDSC
+
 required:
   - compatible
   - reg
diff --git a/drivers/clk/qcom/mmcc-msm8996.c b/drivers/clk/qcom/mmcc-msm8996.c
index 6c7592ddf8bb..fd43a35db13b 100644
--- a/drivers/clk/qcom/mmcc-msm8996.c
+++ b/drivers/clk/qcom/mmcc-msm8996.c
@@ -3064,7 +3064,9 @@ static struct gdsc gpu_gx_gdsc = {
 		.name = "gpu_gx",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &gpu_gdsc.pd,
 	.flags = CLAMP_IO,
+	.supply = "vdd_gfx",
 };
 
 static struct clk_regmap *mmcc_msm8996_clocks[] = {
-- 
2.24.0

