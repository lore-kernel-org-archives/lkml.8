Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B05C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958C8206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgFZTha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:37:30 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:22534 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFZTh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:37:28 -0400
Received: from localhost.localdomain ([93.22.36.38])
        by mwinf5d77 with ME
        id vvdP220040pNVn903vdPdG; Fri, 26 Jun 2020 21:37:25 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 26 Jun 2020 21:37:25 +0200
X-ME-IP: 93.22.36.38
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     richard.gong@linux.intel.com, atull@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH V3] firmware: stratix10-svc: Fix some error handling code
Date:   Fri, 26 Jun 2020 21:37:20 +0200
Message-Id: <20200626193720.949431-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0ecc14c7-b4df-1890-fbe7-91307c2db398@wanadoo.fr>
References: <0ecc14c7-b4df-1890-fbe7-91307c2db398@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix several error handling issues:
   - In 'svc_create_memory_pool()' we memremap some memory. This has to be
undone in case of error and if the driver is removed.
The easiest way to do it is to use 'devm_memremap()'.

  - 'svc_create_memory_pool()' returns an error pointer on error, not NULL.
In 'stratix10_svc_drv_probe()', fix the corresponding test and return value
accordingly.

  - Move the genpool allocation after a few devm_kzalloc in order to ease
error handling. (some call to 'gen_pool_destroy()' were missing)

   - If an error occurs after calling 'svc_create_memory_pool()', the
allocated genpool should be destroyed with 'gen_pool_destroy()', as
already done in the remove function.
Add an error handling path for that

   - If an error occurs after calling 'kfifo_alloc()', the allocated
memory should be freed with 'kfifo_free()', as already done in the remove
function.
Add an error handling path for that


While at it, do some clean-up:
   - Use 'devm_kcalloc()' instead of 'devm_kmalloc_array(... __GFP_ZERO)'

   - move a 'platform_device_put()' call to the new error handling path.

   - In 'stratix10_svc_drv_remove()', 'ctrl->genpool' can not be NULL, so
axe a useless test in the remove function.

Fixes: b5dc75c915cd ("firmware: stratix10-svc: extend svc to support new RSU features")
Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: takes Dan's comment into account and fix another resource leak.
v3: merge the previous 4 patches in a single one to ease review
---
 drivers/firmware/stratix10-svc.c | 42 +++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e0db8dbfc9d1..90f7d68a2473 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -605,7 +605,7 @@ svc_create_memory_pool(struct platform_device *pdev,
 	end = rounddown(sh_memory->addr + sh_memory->size, PAGE_SIZE);
 	paddr = begin;
 	size = end - begin;
-	va = memremap(paddr, size, MEMREMAP_WC);
+	va = devm_memremap(dev, paddr, size, MEMREMAP_WC);
 	if (!va) {
 		dev_err(dev, "fail to remap shared memory\n");
 		return ERR_PTR(-EINVAL);
@@ -971,20 +971,19 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	genpool = svc_create_memory_pool(pdev, sh_memory);
-	if (!genpool)
-		return -ENOMEM;
-
 	/* allocate service controller and supporting channel */
 	controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);
 	if (!controller)
 		return -ENOMEM;
 
-	chans = devm_kmalloc_array(dev, SVC_NUM_CHANNEL,
-				   sizeof(*chans), GFP_KERNEL | __GFP_ZERO);
+	chans = devm_kcalloc(dev, SVC_NUM_CHANNEL, sizeof(*chans), GFP_KERNEL);
 	if (!chans)
 		return -ENOMEM;
 
+	genpool = svc_create_memory_pool(pdev, sh_memory);
+	if (IS_ERR(genpool))
+		return PTR_ERR(genpool);
+
 	controller->dev = dev;
 	controller->num_chans = SVC_NUM_CHANNEL;
 	controller->num_active_client = 0;
@@ -998,7 +997,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	ret = kfifo_alloc(&controller->svc_fifo, fifo_size, GFP_KERNEL);
 	if (ret) {
 		dev_err(dev, "failed to allocate FIFO\n");
-		return ret;
+		goto err_destroy_pool;
 	}
 	spin_lock_init(&controller->svc_fifo_lock);
 
@@ -1017,24 +1016,34 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 	/* add svc client device(s) */
 	svc = devm_kzalloc(dev, sizeof(*svc), GFP_KERNEL);
-	if (!svc)
-		return -ENOMEM;
+	if (!svc) {
+		ret = -ENOMEM;
+		goto err_free_kfifo;
+	}
 
 	svc->stratix10_svc_rsu = platform_device_alloc(STRATIX10_RSU, 0);
 	if (!svc->stratix10_svc_rsu) {
 		dev_err(dev, "failed to allocate %s device\n", STRATIX10_RSU);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_free_kfifo;
 	}
 
 	ret = platform_device_add(svc->stratix10_svc_rsu);
-	if (ret) {
-		platform_device_put(svc->stratix10_svc_rsu);
-		return ret;
-	}
+	if (ret)
+		goto put_platform;
+
 	dev_set_drvdata(dev, svc);
 
 	pr_info("Intel Service Layer Driver Initialized\n");
 
+	return 0;
+
+put_platform:
+	platform_device_put(svc->stratix10_svc_rsu);
+err_free_kfifo:
+	kfifo_free(&controller->svc_fifo);
+err_destroy_pool:
+	gen_pool_destroy(genpool);
 	return ret;
 }
 
@@ -1050,8 +1059,7 @@ static int stratix10_svc_drv_remove(struct platform_device *pdev)
 		kthread_stop(ctrl->task);
 		ctrl->task = NULL;
 	}
-	if (ctrl->genpool)
-		gen_pool_destroy(ctrl->genpool);
+	gen_pool_destroy(ctrl->genpool);
 	list_del(&ctrl->node);
 
 	return 0;
-- 
2.25.1

