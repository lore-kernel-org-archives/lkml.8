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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFB7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4832080D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dilKe5du"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgHQIKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgHQIKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:10:08 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497A7C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d4so7321591pjx.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oXuZM0UtzOKb7bYgg7JDDFHqHlWmubYl3laiIuHyNew=;
        b=dilKe5duicGRVShs9cymAV633YA7iyG35fWZzdKAe//8TCTIpnL081KwCo9e8lKa5C
         /Hkf4f/0gldooNUTSwS9EZU0IpNoW61tWtS/RrWPgHwV49BfHBMut/rjo4G83mrB2EAK
         vgVWZDQWM7CcQxye8kydk/tg9s0E9WKNwlMurMv4SfNlJ4x5IbqreFdeQuRZ+5yQeNlb
         V1drdbJ3O3Y6LofPIGU7alwke2OJ6EiKeNdPlI+UK6NXUWEjK/yWIExkCs4PcGiaT6J2
         Gbo4rnU30z6V3jp8pFAk7Z/YdKA6hbbyaVW/rqQPvVxNkwtej2Am28eStfCNT9jxYyPr
         PmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oXuZM0UtzOKb7bYgg7JDDFHqHlWmubYl3laiIuHyNew=;
        b=S7c+w67Eg2yJfnGjnpb1KsK+73l+K3geOioGPP0WMLj5no4sd/7EoMBWgEuzbTNkhF
         mQq9LN501BWJWYwpR/107+tRffZRtXMEMVvgpRSo660A6Gene32sG2emKGojBK0PsePp
         /Q61hvPCXQdICTVFoYMjfR07sR2nOtMXpD+iom2P3vzkv9BdrNm2N6y9zb0yEbLvAXln
         DxOpMFcswOIyD8/TbmAEzu75ITpQcwOOJciIk8HjWBJ9xk0XG+rU1OZrf+iskRzjBSsH
         eXmEXCjy1w5fEEvyPmU/j+G0K1DwFD4TLaw8P9VqDMTK/ip5RqsHcMoV6ttrN+kgakJU
         5JEw==
X-Gm-Message-State: AOAM530OIdmOIEzwUASYcMQDGptGcVpR2RGBRHPDASUXnImzou6Uw6fk
        M0uaHvQRUh0drNuHAASe9Gg=
X-Google-Smtp-Source: ABdhPJw4+imJJVYhPWAJOmoDuSgHiaiwqr0MfGtF+c8aOUcQplUQ6y6DBuEzcIDmE0XEQGrGDBZOQw==
X-Received: by 2002:a17:90a:bc96:: with SMTP id x22mr12223652pjr.164.1597651807885;
        Mon, 17 Aug 2020 01:10:07 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:10:07 -0700 (PDT)
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
Subject: [PATCH 02/19] crypto: atmel: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:24 +0530
Message-Id: <20200817080941.19227-3-allen.lkml@gmail.com>
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
 drivers/crypto/atmel-aes.c  | 14 ++++++--------
 drivers/crypto/atmel-sha.c  | 14 ++++++--------
 drivers/crypto/atmel-tdes.c | 14 ++++++--------
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index a6e14491e080..99851e40c729 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -2300,16 +2300,16 @@ static void atmel_aes_dma_cleanup(struct atmel_aes_dev *dd)
 	dma_release_channel(dd->src.chan);
 }
 
-static void atmel_aes_queue_task(unsigned long data)
+static void atmel_aes_queue_task(struct tasklet_struct *t)
 {
-	struct atmel_aes_dev *dd = (struct atmel_aes_dev *)data;
+	struct atmel_aes_dev *dd = from_tasklet(dd, t, queue_task);
 
 	atmel_aes_handle_queue(dd, NULL);
 }
 
-static void atmel_aes_done_task(unsigned long data)
+static void atmel_aes_done_task(struct tasklet_struct *t)
 {
-	struct atmel_aes_dev *dd = (struct atmel_aes_dev *)data;
+	struct atmel_aes_dev *dd = from_tasklet(dd, t, done_task);
 
 	dd->is_async = true;
 	(void)dd->resume(dd);
@@ -2499,10 +2499,8 @@ static int atmel_aes_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&aes_dd->list);
 	spin_lock_init(&aes_dd->lock);
 
