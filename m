Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B64AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 21:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECF520823
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 21:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hb4EWUiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbgEWV1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 17:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387905AbgEWV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 17:27:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF05FC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 14:27:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h129so13126102ybc.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 14:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=L7hPQvY2NIf4meJrg9SAHQ2svkS/4rdW/+N34fTKjso=;
        b=Hb4EWUiLNML4nAz2rpesxRQ3Xui71Qj89OfwfSHj9V4QiHPwZcMHwuf0RSOkNFix8D
         Cwb//Nc0K3oXE78uSX2KvrGQuwktkdmGND/sy466Tui/B056QjaGvSP1dtqoB0WvXthA
         0807ZieAJnvaQYOiZ7LWnTKoes3+17uK+7MCau8uULig1fq/FB8DH0GadbFtpxI4IsGR
         amCM8Hzpm8gp8ncdPu8egBC7VPFWX52gtuY+HOk+nkHYfA+44zO80L4OVWZi/HwdayDs
         xof3VJdd3Cq3INRQnW2tGnhDD0H+1jvrfr/xx2ZjJnz1KMwSCPjS/681DLnFQq6EL9Nf
         AhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=L7hPQvY2NIf4meJrg9SAHQ2svkS/4rdW/+N34fTKjso=;
        b=r/WZRfXO11HzSyemhB+EUsD013hO1guW6aRNtrcS4yOWWzwLuVoBp01Sia8FbDQ7K9
         484M8QYOrgYWz1rakO8eiSGwuYDo4J0C7suS00obsDCPN+uWff43+G6Gm/sMdfzfR4Sj
         0yJkJkUEhzNjxUkU7Eyzz8ULS/anM3l/LCXGPHmgu2H0IEIpaSBX9B3f1iSk6gRXhngv
         3U5BZ7EjyOr1Frl5dxwTL9QP2RFkp2OzX6GIlB6OsXe1jyLg9fHH8RlQ2VcaFEbt6ApF
         87UQJt8aF7JVncSWTKw4J0doX5lnc6zB8l0vxEps3ko+NtrxIw+MiYNjiu44s46XcaZv
         aDTA==
X-Gm-Message-State: AOAM532frVwATg6RifzYLuWFSvdfKqOclhOhpSpVCTlpxG4k9Zg71KLH
        n1NjagBbxrP6jlQiAKqfo5vkLHQZLvVY
X-Google-Smtp-Source: ABdhPJzlNWcVHOMWGwLCGzq9m9H3VHSJkfIikGT3epD7agMuS7DCu02ze0nAP7jyATxoOh5dWnFoWcT6Ewoe
X-Received: by 2002:a25:253:: with SMTP id 80mr18381858ybc.405.1590269266946;
 Sat, 23 May 2020 14:27:46 -0700 (PDT)
Date:   Sat, 23 May 2020 22:27:35 +0100
Message-Id: <20200523212735.32364-1-pterjan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH] atmel: Use shared constant for rfc1042 header
From:   Pascal Terjan <pterjan@google.com>
To:     Simon Kelley <simon@thekelleys.org.uk>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pascal Terjan <pterjan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is one of the 9 drivers redefining rfc1042_header.

Signed-off-by: Pascal Terjan <pterjan@google.com>
---
 drivers/net/wireless/atmel/atmel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
index 74538085cfb7..d5875836068c 100644
--- a/drivers/net/wireless/atmel/atmel.c
+++ b/drivers/net/wireless/atmel/atmel.c
@@ -798,7 +798,6 @@ static void tx_update_descriptor(struct atmel_private *priv, int is_bcast,
 
 static netdev_tx_t start_tx(struct sk_buff *skb, struct net_device *dev)
 {
-	static const u8 SNAP_RFC1024[6] = { 0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00 };
 	struct atmel_private *priv = netdev_priv(dev);
 	struct ieee80211_hdr header;
 	unsigned long flags;
@@ -853,7 +852,7 @@ static netdev_tx_t start_tx(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	if (priv->use_wpa)
-		memcpy(&header.addr4, SNAP_RFC1024, ETH_ALEN);
+		memcpy(&header.addr4, rfc1042_header, ETH_ALEN);
 
 	header.frame_control = cpu_to_le16(frame_ctl);
 	/* Copy the wireless header into the card */
-- 
2.27.0.rc0.183.gde8f92d652-goog

