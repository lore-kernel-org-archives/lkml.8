Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913F7C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706BB207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ17WiWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHQIKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgHQIKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:10:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B708EC061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 74so7831941pfx.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EjM/bc9oMW+0sBykqCFUkPw3qkHdhalyi/ZZCcuM7jI=;
        b=TZ17WiWGgSUx7KDRMcYgdPiVlPvhIeKyT7JacWITYd5bfAzGX0K/drdRZgf/IgMZnQ
         haeKHiKqj+EWZOMjz9vK4jyjQiqD2EsYL5wZtUY/7MKM8EcwZCyMRJ9m0MJHmJysxrGT
         rEe7Yhg9fiXCpeiIOwHg87Nc2oW9XxSEsocphkY+WifyY5+Lr48OB0OlGW1u2ACfuUp2
         1lrjWZf+TyJF5sRol6kMfbmX6DqRnNgYIZ7szwvBsl3Dc96FJPHdC/QrIh8YsFfghKkv
         Lds0hCRbLyYqsmh1KhEpxq6A5urNKeBOU3y2s7X0wX6op6r5rAs4OcFXJX8gg7m83fNC
         srrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EjM/bc9oMW+0sBykqCFUkPw3qkHdhalyi/ZZCcuM7jI=;
        b=lqHsobhd961gl4JcUULvyMLtF2P0zceq3TIDOQwMkVQvJMCh59CH4V5Z2EpyPja38D
         AwdxQaKA51hzDNjUucQdM61NcMmn2KrTtn4bOmBW5wPNHYitnpgYkRfBBW4vh8qHLqb+
         rPcf1Bxln/UO/RIlSM1mk4wMpdMTSMNx/hQ9FBBUuzTD2Y1lriUVOjPPwdEEE1Cb8yAX
         2JUg5dSnnQEO3nCWgDJQKw+Sxa4XU3DEWmIerVkxjO8eqeNYYcXA3rspTI/2y5BAfQhY
         eNvxCcOnY5r67YbKYpeFP/tre1jWHe+qXGXwya3vt4on7rt2uPW+CDNMVpi0wcU2Hk2O
         q+/w==
X-Gm-Message-State: AOAM533oDwqo+dO52nigfqllH5+1pVs0/EvIeJVZOaAIH3u4WKAn6aWN
        dbsRO9nTSWrtkx3LrcvoEY4=
X-Google-Smtp-Source: ABdhPJyC+tc9WoKzXMgb8ccCrUbWRcq5oU1rFYGbt/72fsZUVj49tUcq4g9/xNjX1u4iKnS7QZEhOA==
X-Received: by 2002:a63:31c6:: with SMTP id x189mr6189388pgx.182.1597651812808;
        Mon, 17 Aug 2020 01:10:12 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:10:12 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, heiko@sntech.de,
        matthias.bgg@gmail.com
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        inux-mediatek@lists.infradead.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 03/19] crypto: axis: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:25 +0530
Message-Id: <20200817080941.19227-4-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817080941.19227-1-allen.lkml@gmail.com>
References: <20200817080941.19227-1-allen.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/crypto/axis/artpec6_crypto.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 1a46eeddf082..83e4c164dedb 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -2074,9 +2074,9 @@ static void artpec6_crypto_timeout(struct timer_list *t)
 	tasklet_schedule(&ac->task);
 }
 
-static void artpec6_crypto_task(unsigned long data)
+static void artpec6_crypto_task(struct tasklet_struct *t)
 {
-	struct artpec6_crypto *ac = (struct artpec6_crypto *)data;
+	struct artpec6_crypto *ac = from_tasklet(ac, t, task);
 	struct artpec6_crypto_req_common *req;
 	struct artpec6_crypto_req_common *n;
 	struct list_head complete_done;
@@ -2899,8 +2899,7 @@ static int artpec6_crypto_probe(struct platform_device *pdev)
 	artpec6_crypto_init_debugfs();
 #endif
 
-	tasklet_init(&ac->task, artpec6_crypto_task,
-		     (unsigned long)ac);
+	tasklet_setup(&ac->task, artpec6_crypto_task);
 
 	ac->pad_buffer = devm_kzalloc(&pdev->dev, 2 * ARTPEC_CACHE_LINE_MAX,
 				      GFP_KERNEL);
-- 
2.17.1

