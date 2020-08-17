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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A40C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A86207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBOxEYVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHQILz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgHQILQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:11:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA16CC061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:11:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r4so7124089pls.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0I0WPdb+Lnw0T9UwVRKshyQRyAmBHfkv+OIhMK0TwCo=;
        b=XBOxEYVLtO2d2M09e9vTXjaL+F4HowWz6DhEtXsFNUd951C+5m4MzRyoZxFJWYzrnO
         mwikjKG2qiC1NFIgVCjXOgYdEh4rIRn2IF1R+D0Y2MOrmlsJGUFTYGGu5biSm5l4w55/
         4O0k0A77BOI+DcVDGguCfMX+9fARyOmTI7IeL7Ecg5dpxptZdvGN6wbD5zMQJnpAe+Z9
         BdUlPY0isvAhdgwTfc7p/ItKyKbU6aJNjROrPBeECqASpe15Nd3BED/akhjyaRaaL9V6
         wBjZ4MrFjHybqqJljXD89sOEqWkbOUGk09/Ov6gtyBSPb5MJaObTvCMDihr0WuYVhDQW
         1r5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0I0WPdb+Lnw0T9UwVRKshyQRyAmBHfkv+OIhMK0TwCo=;
        b=r2g+WYdNZCUqYi0U4ba0zh/YotdcMvvY93tS1UKZjHwbAXVRcpZdyqFA7hjnnk5qBE
         lkydknvucRvlWXPsABs2zUYwy4xI4YdB5WNhWQJxEm+1vYvN2+1uIWU4/qQd8GUkEedm
         /YOVRTmAW3vCRDP1WL777TVfWw6cxeKHAD2G3ikuz8hrES4dxX7AFNFPxfcehcJNXnk+
         RnoEkVXduf2b75ibn5fxpW/8jygh18lwTMtqh/cuxyB0wQNwKtXrDOMCAsQWoTc4XJ6A
         dE6wVd0bWzjwfxwqk7X636gH6+UGIPUh85pWkaIVEONOf5+S/lTvdcJUCHX0jJ9kovSC
         dUMQ==
X-Gm-Message-State: AOAM531LHxLqOWlCLX62S1TptOyjMVJS67sQ/mOWoaZjoI8HPvOTLGjb
        x7sw/XdRfM9sjeEOAKfUWL0=
X-Google-Smtp-Source: ABdhPJz2yRlSGkjkyLzNCiZu5WWMgo5Ib2xo7ul7gKuWuKj/0odSFXT4lG38fkzXMXkYK2N9DxmmjA==
X-Received: by 2002:a17:902:bb90:: with SMTP id m16mr4634935pls.144.1597651875281;
        Mon, 17 Aug 2020 01:11:15 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:11:14 -0700 (PDT)
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
Subject: [PATCH 16/19] crypto: rockchip: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:38 +0530
Message-Id: <20200817080941.19227-17-allen.lkml@gmail.com>
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
 drivers/crypto/rockchip/rk3288_crypto.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index f385587f99af..23a695f31d1d 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -200,9 +200,9 @@ static int rk_crypto_enqueue(struct rk_crypto_info *dev,
 	return ret;
 }
 
-static void rk_crypto_queue_task_cb(unsigned long data)
+static void rk_crypto_queue_task_cb(struct tasklet_struct *T)
 {
-	struct rk_crypto_info *dev = (struct rk_crypto_info *)data;
+	struct rk_crypto_info *dev = from_tasklet(dev, t, queue_task);
 	struct crypto_async_request *async_req, *backlog;
 	unsigned long flags;
 	int err = 0;
@@ -230,9 +230,9 @@ static void rk_crypto_queue_task_cb(unsigned long data)
 		dev->complete(dev->async_req, err);
 }
 
-static void rk_crypto_done_task_cb(unsigned long data)
+static void rk_crypto_done_task_cb(struct tasklet_struct *t)
 {
-	struct rk_crypto_info *dev = (struct rk_crypto_info *)data;
+	struct rk_crypto_info *dev = from_tasklet(dev, t, done_task);
 
 	if (dev->err) {
 		dev->complete(dev->async_req, dev->err);
@@ -388,10 +388,8 @@ static int rk_crypto_probe(struct platform_device *pdev)
 	crypto_info->dev = &pdev->dev;
 	platform_set_drvdata(pdev, crypto_info);
 
-	tasklet_init(&crypto_info->queue_task,
-		     rk_crypto_queue_task_cb, (unsigned long)crypto_info);
-	tasklet_init(&crypto_info->done_task,
-		     rk_crypto_done_task_cb, (unsigned long)crypto_info);
+	tasklet_setup(&crypto_info->queue_task, rk_crypto_queue_task_cb);
+	tasklet_setup(&crypto_info->done_task, rk_crypto_done_task_cb);
 	crypto_init_queue(&crypto_info->queue, 50);
 
 	crypto_info->enable_clk = rk_crypto_enable_clk;
-- 
2.17.1

