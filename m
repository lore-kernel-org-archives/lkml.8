Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DACC2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3687E20719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OT/L+d2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgDGXvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:51:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46486 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgDGXvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:51:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id q3so1531662pff.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KvEJzMH6Rxi8JFDstC273KQ0bdGB37YijaATrtjA+Oo=;
        b=OT/L+d2sOkBze7u7kCa/ul9nbt7FBPk4UFbvoXf7evUw860Zm7kdOTvn+/o1kPqp4C
         1Y0MaFQ01GRIGs3AAZfSuNfnwO66ph7dkS6vDmTcUTZl5i6jIw+1+KFcO9KXV1wjqlrZ
         PPO7T+JbzB1wgA8vitRJDvxObqOOuYYVZDiYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KvEJzMH6Rxi8JFDstC273KQ0bdGB37YijaATrtjA+Oo=;
        b=pbObw0DjDOJ5DWxemhZsRHQdOy9pqLywERkbPlqOyBQWx9zdSxo2ARlztIcFipIB4e
         w7wofaRet6ADdMbVmwgNHFqC3wkCSGXg0gI7y9KO2yPgdTA1JqgBRkx4tNQ44aOwEQ0L
         1yIfbBMcCozLHBn+VXV365aV2PVRHm3ME/HHxWlLcHZg1Znbk5u/e16ONFgKeaszfu88
         IivGNMZyi5j9jjP8ik+8I7AQZqXqO+hD8THhteM9jCVNRXfc4F467cxdYaBZjX1tE1Mh
         4Z2QTlMFwxlHRLVvkRSaRyFbfqyQmUpQGvLZu4vnAmcgMQ0N8RnyzH7SCthHMtczeS7g
         uDlA==
X-Gm-Message-State: AGi0PuYsQubxWvMf6/tOWzs35FD4V3jLbs6O3GyuA5zJ6g+Dk0CDTigW
        PkdzqAIwMyvWbT5f3XP4ZR5tMg==
X-Google-Smtp-Source: APiQypJMr4oUHM0Ta88xT7+6ntyKOqf33TdlrkpIUfBkSR/NP5bMYzT+8z/Iix1PO7MN42gvKmsSlg==
X-Received: by 2002:aa7:8d90:: with SMTP id i16mr3456900pfr.126.1586303467414;
        Tue, 07 Apr 2020 16:51:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id s27sm14467165pgn.90.2020.04.07.16.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 16:51:06 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     mka@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/10] drivers: qcom: rpmh-rsc: read_tcs_reg()/write_tcs_reg() are not for IRQ
Date:   Tue,  7 Apr 2020 16:50:24 -0700
Message-Id: <20200407164915.v3.10.I2adf93809c692d0b673e1a86ea97c45644aa8d97@changeid>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200407235024.260460-1-dianders@chromium.org>
References: <20200407235024.260460-1-dianders@chromium.org>
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
---

Changes in v3:
- ("...are not for IRQ") is new for v3.

Changes in v2: None

 drivers/soc/qcom/rpmh-rsc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index a3b015196f15..31a998e6f2e9 100644
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
@@ -969,7 +969,8 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	}
 
 	/* Enable the active TCS to send requests immediately */
-	write_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, drv->tcs[ACTIVE_TCS].mask);
+	writel_relaxed(drv->tcs[ACTIVE_TCS].mask,
+		       drv->tcs_base + RSC_DRV_IRQ_ENABLE);
 
 	spin_lock_init(&drv->client.cache_lock);
 	INIT_LIST_HEAD(&drv->client.cache);
-- 
2.26.0.292.g33ef6b2f38-goog

