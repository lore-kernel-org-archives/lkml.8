Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A42C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B119B20708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339710;
	bh=SdEq5FquVtGP1Bawzhl6mZZQ/Of71zBhEmQfv4dxXoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pd7j3+Vud8EozVoxGf1Hu+Zq/bX1q8TTz1Zxnp2K2ldJ589Npd7URUrd9lU3HzMMR
	 JbXQ1pkEobOYHMchn3XiD+uVgi5WpP2IyDKdjywk+Kn9HUtLmmBhOOUFm5cKfE4ciJ
	 DCWf/5XKUNRbhrRUprd5vz+NSXSMuxEYqKfcCur4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgBJNBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:01:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729785AbgBJMkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:43 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AFEE24682;
        Mon, 10 Feb 2020 12:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338442;
        bh=SdEq5FquVtGP1Bawzhl6mZZQ/Of71zBhEmQfv4dxXoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZ8ccJlnCHPFGKCM+Kvwac2cxHitYstsJ4AAjJsYQO/+KANhJo2BGlKP0/Zh46RQl
         jJOnvp2+nRvuR1149rdasaQ1p1xd5weK4/uZm06+S+OX8ye3+vRKOCinmkd3vLc0nE
         WWhGkTtHwAOIJijnByhTkjNa4tNWvP4pFpB0whYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.5 181/367] crypto: arm64/ghash-neon - bump priority to 150
Date:   Mon, 10 Feb 2020 04:31:34 -0800
Message-Id: <20200210122441.468622016@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

commit 5441c6507bc84166e9227e9370a56c57ba13794a upstream.

The SIMD based GHASH implementation for arm64 is typically much faster
than the generic one, and doesn't use any lookup tables, so it is
clearly preferred when available. So bump the priority to reflect that.

Fixes: 5a22b198cd527447 ("crypto: arm64/ghash - register PMULL variants ...")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/crypto/ghash-ce-glue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/crypto/ghash-ce-glue.c
+++ b/arch/arm64/crypto/ghash-ce-glue.c
@@ -259,7 +259,7 @@ static int ghash_setkey(struct crypto_sh
 static struct shash_alg ghash_alg[] = {{
 	.base.cra_name		= "ghash",
 	.base.cra_driver_name	= "ghash-neon",
-	.base.cra_priority	= 100,
+	.base.cra_priority	= 150,
 	.base.cra_blocksize	= GHASH_BLOCK_SIZE,
 	.base.cra_ctxsize	= sizeof(struct ghash_key),
 	.base.cra_module	= THIS_MODULE,


