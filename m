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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EB2C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72282078D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZj7I1Dh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgHQIKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgHQIKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:10:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42541C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e4so7449892pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bp1Vjbvu9eesAqyHmjyMGr6ksKKLGEXaOUC7HAWJKx4=;
        b=QZj7I1DhKFHe3pdIN6F8lOX8R2BA9cNJggmdfL9LrK28VcHVbDs/cZidkyV4Jzxn1e
         8Q5sl7RE35mx89R2lS4f5qR0pWATUzSr2FpMBwvCbHJgFk/BTxbO9rpL7mpNDxCYRWme
         p0yMBqyWoAQhsGWIv9CEF0gnbTi0wee40V/XeQFSxZvuG7CR2x2kLlQQ1DuZkVV8eW49
         NO61cvUHWLJabyMMLeaDEgQCMdtOMiVRljjd/3SfLb0t/cZTRjhe7idqLnqd4Oqx+Trh
         /OoFDUF58EIv94kvwTA98NUUj4dtZUCS4c7QNt4XDLzO5sjU+GYhwdnZiHWZXw79O5zA
         cJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bp1Vjbvu9eesAqyHmjyMGr6ksKKLGEXaOUC7HAWJKx4=;
        b=qiU7JAnkAQ/PdmmUw7gPuFqDtIvAasn2j8qSdk5RdE9WeR6JCisRYCVOOU0ipTqjNd
         wVtCuScq8kfjEGAwritl5FYVb+fr7sts5nFPAGsF4Q9q4CLG0VWPu4/zGo72iSlk7nBp
         jzLlUjH8MLRvW9tnypJ5vcFw3LTlGnyaMVZ2GXL8+G+OhbcxnFzBY7hLHnnz58S2Ps0S
         jIU7W+5BKXj5upgaTNRUo1JuNpF88eiujd8EtlhWMHWk8dImoVK3LptphNRDjL/AlETf
         AjxrI9RNWWVN+8X0G6/IncETbCZZtSAH9vFzy2mBTDwh7aVYpogFTSaOJsed6vxoABWY
         VJDA==
X-Gm-Message-State: AOAM532Z7I1MVd62ulkZugQir4sR01cRjYIra873XtZRstzIHKaau/3d
        tu6mPS+MG23kxlpQrrnHNas=
X-Google-Smtp-Source: ABdhPJyoVJX3X87+tugLmoxBG/s46WfS1oac9OnhxEJJbePel+PZIBobfcV+AokpUHaOzTi/R3hj+w==
X-Received: by 2002:a17:902:fe10:: with SMTP id g16mr10413715plj.43.1597651838856;
        Mon, 17 Aug 2020 01:10:38 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:10:38 -0700 (PDT)
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
Subject: [PATCH 07/19] crypto: ccree: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:29 +0530
Message-Id: <20200817080941.19227-8-allen.lkml@gmail.com>
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
 drivers/crypto/ccree/cc_fips.c        |  6 +++---
 drivers/crypto/ccree/cc_request_mgr.c | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/ccree/cc_fips.c b/drivers/crypto/ccree/cc_fips.c
index 702aefc21447..bad228a36776 100644
--- a/drivers/crypto/ccree/cc_fips.c
+++ b/drivers/crypto/ccree/cc_fips.c
@@ -109,9 +109,9 @@ void cc_tee_handle_fips_error(struct cc_drvdata *p_drvdata)
 }
 
 /* Deferred service handler, run as interrupt-fired tasklet */
-static void fips_dsr(unsigned long devarg)
+static void fips_dsr(struct tasklet_struct *t)
 {
-	struct cc_drvdata *drvdata = (struct cc_drvdata *)devarg;
+	struct cc_drvdata *drvdata = from_tasklet(drvdata, t, tasklet);
 	u32 irq, val;
 
 	irq = (drvdata->irq & (CC_GPR0_IRQ_MASK));
@@ -143,7 +143,7 @@ int cc_fips_init(struct cc_drvdata *p_drvdata)
 	p_drvdata->fips_handle = fips_h;
 
 	dev_dbg(dev, "Initializing fips tasklet\n");
-	tasklet_init(&fips_h->tasklet, fips_dsr, (unsigned long)p_drvdata);
+	tasklet_setup(&fips_h->tasklet, fips_dsr);
 	fips_h->drvdata = p_drvdata;
 	fips_h->nb.notifier_call = cc_ree_fips_failure;
 	atomic_notifier_chain_register(&fips_fail_notif_chain, &fips_h->nb);
diff --git a/drivers/crypto/ccree/cc_request_mgr.c b/drivers/crypto/ccree/cc_request_mgr.c
index 33fb27745d52..ec0f3bf00d33 100644
--- a/drivers/crypto/ccree/cc_request_mgr.c
+++ b/drivers/crypto/ccree/cc_request_mgr.c
@@ -70,7 +70,7 @@ static const u32 cc_cpp_int_masks[CC_CPP_NUM_ALGS][CC_CPP_NUM_SLOTS] = {
 	  BIT(CC_HOST_IRR_REE_OP_ABORTED_SM_7_INT_BIT_SHIFT) }
 };
 
-static void comp_handler(unsigned long devarg);
+static void comp_handler(struct tasklet_struct *t);
 #ifdef COMP_IN_WQ
 static void comp_work_handler(struct work_struct *work);
 #endif
@@ -140,8 +140,7 @@ int cc_req_mgr_init(struct cc_drvdata *drvdata)
 	INIT_DELAYED_WORK(&req_mgr_h->compwork, comp_work_handler);
 #else
 	dev_dbg(dev, "Initializing completion tasklet\n");
-	tasklet_init(&req_mgr_h->comptask, comp_handler,
-		     (unsigned long)drvdata);
+	tasklet_setup(&req_mgr_h->comptask, comp_handler);
 #endif
 	req_mgr_h->hw_queue_size = cc_ioread(drvdata,
 					     CC_REG(DSCRPTR_QUEUE_SRAM_SIZE));
@@ -611,11 +610,12 @@ static inline u32 cc_axi_comp_count(struct cc_drvdata *drvdata)
 }
 
 /* Deferred service handler, run as interrupt-fired tasklet */
-static void comp_handler(unsigned long devarg)
+static void comp_handler(struct tasklet_struct *t)
 {
-	struct cc_drvdata *drvdata = (struct cc_drvdata *)devarg;
 	struct cc_req_mgr_handle *request_mgr_handle =
-						drvdata->request_mgr_handle;
+				from_tasklet(request_mgr_handle, t, comptask);
+	struct cc_drvdata *drvdata = container_of((void *)request_mgr_handle,
+				     typeof(*drvdata), request_mgr_handle);
 	struct device *dev = drvdata_to_dev(drvdata);
 	u32 irq;
 
-- 
2.17.1

