Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02557C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC26B20738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhOhwnPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgH0Hfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgH0Hft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:35:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3D7C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:35:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h15so4314641wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y3aNmNMSAAKySSaB5bb9ahC7IKT1fIK3BKBDgaZqfos=;
        b=MhOhwnPkn/mXHk29S0aVGPJU+5pGzM00XUyRGPLOZAnJUjsvfY0rCUKwzWzrzdKk8B
         FTmXKFB6z7GR7R/M1UEGZAUnMVK3c7iUB2d6ME0A74idDUUTr8FnttE4PzyNoRn1dDaN
         4Fe7Pq9ZXuzFK6T2K/MTj6iemQynffo8dufGq8IT78d+oGaKz/KejTRqiLTf/xnEEQBi
         slzHFZ6xWq0nv16ud1WN92MQgBuot96gRpLkxkpjddXr3H7lVTHaK9DQ3Y58m2wrCNem
         F/U3wCjoehqArOBRwez7CFZ4tkLH02bmDlPa9zjB6s6mR2KjUjVFBlpcKguHz9+0lymL
         g7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y3aNmNMSAAKySSaB5bb9ahC7IKT1fIK3BKBDgaZqfos=;
        b=dqpWYzKQMxdLJNhNxwJsYEpbbUZ7NZ2p2NyWe5YbmeVEDU4hcUZTjtQWVJUX8Mcdgr
         HjI3t+UxvyoJ3IkYn1TpvUK/dz8fJtaIC0PtMlCaixBRorByYPlDWGMxLM/c7iphkhjk
         XrbrIO8S4OvT/HbgzSdHsCYyQ4kiQQkdbp+26IN49qNUf0o3Am5JxVn1A/wYOEllAV2R
         NvbUNoVvKoFQ+7pRL7jrARS1409uDwJZ9+Q4sxn6iUL449Ge8ano/dgSnY8jNL3LUgbz
         hd9xtjLmwTWDdJMfmDJoI2LTt594DE62PRG1jhfStKLYKpS5m3raElqhhRRPOWA13xb3
         XM0A==
X-Gm-Message-State: AOAM530Y+E57QqTw17E+jDZOwh/rPscZjbWUfG7GI4oNXKTHlmAwn1V/
        lbya4fFUbAm2o1hHsv0y6JDHVw==
X-Google-Smtp-Source: ABdhPJyWD1fdGyzx1TwvJ8SngQQVXACF9Ez6lTR5lordc8i60z7i6OZvhFz80HM5+t9PexURWoznSw==
X-Received: by 2002:adf:ee4a:: with SMTP id w10mr18352605wro.197.1598513747908;
        Thu, 27 Aug 2020 00:35:47 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id a8sm3868108wrh.86.2020.08.27.00.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 00:35:47 -0700 (PDT)
Date:   Thu, 27 Aug 2020 08:35:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Maya Erez <merez@codeaurora.org>,
        wil6210@qti.qualcomm.com
Subject: [PATCH v2 28/32] wireless: ath: wil6210: txrx_edma: Demote comments
 which are clearly not kernel-doc
Message-ID: <20200827073545.GU3248864@dell>
References: <20200821071644.109970-1-lee.jones@linaro.org>
 <20200821071644.109970-29-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821071644.109970-29-lee.jones@linaro.org>
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
 drivers/net/wireless/ath/wil6210/txrx_edma.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c b/drivers/net/wireless/ath/wil6210/txrx_edma.c
index 7bfe867c7509e..8ca2ce51c83ef 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -147,9 +147,7 @@ static int wil_tx_init_edma(struct wil6210_priv *wil)
 	return rc;
 }
 
-/**
- * Allocate one skb for Rx descriptor RING
- */
+/* Allocate one skb for Rx descriptor RING */
 static int wil_ring_alloc_skb_edma(struct wil6210_priv *wil,
 				   struct wil_ring *ring, u32 i)
 {
@@ -1152,8 +1150,7 @@ wil_get_next_tx_status_msg(struct wil_status_ring *sring, u8 *dr_bit,
 	*msg = *_msg;
 }
 
-/**
- * Clean up transmitted skb's from the Tx descriptor RING.
+/* Clean up transmitted skb's from the Tx descriptor RING.
  * Return number of descriptors cleared.
  */
 int wil_tx_sring_handler(struct wil6210_priv *wil,
@@ -1314,8 +1311,7 @@ int wil_tx_sring_handler(struct wil6210_priv *wil,
 	return desc_cnt;
 }
 
-/**
- * Sets the descriptor @d up for csum and/or TSO offloading. The corresponding
+/* Sets the descriptor @d up for csum and/or TSO offloading. The corresponding
  * @skb is used to obtain the protocol and headers length.
  * @tso_desc_type is a descriptor type for TSO: 0 - a header, 1 - first data,
  * 2 - middle, 3 - last descriptor.
-- 
2.25.1
