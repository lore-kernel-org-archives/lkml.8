Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD4DC433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B309212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2al1fLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgGNUFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbgGNUE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:04:56 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D3EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:04:56 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o22so2041893pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HLlEel+6hkVFpJmPTSkYr9jJlciZ5vVR474YE3QPGUI=;
        b=J2al1fLyl+C52Ke+qEdt6M1Bbv8a6SBTdeYTQm9PdUTrHxKH6TblbNw6+xcL60+qML
         s+Fb1GjCAinYeKKMfupdyIwYHbuyHiGV5GdjwaP+4+S8bH2iOup0ev6zNRJ7kXXC8GQr
         CEqSJcWz6HnEQTD+JyK5kkRBduxnQNSJceHNgHd68kvx3+5Oy3X+V55jizyeh41D0QoA
         BOJlQhmfTS33b+QUEPNT51HsgqLNhSW9g6GvoefqOlDps8iEqy+iJk8UX5G7D3FEG3dr
         1U9PYiv7Yn+uT21VI9qlA/P3cLI4bqu2uWLSMzN0pPNas0Grw5Bt/bZtohj0kwknnKvh
         nM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HLlEel+6hkVFpJmPTSkYr9jJlciZ5vVR474YE3QPGUI=;
        b=SgUirFcoA+ecy2X17x7ec6G7Z7qc1toL1pjT64hGPQDM3JOCiCagcPt90sS0SBuPnG
         s648cq7kr8iOmXf/4kXVw22ZN7w0XNWHXN73WiLtzG1T5kefUqIHAcLzDub+Ga/yWJx+
         sDZTVcwmoGF2B+oj/dFbdy6x193Fa4sKztlui1tLv4hoq1M5awap1WPwfxF3JJ0x5C8A
         02CrVdGAUHkX5Zx5JlQBxn6TeBb/z9FWs9QuwOdTdBhDgVIY37vNrnVH3YyFgGHFY62H
         WGg8slVKbEtAUsYAsQva3QLMIq0U1cS5fZXR97tYrABmd8pWktRsvzAflLjSAl+Mv1RH
         k5hA==
X-Gm-Message-State: AOAM530VN3hV/HpWNAxdSmurmwpZcaUZuIxbBaOOvEqMr6laprAGBaVo
        Kvh0Nu2SnLE0Ww/DX/K48U1YYw==
X-Google-Smtp-Source: ABdhPJxYNLWJRYA87GVE2PmZT3pjEv+4tXiNcgg7HfZU4zaIdo175xOC9JQGh0zDYmdfjP1o83nP3w==
X-Received: by 2002:a17:90a:43c3:: with SMTP id r61mr6805055pjg.216.1594757095648;
        Tue, 14 Jul 2020 13:04:55 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t13sm3262959pjs.17.2020.07.14.13.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:04:55 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v6 06/11] remoteproc: stm32: Properly set co-processor state when attaching
Date:   Tue, 14 Jul 2020 14:04:40 -0600
Message-Id: <20200714200445.1427257-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
References: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the required mechanic to set the state of the M4 in order
to properly deal with scenarios where the co-processor has been
started by another entity.

Mainly based on the work published by Arnaud Pouliquen [1].

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 961a53f67ec5..f393f2503106 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -39,6 +39,13 @@
 #define STM32_MBX_VQ1_ID	1
 #define STM32_MBX_SHUTDOWN	"shutdown"
 
+#define M4_STATE_OFF		0
+#define M4_STATE_INI		1
+#define M4_STATE_CRUN		2
+#define M4_STATE_CSTOP		3
+#define M4_STATE_STANDBY	4
+#define M4_STATE_CRASH		5
+
 struct stm32_syscon {
 	struct regmap *map;
 	u32 reg;
@@ -636,12 +643,29 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
 	return 0;
 }
 
+static int stm32_rproc_get_m4_status(struct stm32_rproc *ddata,
+				     unsigned int *state)
+{
+	/* See stm32_rproc_parse_dt() */
+	if (!ddata->m4_state.map) {
+		/*
+		 * We couldn't get the coprocessor's state, assume
+		 * it is not running.
+		 */
+		state = M4_STATE_OFF;
+		return 0;
+	}
+
+	return regmap_read(ddata->m4_state.map, ddata->m4_state.reg, state);
+}
+
 static int stm32_rproc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct stm32_rproc *ddata;
 	struct device_node *np = dev->of_node;
 	struct rproc *rproc;
+	unsigned int state;
 	int ret;
 
 	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
@@ -664,6 +688,13 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
+	ret = stm32_rproc_get_m4_status(ddata, &state);
+	if (ret)
+		goto free_rproc;
+
+	if (state == M4_STATE_CRUN)
+		rproc->state = RPROC_DETACHED;
+
 	rproc->has_iommu = false;
 	ddata->workqueue = create_workqueue(dev_name(dev));
 	if (!ddata->workqueue) {
-- 
2.25.1

