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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA86C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC172080D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3GLZCJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgHQILu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgHQILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:11:19 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769D3C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:11:19 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s14so1147291plp.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9P4UiaV8KPwel1Tt9KznXK/0ns/MMrwircAHJYOTu7A=;
        b=r3GLZCJWNlctZu3MPc3ZktHezCi9I2Lgci9quhal0K/lYWU2YxEI16zK2p3ooqfNit
         +fAkbSvrmIAk5pGEm8CaNi/rDu8w1HgrPE9X/kqPFvXxQadi1mwV51kDgu4kPZYbtxO5
         aCFOq8j+ttIjUl2GbfMIrJsCgY8lCgalLwAsLwOCtwB8puTqdICaZkG9bgt2XeVti5v4
         rfnLq70AzkzKewtTbXjYA67XjHP7HVT2EHHAF/P1PjBIVjF9eUatUBANtzFGb9G2O2Is
         51S64GucqinbZVux8cgh09OvCL6aJmEREOvh9+sIk0V1LU9My1LNvw/brCCcyn/z1NF5
         Q1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9P4UiaV8KPwel1Tt9KznXK/0ns/MMrwircAHJYOTu7A=;
        b=lhm1JCS6BiaovhO3h9Dzhhw4wZ+07h11ZHw8Sfab0+/I7aGjuWhfM08p4NSaGqEWAm
         lc1iomMnLcmrrFEfs8gK4zK6DOjggWkk0TNWV83yhLAvvhLeyrp7oZOiGeUfasxOrXvK
         XUUPYAGuX+KRIFwq52aO2GmdU48oBFh2JExNiMmLuuQjU0xazs8HuZvzt2LMzcArZkpB
         vlxKmQicRwv35axqReTTVoXRg16AQ4MaIk5p/PM/D3MwAPUQIwVeaCfquxsB7UGwSZ7x
         Aitu4HzTb1V3U5g2HR7vGpAUpdrUzCHtmeC+Y7S7hCPm+uGvjk75+AdtwFaAFUmA2SlB
         MBwQ==
X-Gm-Message-State: AOAM531dVfxAGowYM4EPaAEDeBZZIKzQikkxwlXL4ZU8knaM/6pgUHvj
        M8o82PbYwpzsvYuv8Thvhu0=
X-Google-Smtp-Source: ABdhPJxTMIDoLuD0wfD5gOa8F8cIxaCsYKHgtCExwrUW8xhgxL6VK0Q3dQ22P3FK+4kYogWSGoyK5A==
X-Received: by 2002:a17:90a:154e:: with SMTP id y14mr11992119pja.178.1597651879050;
        Mon, 17 Aug 2020 01:11:19 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:11:18 -0700 (PDT)
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
Subject: [PATCH 17/19] crypto: s5p: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:39 +0530
Message-Id: <20200817080941.19227-18-allen.lkml@gmail.com>
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
 drivers/crypto/s5p-sss.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index 341433fbcc4a..3647dffc307f 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -1443,9 +1443,9 @@ static int s5p_hash_handle_queue(struct s5p_aes_dev *dd,
  * s5p_hash_tasklet_cb() - hash tasklet
  * @data:	ptr to s5p_aes_dev
  */
-static void s5p_hash_tasklet_cb(unsigned long data)
+static void s5p_hash_tasklet_cb(struct tasklet_struct *t)
 {
-	struct s5p_aes_dev *dd = (struct s5p_aes_dev *)data;
+	struct s5p_aes_dev *dd = from_tasklet(dd, t, hash_tasklet);
 
 	if (!test_bit(HASH_FLAGS_BUSY, &dd->hash_flags)) {
 		s5p_hash_handle_queue(dd, NULL);
@@ -1973,9 +1973,9 @@ static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 	s5p_aes_complete(req, err);
 }
 
-static void s5p_tasklet_cb(unsigned long data)
+static void s5p_tasklet_cb(struct tasklet_struct *t)
 {
-	struct s5p_aes_dev *dev = (struct s5p_aes_dev *)data;
+	struct s5p_aes_dev *dev = from_tasklet(dev, t, tasklet);
 	struct crypto_async_request *async_req, *backlog;
 	struct s5p_aes_reqctx *reqctx;
 	unsigned long flags;
@@ -2257,7 +2257,7 @@ static int s5p_aes_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pdata);
 	s5p_dev = pdata;
 
-	tasklet_init(&pdata->tasklet, s5p_tasklet_cb, (unsigned long)pdata);
+	tasklet_setup(&pdata->tasklet, s5p_tasklet_cb);
 	crypto_init_queue(&pdata->queue, CRYPTO_QUEUE_LEN);
 
 	for (i = 0; i < ARRAY_SIZE(algs); i++) {
@@ -2267,8 +2267,7 @@ static int s5p_aes_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->use_hash) {
-		tasklet_init(&pdata->hash_tasklet, s5p_hash_tasklet_cb,
-			     (unsigned long)pdata);
+		tasklet_setup(&pdata->hash_tasklet, s5p_hash_tasklet_cb);
 		crypto_init_queue(&pdata->hash_queue, SSS_HASH_QUEUE_LENGTH);
 
 		for (hash_i = 0; hash_i < ARRAY_SIZE(algs_sha1_md5_sha256);
-- 
2.17.1

