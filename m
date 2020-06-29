Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2C9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8FA62063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="cakXMdhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391425AbgF2VoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgF2Shr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:47 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C2BC031433
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:21:12 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id g11so8004262qvs.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MEAgnaM7D2mpY2dMCdUXKcsS9ZNQb7s4gUJ6O4bO1VY=;
        b=cakXMdhcddci1jYVi33hSFcTaWjtdUzX5bG+pUizoRKtavcztv5pEaTMcR3xhC3pwc
         +oFlbm5GPeRBw6/yBHNsb2PyDNdKFFm6cLRFu/zWPqDKIvOXOvdhN1DSUWkxKIG6LYo7
         7kuDTw4b5e4x8NwN5PFfMI26gd4OmiBKT4kbnvRmOOO/rEe0QQoio1VL2pUsNlGYIY9h
         eY/oYmNlpRRKzpOVUzXibc/63n8GQvOUrjdP4mAiJ865Fn2NvzdH9ZhPFjWhgcGc/urt
         gOmvnB8AoQFacwoRRRA8YESi0slDXE6DWDqu7dZyzgerrRtYZ0jk90J5sX3fxzoWzuAP
         JPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MEAgnaM7D2mpY2dMCdUXKcsS9ZNQb7s4gUJ6O4bO1VY=;
        b=IlifVuitvla5/NpssykOHZantf5ENwmsMXEey6bvRJw1FWqpUuDPAXFGjs0eIzUC6x
         QqUz0VDqg9Fbnq42zCCS/q1ZDeje7kVk9sP2Ihvak5Ls+fB1biI7ZRTPPQXrl7jMZmie
         QPlkSxt/n3MHzN8nWrezzkylGe+5vPfMSNejIA+RWbU3lW/VaFByerwYJmV/oYrNx3kg
         fStnLv8cSn3ncx5gjMlxvXS6GVxACFipt4G1UK+JA/ncnDWf+2X0j7g0RLPdoAT5GgXH
         TxZx6vAoNTVIzDEdvlBi319PuJd3z4/jdlIXs1n1MKwE6Za/yIhED17cxs0bP5QS9Mi1
         UdJA==
X-Gm-Message-State: AOAM5321Rc+u69DYzKloXd+3YW5xUbPlnCxaO2mzh8IdskWDCAZPuD7M
        ghApJYK54M15k2OPqoDRa7vweQ==
X-Google-Smtp-Source: ABdhPJyaLd6au1/0WA+lxGsA1HcU8jMvhnK/QtKjdcrss2tNZZ0jSr2bU65AOstsV9I+9d+Bn3UceA==
X-Received: by 2002:a05:6214:9af:: with SMTP id du15mr16068477qvb.188.1593451271974;
        Mon, 29 Jun 2020 10:21:11 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id q5sm408363qtf.12.2020.06.29.10.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 10:21:11 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 08/13] clk: qcom: add common gdsc_gx_do_nothing_enable for gpucc drivers
Date:   Mon, 29 Jun 2020 13:20:38 -0400
Message-Id: <20200629172049.30452-9-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200629172049.30452-1-jonathan@marek.ca>
References: <20200629172049.30452-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All gpucc drivers need this, so move it to common code instead of
duplicating it in every gpucc driver.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/clk/qcom/gdsc.c         | 25 +++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h         |  1 +
 drivers/clk/qcom/gpucc-sc7180.c | 27 +--------------------------
 drivers/clk/qcom/gpucc-sdm845.c | 27 +--------------------------
 4 files changed, 28 insertions(+), 52 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 04944f11659b..628397703717 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -433,3 +433,28 @@ void gdsc_unregister(struct gdsc_desc *desc)
 	}
 	of_genpd_del_provider(dev->of_node);
 }
