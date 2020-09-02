Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CFDC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA9F20678
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599060950;
	bh=uEEbF9O3LOrdRnl2MqtSWAvJvl+wM/QUWvrcJodDPZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=chQ/hoXIy+4VPCoDNkDcNCkESVEEMGMB9dt8T/t9IP4rJJ9qpEVaBPKw7mj7nKw+A
	 x02fscbJN/AECFUmOXMZ5dwjjsgRFQe7isoN80MuCaysso0Mxkn85i/afHTucDpH4N
	 LKeAB/8yUWcXv0sJpem9lbDEmjT6RXlPAw9RXhrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgIBPfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:35:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgIBPEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:04:35 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E1BD2087D;
        Wed,  2 Sep 2020 15:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599059074;
        bh=uEEbF9O3LOrdRnl2MqtSWAvJvl+wM/QUWvrcJodDPZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBzOJ21aMi6+2TWRrPDyOJ2Hyhsd4uABRvoBrBRJrIaI4sjLi12ulks+GIT2ES0xb
         7tiDdl9lJipBdQsMJr8sO11mYUbz6ze+903R+iQwc8WogKPHBYTLxMRv5X2jZusshJ
         TBAKgCaTGVljaZQbXuezcbx7a4CSKNQRCnwR+EM8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 08/10] clk: qcom: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 17:03:46 +0200
Message-Id: <20200902150348.14465-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902150348.14465-1-krzk@kernel.org>
References: <20200902150348.14465-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/qcom/apcs-msm8916.c      |  9 +++------
 drivers/clk/qcom/clk-spmi-pmic-div.c | 10 ++++------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/qcom/apcs-msm8916.c b/drivers/clk/qcom/apcs-msm8916.c
index cf69a97d0439..5e85625b1d02 100644
--- a/drivers/clk/qcom/apcs-msm8916.c
+++ b/drivers/clk/qcom/apcs-msm8916.c
@@ -77,12 +77,9 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	a53cc->parent_map = gpll0_a53cc_map;
 
 	a53cc->pclk = devm_clk_get(parent, NULL);
-	if (IS_ERR(a53cc->pclk)) {
-		ret = PTR_ERR(a53cc->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get clk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(a53cc->pclk))
+		return dev_err_probe(dev, PTR_ERR(a53cc->pclk),
+				     "failed to get clk\n");
 
 	a53cc->clk_nb.notifier_call = a53cc_notifier_cb;
 	ret = clk_notifier_register(a53cc->pclk, &a53cc->clk_nb);
diff --git a/drivers/clk/qcom/clk-spmi-pmic-div.c b/drivers/clk/qcom/clk-spmi-pmic-div.c
index f2cf55cee2fd..3088050fb016 100644
--- a/drivers/clk/qcom/clk-spmi-pmic-div.c
+++ b/drivers/clk/qcom/clk-spmi-pmic-div.c
@@ -237,12 +237,10 @@ static int spmi_pmic_clkdiv_probe(struct platform_device *pdev)
 	cc->nclks = nclks;
 
 	cxo = clk_get(dev, "xo");
-	if (IS_ERR(cxo)) {
-		ret = PTR_ERR(cxo);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get xo clock\n");
-		return ret;
-	}
+	if (IS_ERR(cxo))
+		return dev_err_probe(dev, PTR_ERR(cxo),
+				     "failed to get xo clock\n");
+
 	cxo_hz = clk_get_rate(cxo);
 	clk_put(cxo);
 
-- 
2.17.1

