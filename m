Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6BEC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 04:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8088E20757
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 04:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="bj+wXQLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgIFEEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 00:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgIFEEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 00:04:37 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3963C061574
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 21:04:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j34so991265pgi.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 21:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5cgAJ/M47tJob1MrGll46hQWP0P/4Ncz8b1EuDVEqMg=;
        b=bj+wXQLQkSfx5qaJUAyTW3bRLz3iQqXmy3cYLXVKdxG8QJYJ6QKh02deys+Ye3Slre
         4xzMzbJgI9p1DVyuhhqzQYBZhjHIa+2dvy1t3eyhbZTqRVOXHU0i3RCT4YRuds+Ply7K
         nA9OJ88MD56Z5EUOiq27pYAZnT8U04bbUqFEPTA2kCMaOrdWz9F1919NlDERN8V2zX1/
         +kksNtk6dQUQmgKFQW6ZHnc6gq9kpTvYwJC9VM8NZLB93vn4OpveGkbwZ0wZI7Ds0Lan
         ECyH14w1qYaCrglb+gL6hYS/ia93c2Ek905iXsiVccbex1cYqbywPQVOt+deCadyLPZI
         ueNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5cgAJ/M47tJob1MrGll46hQWP0P/4Ncz8b1EuDVEqMg=;
        b=s0aYn2pY3JP6cJQNklpDa7Dd10aYNR4ynn7qxx6lmFAF83qnfR6nmwXSxKgxACzeUm
         3bhZp75XhB/DAp4itCCyo+cnIifdI0kT8CdSszd8mI4ebZjpYVq6lWXtPr5HGa7BYc7i
         49FkmCCfTtyr+Yz35n0SfkaWhZSKKknzlblwbFp+sKmI3ruLSRE7NloqUQyBEY6/0KGt
         gYUYGWWrCwh/MJh+uwJnV4rz8ZZmP/rQmJbDfR9JqEKs/nB3VtihJNsj82jbBDK+LQp+
         Zmq4RQmjo31OM8+VVNZmMH7Tp5QoZnGpflL1SZVdjrNxmSil/LW21sE5dgbcn5vJEjCj
         DfRg==
X-Gm-Message-State: AOAM530MuvHFzqYBCEN9QQEv2/K7OkWZ2TEp70OodRYSyez0Ei5BQLd4
        0dfc7Vn8NWp9guCGu04c/njBIg==
X-Google-Smtp-Source: ABdhPJySDsaeopqr8sa0QuCqwxs/O+aUhy9KjYsBarbIvUV2b9xJ/7bF1Lp+4IFW7AMflqhOnH2yrQ==
X-Received: by 2002:a62:4e8a:0:b029:13c:1611:653b with SMTP id c132-20020a624e8a0000b029013c1611653bmr12803945pfb.13.1599365075335;
        Sat, 05 Sep 2020 21:04:35 -0700 (PDT)
Received: from localhost.localdomain (111-243-26-127.dynamic-ip.hinet.net. [111.243.26.127])
        by smtp.gmail.com with ESMTPSA id l7sm2347096pjz.56.2020.09.05.21.04.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Sep 2020 21:04:34 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Chiu <chiu@endlessm.com>
Subject: [PATCH] rtl8xxxu: prevent potential memory leak
Date:   Sun,  6 Sep 2020 12:04:24 +0800
Message-Id: <20200906040424.22022-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free the skb if usb_submit_urb fails on rx_urb. And free the urb
no matter usb_submit_urb succeeds or not in rtl8xxxu_submit_int_urb.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 19efae462a24..5cd7ef3625c5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5795,7 +5795,6 @@ static int rtl8xxxu_submit_int_urb(struct ieee80211_hw *hw)
 	ret = usb_submit_urb(urb, GFP_KERNEL);
 	if (ret) {
 		usb_unanchor_urb(urb);
-		usb_free_urb(urb);
 		goto error;
 	}
 
@@ -5804,6 +5803,7 @@ static int rtl8xxxu_submit_int_urb(struct ieee80211_hw *hw)
 	rtl8xxxu_write32(priv, REG_USB_HIMR, val32);
 
 error:
+	usb_free_urb(urb);
 	return ret;
 }
 
@@ -6318,6 +6318,7 @@ static int rtl8xxxu_start(struct ieee80211_hw *hw)
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct rtl8xxxu_rx_urb *rx_urb;
 	struct rtl8xxxu_tx_urb *tx_urb;
+	struct sk_buff *skb;
 	unsigned long flags;
 	int ret, i;
 
@@ -6368,6 +6369,13 @@ static int rtl8xxxu_start(struct ieee80211_hw *hw)
 		rx_urb->hw = hw;
 
 		ret = rtl8xxxu_submit_rx_urb(priv, rx_urb);
+		if (ret) {
+			if (ret != -ENOMEM) {
+				skb = (struct sk_buff *)rx_urb->urb.context;
+				dev_kfree_skb(skb);
+			}
+			rtl8xxxu_queue_rx_urb(priv, rx_urb);
+		}
 	}
 
 	schedule_delayed_work(&priv->ra_watchdog, 2 * HZ);
-- 
2.20.1

