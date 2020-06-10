Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16122C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA37320760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbW0xRSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgFJHsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgFJHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:47:53 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559D2C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:47:53 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n23so608553pgb.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dSE9dqY0eKEnI3JM3RkevfVx7P9DxAySSIY6zGnKG0k=;
        b=FbW0xRSDuDBHPICwLz6J0+xSwKToUC5OHVH6pVC2xAJKD3+d9wSqcJ4aQA5mQIgkuh
         QPr3AusxGl9SkAEq3GF9VJszl07SB1IOqHsBUpxMjDsPrB4sjGCdlg+01WKWCDXKjbVj
         Pe5SrDBj25ONBPbOIxAA9jOKWywKcDUY5HhCjMxxHsnJwqqiI/shd8ir17LXRuxuFCsi
         lpXXBIN69PrCtDXTk0VmJCjzWEYR+Oa6pljEJZj2VIZBoIyXEcyf+iyvooVfzstaDxVM
         R0fRobXFQahfQzfmrrmoripc6I6KiBUPG/lFdZ4u0ujBNosSQEJQeMYNCxYCg0j2rGlo
         e1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dSE9dqY0eKEnI3JM3RkevfVx7P9DxAySSIY6zGnKG0k=;
        b=jkkYPLg3sWFPoTBpk/izwxgHyAC/FmeBgbL11E8XNV1yXTfCQgY5nf89Die9LZ5jVF
         YXkz+I02kQiMMu3IptfMa+uiXMfLzb7vfyhKOU+NrrVP/SkCOaMbBUHeloPRz620+Dxm
         29nOqxxNrN8keLR4agGsfWq3uYXXZhYuS3/6cZblaFf1+D/8Nk/Tizufafor0ht7f0VR
         84e6n3GfypfZ4hOzV8OGObUKqq4lsIVPJZXauPH/aLdTS5WoPuueF5gZhq79D7J+hGOp
         2lRuwYiCPsbHrdfrqB/Nq5oVAqrHm4yoBYeE9WpG5NVb/fvdlFv1VYynQM02XTic2v+c
         ECKQ==
X-Gm-Message-State: AOAM532UKY2bETP0pCYlusaJMbcDEwlxZukBxr4KOWZcW/mvHI3C1bTq
        h72rqHRDvY/5Fzo8EDvkfGFj
X-Google-Smtp-Source: ABdhPJwM9GPb13WEAKboxPmHVrXXAcCW+ynmNb1XvpXEq6zaYnQbuQT0y6UHLHzNvddGrUPXD5MJ7w==
X-Received: by 2002:a62:2acf:: with SMTP id q198mr1696952pfq.48.1591775272783;
        Wed, 10 Jun 2020 00:47:52 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:630f:1dba:c41:a14e:6586:388a])
        by smtp.gmail.com with ESMTPSA id u1sm10075040pgf.28.2020.06.10.00.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 00:47:52 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@martin.sperl.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 5/6] can: mcp25xxfd: Optimize TEF read by avoiding unnecessary SPI transfers
Date:   Wed, 10 Jun 2020 13:17:10 +0530
Message-Id: <20200610074711.10969-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200610074711.10969-1-manivannan.sadhasivam@linaro.org>
References: <20200610074711.10969-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

We have already enough information to know how many tx-messages have
been terminated so that we do not have to query TEF every time if
there is anything pending but we can read the tefs blindly.

This avoids 1 SPI transfer per TEF read.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c
index 5ea1e525e776..6f066cb95844 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c
@@ -263,6 +263,13 @@ int mcp25xxfd_can_tx_handle_int_tefif_fifo(struct mcp25xxfd_can_priv *cpriv)
 					MCP25XXFD_CAN_TEFCON_UINC);
 }
 
+/* reading TEF entries can be made even more efficient by reading
+ * multiple TEF entries in one go.
+ * Under the assumption that we have count(TEF) >= count(TX_FIFO)
+ * we can even release TEFs early (before we read them)
+ * (and potentially restarting the transmit-queue early aswell)
+ */
+
 static int
 mcp25xxfd_can_tx_handle_int_tefif_conservative(struct mcp25xxfd_can_priv *cpriv)
 {
@@ -293,6 +300,25 @@ mcp25xxfd_can_tx_handle_int_tefif_conservative(struct mcp25xxfd_can_priv *cpriv)
 	return 0;
 }
 
+static int
+mcp25xxfd_can_tx_handle_int_tefif_optimized(struct mcp25xxfd_can_priv *cpriv,
+					    u32 finished)
+{
+	int i, fifo, ret;
+
+	/* now iterate those */
+	for (i = 0, fifo = cpriv->fifos.tx.start; i < cpriv->fifos.tx.count;
+	     i++, fifo++) {
+		if (finished & BIT(fifo)) {
+			ret = mcp25xxfd_can_tx_handle_int_tefif_fifo(cpriv);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 int mcp25xxfd_can_tx_handle_int_tefif(struct mcp25xxfd_can_priv *cpriv)
 {
 	unsigned long flags;
@@ -310,6 +336,13 @@ int mcp25xxfd_can_tx_handle_int_tefif(struct mcp25xxfd_can_priv *cpriv)
 
 	spin_unlock_irqrestore(&cpriv->fifos.tx_queue->lock, flags);
 
+	/* run in optimized mode if possible */
+	if (finished)
+		return mcp25xxfd_can_tx_handle_int_tefif_optimized(cpriv,
+								   finished);
+	/* otherwise play it safe */
+	netdev_warn(cpriv->can.dev,
+		    "Something is wrong - we got a TEF interrupt but we were not able to detect a finished fifo\n");
 	return mcp25xxfd_can_tx_handle_int_tefif_conservative(cpriv);
 }
 
-- 
2.17.1

