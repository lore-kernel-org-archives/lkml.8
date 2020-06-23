Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1ECC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA4A206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944451;
	bh=wDtFrapsnioZClbXOoiJVnqKh7rXYEFcysXwDAhr9fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WzT8uI2VIEpJhycFHd/GpYnv2t6ahdVz4HqKl8lG3ldtFNHFWki7ZtOGynP3vsmae
	 jJ3d7Qz4cTG2Jztvmtk8JpeLvYVxvdSaBbuHZefDC4volCI/fLN138/APG4FuPUFsJ
	 D5z9hBto7rXaBdKLCLzfpJp21h2vayOyPN2SiOU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391499AbgFWUeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403772AbgFWUd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:33:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 738752064B;
        Tue, 23 Jun 2020 20:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944436;
        bh=wDtFrapsnioZClbXOoiJVnqKh7rXYEFcysXwDAhr9fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AF89dtPnbhQu5bOM8CFD7f+BK4wMV5uHti40twzb0nFA1mPXTdw0RgA/Jwhuld+WO
         fgTq7k3qdJDNPjjM5t8hH7mJbIg50LBoCgbUYi/6l1iE5zdJXPtW4s1EmNKLPk9fVU
         TbaOdgsAE2zzylhGWINViD7bEFDT7+feo7AkThjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH 5.4 305/314] crypto: algif_skcipher - Cap recv SG list at ctx->used
Date:   Tue, 23 Jun 2020 21:58:20 +0200
Message-Id: <20200623195353.545410487@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 7cf81954705b7e5b057f7dc39a7ded54422ab6e1 upstream.

Somewhere along the line the cap on the SG list length for receive
was lost.  This patch restores it and removes the subsequent test
which is now redundant.

Fixes: 2d97591ef43d ("crypto: af_alg - consolidation of...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/algif_skcipher.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -74,14 +74,10 @@ static int _skcipher_recvmsg(struct sock
 		return PTR_ERR(areq);
 
 	/* convert iovecs of output buffers into RX SGL */
-	err = af_alg_get_rsgl(sk, msg, flags, areq, -1, &len);
+	err = af_alg_get_rsgl(sk, msg, flags, areq, ctx->used, &len);
 	if (err)
 		goto free;
 
-	/* Process only as much RX buffers for which we have TX data */
-	if (len > ctx->used)
-		len = ctx->used;
-
 	/*
 	 * If more buffers are to be expected to be processed, process only
 	 * full block size buffers.


