Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DC6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D45920855
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="D+MLA+rA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgHUNq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbgHUNoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:44:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD48C061388
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:44:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so1969413wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=enpDAR+q6vLHcCWoXqxt/APfxOpAFUDPCVJnonleY4M=;
        b=D+MLA+rAd1G4H5BgYt/u/BmAvzHLvCN1+/+4PHxXfzMi4Ma9mp9yvPzpMSJL5VxKwy
         SWVI0TuzypjDFxdpk0gORemJnyasicw+C+/PMXEGKImyPTPvVwANtNpaYNfcezmHKVAu
         JRz7JwrFJS37xupAKUml4yBahTd6b0ZVKPIYEL0dgZxDxjgb0URsS6hiiRjVz2FFdCAT
         CwpwTLza0ITYtK/E6Y14VpdFA2n3Jya0NEC/Lz6gbI6khTG8N2JLE7lDy7bXCpdhZtOM
         kGQecTa634qyZ0x0yMH1IJBfYDWkWOiIGDrqeA3PHYkcMHpOLbBs1q8YkVlnDowOEcyY
         YsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=enpDAR+q6vLHcCWoXqxt/APfxOpAFUDPCVJnonleY4M=;
        b=FxGepV2M3jQsEWtB9GV2VeYtW6LHkRGg9+QfM5z7kMYMj30cwfOY5Vq9PAl2vzRz74
         Om5p99jSBaC5E9HkN0OLhAHCzi09RCYU3dnf+q3OA30+J0+iNfwmeHZ71TPun8gcxEr0
         aK1ncmBhOL04TPcw5RwaC/EbnbwSCsTMRVN87g04T1v7/hCewlBAwlWrAh7K1cm2PSG/
         sJcRdtosAQJH2zM3OnWHxM0yvIgfhDe0hN38aOesRZ/wld8D20Vcz9cM+YMN7wZAAN2a
         i0G7+wyvAk9vR05yqG5mZ6m+6kDP01LCmgU9TKZeF2Y7ib7jYIUDxBJ3mrMdBy4fmc+p
         SFeA==
X-Gm-Message-State: AOAM530GNUm6MNzfE0Rn1AMiUqVxFK0WOmL/rBO8dAGk6ndpyb9Pn8xf
        P4tL3k+KxfYPWHlPejAiamBXQA==
X-Google-Smtp-Source: ABdhPJyV12W2BMExNB8lxQeBLYW3xGMYKwMMJRJujagwIga42zrvqPJJJcsNX8gLSU7R2pEtsxJD2Q==
X-Received: by 2002:a5d:48c3:: with SMTP id p3mr1796453wrs.69.1598017441403;
        Fri, 21 Aug 2020 06:44:01 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 202sm5971179wmb.10.2020.08.21.06.44.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 06:44:00 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 18/18] crypto: sun8i-ce: fix some style issue
Date:   Fri, 21 Aug 2020 13:43:35 +0000
Message-Id: <1598017415-39059-19-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
References: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a double empty line issue reported by checkpatch.
While at it, since now the maximum line length is now 100, reorder some
wrapped line.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 34 ++++++-------------
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c |  9 ++---
 2 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 2dcf508b0f18..9dae2be26e48 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -164,12 +164,10 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 				goto theend_key;
 			}
 			offset = areq->cryptlen - ivsize;
-			scatterwalk_map_and_copy(rctx->backup_iv, areq->src,
-						 offset, ivsize, 0);
+			scatterwalk_map_and_copy(rctx->backup_iv, areq->src, offset, ivsize, 0);
 		}
 		memcpy(rctx->bounce_iv, areq->iv, ivsize);
-		addr_iv = dma_map_single(ce->dev, rctx->bounce_iv, rctx->ivlen,
-					 DMA_TO_DEVICE);
+		addr_iv = dma_map_single(ce->dev, rctx->bounce_iv, rctx->ivlen, DMA_TO_DEVICE);
 		cet->t_iv = cpu_to_le32(addr_iv);
 		if (dma_mapping_error(ce->dev, addr_iv)) {
 			dev_err(ce->dev, "Cannot DMA MAP IV\n");
@@ -179,8 +177,7 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 	}
 
 	if (areq->src == areq->dst) {
-		nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src),
-				    DMA_BIDIRECTIONAL);
+		nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src), DMA_BIDIRECTIONAL);
 		if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
 			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
 			err = -EINVAL;
@@ -188,15 +185,13 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 		}
 		nr_sgd = nr_sgs;
 	} else {
-		nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src),
-				    DMA_TO_DEVICE);
+		nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
 		if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
 			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
 			err = -EINVAL;
 			goto theend_iv;
 		}
-		nr_sgd = dma_map_sg(ce->dev, areq->dst, sg_nents(areq->dst),
-				    DMA_FROM_DEVICE);
+		nr_sgd = dma_map_sg(ce->dev, areq->dst, sg_nents(areq->dst), DMA_FROM_DEVICE);
 		if (nr_sgd <= 0 || nr_sgd > MAX_SG) {
 			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgd);
 			err = -EINVAL;
