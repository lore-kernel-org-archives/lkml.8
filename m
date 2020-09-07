Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1194C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0FA206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0Ljo/uV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIGG6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgIGG6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:58:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A5FC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 23:58:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u13so7611060pgh.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 23:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LKqGEGfZu+9yBYF0gMGbxjoNciSYpOurX9vGA/w/tHs=;
        b=h0Ljo/uV94yJjaPN2S59uCTNiwyniFEK7bEeC1ih89o4Y/LNyDgkj0YZDtYiKswhkf
         uLinXvQ9Vg36rkZAaE94u1uuSArN+5FpOxpPUorS6iW4PQzc67EvqOz8XesBpu8+acG/
         q+UbjgIDlc/4c+wSlLdcd+h/vDm/hjCTZFqKoNZExB8dFLEze33Oz+Of0U9cxztHZ1E0
         +aQUwDYZ4KFaycnt+BJzya3c/TVGeRkwPq1J3JxARM7uxDqIXT70WufsReKOa0259UUG
         f0wsraBZ6hBOUsBOa9cVZJlu/kuwuCySMNdoVMvPlGGF/OMtV/MsOplKePhgAFdig5BZ
         tBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LKqGEGfZu+9yBYF0gMGbxjoNciSYpOurX9vGA/w/tHs=;
        b=kZQbF/aiB2paOeXDJCiczeOaaoaoXbGa9Qu4gR56IXeCSjf63gM3oq+FH7dEUyYLj7
         lRsWhuUqlbx3d7d2R2pDyHI5l4m/JnNQLeJdvUNEQgFEf20oiHUGPTtGM1H7HESRPsH1
         JVIzv7j5EHd2ihsojIe8FZkAmyQO2AK/4scbsW0MPv58Qh0L19btICjK9ob48qPoFUvN
         jS2mJ7gpC/emIpgGC0ZgiGoBgHwndEZCrlO/bF3s8sxRMpV2RGrHCNa4uqGFo4MsNOv1
         OEuv0aS9369xg37THgbZ/NpFVs5WaklGl2/W0CpgzJv6OY43hscfHsORtAv+XR7Nyy+E
         3e5Q==
X-Gm-Message-State: AOAM533TvML8QKGzGE4vgtZ2Xl9BeGldMfoT7slu2JxxQvspM5GE1EPd
        B3HAoDAkSF7Yi8krJ+1Wc/Y=
X-Google-Smtp-Source: ABdhPJy07uqzYSsi8wXNiQXIBFIQipoilcJ/cdRxmq6k6Bz4R+L2tMes6OzohnwuD9g3wxVI9/YE7A==
X-Received: by 2002:a62:5e81:: with SMTP id s123mr19782288pfb.40.1599461901471;
        Sun, 06 Sep 2020 23:58:21 -0700 (PDT)
Received: from laptop.Scindia.edu (proxy.scindia.edu. [210.212.152.36])
        by smtp.gmail.com with ESMTPSA id i17sm203127pfa.2.2020.09.06.23.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 23:58:20 -0700 (PDT)
From:   Naveen Panwar <naveen.panwar27@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     mpe@ellerman.id.au, stern@rowland.harvard.edu,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Naveen Panwar <naveen.panwar27@gmail.com>
Subject: [PATCH] Staging: Ralink: ralink-gdma: Fixed codestyle issue and warnings
Date:   Mon,  7 Sep 2020 12:27:45 +0530
Message-Id: <20200907065745.21439-1-naveen.panwar27@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed checkpatch warnings two warnings still exits about DT
compatible strings appers undocumented. Fixed the other codestyle
errors, and some warnings about use of volatile and un-necessary
out of memory errors.

Signed-off-by: Naveen Panwar <naveen.panwar27@gmail.com>
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 29 ++++++++++++-----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index eabf10933..1c3388b7c 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -122,7 +122,8 @@ struct gdma_dma_dev {
 	struct gdma_data *data;
 	void __iomem *base;
 	struct tasklet_struct task;
-	volatile unsigned long chan_issued;
+
+	unsigned long chan_issued;
 	atomic_t cnt;
 
 	struct gdma_dmaengine_chan chan[];
@@ -135,8 +136,8 @@ struct gdma_data {
 	int (*start_transfer)(struct gdma_dmaengine_chan *chan);
 };
 
-static struct gdma_dma_dev *gdma_dma_chan_get_dev(
-	struct gdma_dmaengine_chan *chan)
+static struct gdma_dma_dev *gdma_dma_chan_get_dev
+	(struct gdma_dmaengine_chan *chan)
 {
 	return container_of(chan->vchan.chan.device, struct gdma_dma_dev,
 		ddev);
@@ -510,10 +511,10 @@ static void gdma_dma_issue_pending(struct dma_chan *c)
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
 
-static struct dma_async_tx_descriptor *gdma_dma_prep_slave_sg(
-		struct dma_chan *c, struct scatterlist *sgl,
-		unsigned int sg_len, enum dma_transfer_direction direction,
-		unsigned long flags, void *context)
+static struct dma_async_tx_descriptor *gdma_dma_prep_slave_sg
+	(struct dma_chan *c, struct scatterlist *sgl,
+	 unsigned int sg_len, enum dma_transfer_direction direction,
+	 unsigned long flags, void *context)
 {
 	struct gdma_dmaengine_chan *chan = to_gdma_dma_chan(c);
 	struct gdma_dma_desc *desc;
@@ -522,7 +523,7 @@ static struct dma_async_tx_descriptor *gdma_dma_prep_slave_sg(
 
 	desc = kzalloc(struct_size(desc, sg, sg_len), GFP_ATOMIC);
 	if (!desc) {
-		dev_err(c->device->dev, "alloc sg decs error\n");
+		goto free_rx_tx;
 		return NULL;
 	}
 	desc->residue = 0;
@@ -558,9 +559,9 @@ static struct dma_async_tx_descriptor *gdma_dma_prep_slave_sg(
 	return NULL;
 }
 
-static struct dma_async_tx_descriptor *gdma_dma_prep_dma_memcpy(
-		struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
-		size_t len, unsigned long flags)
+static struct dma_async_tx_descriptor *gdma_dma_prep_dma_memcpy
+	(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
+	 size_t len, unsigned long flags)
 {
 	struct gdma_dmaengine_chan *chan = to_gdma_dma_chan(c);
 	struct gdma_dma_desc *desc;
@@ -577,7 +578,7 @@ static struct dma_async_tx_descriptor *gdma_dma_prep_dma_memcpy(
 
 	desc = kzalloc(struct_size(desc, sg, num_periods), GFP_ATOMIC);
 	if (!desc) {
-		dev_err(c->device->dev, "alloc memcpy decs error\n");
+		goto free_rx_tx;
 		return NULL;
 	}
 	desc->residue = len;
@@ -601,8 +602,8 @@ static struct dma_async_tx_descriptor *gdma_dma_prep_dma_memcpy(
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 }
 
-static struct dma_async_tx_descriptor *gdma_dma_prep_dma_cyclic(
-	struct dma_chan *c, dma_addr_t buf_addr, size_t buf_len,
+static struct dma_async_tx_descriptor *gdma_dma_prep_dma_cyclic
+	(struct dma_chan *c, dma_addr_t buf_addr, size_t buf_len,
 	size_t period_len, enum dma_transfer_direction direction,
 	unsigned long flags)
 {
-- 
2.17.1

