Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C48C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112442075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZsKvRtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgGGVbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbgGGVbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:31:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCA3C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:31:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l6so234995pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+3MCXBkEweRCBCXnKkbvCmuaqKQRYPJZEhIYqjzffxA=;
        b=GZsKvRttTVdpRXiFAFQqLB/OSr1mbj6jtRxZCmNENnI2UyhGQ97vFRT73Rf53p1Pw/
         7Kv8tMfvl8SbjnJPz7hAgz2qL96nPrs5yxXLMJaXlz7IDv1viQhZd5q0U8gi1u8EUQ62
         I3TVIossUE8jTwWxWgD3bsaOGbA/z9LMxoQ1RVCFvVOP/kwVl80fSm3NS2bfjRNX73i5
         bdPpi2ievzipfaZk06WjSrTQJs4zFvIv59xVdtWnb2usDFSd5y4yaBg4OjVK3udXkBWE
         2yxbDGZ3Dbrv8WUhnmw9rQ/MqxfPgtE9PcZDdqSPjpPydg8wkR+dBP+gnZG2cTMr4D3Z
         xctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+3MCXBkEweRCBCXnKkbvCmuaqKQRYPJZEhIYqjzffxA=;
        b=dnxD1qavQ5e9VhQBAeBENu2VycEwqUym5elX6kSdcjYG7RYyEQcRfbcdhSlg5/1nR9
         n5OHgdcVjpwHxidzGgXIDHcPA+CWwmjfx75QGzJ1jFoYdjUyEAGUzJzXO/bLPaoObKe/
         QXKhKHmAoBGwKHN14DqV5J8h2k9IC/OWCKhe2Wm0Kk1RBxZbR4NtQj0blDtzjCO+Zmje
         H9Rcd6tT+k4hkGjAEbwW6FhMPQFH8EcVRITGQL3gCOlLAoupx2NgzvWnfvI3DTUT9j9R
         83ek23yaLnkyd1mvBJiDjeTMfV7E4XkyxM8Qsm4YaxpxVkkg7nFescydOWeReqNALJDA
         8m0Q==
X-Gm-Message-State: AOAM5319iyYGxI+UglhhCEyb9oK9a9l11xwYJOEg2MHY6ATZjmV3BDEL
        NSSo458MVBgZP8eCzicCQ8z/CQ==
X-Google-Smtp-Source: ABdhPJzK/vQWGHOgnTL/Tw1JIjnDO3iSBBS4unWLbbvc5+fevfix2oAOiUFAwNtcZMZEixXYa9AjMQ==
X-Received: by 2002:a17:902:c411:: with SMTP id k17mr44127764plk.165.1594157482000;
        Tue, 07 Jul 2020 14:31:22 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o128sm23560832pfg.127.2020.07.07.14.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:31:21 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v5 06/11] remoteproc: stm32: Properly set co-processor state when attaching
Date:   Tue,  7 Jul 2020 15:31:07 -0600
Message-Id: <20200707213112.928383-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707213112.928383-1-mathieu.poirier@linaro.org>
References: <20200707213112.928383-1-mathieu.poirier@linaro.org>
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
 drivers/remoteproc/stm32_rproc.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 961a53f67ec5..cbeb5ceb15c5 100644
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
@@ -636,12 +643,30 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
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
@@ -664,6 +689,13 @@ static int stm32_rproc_probe(struct platform_device *pdev)
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