@@ -251,15 +246,13 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 theend_iv:
 	if (areq->iv && ivsize > 0) {
 		if (addr_iv)
-			dma_unmap_single(ce->dev, addr_iv, rctx->ivlen,
-					 DMA_TO_DEVICE);
+			dma_unmap_single(ce->dev, addr_iv, rctx->ivlen, DMA_TO_DEVICE);
 		offset = areq->cryptlen - ivsize;
 		if (rctx->op_dir & CE_DECRYPTION) {
 			memcpy(areq->iv, rctx->backup_iv, ivsize);
 			kfree_sensitive(rctx->backup_iv);
 		} else {
-			scatterwalk_map_and_copy(areq->iv, areq->dst, offset,
-						 ivsize, 0);
+			scatterwalk_map_and_copy(areq->iv, areq->dst, offset, ivsize, 0);
 		}
 		kfree(rctx->bounce_iv);
 	}
@@ -315,15 +308,13 @@ static int sun8i_ce_cipher_unprepare(struct crypto_engine *engine, void *async_r
 
 	if (areq->iv && ivsize > 0) {
 		if (cet->t_iv)
-			dma_unmap_single(ce->dev, cet->t_iv, rctx->ivlen,
-					 DMA_TO_DEVICE);
+			dma_unmap_single(ce->dev, cet->t_iv, rctx->ivlen, DMA_TO_DEVICE);
 		offset = areq->cryptlen - ivsize;
 		if (rctx->op_dir & CE_DECRYPTION) {
 			memcpy(areq->iv, rctx->backup_iv, ivsize);
 			kfree_sensitive(rctx->backup_iv);
 		} else {
-			scatterwalk_map_and_copy(areq->iv, areq->dst, offset,
-						 ivsize, 0);
+			scatterwalk_map_and_copy(areq->iv, areq->dst, offset, ivsize, 0);
 		}
 		kfree(rctx->bounce_iv);
 	}
@@ -395,7 +386,6 @@ int sun8i_ce_cipher_init(struct crypto_tfm *tfm)
 	sktfm->reqsize = sizeof(struct sun8i_cipher_req_ctx) +
 			 crypto_skcipher_reqsize(op->fallback_tfm);
 
-
 	dev_info(op->ce->dev, "Fallback for %s is %s\n",
 		 crypto_tfm_alg_driver_name(&sktfm->base),
 		 crypto_tfm_alg_driver_name(crypto_skcipher_tfm(op->fallback_tfm)));
@@ -427,8 +417,7 @@ void sun8i_ce_cipher_exit(struct crypto_tfm *tfm)
 	pm_runtime_put_sync_suspend(op->ce->dev);
 }
 
-int sun8i_ce_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
-			unsigned int keylen)
+int sun8i_ce_aes_setkey(struct crypto_skcipher *tfm, const u8 *key, unsigned int keylen)
 {
 	struct sun8i_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
 	struct sun8i_ce_dev *ce = op->ce;
@@ -459,8 +448,7 @@ int sun8i_ce_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	return crypto_skcipher_setkey(op->fallback_tfm, key, keylen);
 }
 
-int sun8i_ce_des3_setkey(struct crypto_skcipher *tfm, const u8 *key,
-			 unsigned int keylen)
+int sun8i_ce_des3_setkey(struct crypto_skcipher *tfm, const u8 *key, unsigned int keylen)
 {
 	struct sun8i_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
 	int err;
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index cf320898a4b1..1dbbd40ad576 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -596,8 +596,7 @@ static int sun8i_ce_dbgfs_read(struct seq_file *seq, void *v)
 		}
 	}
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_TRNG
-	seq_printf(seq, "HWRNG %lu %lu\n",
-		   ce->hwrng_stat_req, ce->hwrng_stat_bytes);
+	seq_printf(seq, "HWRNG %lu %lu\n", ce->hwrng_stat_req, ce->hwrng_stat_bytes);
 #endif
 	return 0;
 }
@@ -635,8 +634,7 @@ static int sun8i_ce_allocate_chanlist(struct sun8i_ce_dev *ce)
 {
 	int i, err;
 
-	ce->chanlist = devm_kcalloc(ce->dev, MAXFLOW,
-				    sizeof(struct sun8i_ce_flow), GFP_KERNEL);
+	ce->chanlist = devm_kcalloc(ce->dev, MAXFLOW, sizeof(struct sun8i_ce_flow), GFP_KERNEL);
 	if (!ce->chanlist)
 		return -ENOMEM;
 
@@ -935,8 +933,7 @@ static int sun8i_ce_probe(struct platform_device *pdev)
 	if (err)
 		goto error_pm;
 
-	err = devm_request_irq(&pdev->dev, irq, ce_irq_handler, 0,
-			       "sun8i-ce-ns", ce);
+	err = devm_request_irq(&pdev->dev, irq, ce_irq_handler, 0, "sun8i-ce-ns", ce);
 	if (err) {
 		dev_err(ce->dev, "Cannot request CryptoEngine Non-secure IRQ (err=%d)\n", err);
 		goto error_irq;
-- 
2.26.2

