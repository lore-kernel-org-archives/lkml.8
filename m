Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD92C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A6621741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NehaB4Fk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgBERRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:17:44 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39056 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgBERRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:17:42 -0500
Received: by mail-pj1-f68.google.com with SMTP id e9so1266116pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 09:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=XPGso/ZAKLC4MqsABJuAPwcPuQWv0VhrryHLJIxVO2Y=;
        b=NehaB4FkdVpJOyGpoal4BBxFWUcDBomsW1oQGBRjaHdJbq2C5d5WP1kPRhix/7Sf07
         4pDk1kc0gzHk7o8ZbgSOwPgOH7Lb3QXBuxz/Z61Mz/Ajs8ah8CYvJ1mk4LqBFo3dowvX
         nVMf18NQaCS/30qGQUC9YuVfExsJn9nhrxzc+CEjBkX+j/jEZxb2nuWaaYPSbtRHUTRF
         BctpoelUPHTTMVOtOm+IXpumfJ6t1z3F3yM3hzwecY6WrKtxEBLRp6/VoNAHvodgpGh7
         dQl0xHRwxKGOGlCeDWIZMqlySGaENcHlOw94FJQv6zDPbjSZEorr85KhzH36rq/WDcGe
         V/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=XPGso/ZAKLC4MqsABJuAPwcPuQWv0VhrryHLJIxVO2Y=;
        b=aHBvcQjLpYe4VyJjTnqgjeli9uIZ1ncBRk5/lCZvjqOaZklAJCsgDDuMfqulxRo5Ov
         zLvOsTkPQ3PLxLxJ22BF4Z2UYY8TaT6JgeA3U9JTE1vVBQUjuPAVG59YntSAND5PBLZt
         Q4O6IRUr+7TGUvVy+5r7Bz+N++xwCBp4ecdbvF8ecKnEmFy3IlDR/cClF4hjg+vpJlIF
         r/g+mPN9LDvjAR+G3XJL4lYBWtiyClaeIV3ew/4uWgRx7TbDJgtyYRgbPLszEBtXttBS
         OO+/gr483NJzyzGs+y1aFqMlK5Xt2Dszcn8I3aO48FJaZbcn+l2fz6U1GFWgpT/9N7E/
         311Q==
X-Gm-Message-State: APjAAAXs+8WbgtLdjNeCS7K7ZUNtl6RPsuV7CYg8YgNy+9GPFgh+E/wM
        h60Nj5mE7tjMum7b8r6EMVYi6O+siE4=
X-Google-Smtp-Source: APXvYqy99nL6dx5gj32pUAJXDxSdcaTqoRR595fqylhPwV4MrcdnHz+Tvcl0zzHDp0uBHtxZryfidQ==
X-Received: by 2002:a17:90a:fb4f:: with SMTP id iq15mr6814778pjb.86.1580923061293;
        Wed, 05 Feb 2020 09:17:41 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id l8sm357945pjy.24.2020.02.05.09.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 09:17:40 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 1/4] ntb_perf: refactor code for CPU and DMA transfers
Date:   Wed,  5 Feb 2020 22:46:55 +0530
Message-Id: <698cd5b0fd615600d0d01e8f5e4c1715c9f06a15.1580921119.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580921119.git.arindam.nath@amd.com>
References: <cover.1580921119.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580921119.git.arindam.nath@amd.com>
References: <cover.1580921119.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates separate function to handle CPU
and DMA transfers. Since CPU transfers use memcopy
and DMA transfers use dmaengine APIs, these changes
not only allow logical separation between the two,
but also allows someone to clearly see the difference
in the way the two are handled.

In the case of DMA, we DMA from system memory to the
memory window(MW) of NTB, which is a MMIO region, we
should not use dma_map_page() for mapping MW. The
correct way to map a MMIO region is to use
dma_map_resource(), so the code is modified
accordingly.

dma_map_resource() expects physical address of the
region to be mapped for DMA, we add a new field,
outbuf_phys_addr, to struct perf_peer, and also
another field, outbuf_dma_addr, to store the
corresponding mapped address returned by the API.

Since the MW is contiguous, rather than mapping
chunk-by-chunk, we map the entire MW before the
actual DMA transfer happens. Then for each chunk,
we simply pass offset into the mapped region and
DMA to that region. Then later, we unmap the MW
during perf_clear_test().

