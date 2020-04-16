Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5E4C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8291D2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587044428;
	bh=gH7swMDbL00KCFBsmZ4JWiRa5w/P1gxEPtUKi019DXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BGP/ETkZQN7TvYcyixV1zlqUP1CCDBRS92roTj1AThSUzL/QcH/gLyotSc2/x2qAq
	 htUEmqVRhu+SvLtsnhhYeXkDcZcJenStPgUoIuzxBxirclQjLlDC9+9JspEn/htViB
	 MpKUdHDG6TlQe/sFy7IqX/W9nK9RPsxAPpzlD/08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898110AbgDPNkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896386AbgDPNb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:31:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E10B8208E4;
        Thu, 16 Apr 2020 13:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043871;
        bh=gH7swMDbL00KCFBsmZ4JWiRa5w/P1gxEPtUKi019DXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g4hD7S3WkoaxTJkathrqYfL0/6zue8o552TXV94+6ReJkiH9aZzd3n+NxAZzt51uY
         SXGOGL1x6ujnyI6RvsTB1/9kdfxTVhv+hA2jKw8nUMFenaIn4Btygcx3L30TrGOd4d
         00nZbQ3KCfCT+pHH7Y6q+DvjyzCGE2pGJVoOiBzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hadar Gat <hadar.gat@arm.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 135/146] crypto: ccree - improve error handling
Date:   Thu, 16 Apr 2020 15:24:36 +0200
Message-Id: <20200416131300.889255507@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hadar Gat <hadar.gat@arm.com>

[ Upstream commit ccba2f1112d4871982ae3f09d1984c0443c89a97 ]

pass the returned error code to the higher level functions

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccree/cc_buffer_mgr.c | 74 +++++++++++++---------------
 1 file changed, 35 insertions(+), 39 deletions(-)

diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c b/drivers/crypto/ccree/cc_buffer_mgr.c
index 90b4870078fb7..7489887cc7802 100644
--- a/drivers/crypto/ccree/cc_buffer_mgr.c
+++ b/drivers/crypto/ccree/cc_buffer_mgr.c
@@ -460,10 +460,8 @@ int cc_map_cipher_request(struct cc_drvdata *drvdata, void *ctx,
 	/* Map the src SGL */
 	rc = cc_map_sg(dev, src, nbytes, DMA_BIDIRECTIONAL, &req_ctx->in_nents,
 		       LLI_MAX_NUM_OF_DATA_ENTRIES, &dummy, &mapped_nents);
-	if (rc) {
-		rc = -ENOMEM;
+	if (rc)
 		goto cipher_exit;
-	}
 	if (mapped_nents > 1)
 		req_ctx->dma_buf_type = CC_DMA_BUF_MLLI;
 
@@ -477,12 +475,11 @@ int cc_map_cipher_request(struct cc_drvdata *drvdata, void *ctx,
 		}
 	} else {
 		/* Map the dst sg */
-		if (cc_map_sg(dev, dst, nbytes, DMA_BIDIRECTIONAL,
-			      &req_ctx->out_nents, LLI_MAX_NUM_OF_DATA_ENTRIES,
-			      &dummy, &mapped_nents)) {
-			rc = -ENOMEM;
+		rc = cc_map_sg(dev, dst, nbytes, DMA_BIDIRECTIONAL,
+			       &req_ctx->out_nents, LLI_MAX_NUM_OF_DATA_ENTRIES,
+			       &dummy, &mapped_nents);
+		if (rc)
 			goto cipher_exit;
-		}
 		if (mapped_nents > 1)
 			req_ctx->dma_buf_type = CC_DMA_BUF_MLLI;
 
@@ -1033,10 +1030,8 @@ static int cc_aead_chain_data(struct cc_drvdata *drvdata,
 			       &areq_ctx->dst.nents,
 			       LLI_MAX_NUM_OF_DATA_ENTRIES, &dst_last_bytes,
 			       &dst_mapped_nents);
-		if (rc) {
-			rc = -ENOMEM;
+		if (rc)
 			goto chain_data_exit;
-		}
 	}
 
 	dst_mapped_nents = cc_get_sgl_nents(dev, req->dst, size_for_map,
@@ -1190,11 +1185,10 @@ int cc_map_aead_request(struct cc_drvdata *drvdata, struct aead_request *req)
 		}
 		areq_ctx->ccm_iv0_dma_addr = dma_addr;
 
-		if (cc_set_aead_conf_buf(dev, areq_ctx, areq_ctx->ccm_config,
-					 &sg_data, req->assoclen)) {
-			rc = -ENOMEM;
+		rc = cc_set_aead_conf_buf(dev, areq_ctx, areq_ctx->ccm_config,
+					  &sg_data, req->assoclen);
+		if (rc)
 			goto aead_map_failure;
-		}
 	}
 
 	if (areq_ctx->cipher_mode == DRV_CIPHER_GCTR) {
@@ -1254,10 +1248,8 @@ int cc_map_aead_request(struct cc_drvdata *drvdata, struct aead_request *req)
 		       (LLI_MAX_NUM_OF_ASSOC_DATA_ENTRIES +
 			LLI_MAX_NUM_OF_DATA_ENTRIES),
 		       &dummy, &mapped_nents);
