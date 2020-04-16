Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18213C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50182222D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587050139;
	bh=cIOg4crpwTP9ciJe671gs1El4Wkf8mdK+l18SkpVrV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i1n1OKh+1cX5ybiJymr+ZeLlByCw01In057zxxzsinWYQ4BppwKJanWWg9Zwr71rf
	 v985bjcZVUV4o6+wOiNupy1PavXCgEDD9SwZgDZ+ulep/nfwgFoT1WVRD3w2gGy/U9
	 vqJ+zfDyo90uBYJMXD8SGpIsiEWDZGiWbYFNcOZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408794AbgDPPPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441643AbgDPNuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:50:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE9A20786;
        Thu, 16 Apr 2020 13:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044965;
        bh=cIOg4crpwTP9ciJe671gs1El4Wkf8mdK+l18SkpVrV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FD8VPc0KNBXRzlPq83OOYxIUari7/uvbiIIhn8JXVHW5ayxEHLN8sA9G04gSNGDK2
         1+yrIdqr0lMHSDZZkX2KyixjVqG4ZKtiN9moZpp+qTaxXMVM251uRWVk1XqrWYB5L6
         JqECHt2cGdPQewRUPEmsUsMmSHBXUK/uY+P6e6dU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.4 172/232] crypto: ccree - dec auth tag size from cryptlen map
Date:   Thu, 16 Apr 2020 15:24:26 +0200
Message-Id: <20200416131336.541747933@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit 8962c6d2c2b8ca51b0f188109015b15fc5f4da44 upstream.

Remove the auth tag size from cryptlen before mapping the destination
in out-of-place AEAD decryption thus resolving a crash with
extended testmgr tests.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable@vger.kernel.org # v4.19+
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_buffer_mgr.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/crypto/ccree/cc_buffer_mgr.c
+++ b/drivers/crypto/ccree/cc_buffer_mgr.c
@@ -894,8 +894,12 @@ static int cc_aead_chain_data(struct cc_
 
 	if (req->src != req->dst) {
 		size_for_map = areq_ctx->assoclen + req->cryptlen;
-		size_for_map += (direct == DRV_CRYPTO_DIRECTION_ENCRYPT) ?
-				authsize : 0;
+
+		if (direct == DRV_CRYPTO_DIRECTION_ENCRYPT)
+			size_for_map += authsize;
+		else
+			size_for_map -= authsize;
+
 		if (is_gcm4543)
 			size_for_map += crypto_aead_ivsize(tfm);
 