The above means that now we need to have different
function parameters to deal with in the case of
CPU and DMA transfers. In the case of CPU transfers,
we simply need the CPU virtual addresses for memcopy,
but in the case of DMA, we need dma_addr_t, which
will be different from CPU physical address depending
on whether IOMMU is enabled or not. Thus we now
have two separate functions, perf_copy_chunk_cpu(),
and perf_copy_chunk_dma() to take care of above
consideration.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 143 ++++++++++++++++++++++++++----------
 1 file changed, 105 insertions(+), 38 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index e9b7c2dfc730..0e9b9efe74a4 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -149,6 +149,8 @@ struct perf_peer {
 	u64 outbuf_xlat;
 	resource_size_t outbuf_size;
 	void __iomem *outbuf;
+	phys_addr_t outbuf_phys_addr;
+	dma_addr_t outbuf_dma_addr;
 
 	/* Inbound MW params */
 	dma_addr_t inbuf_xlat;
@@ -775,49 +777,41 @@ static void perf_dma_copy_callback(void *data)
 	wake_up(&pthr->dma_wait);
 }
 
-static int perf_copy_chunk(struct perf_thread *pthr,
-			   void __iomem *dst, void *src, size_t len)
+static int perf_copy_chunk_cpu(struct perf_thread *pthr,
+			       void __iomem *dst, void *src, size_t len)
+{
+	memcpy_toio(dst, src, len);
+
+	return likely(atomic_read(&pthr->perf->tsync) > 0) ? 0 : -EINTR;
+}
+
+static int perf_copy_chunk_dma(struct perf_thread *pthr,
+			       dma_addr_t dst, void *src, size_t len)
 {
 	struct dma_async_tx_descriptor *tx;
 	struct dmaengine_unmap_data *unmap;
 	struct device *dma_dev;
 	int try = 0, ret = 0;
 
-	if (!use_dma) {
-		memcpy_toio(dst, src, len);
-		goto ret_check_tsync;
-	}
-
 	dma_dev = pthr->dma_chan->device->dev;
-
-	if (!is_dma_copy_aligned(pthr->dma_chan->device, offset_in_page(src),
-				 offset_in_page(dst), len))
-		return -EIO;
-
-	unmap = dmaengine_get_unmap_data(dma_dev, 2, GFP_NOWAIT);
+	unmap = dmaengine_get_unmap_data(dma_dev, 1, GFP_NOWAIT);
 	if (!unmap)
 		return -ENOMEM;
 
 	unmap->len = len;
 	unmap->addr[0] = dma_map_page(dma_dev, virt_to_page(src),
-		offset_in_page(src), len, DMA_TO_DEVICE);
+				offset_in_page(src), len, DMA_TO_DEVICE);
 	if (dma_mapping_error(dma_dev, unmap->addr[0])) {
 		ret = -EIO;
 		goto err_free_resource;
 	}
 	unmap->to_cnt = 1;
 
-	unmap->addr[1] = dma_map_page(dma_dev, virt_to_page(dst),
-		offset_in_page(dst), len, DMA_FROM_DEVICE);
-	if (dma_mapping_error(dma_dev, unmap->addr[1])) {
-		ret = -EIO;
-		goto err_free_resource;
-	}
-	unmap->from_cnt = 1;
-
 	do {
-		tx = dmaengine_prep_dma_memcpy(pthr->dma_chan, unmap->addr[1],
-			unmap->addr[0], len, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		tx = dmaengine_prep_dma_memcpy(pthr->dma_chan, dst,
+					       unmap->addr[0], len,
+					       DMA_PREP_INTERRUPT |
+					       DMA_CTRL_ACK);
 		if (!tx)
 			msleep(DMA_MDELAY);
 	} while (!tx && (try++ < DMA_TRIES));
@@ -833,22 +827,16 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 
 	ret = dma_submit_error(dmaengine_submit(tx));
 	if (ret) {
-		dmaengine_unmap_put(unmap);
 		goto err_free_resource;
 	}
 
-	dmaengine_unmap_put(unmap);
-
 	atomic_inc(&pthr->dma_sync);
 	dma_async_issue_pending(pthr->dma_chan);
 
-ret_check_tsync:
-	return likely(atomic_read(&pthr->perf->tsync) > 0) ? 0 : -EINTR;
-
 err_free_resource:
 	dmaengine_unmap_put(unmap);
 
-	return ret;
+	return likely(atomic_read(&pthr->perf->tsync) > 0) ? ret : -EINTR;
 }
 
 static bool perf_dma_filter(struct dma_chan *chan, void *data)
@@ -893,7 +881,7 @@ static int perf_init_test(struct perf_thread *pthr)
 	return 0;
 }
 
-static int perf_run_test(struct perf_thread *pthr)
+static int perf_run_test_cpu(struct perf_thread *pthr)
 {
 	struct perf_peer *peer = pthr->perf->test_peer;
 	struct perf_ctx *perf = pthr->perf;
@@ -911,10 +899,9 @@ static int perf_run_test(struct perf_thread *pthr)
 	flt_dst = peer->outbuf;
 
 	pthr->duration = ktime_get();
-
 	/* Copied field is cleared on test launch stage */
 	while (pthr->copied < total_size) {
-		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size);
+		ret = perf_copy_chunk_cpu(pthr, flt_dst, flt_src, chunk_size);
 		if (ret) {
 			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
 				pthr->tidx, ret);
@@ -937,6 +924,74 @@ static int perf_run_test(struct perf_thread *pthr)
 	return 0;
 }
 
