Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41889C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B93A2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047169;
	bh=C2xvSIt4N+YDFfvjuyl6IfLNv5/JFRfI1h8xGvROUxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BRPiA2MjYFcsOhH/zXnp+TL3fH/Rq/hCzuBcuBfzHFwQcozXQfn3iHfJMtzRnVYAj
	 GXmpK+xTW1n6qa3ZzsMNdFPnrhtPnD2YjLYx4l3B8zhQ4By+PbDhHfP4Uutkvd+v+O
	 7lXmkN3FradGAQ59EzzoiFWCI8VMmGetbLnz0tbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393123AbgDPO0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409351AbgDPN6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:58:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 057A92192A;
        Thu, 16 Apr 2020 13:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045510;
        bh=C2xvSIt4N+YDFfvjuyl6IfLNv5/JFRfI1h8xGvROUxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpxsH8KjCBMxDf0YPi01lCk22o2muqF1Vc0LJR8A54zXUfeg6T2oUsQjvMGy9IcAQ
         Z9gUcz6RrficWPsfh7BHD/vu0eURgNLcl1KuR/2yh/gJQVZbjSpDy62O/JPoYjtwt+
         qilZ4aN7CKOCb1BxWLwFMyDerhNbv5w6rX8K8Ql4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rosioru Dragos <dragos.rosioru@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.6 164/254] crypto: mxs-dcp - fix scatterlist linearization for hash
Date:   Thu, 16 Apr 2020 15:24:13 +0200
Message-Id: <20200416131347.058598124@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rosioru Dragos <dragos.rosioru@nxp.com>

commit fa03481b6e2e82355c46644147b614f18c7a8161 upstream.

The incorrect traversal of the scatterlist, during the linearization phase
lead to computing the hash value of the wrong input buffer.
New implementation uses scatterwalk_map_and_copy()
to address this issue.

Cc: <stable@vger.kernel.org>
Fixes: 15b59e7c3733 ("crypto: mxs - Add Freescale MXS DCP driver")
Signed-off-by: Rosioru Dragos <dragos.rosioru@nxp.com>
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/mxs-dcp.c |   54 ++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -20,6 +20,7 @@
 #include <crypto/sha.h>
 #include <crypto/internal/hash.h>
 #include <crypto/internal/skcipher.h>
+#include <crypto/scatterwalk.h>
 
 #define DCP_MAX_CHANS	4
 #define DCP_BUF_SZ	PAGE_SIZE
@@ -611,49 +612,46 @@ static int dcp_sha_req_to_buf(struct cry
 	struct dcp_async_ctx *actx = crypto_ahash_ctx(tfm);
 	struct dcp_sha_req_ctx *rctx = ahash_request_ctx(req);
 	struct hash_alg_common *halg = crypto_hash_alg_common(tfm);
-	const int nents = sg_nents(req->src);
 
 	uint8_t *in_buf = sdcp->coh->sha_in_buf;
 	uint8_t *out_buf = sdcp->coh->sha_out_buf;
 
-	uint8_t *src_buf;
-
 	struct scatterlist *src;
 
-	unsigned int i, len, clen;
+	unsigned int i, len, clen, oft = 0;
 	int ret;
 
 	int fin = rctx->fini;
 	if (fin)
 		rctx->fini = 0;
 
-	for_each_sg(req->src, src, nents, i) {
-		src_buf = sg_virt(src);
-		len = sg_dma_len(src);
+	src = req->src;
+	len = req->nbytes;
 
-		do {
-			if (actx->fill + len > DCP_BUF_SZ)
-				clen = DCP_BUF_SZ - actx->fill;
-			else
-				clen = len;
+	while (len) {
+		if (actx->fill + len > DCP_BUF_SZ)
+			clen = DCP_BUF_SZ - actx->fill;
+		else
+			clen = len;
 
-			memcpy(in_buf + actx->fill, src_buf, clen);
-			len -= clen;
-			src_buf += clen;
-			actx->fill += clen;
+		scatterwalk_map_and_copy(in_buf + actx->fill, src, oft, clen,
+					 0);
 
-			/*
-			 * If we filled the buffer and still have some
-			 * more data, submit the buffer.
-			 */
-			if (len && actx->fill == DCP_BUF_SZ) {
-				ret = mxs_dcp_run_sha(req);
-				if (ret)
-					return ret;
-				actx->fill = 0;
-				rctx->init = 0;
-			}
-		} while (len);
+		len -= clen;
+		oft += clen;
+		actx->fill += clen;
+
+		/*
+		 * If we filled the buffer and still have some
+		 * more data, submit the buffer.
+		 */
+		if (len && actx->fill == DCP_BUF_SZ) {
+			ret = mxs_dcp_run_sha(req);
+			if (ret)
+				return ret;
+			actx->fill = 0;
+			rctx->init = 0;
+		}
 	}
 
 	if (fin) {


