Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7ECC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E972D23C3F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LbyxmIdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgFUTbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 15:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730288AbgFUTbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 15:31:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33D5C061797
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:31:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id v3so7078530wrc.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LFDRXwTitCs1nrRc2jOX6sWRaTpGwdnr5FsLJM6PpMw=;
        b=LbyxmIddIqVwlVyDrhBNdNJYWnIxcroyi8gEbTkbaVer9A2emoTWqlBqwN//azBoIs
         8RArNyjqMpHYjWHKa2HtU6yR53NGxHcb25cfKNwOltxxy1VLHPprDytFMVutQSW84bg4
         N/QDEcS+6oL8CiTIwD/9EurfZajZIYLyIcmcXcxhvJfJIqOGa5KxUZFyJ798/L2vSplN
         64ySfeFSa1b4SF/ZAcoP3Zs0wtasp7u+FivzahEwzvMlJ0QoyYwZZefeDGM8YineSMAO
         2yR3aCvt3abGlSVk/LM9hEMxB5zW7EUVjVegBrQSFngHFrbpQaw4fskRlbbLqCLsaIAu
         KQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LFDRXwTitCs1nrRc2jOX6sWRaTpGwdnr5FsLJM6PpMw=;
        b=rREPmKog9OkTpiurM5WmOPnokWtOSn29wk00Q3RPbcZRnB+97z8kfGH4L0qeKKJxx5
         fzd/9Fh+dKFwPQXPLY71/3600XiYmIAwtOHWRNWDAmNu04kgPymrxXQGeDz06QOCbiQv
         Q767VAlnbtVh99RcPnMqzPzOqEpnSpmPEOhV1/ZfMeFrtWHrjKnCbG3YNApqTyzSInZh
         Dg44LSBpI7LtGmKfadxoLEQdoDCIiHGY4BUxGoBcKE9aR23U//aYjDu/X4SWSVEzBU9c
         pc1AW5ReC16sADk0L4g6bL9r7ayI77hXImTfhH7leTPfa5F9XQ8jK59sw6Z8YNfklbvq
         7TGw==
X-Gm-Message-State: AOAM5301i18TddweYiL7LBb+VZmDUs8kZEdoGxpBb5fsdXMfiLH+sr+5
        o5Pn7sS9TNMf6FwfWQsnp1+6UQ==
X-Google-Smtp-Source: ABdhPJzH5Rl0vy2fvwdAWyfkHLzRKA42JFPpKgqIpR/JnM/nbm4j5KRCHFpd9pFsONa8AZQ4VctBrQ==
X-Received: by 2002:a5d:4f01:: with SMTP id c1mr14539533wru.190.1592767874285;
        Sun, 21 Jun 2020 12:31:14 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e3sm16086924wrj.17.2020.06.21.12.31.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2020 12:31:13 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 01/14] crypto: sun8i-ss: Add SS_START define
Date:   Sun, 21 Jun 2020 19:30:54 +0000
Message-Id: <1592767867-35982-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592767867-35982-1-git-send-email-clabbe@baylibre.com>
References: <1592767867-35982-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using an hardcoded value, let's use a defined value for
SS_START.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 2 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 5d9d0fedcb06..81eff935fb5c 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -61,7 +61,7 @@ int sun8i_ss_run_task(struct sun8i_ss_dev *ss, struct sun8i_cipher_req_ctx *rctx
 		      const char *name)
 {
 	int flow = rctx->flow;
-	u32 v = 1;
+	u32 v = SS_START;
 	int i;
 
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_DEBUG
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index 29c44f279112..f7a64033fc03 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -13,6 +13,8 @@
 #include <linux/debugfs.h>
 #include <linux/crypto.h>
 
+#define SS_START	1
+
 #define SS_ENCRYPTION		0
 #define SS_DECRYPTION		BIT(6)
 
-- 
2.26.2

