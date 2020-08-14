Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15A2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C112F20771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgQFNgl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgHNLmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbgHNLkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78FAC061346
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 184so7677157wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IFZOPtR6KI+rxA/lqxwIdqFyIwqMfS+8QowGRbn6S6c=;
        b=RgQFNgl65ZIR7EMkc8YqH6kzCDZzK/89NbSMs4w9VAwULPTsl0jNEfmDyXCvm0w3HF
         j5GajrrvhVxPKS/5R5bksj7YIWj5tsqvD2VViue+aMDKzPBO/FPUPxX6FHjEG/oMh4bq
         Ei4uXWbe4G2s+N6spzm1Yj4tWvfopFn2D879+kWi5cR4sP+OfELE2d2WxHIuMeHKWvMG
         WG5joLqe3oiEUTFgECwQznnGP46n2Po+9cDyOXClExY1/Qp5tZqQwn4+oXUXMprnVHDR
         4mqoISP/KmmsqEYeuQGoxt72slmfKg0Njo46PAfR1+A0c1uOd3pnxnbMNZVp+NGv60LJ
         8vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFZOPtR6KI+rxA/lqxwIdqFyIwqMfS+8QowGRbn6S6c=;
        b=npWIyeFh387R0r8KbO3bPDWjbp7WVqF74Qn43tCAUpL9LjysVOwJJU28HVba4sKuxO
         Iq0PSEY6HJ/LnvbQcmA3xqfvXXv4setx19r8JZdf3i5YE+qv7+fUYBJ+dZl/Lp17xjAz
         QuR64NOEt9asXWlVZeKXt347mJl+te/qoFWZKozd1HKhlv6K+jKVbDuz9MvapHUKkeN1
         m0FkSo6troEoNkGBuIC5m1bg0mwTygLXSYakQZbUm/RGSfDIcqXXDkXpFHFrU7jjY9yd
         APQt0AwPR9fx26+H+DiowBGXT9LkhHgK8O7D2ueSPuui4evq/rAWz6g8lMAlyXy1+Z3p
         /PaQ==
X-Gm-Message-State: AOAM533DFLWceHuABfGcYdXLUm8DP5hSrhq8A1rWDWfCzjOx1vzlhOMm
        vWDf1L7WDli0dQyQFz0eK0LMdg==
X-Google-Smtp-Source: ABdhPJyOkQHG7sfqRyJMAFAZsxAi8frxHRFAAgp/0CDRrGUgb2MXZIXsvYpokPZrFhEajNXubg+4AQ==
X-Received: by 2002:a1c:18b:: with SMTP id 133mr2205145wmb.178.1597405206403;
        Fri, 14 Aug 2020 04:40:06 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:40:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Gerald Combs <gerald@ethereal.com>,
        Linux Wireless <ilw@linux.intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 16/30] net: wireless: intel: ipw2200: Remove set but unused variables 'rc' and 'w'
Date:   Fri, 14 Aug 2020 12:39:19 +0100
Message-Id: <20200814113933.1903438-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/ipw2x00/ipw2200.c: In function ‘ipw_irq_tasklet’:
 drivers/net/wireless/intel/ipw2x00/ipw2200.c:1953:6: warning: variable ‘rc’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/intel/ipw2x00/ipw2200.c: In function ‘ipw_rx’:
 drivers/net/wireless/intel/ipw2x00/ipw2200.c:8251:9: warning: variable ‘w’ set but not used [-Wunused-but-set-variable]

Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Gerald Combs <gerald@ethereal.com>
Cc: Linux Wireless <ilw@linux.intel.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 129ef2f6248ae..5345f90837f5f 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -1950,7 +1950,6 @@ static void ipw_irq_tasklet(unsigned long data)
 	struct ipw_priv *priv = (struct ipw_priv *)data;
 	u32 inta, inta_mask, handled = 0;
 	unsigned long flags;
-	int rc = 0;
 
 	spin_lock_irqsave(&priv->irq_lock, flags);
 
@@ -1980,7 +1979,7 @@ static void ipw_irq_tasklet(unsigned long data)
 
 	if (inta & IPW_INTA_BIT_TX_CMD_QUEUE) {
 		IPW_DEBUG_HC("Command completed.\n");
-		rc = ipw_queue_tx_reclaim(priv, &priv->txq_cmd, -1);
+		ipw_queue_tx_reclaim(priv, &priv->txq_cmd, -1);
 		priv->status &= ~STATUS_HCMD_ACTIVE;
 		wake_up_interruptible(&priv->wait_command_queue);
 		handled |= IPW_INTA_BIT_TX_CMD_QUEUE;
@@ -1988,25 +1987,25 @@ static void ipw_irq_tasklet(unsigned long data)
 
 	if (inta & IPW_INTA_BIT_TX_QUEUE_1) {
 		IPW_DEBUG_TX("TX_QUEUE_1\n");
-		rc = ipw_queue_tx_reclaim(priv, &priv->txq[0], 0);
+		ipw_queue_tx_reclaim(priv, &priv->txq[0], 0);
 		handled |= IPW_INTA_BIT_TX_QUEUE_1;
 	}
 
 	if (inta & IPW_INTA_BIT_TX_QUEUE_2) {
 		IPW_DEBUG_TX("TX_QUEUE_2\n");
-		rc = ipw_queue_tx_reclaim(priv, &priv->txq[1], 1);
+		ipw_queue_tx_reclaim(priv, &priv->txq[1], 1);
 		handled |= IPW_INTA_BIT_TX_QUEUE_2;
 	}
 
 	if (inta & IPW_INTA_BIT_TX_QUEUE_3) {
 		IPW_DEBUG_TX("TX_QUEUE_3\n");
-		rc = ipw_queue_tx_reclaim(priv, &priv->txq[2], 2);
+		ipw_queue_tx_reclaim(priv, &priv->txq[2], 2);
 		handled |= IPW_INTA_BIT_TX_QUEUE_3;
 	}
 
 	if (inta & IPW_INTA_BIT_TX_QUEUE_4) {
 		IPW_DEBUG_TX("TX_QUEUE_4\n");
-		rc = ipw_queue_tx_reclaim(priv, &priv->txq[3], 3);
+		ipw_queue_tx_reclaim(priv, &priv->txq[3], 3);
 		handled |= IPW_INTA_BIT_TX_QUEUE_4;
 	}
 
@@ -8248,12 +8247,12 @@ static void ipw_rx(struct ipw_priv *priv)
 	struct ipw_rx_mem_buffer *rxb;
 	struct ipw_rx_packet *pkt;
 	struct libipw_hdr_4addr *header;
-	u32 r, w, i;
+	u32 r, i;
 	u8 network_packet;
 	u8 fill_rx = 0;
 
 	r = ipw_read32(priv, IPW_RX_READ_INDEX);
-	w = ipw_read32(priv, IPW_RX_WRITE_INDEX);
+	ipw_read32(priv, IPW_RX_WRITE_INDEX);
 	i = priv->rxq->read;
 
 	if (ipw_rx_queue_space (priv->rxq) > (RX_QUEUE_SIZE / 2))
-- 
2.25.1

