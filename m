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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B75AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14929207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCHZCy3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgHQILJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgHQILA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:11:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634B1C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:11:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c6so7443285pje.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UiTTtY4um+8cmYBKgcrZZYgd8CdoEU+ARxIZdRX9Hl4=;
        b=lCHZCy3pNI0pZrwfcPNazSDtJnQIEjsNJln05t6INik82IzhLcow4WN5JuRRzBEhA8
         YGwXaK8fgpT/G5By171ao66YPo2MgKLkXIFSfl9+DDdLatYNmq9QUaBsSZDFiSFCnXBO
         h1PFiJwVPDIJqYeEmoE4IiHXKJ9F/Lc6mQ4o5hhJdjxM1YEDJoq8+UVgKvbCHh3XCf2M
         4UwWOdm1OH4+TcG6HaB9yOwqe1aNeUGzNBpmLgZNFRIxmOBqFUrKXw2hWL4MIxDXYJm7
         9UrmnGTGigzKdDSZRmSUB5ka9AutzOl2Yks+Z/DEtQVWrTyPsyn8Ygyr1rbjvyFrBIj/
         9QEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UiTTtY4um+8cmYBKgcrZZYgd8CdoEU+ARxIZdRX9Hl4=;
        b=MIqC5DnEVCzSOJyzAcZsmDntMIC5GoMUn8qXDBCQteqQ71OkX6HDgJwo+8RSO9QCVH
         QLVBbRd2cEqryEzDsEQN3jM1xX1pAWz+eQTB3J2LLc56Rzi//b0B2zbeh4mtVXiDL3pI
         cUiHb3PtfKVxLmQkrgQhIuh2lr3RkCIvR45J7m/vc7SvLcbP2WdqeZukb5mnO04ebmR2
         KRyCqACUjVAnyrnuihTdHDYqPThomLnTHsXhanIzO3qRsFf9RgQqziqDG23cIFZNOnZL
         BRQyNa0sBpMPH+2rf4KekvglEuH/1Xq8V35jw07GsTAx1C3L0pI7SUMuXw0/XFHDQrPX
         4dnw==
X-Gm-Message-State: AOAM533g8jJSNFhjFrTia3U0LggNVsuqNqHw/j9UzGqQuVlyy+vhvREB
        BOlGH6U4ZKuZ50PoVIp8tvs=
X-Google-Smtp-Source: ABdhPJzIlpoIQTSdahVGMk8x5siqZ5Y3mjG1CPosG5SauNGyLp+frSB0ojX4DsaYxwOAzse/edpt+w==
X-Received: by 2002:a17:90b:684:: with SMTP id m4mr11607612pjz.4.1597651859925;
        Mon, 17 Aug 2020 01:10:59 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:10:59 -0700 (PDT)
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
Subject: [PATCH 12/19] crypto: omap: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:34 +0530
Message-Id: <20200817080941.19227-13-allen.lkml@gmail.com>
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
 drivers/crypto/omap-aes.c  | 6 +++---
 drivers/crypto/omap-des.c  | 6 +++---
 drivers/crypto/omap-sham.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index 4fd14d90cc40..4eae24167a5d 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -502,9 +502,9 @@ static void omap_aes_copy_ivout(struct omap_aes_dev *dd, u8 *ivbuf)
 		((u32 *)ivbuf)[i] = omap_aes_read(dd, AES_REG_IV(dd, i));
 }
 
-static void omap_aes_done_task(unsigned long data)
+static void omap_aes_done_task(struct tasklet_struct *t)
 {
-	struct omap_aes_dev *dd = (struct omap_aes_dev *)data;
+	struct omap_aes_dev *dd = from_tasklet(dd, t, done_task);
 
 	pr_debug("enter done_task\n");
 
@@ -1150,7 +1150,7 @@ static int omap_aes_probe(struct platform_device *pdev)
 		 (reg & dd->pdata->major_mask) >> dd->pdata->major_shift,
 		 (reg & dd->pdata->minor_mask) >> dd->pdata->minor_shift);
 
-	tasklet_init(&dd->done_task, omap_aes_done_task, (unsigned long)dd);
+	tasklet_setup(&dd->done_task, omap_aes_done_task);
 
 	err = omap_aes_dma_init(dd);
 	if (err == -EPROBE_DEFER) {
diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index c9d38bcfd1c7..fddcfc3ba57b 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -594,9 +594,9 @@ static int omap_des_crypt_req(struct crypto_engine *engine,
 	return omap_des_crypt_dma_start(dd);
 }
 
-static void omap_des_done_task(unsigned long data)
+static void omap_des_done_task(struct tasklet_struct *t)
 {
-	struct omap_des_dev *dd = (struct omap_des_dev *)data;
+	struct omap_des_dev *dd = from_tasklet(dd, t, done_task);
 	int i;
 
 	pr_debug("enter done_task\n");
@@ -1011,7 +1011,7 @@ static int omap_des_probe(struct platform_device *pdev)
 		 (reg & dd->pdata->major_mask) >> dd->pdata->major_shift,
 		 (reg & dd->pdata->minor_mask) >> dd->pdata->minor_shift);
 
-	tasklet_init(&dd->done_task, omap_des_done_task, (unsigned long)dd);
+	tasklet_setup(&dd->done_task, omap_des_done_task);
 
 	err = omap_des_dma_init(dd);
 	if (err == -EPROBE_DEFER) {
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 954d703f2981..3c03ee164039 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1750,9 +1750,9 @@ static struct ahash_alg algs_sha384_sha512[] = {
 },
 };
 
-static void omap_sham_done_task(unsigned long data)
+static void omap_sham_done_task(struct tasklet_struct *t)
 {
-	struct omap_sham_dev *dd = (struct omap_sham_dev *)data;
+	struct omap_sham_dev *dd = from_tasklet(dd, t, done_task);
 	int err = 0;
 
 	dev_dbg(dd->dev, "%s: flags=%lx\n", __func__, dd->flags);
@@ -2126,7 +2126,7 @@ static int omap_sham_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&dd->list);
 	spin_lock_init(&dd->lock);
-	tasklet_init(&dd->done_task, omap_sham_done_task, (unsigned long)dd);
+	tasklet_setup(&dd->done_task, omap_sham_done_task);
 	crypto_init_queue(&dd->queue, OMAP_SHAM_QUEUE_LENGTH);
 
 	err = (dev->of_node) ? omap_sham_get_res_of(dd, dev, &res) :
-- 
2.17.1

