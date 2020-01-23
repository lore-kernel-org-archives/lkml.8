Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BDBC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A40218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fIOS/1qV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgAWXZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:25:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39472 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbgAWXY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 18:24:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so2027397plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 15:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4aX5l/dML5eau8GIuNAKI55XbIc1iZhh7nAnGo45frU=;
        b=fIOS/1qVRkjNyhx3V73sope4wo1BXA5gIGf2pMh9gjTD90sZUTga2GQxpqKojDByNR
         vM8uII6xaga31QKDa3gsfws/qchBWSUnFcIjCytJoWPwM9JAsYPeQtvJLyZ1m/iYGg8D
         i5H8kY81G1W1AyK1MldthNgzwsAaLJemjl1wM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4aX5l/dML5eau8GIuNAKI55XbIc1iZhh7nAnGo45frU=;
        b=mluy/eAgti4g0n0dL8zQyYz1qjPOE8BAeNFp5B5FHAFuwswYsCvvIruiEIdw/9yTQn
         b/h1OiCOH1s3N7HOTGNhxCwxhjmgIqvSVtLmGFCTnnjkDy0U2H01PakDaUoP5Ng4HUBV
         uU1NvrAqo+i1gYu9w9GYHkA7QxXLz1rCUH0g+GdV+J0lCdRza8F1q2hK+6TGXYnxXxia
         ogpK7lMPcu9L/yfhINFCKrOsTuj/q8/YZAmB5MvkpLONK2uwn12T6QVljfSCrhY9fNmP
         awKwr0zAX9LVu8t/v1zQXAcyXCW/oLH7mlkLXL8M2y8201D6Up3bKIgfO+b6mzRhOdJy
         NKDQ==
X-Gm-Message-State: APjAAAVALvXf7cNHV+eT42EoM4rfnKR+KSgLVSXEg/koAoJrUmha1AFR
        SBIToJlW8Q3i8hX/dtyUBZ8cnA==
X-Google-Smtp-Source: APXvYqzyIxhJ9N7AmSY8hYmSpeu53DPs0ZzjqEnLgPK9rcHArpPdcPqUrGEPOiU5PX5ysoAwh/+z1g==
X-Received: by 2002:a17:902:aa41:: with SMTP id c1mr568850plr.105.1579821898215;
        Thu, 23 Jan 2020 15:24:58 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c19sm4085849pfc.144.2020.01.23.15.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:24:57 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] ath10k: Add newlines to printk messages
Date:   Thu, 23 Jan 2020 15:24:56 -0800
Message-Id: <20200123232456.36197-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some printks in here don't have newlines at the end, meaning the log
will be sort of hard to read. Add newlines.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 7e85c4916e7f..19a4d053d1de 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -582,7 +582,7 @@ static void ath10k_snoc_process_rx_cb(struct ath10k_ce_pipe *ce_state,
 				 max_nbytes, DMA_FROM_DEVICE);
 
 		if (unlikely(max_nbytes < nbytes)) {
-			ath10k_warn(ar, "rxed more than expected (nbytes %d, max %d)",
+			ath10k_warn(ar, "rxed more than expected (nbytes %d, max %d)\n",
 				    nbytes, max_nbytes);
 			dev_kfree_skb_any(skb);
 			continue;
@@ -1201,7 +1201,7 @@ static int ath10k_snoc_request_irq(struct ath10k *ar)
 				  irqflags, ce_name[id], ar);
 		if (ret) {
 			ath10k_err(ar,
-				   "failed to register IRQ handler for CE %d: %d",
+				   "failed to register IRQ handler for CE %d: %d\n",
 				   id, ret);
 			goto err_irq;
 		}
@@ -1485,7 +1485,7 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
 
 	ret = dma_set_mask_and_coherent(dev, drv_data->dma_mask);
 	if (ret) {
-		dev_err(dev, "failed to set dma mask: %d", ret);
+		dev_err(dev, "failed to set dma mask: %d\n", ret);
 		return ret;
 	}
 
-- 
Sent by a computer, using git, on the internet

