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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24F6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8275C207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH+SZkjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHQIKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgHQIKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:10:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD91CC061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k18so7842866pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+CczU85S+/uH24ewiNmvI8CVQIP/5ll4+ExQ6Q4RriA=;
        b=QH+SZkjSRXli6dhDl/PYa92MYnDglHyX/Y+c8a919EtHMLwSk11mD0xwVEGvrYzsjG
         6YHStcWlbvDg7m1nCbTu0mzv4oZuD8ixW7hNibRqKw8PcLmHtLG2/QciwIzw+8fj1QzI
         +k9V6tnsiKr6cex+82bCgVz3pI+EM+ZXMvggkx35zkVe2ztbSG6mN58KHAX1R4vLDETd
         T64cUILKyX0ps+0NxtbWr0jr8yJZnlso4tfOXh/ZuhkzOwn0HkHiRPshvFvtOdAALHD7
         z8CPKf0Ux+LhIy1Jnsz2SiSfL+T0uJNzDkf32MhphrNkOu8oFKovfslNCi32tB0Ln7tf
         1aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+CczU85S+/uH24ewiNmvI8CVQIP/5ll4+ExQ6Q4RriA=;
        b=Z8SXzX/P7ZxAy0n+VBgjYvm5DmFhnfuI/pKgIaXdJsBVMzHHPHMnHV98s1a2QlPOzw
         GIMYVZlX4ZSw1SGtWGjAzSbPCwJX6AGJ5Oi1e/OhZ/6qr5GjpewaeqH0NKQB6FOfXChJ
         bk6sB/n1hBxhTmq7kF+C5xqzHA6OnjKQ5dYGngR2Dv5ufzSNvITr5klJCa1oTGNtSsjS
         WZ/6JIkJkRmyDtsxlXsFKT4brH5p8nBbQIS76Or7zugxHOCczdIFOkihVZ+/Us6o/HPL
         4m+LCNpsoXQt+j1juwXrUN8lSWZeWyjhqnVPcklPExEE7Tc/YIxkYIBpammBQmN1AobS
         e3BA==
X-Gm-Message-State: AOAM5335taHNbfCBuNsf8p1rDDGbFFCVlCgg/TucQvF9P6pfJW6NXEZE
        5iyiXXwgTJHVHu2BpVupyCk=
X-Google-Smtp-Source: ABdhPJxmetqO1n9H4Ju5wN5dejc+GQRTEjJ2B9RVF6qMxczI2kKGGoFf4wVOw48rAOu09tHL2QUQtA==
X-Received: by 2002:a62:1745:: with SMTP id 66mr10016518pfx.273.1597651846354;
        Mon, 17 Aug 2020 01:10:46 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:10:45 -0700 (PDT)
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
Subject: [PATCH 09/19] crypto: img-hash: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:31 +0530
Message-Id: <20200817080941.19227-10-allen.lkml@gmail.com>
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
 drivers/crypto/img-hash.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/img-hash.c b/drivers/crypto/img-hash.c
index 87226b7c2795..0e1a32bdbaf4 100644
--- a/drivers/crypto/img-hash.c
+++ b/drivers/crypto/img-hash.c
@@ -353,9 +353,9 @@ static int img_hash_dma_init(struct img_hash_dev *hdev)
 	return 0;
 }
 
-static void img_hash_dma_task(unsigned long d)
+static void img_hash_dma_task(struct tasklet_struct *t)
 {
-	struct img_hash_dev *hdev = (struct img_hash_dev *)d;
+	struct img_hash_dev *hdev = from_tasklet(hdev, t, dma_task);
 	struct img_hash_request_ctx *ctx = ahash_request_ctx(hdev->req);
 	u8 *addr;
 	size_t nbytes, bleft, wsend, len, tbc;
@@ -885,9 +885,9 @@ static int img_unregister_algs(struct img_hash_dev *hdev)
 	return 0;
 }
 
-static void img_hash_done_task(unsigned long data)
+static void img_hash_done_task(struct tasklet_struct *t)
 {
-	struct img_hash_dev *hdev = (struct img_hash_dev *)data;
+	struct img_hash_dev *hdev = from_tasklet(hdev, t, done_task);
 	int err = 0;
 
 	if (hdev->err == -EINVAL) {
@@ -952,8 +952,8 @@ static int img_hash_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&hdev->list);
 
-	tasklet_init(&hdev->done_task, img_hash_done_task, (unsigned long)hdev);
-	tasklet_init(&hdev->dma_task, img_hash_dma_task, (unsigned long)hdev);
+	tasklet_setup(&hdev->done_task, img_hash_done_task);
+	tasklet_setup(&hdev->dma_task, img_hash_dma_task);
 
 	crypto_init_queue(&hdev->queue, IMG_HASH_QUEUE_LENGTH);
 
-- 
2.17.1

