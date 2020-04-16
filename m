Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1D0C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A88B2223C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587044461;
	bh=z4Y8kmHA0kzaiF82tX9ljWFZJuBuSiiOA2BFNp01Q+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C56JsVyVMgORoamB45V6Z3Fe54K+l+TP2CQdKJ+N8uvJb1L3UrlZM2Y53dvNCOYFm
	 d7S4l/I6B+I9rraSpOjdObOVNxDhuZhij4lJSzmUqWttjprRzdeWrLGDYUVZQABqGA
	 l3APz3LPGRjOMvBcSDvxMqRXNIC+NCALNoMWnWBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898233AbgDPNk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896467AbgDPNcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:32:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5553321D94;
        Thu, 16 Apr 2020 13:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043873;
        bh=z4Y8kmHA0kzaiF82tX9ljWFZJuBuSiiOA2BFNp01Q+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQf6PqqJkSMM4rEGT6DEi47Zw9J9bY60nVlo4emI3uGIRje7Cg0ftgiLt6Qs6V3VI
         kpkLjC/Qf+Y8iBUHd4AUK5yb222m2yJmDHH0NqFEKPPwny1+s8tHXZJakaM2LnG62U
         4eLdKy0n/2Io0t2wSGw4bqvYNaWk+hSF6+8mjvAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 136/146] crypto: ccree - zero out internal struct before use
Date:   Thu, 16 Apr 2020 15:24:37 +0200
Message-Id: <20200416131301.008084729@linuxfoundation.org>
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

From: Gilad Ben-Yossef <gilad@benyossef.com>

[ Upstream commit 9f31eb6e08cc1b0eb3926eebf4c51467479a7722 ]

We did not zero out the internal struct before use causing problem
in some rare error code paths.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccree/cc_aead.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/crypto/ccree/cc_aead.c b/drivers/crypto/ccree/cc_aead.c
index aa6b45bc13b98..c9233420fe421 100644
--- a/drivers/crypto/ccree/cc_aead.c
+++ b/drivers/crypto/ccree/cc_aead.c
@@ -2058,6 +2058,8 @@ static int cc_aead_encrypt(struct aead_request *req)
 	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
 	int rc;
 
+	memset(areq_ctx, 0, sizeof(*areq_ctx));
+
 	/* No generated IV required */
 	areq_ctx->backup_iv = req->iv;
 	areq_ctx->backup_giv = NULL;
@@ -2087,6 +2089,8 @@ static int cc_rfc4309_ccm_encrypt(struct aead_request *req)
 		goto out;
 	}
 
+	memset(areq_ctx, 0, sizeof(*areq_ctx));
+
 	/* No generated IV required */
 	areq_ctx->backup_iv = req->iv;
 	areq_ctx->backup_giv = NULL;
@@ -2106,6 +2110,8 @@ static int cc_aead_decrypt(struct aead_request *req)
 	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
 	int rc;
 
+	memset(areq_ctx, 0, sizeof(*areq_ctx));
+
 	/* No generated IV required */
 	areq_ctx->backup_iv = req->iv;
 	areq_ctx->backup_giv = NULL;
@@ -2133,6 +2139,8 @@ static int cc_rfc4309_ccm_decrypt(struct aead_request *req)
 		goto out;
 	}
 
+	memset(areq_ctx, 0, sizeof(*areq_ctx));
+
 	/* No generated IV required */
 	areq_ctx->backup_iv = req->iv;
 	areq_ctx->backup_giv = NULL;
@@ -2250,6 +2258,8 @@ static int cc_rfc4106_gcm_encrypt(struct aead_request *req)
 		goto out;
 	}
 
+	memset(areq_ctx, 0, sizeof(*areq_ctx));
+
 	/* No generated IV required */
 	areq_ctx->backup_iv = req->iv;
 	areq_ctx->backup_giv = NULL;
@@ -2273,6 +2283,8 @@ static int cc_rfc4543_gcm_encrypt(struct aead_request *req)
 	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
 	int rc;
 
+	memset(areq_ctx, 0, sizeof(*areq_ctx));
+
 	//plaintext is not encryped with rfc4543
 	areq_ctx->plaintext_authenticate_only = true;
 
@@ -2305,6 +2317,8 @@ static int cc_rfc4106_gcm_decrypt(struct aead_request *req)
 		goto out;
 	}
 
+	memset(areq_ctx, 0, sizeof(*areq_ctx));
+
 	/* No generated IV required */
 	areq_ctx->backup_iv = req->iv;
 	areq_ctx->backup_giv = NULL;
@@ -2328,6 +2342,8 @@ static int cc_rfc4543_gcm_decrypt(struct aead_request *req)
 	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
 	int rc;
 
+	memset(areq_ctx, 0, sizeof(*areq_ctx));
+
 	//plaintext is not decryped with rfc4543
 	areq_ctx->plaintext_authenticate_only = true;
 
-- 
2.20.1