+static int perf_run_test_dma(struct perf_thread *pthr)
+{
+	struct perf_peer *peer = pthr->perf->test_peer;
+	struct perf_ctx *perf = pthr->perf;
+	struct device *dma_dev;
+	dma_addr_t flt_dst, bnd_dst;
+	u64 total_size, chunk_size;
+	void *flt_src;
+	int ret = 0;
+
+	total_size = 1ULL << total_order;
+	chunk_size = 1ULL << chunk_order;
+	chunk_size = min_t(u64, peer->outbuf_size, chunk_size);
+
+	/* Map MW for DMA */
+	dma_dev = pthr->dma_chan->device->dev;
+	peer->outbuf_dma_addr = dma_map_resource(dma_dev,
+						 peer->outbuf_phys_addr,
+						 peer->outbuf_size,
+						 DMA_FROM_DEVICE, 0);
+	if (dma_mapping_error(dma_dev, peer->outbuf_dma_addr)) {
+		dma_unmap_resource(dma_dev, peer->outbuf_dma_addr,
+				   peer->outbuf_size, DMA_FROM_DEVICE, 0);
+		return -EIO;
+	}
+
+	flt_src = pthr->src;
+	bnd_dst = peer->outbuf_dma_addr + peer->outbuf_size;
+	flt_dst = peer->outbuf_dma_addr;
+
+	pthr->duration = ktime_get();
+	/* Copied field is cleared on test launch stage */
+	while (pthr->copied < total_size) {
+		ret = perf_copy_chunk_dma(pthr, flt_dst, flt_src, chunk_size);
+		if (ret) {
+			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
+				pthr->tidx, ret);
+			return ret;
+		}
+
+		pthr->copied += chunk_size;
+
+		flt_dst += chunk_size;
+		flt_src += chunk_size;
+		if (flt_dst >= bnd_dst || flt_dst < peer->outbuf_dma_addr) {
+			flt_dst = peer->outbuf_dma_addr;
+			flt_src = pthr->src;
+		}
+
+		/* Give up CPU to give a chance for other threads to use it */
+		schedule();
+	}
+
+	return 0;
+}
+
+static int perf_run_test(struct perf_thread *pthr)
+{
+	int ret = 0;
+
+	if (!use_dma)
+		ret = perf_run_test_cpu(pthr);
+	else
+		ret = perf_run_test_dma(pthr);
+
+	return ret;
+}
+
 static int perf_sync_test(struct perf_thread *pthr)
 {
 	struct perf_ctx *perf = pthr->perf;
@@ -969,6 +1024,8 @@ static int perf_sync_test(struct perf_thread *pthr)
 static void perf_clear_test(struct perf_thread *pthr)
 {
 	struct perf_ctx *perf = pthr->perf;
+	struct perf_peer *peer = pthr->perf->test_peer;
+	struct device *dma_dev;
 
 	if (!use_dma)
 		goto no_dma_notify;
@@ -978,6 +1035,10 @@ static void perf_clear_test(struct perf_thread *pthr)
 	 * We call it anyway just to be sure of the transfers completion.
 	 */
 	(void)dmaengine_terminate_sync(pthr->dma_chan);
+	/* Un-map MW */
+	dma_dev = pthr->dma_chan->device->dev;
+	dma_unmap_resource(dma_dev, peer->outbuf_dma_addr, peer->outbuf_size,
+			   DMA_FROM_DEVICE, 0);
 
 	dma_release_channel(pthr->dma_chan);
 
@@ -1383,10 +1444,16 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
 	if (ret)
 		return ret;
 
-	peer->outbuf = devm_ioremap_wc(&perf->ntb->dev, phys_addr,
-					peer->outbuf_size);
-	if (!peer->outbuf)
-		return -ENOMEM;
+	if (use_dma) {
+		/* For DMA to/from MW */
+		peer->outbuf_phys_addr = phys_addr;
+	} else {
+		/* For CPU read(from)/write(to) MW */
+		peer->outbuf = devm_ioremap_wc(&perf->ntb->dev, phys_addr,
+					       peer->outbuf_size);
+		if (!peer->outbuf)
+			return -ENOMEM;
+	}
 
 	if (max_mw_size && peer->outbuf_size > max_mw_size) {
 		peer->outbuf_size = max_mw_size;
-- 
2.17.1

