Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B195EC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EAEE2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587553393;
	bh=zme3VJnPvVfRE8xRvtJi2B0Cfn4I7S00HFEx5DBO+cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qUnaFuyDPJYfl8/14flqsIdN+rMVGBfti/D/HdvP66L//nJS4L4206jQJmosRUJdw
	 d/FjU+2kddgj4b1VdjtOI5H73Spksmt0G9OmHFd7+pRk8bUzeBqfO3H2lKt6mO1K/J
	 XlDBA2Xo+skv+nRenvp7kvmQByichq0/m2/L9IXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbgDVLDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgDVKAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:00:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC35E20774;
        Wed, 22 Apr 2020 10:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549609;
        bh=zme3VJnPvVfRE8xRvtJi2B0Cfn4I7S00HFEx5DBO+cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eG1cKxDJfe4rVVqNhcbHzbwUFrb0hUjmWm+8lN1U6WLmBOc6Y48OOUsDM0esV3d5L
         HZYpN0A7gA0ajNipnfWg3ARdLvKCCjmW02GmeYgH4As31MDjftTPSLodWt1Y9eHrk4
         qjGTAmAAyZBEconWtgtG4CS03FVdxFmdOcjw6cWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rosioru Dragos <dragos.rosioru@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.4 034/100] crypto: mxs-dcp - fix scatterlist linearization for hash
Date:   Wed, 22 Apr 2020 11:56:04 +0200
Message-Id: <20200422095028.843809523@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
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
@@ -25,6 +25,7 @@
 #include <crypto/aes.h>
 #include <crypto/sha.h>
 #include <crypto/internal/hash.h>
+#include <crypto/scatterwalk.h>
 
 #define DCP_MAX_CHANS	4
 #define DCP_BUF_SZ	PAGE_SIZE
@@ -626,49 +627,46 @@ static int dcp_sha_req_to_buf(struct cry
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


