Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5ADC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469772073E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E0mCZBIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbgDMRFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732390AbgDMREz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:04:55 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9433EC00860A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:04:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y25so2477789pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YoTy9v1GALGtXWEjIsnk6ikaa3w8TCy0VVFYmR0SOSI=;
        b=E0mCZBIbcdB3lQD1HTRdYUk01U9CFJjGMxEi9JxwD8NG5whUHuwVff+wR5ygngxq0y
         GxKsa8ukg/tvnwovtwNu4WIoUKh3hcIaJ86nm0pSsV8imcMv9Lb/4tuSlM7pGcib3fcX
         SHvJU5TXRSKj5n+z00qT5YdLpTo26ZJ/UfHQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YoTy9v1GALGtXWEjIsnk6ikaa3w8TCy0VVFYmR0SOSI=;
        b=oEp/xR6P5KmLwTR3HtPQTf150gFxBvYn+oohriSeHHLvoPfI6FLDkGLVlH3qB75oJn
         MS7XI2uGEqbG2fUfd5SjB91GpZc94EH31E5omIHg15ZLRP7HTEix6329glTa3dup+zb7
         7Jttk6zZ9fx1w8KUy1MExrUJa/D+79NqwhAYbFnzD4wzWeb325c6Oll6h579qGA6oWKu
         EmUVS+revTCXzv9eWVkSUoik+C7b7mPti3IMSB/ryYaloHMsSW7rCKVUIcamQNeFF/GR
         an2PGVvhrsc9PXL42Y1PcThQtr+yqPM4iK5ky2KB/g3P+lOWGsJJ+rYbC1mzZfkYHFPx
         rhhw==
X-Gm-Message-State: AGi0PuZwtzCWUrvfyTAFvX6N0nzmau4vnCOPBRmN5IRYYGb+0EpCxiEx
        6vre/jc1iKhpdsy8nP7GCuLPng==
X-Google-Smtp-Source: APiQypL0Rea6oKvw07qyNd4zvgQ2zgujG6OuE32aQox0LFqc4KBOLx8rflBT87Atl3chWHnsC6djbA==
X-Received: by 2002:a63:4d57:: with SMTP id n23mr18749844pgl.59.1586797493104;
        Mon, 13 Apr 2020 10:04:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p62sm1634414pfb.93.2020.04.13.10.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:04:52 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>, evgreen@chromium.org,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/10] drivers: qcom: rpmh-rsc: read_tcs_reg()/write_tcs_reg() are not for IRQ
Date:   Mon, 13 Apr 2020 10:04:15 -0700
Message-Id: <20200413100321.v4.10.I2adf93809c692d0b673e1a86ea97c45644aa8d97@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200413170415.32463-1-dianders@chromium.org>
References: <20200413170415.32463-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RSC_DRV_IRQ_ENABLE, RSC_DRV_IRQ_STATUS, and RSC_DRV_IRQ_CLEAR
registers are not part of TCS 0.  Let's not pretend that they are by
using read_tcs_reg() and write_tcs_reg() and passing a bogus tcs_id of
0.  We could introduce a new wrapper for these registers but it
wouldn't buy us much.  Let's just read/write directly.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
Tested-by: Maulik Shah <mkshah@codeaurora.org>
---

Changes in v4: None
Changes in v3:
- ("...are not for IRQ") is new for v3.

Changes in v2: None

 drivers/soc/qcom/rpmh-rsc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 9bd0c7c3db7c..3c77a0eed90d 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -363,12 +363,12 @@ static void enable_tcs_irq(struct rsc_drv *drv, int tcs_id, bool enable)
 {
 	u32 data;
 
-	data = read_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0);
+	data = readl_relaxed(drv->tcs_base + RSC_DRV_IRQ_ENABLE);
 	if (enable)
 		data |= BIT(tcs_id);
 	else
 		data &= ~BIT(tcs_id);
-	write_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, data);
+	writel_relaxed(data, drv->tcs_base + RSC_DRV_IRQ_ENABLE);
 }
 
 /**
@@ -389,7 +389,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 	const struct tcs_request *req;
 	struct tcs_cmd *cmd;
 
-	irq_status = read_tcs_reg(drv, RSC_DRV_IRQ_STATUS, 0);
+	irq_status = readl_relaxed(drv->tcs_base + RSC_DRV_IRQ_STATUS);
 
 	for_each_set_bit(i, &irq_status, BITS_PER_LONG) {
 		req = get_req_from_tcs(drv, i);
@@ -426,7 +426,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 		/* Reclaim the TCS */
 		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i, 0);
 		write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, i, 0);
-		write_tcs_reg(drv, RSC_DRV_IRQ_CLEAR, 0, BIT(i));
+		writel_relaxed(BIT(i), drv->tcs_base + RSC_DRV_IRQ_CLEAR);
 		spin_lock(&drv->lock);
 		clear_bit(i, drv->tcs_in_use);
 		/*
@@ -968,7 +968,8 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	}
 
 	/* Enable the active TCS to send requests immediately */
-	write_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, drv->tcs[ACTIVE_TCS].mask);
+	writel_relaxed(drv->tcs[ACTIVE_TCS].mask,
+		       drv->tcs_base + RSC_DRV_IRQ_ENABLE);
 
 	spin_lock_init(&drv->client.cache_lock);
 	INIT_LIST_HEAD(&drv->client.cache);
-- 
2.26.0.110.g2183baf09c-goog