+
+/*
+ * On SDM845+ the GPU GX domain is *almost* entirely controlled by the GMU
+ * running in the CX domain so the CPU doesn't need to know anything about the
+ * GX domain EXCEPT....
+ *
+ * Hardware constraints dictate that the GX be powered down before the CX. If
+ * the GMU crashes it could leave the GX on. In order to successfully bring back
+ * the device the CPU needs to disable the GX headswitch. There being no sane
+ * way to reach in and touch that register from deep inside the GPU driver we
+ * need to set up the infrastructure to be able to ensure that the GPU can
+ * ensure that the GX is off during this super special case. We do this by
+ * defining a GX gdsc with a dummy enable function and a "default" disable
+ * function.
+ *
+ * This allows us to attach with genpd_dev_pm_attach_by_name() in the GPU
+ * driver. During power up, nothing will happen from the CPU (and the GMU will
+ * power up normally but during power down this will ensure that the GX domain
+ * is *really* off - this gives us a semi standard way of doing what we need.
+ */
+int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
+{
+	/* Do nothing but give genpd the impression that we were successful */
+	return 0;
+}
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index c36fc26dcdff..1896bfb2bbd1 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -68,6 +68,7 @@ struct gdsc_desc {
 int gdsc_register(struct gdsc_desc *desc, struct reset_controller_dev *,
 		  struct regmap *);
 void gdsc_unregister(struct gdsc_desc *desc);
+int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain);
 #else
 static inline int gdsc_register(struct gdsc_desc *desc,
 				struct reset_controller_dev *rcdev,
diff --git a/drivers/clk/qcom/gpucc-sc7180.c b/drivers/clk/qcom/gpucc-sc7180.c
index 7b656b6aeced..88a739b6fec3 100644
--- a/drivers/clk/qcom/gpucc-sc7180.c
+++ b/drivers/clk/qcom/gpucc-sc7180.c
@@ -170,37 +170,12 @@ static struct gdsc cx_gdsc = {
 	.flags = VOTABLE,
 };
 
-/*
- * On SC7180 the GPU GX domain is *almost* entirely controlled by the GMU
- * running in the CX domain so the CPU doesn't need to know anything about the
- * GX domain EXCEPT....
- *
- * Hardware constraints dictate that the GX be powered down before the CX. If
- * the GMU crashes it could leave the GX on. In order to successfully bring back
- * the device the CPU needs to disable the GX headswitch. There being no sane
- * way to reach in and touch that register from deep inside the GPU driver we
- * need to set up the infrastructure to be able to ensure that the GPU can
- * ensure that the GX is off during this super special case. We do this by
- * defining a GX gdsc with a dummy enable function and a "default" disable
- * function.
- *
- * This allows us to attach with genpd_dev_pm_attach_by_name() in the GPU
- * driver. During power up, nothing will happen from the CPU (and the GMU will
- * power up normally but during power down this will ensure that the GX domain
- * is *really* off - this gives us a semi standard way of doing what we need.
- */
-static int gx_gdsc_enable(struct generic_pm_domain *domain)
-{
-	/* Do nothing but give genpd the impression that we were successful */
-	return 0;
-}
-
 static struct gdsc gx_gdsc = {
 	.gdscr = 0x100c,
 	.clamp_io_ctrl = 0x1508,
 	.pd = {
 		.name = "gx_gdsc",
-		.power_on = gx_gdsc_enable,
+		.power_on = gdsc_gx_do_nothing_enable,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = CLAMP_IO,
diff --git a/drivers/clk/qcom/gpucc-sdm845.c b/drivers/clk/qcom/gpucc-sdm845.c
index e40efba1bf7d..5663698b306b 100644
--- a/drivers/clk/qcom/gpucc-sdm845.c
+++ b/drivers/clk/qcom/gpucc-sdm845.c
@@ -131,37 +131,12 @@ static struct gdsc gpu_cx_gdsc = {
 	.flags = VOTABLE,
 };
 
-/*
- * On SDM845 the GPU GX domain is *almost* entirely controlled by the GMU
- * running in the CX domain so the CPU doesn't need to know anything about the
- * GX domain EXCEPT....
- *
- * Hardware constraints dictate that the GX be powered down before the CX. If
- * the GMU crashes it could leave the GX on. In order to successfully bring back
- * the device the CPU needs to disable the GX headswitch. There being no sane
- * way to reach in and touch that register from deep inside the GPU driver we
- * need to set up the infrastructure to be able to ensure that the GPU can
- * ensure that the GX is off during this super special case. We do this by
- * defining a GX gdsc with a dummy enable function and a "default" disable
- * function.
- *
- * This allows us to attach with genpd_dev_pm_attach_by_name() in the GPU
- * driver. During power up, nothing will happen from the CPU (and the GMU will
- * power up normally but during power down this will ensure that the GX domain
- * is *really* off - this gives us a semi standard way of doing what we need.
- */
-static int gx_gdsc_enable(struct generic_pm_domain *domain)
-{
-	/* Do nothing but give genpd the impression that we were successful */
-	return 0;
-}
-
 static struct gdsc gpu_gx_gdsc = {
 	.gdscr = 0x100c,
 	.clamp_io_ctrl = 0x1508,
 	.pd = {
 		.name = "gpu_gx_gdsc",
-		.power_on = gx_gdsc_enable,
+		.power_on = gdsc_gx_do_nothing_enable,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = CLAMP_IO | AON_RESET | POLL_CFG_GDSCR,
-- 
2.26.1

