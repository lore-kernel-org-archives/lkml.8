Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC85C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615D022BEA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKIGuyNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgHUHUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgHUHSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:18:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8065FC0612F2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c15so981779wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3GcXWK42EOat9gpnv8yfBhBVK1TNbXyjHRD+03gi2Dk=;
        b=zKIGuyNS9dEpgui3o1oAewVdt7OZLZGMe4NfJiyTtqzGaBaiFU/KqDyDWUPAMxtUhT
         hrmQQAQAe/ON2srwrzflXkvaBBAP6AFcaSY7svkz+oazdd3o+xdVZlPXvR6m+rkYZzli
         BVV1p+m6HBVNJxlCnSdqYwVKv70l5WkNoDiR4grhO1LqVYLv1IIDOtwwwVXREwTLfSQj
         jfO0aeuOLn3k0QTp8Ei+/ntORcg/UHjP3uHxFS6Zn3mN4vaKZQ7yw1l+MStMtNokpFfB
         FrjyH9aNTzZJCdnU0MwBvVq61+OnYAYpibR1NvR36gN5AlkjOGiguVkkqeVRcjqYnWIn
         KiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3GcXWK42EOat9gpnv8yfBhBVK1TNbXyjHRD+03gi2Dk=;
        b=g/kk0EEagRFlLXFtPJsKN6JdCMbSEI9MWlM1tWUFnPPkP9wVgVntKGrmGe/jZvhipg
         +FNQ1kSbqcMemVhMrr4trPtcPWE5hLMvP/0yK9iUVrufxtqdaz5EeOLIjBygFU3mHfqC
         RaGG69lcxsqnFSDqvuhRl3EFlUjliCI3KipmMKNaXrBL5JggrxgDxqS1kcNs8YJ9za+H
         4RUTWX7RQo6vGUeMlIt47xo5aG3hgDGY+cxfrYEcUmQfpPipgXHSO7+hkx0UTx1QqWhz
         MHme4h5KzZNjdZvJU1rtScq64FmR4U0c0I7uGYO27rI2oCLNojgc9e/CLjX64zzaJ8YG
         GKwQ==
X-Gm-Message-State: AOAM5335QIE7Pzz+dSQpMcqcBpI/WqAFJp49j/LOQTy9DVDWiT3tE67/
        P3ATqflP29gNUwz+H565w5dNRw==
X-Google-Smtp-Source: ABdhPJyno6qESJCJyD/bb2OUFMm5wB39EeK0xwRj1yRHwjS8+ZfoYNIIYaKpFzBo/7N0ZNP3x9pv1Q==
X-Received: by 2002:adf:ba10:: with SMTP id o16mr1424734wrg.100.1597994243109;
        Fri, 21 Aug 2020 00:17:23 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Subject: [PATCH 28/32] wireless: ath: wil6210: txrx_edma: Demote comments which are clearly not kernel-doc
Date:   Fri, 21 Aug 2020 08:16:40 +0100
Message-Id: <20200821071644.109970-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/wil6210/txrx_edma.c:155: warning: Function parameter or member 'wil' not described in 'wil_ring_alloc_skb_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:155: warning: Function parameter or member 'ring' not described in 'wil_ring_alloc_skb_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:155: warning: Function parameter or member 'i' not described in 'wil_ring_alloc_skb_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1161: warning: Function parameter or member 'wil' not described in 'wil_tx_sring_handler'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1161: warning: Function parameter or member 'sring' not described in 'wil_tx_sring_handler'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1328: warning: Function parameter or member 'd' not described in 'wil_tx_desc_offload_setup_tso_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1328: warning: Function parameter or member 'tso_desc_type' not described in 'wil_tx_desc_offload_setup_tso_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1328: warning: Function parameter or member 'is_ipv4' not described in 'wil_tx_desc_offload_setup_tso_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1328: warning: Function parameter or member 'tcp_hdr_len' not described in 'wil_tx_desc_offload_setup_tso_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1328: warning: Function parameter or member 'skb_net_hdr_len' not described in 'wil_tx_desc_offload_setup_tso_edma'
 drivers/net/wireless/ath/wil6210/txrx_edma.c:1328: warning: Function parameter or member 'mss' not described in 'wil_tx_desc_offload_setup_tso_edma'

Cc: Maya Erez <merez@codeaurora.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: wil6210@qti.qualcomm.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/wil6210/txrx_edma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c b/drivers/net/wireless/ath/wil6210/txrx_edma.c
index 7bfe867c7509e..1eb1a309a0264 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -147,7 +147,7 @@ static int wil_tx_init_edma(struct wil6210_priv *wil)
 	return rc;
 }
 
-/**
+/*
  * Allocate one skb for Rx descriptor RING
  */
 static int wil_ring_alloc_skb_edma(struct wil6210_priv *wil,
@@ -1152,7 +1152,7 @@ wil_get_next_tx_status_msg(struct wil_status_ring *sring, u8 *dr_bit,
 	*msg = *_msg;
 }
 
-/**
+/*
  * Clean up transmitted skb's from the Tx descriptor RING.
  * Return number of descriptors cleared.
  */
@@ -1314,7 +1314,7 @@ int wil_tx_sring_handler(struct wil6210_priv *wil,
 	return desc_cnt;
 }
 
-/**
+/*
  * Sets the descriptor @d up for csum and/or TSO offloading. The corresponding
  * @skb is used to obtain the protocol and headers length.
  * @tso_desc_type is a descriptor type for TSO: 0 - a header, 1 - first data,
-- 
2.25.1