-	if (rc) {
-		rc = -ENOMEM;
+	if (rc)
 		goto aead_map_failure;
-	}
 
 	if (areq_ctx->is_single_pass) {
 		/*
@@ -1341,6 +1333,7 @@ int cc_map_hash_request_final(struct cc_drvdata *drvdata, void *ctx,
 	struct mlli_params *mlli_params = &areq_ctx->mlli_params;
 	struct buffer_array sg_data;
 	struct buff_mgr_handle *buff_mgr = drvdata->buff_mgr_handle;
+	int rc = 0;
 	u32 dummy = 0;
 	u32 mapped_nents = 0;
 
@@ -1360,18 +1353,18 @@ int cc_map_hash_request_final(struct cc_drvdata *drvdata, void *ctx,
 	/*TODO: copy data in case that buffer is enough for operation */
 	/* map the previous buffer */
 	if (*curr_buff_cnt) {
-		if (cc_set_hash_buf(dev, areq_ctx, curr_buff, *curr_buff_cnt,
-				    &sg_data)) {
-			return -ENOMEM;
-		}
+		rc = cc_set_hash_buf(dev, areq_ctx, curr_buff, *curr_buff_cnt,
+				     &sg_data);
+		if (rc)
+			return rc;
 	}
 
 	if (src && nbytes > 0 && do_update) {
-		if (cc_map_sg(dev, src, nbytes, DMA_TO_DEVICE,
-			      &areq_ctx->in_nents, LLI_MAX_NUM_OF_DATA_ENTRIES,
-			      &dummy, &mapped_nents)) {
+		rc = cc_map_sg(dev, src, nbytes, DMA_TO_DEVICE,
+			       &areq_ctx->in_nents, LLI_MAX_NUM_OF_DATA_ENTRIES,
+			       &dummy, &mapped_nents);
+		if (rc)
 			goto unmap_curr_buff;
-		}
 		if (src && mapped_nents == 1 &&
 		    areq_ctx->data_dma_buf_type == CC_DMA_BUF_NULL) {
 			memcpy(areq_ctx->buff_sg, src,
@@ -1390,7 +1383,8 @@ int cc_map_hash_request_final(struct cc_drvdata *drvdata, void *ctx,
 		/* add the src data to the sg_data */
 		cc_add_sg_entry(dev, &sg_data, areq_ctx->in_nents, src, nbytes,
 				0, true, &areq_ctx->mlli_nents);
-		if (cc_generate_mlli(dev, &sg_data, mlli_params, flags))
+		rc = cc_generate_mlli(dev, &sg_data, mlli_params, flags);
+		if (rc)
 			goto fail_unmap_din;
 	}
 	/* change the buffer index for the unmap function */
@@ -1406,7 +1400,7 @@ int cc_map_hash_request_final(struct cc_drvdata *drvdata, void *ctx,
 	if (*curr_buff_cnt)
 		dma_unmap_sg(dev, areq_ctx->buff_sg, 1, DMA_TO_DEVICE);
 
-	return -ENOMEM;
+	return rc;
 }
 
 int cc_map_hash_request_update(struct cc_drvdata *drvdata, void *ctx,
@@ -1425,6 +1419,7 @@ int cc_map_hash_request_update(struct cc_drvdata *drvdata, void *ctx,
 	struct buffer_array sg_data;
 	struct buff_mgr_handle *buff_mgr = drvdata->buff_mgr_handle;
 	unsigned int swap_index = 0;
+	int rc = 0;
 	u32 dummy = 0;
 	u32 mapped_nents = 0;
 
@@ -1469,21 +1464,21 @@ int cc_map_hash_request_update(struct cc_drvdata *drvdata, void *ctx,
 	}
 
 	if (*curr_buff_cnt) {
-		if (cc_set_hash_buf(dev, areq_ctx, curr_buff, *curr_buff_cnt,
-				    &sg_data)) {
-			return -ENOMEM;
-		}
+		rc = cc_set_hash_buf(dev, areq_ctx, curr_buff, *curr_buff_cnt,
+				     &sg_data);
+		if (rc)
+			return rc;
 		/* change the buffer index for next operation */
 		swap_index = 1;
 	}
 
 	if (update_data_len > *curr_buff_cnt) {
-		if (cc_map_sg(dev, src, (update_data_len - *curr_buff_cnt),
-			      DMA_TO_DEVICE, &areq_ctx->in_nents,
-			      LLI_MAX_NUM_OF_DATA_ENTRIES, &dummy,
-			      &mapped_nents)) {
+		rc = cc_map_sg(dev, src, (update_data_len - *curr_buff_cnt),
+			       DMA_TO_DEVICE, &areq_ctx->in_nents,
+			       LLI_MAX_NUM_OF_DATA_ENTRIES, &dummy,
+			       &mapped_nents);
+		if (rc)
 			goto unmap_curr_buff;
-		}
 		if (mapped_nents == 1 &&
 		    areq_ctx->data_dma_buf_type == CC_DMA_BUF_NULL) {
 			/* only one entry in the SG and no previous data */
@@ -1503,7 +1498,8 @@ int cc_map_hash_request_update(struct cc_drvdata *drvdata, void *ctx,
 		cc_add_sg_entry(dev, &sg_data, areq_ctx->in_nents, src,
 				(update_data_len - *curr_buff_cnt), 0, true,
 				&areq_ctx->mlli_nents);
-		if (cc_generate_mlli(dev, &sg_data, mlli_params, flags))
+		rc = cc_generate_mlli(dev, &sg_data, mlli_params, flags);
+		if (rc)
 			goto fail_unmap_din;
 	}
 	areq_ctx->buff_index = (areq_ctx->buff_index ^ swap_index);
@@ -1517,7 +1513,7 @@ int cc_map_hash_request_update(struct cc_drvdata *drvdata, void *ctx,
 	if (*curr_buff_cnt)
 		dma_unmap_sg(dev, areq_ctx->buff_sg, 1, DMA_TO_DEVICE);
 
-	return -ENOMEM;
+	return rc;
 }
 
 void cc_unmap_hash_request(struct device *dev, void *ctx,
-- 
2.20.1