-	tasklet_init(&aes_dd->done_task, atmel_aes_done_task,
-					(unsigned long)aes_dd);
-	tasklet_init(&aes_dd->queue_task, atmel_aes_queue_task,
-					(unsigned long)aes_dd);
+	tasklet_setup(&aes_dd->done_task, atmel_aes_done_task);
+	tasklet_setup(&aes_dd->queue_task, atmel_aes_queue_task);
 
 	crypto_init_queue(&aes_dd->queue, ATMEL_AES_QUEUE_LENGTH);
 
diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 75ccf41a7cb9..84a7c8a9dd02 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -1314,9 +1314,9 @@ static struct ahash_alg sha_384_512_algs[] = {
 },
 };
 
-static void atmel_sha_queue_task(unsigned long data)
+static void atmel_sha_queue_task(struct tasklet_struct *t)
 {
-	struct atmel_sha_dev *dd = (struct atmel_sha_dev *)data;
+	struct atmel_sha_dev *dd = from_tasklet(dd, t, queue_task);
 
 	atmel_sha_handle_queue(dd, NULL);
 }
@@ -1353,9 +1353,9 @@ static int atmel_sha_done(struct atmel_sha_dev *dd)
 	return err;
 }
 
-static void atmel_sha_done_task(unsigned long data)
+static void atmel_sha_done_task(struct tasklet_struct *t)
 {
-	struct atmel_sha_dev *dd = (struct atmel_sha_dev *)data;
+	struct atmel_sha_dev *dd = from_tasklet(dd, t, done_task);
 
 	dd->is_async = true;
 	(void)dd->resume(dd);
@@ -2570,10 +2570,8 @@ static int atmel_sha_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&sha_dd->list);
 	spin_lock_init(&sha_dd->lock);
 
-	tasklet_init(&sha_dd->done_task, atmel_sha_done_task,
-					(unsigned long)sha_dd);
-	tasklet_init(&sha_dd->queue_task, atmel_sha_queue_task,
-					(unsigned long)sha_dd);
+	tasklet_setup(&sha_dd->done_task, atmel_sha_done_task);
+	tasklet_setup(&sha_dd->queue_task, atmel_sha_queue_task);
 
 	crypto_init_queue(&sha_dd->queue, ATMEL_SHA_QUEUE_LENGTH);
 
diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index ed40dbb98c6b..170809892acf 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -1049,16 +1049,16 @@ static struct skcipher_alg tdes_algs[] = {
 },
 };
 
-static void atmel_tdes_queue_task(unsigned long data)
+static void atmel_tdes_queue_task(struct tasklet_struct *t)
 {
-	struct atmel_tdes_dev *dd = (struct atmel_tdes_dev *)data;
+	struct atmel_tdes_dev *dd = from_tasklet(dd, t, queue_task);
 
 	atmel_tdes_handle_queue(dd, NULL);
 }
 
-static void atmel_tdes_done_task(unsigned long data)
+static void atmel_tdes_done_task(struct tasklet_struct *t)
 {
-	struct atmel_tdes_dev *dd = (struct atmel_tdes_dev *) data;
+	struct atmel_tdes_dev *dd = from_tasklet(dd, t, done_task);
 	int err;
 
 	if (!(dd->flags & TDES_FLAGS_DMA))
@@ -1177,10 +1177,8 @@ static int atmel_tdes_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&tdes_dd->list);
 	spin_lock_init(&tdes_dd->lock);
 
-	tasklet_init(&tdes_dd->done_task, atmel_tdes_done_task,
-					(unsigned long)tdes_dd);
-	tasklet_init(&tdes_dd->queue_task, atmel_tdes_queue_task,
-					(unsigned long)tdes_dd);
+	tasklet_setup(&tdes_dd->done_task, atmel_tdes_done_task);
+	tasklet_setup(&tdes_dd->queue_task, atmel_tdes_queue_task);
 
 	crypto_init_queue(&tdes_dd->queue, ATMEL_TDES_QUEUE_LENGTH);
 
-- 
2.17.1

