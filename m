Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC141C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06F820675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607989;
	bh=ugwuPXf6WghU5oJsdjNmcF1b0R0Cd4sUsD8gETy8zxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oBlky655kFudLGutK6igzeNFis0MVidgASmtamQnk0GORYdke5IfVdX0oghbj35bI
	 zLIKEDQTCNROdL7GFXuZ4FPIa32bIGJWnwwoIdL3tPUDETee/2do7gSMKR6t3Mphp+
	 nqyG4tIxY+QjP/r5rLxovm73b9CpIlRpx//OCiSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgBMPdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:33:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729618AbgBMP2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:54 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAF24222C2;
        Thu, 13 Feb 2020 15:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607733;
        bh=ugwuPXf6WghU5oJsdjNmcF1b0R0Cd4sUsD8gETy8zxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0EiUmmEN50J56iPkyH6tKy8Hb4D3V07E57vphCq4/ymaRZGD+djEmHhGg/dkkWY+F
         nXiEX6M6aoCJ0CPlQL3cwGBdENjWPJ9kz3gI9uOd3CVfTUz8LoMuP4l1UOViNKQP0L
         tKZ8/xHikUJ58xGgqBEiG0KKoBO13fBYvD6WPsLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.5 084/120] crypto: arm/chacha - fix build failured when kernel mode NEON is disabled
Date:   Thu, 13 Feb 2020 07:21:20 -0800
Message-Id: <20200213151929.629202597@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

commit 0bc81767c5bd9d005fae1099fb39eb3688370cb1 upstream.

When the ARM accelerated ChaCha driver is built as part of a configuration
that has kernel mode NEON disabled, we expect the compiler to propagate
the build time constant expression IS_ENABLED(CONFIG_KERNEL_MODE_NEON) in
a way that eliminates all the cross-object references to the actual NEON
routines, which allows the chacha-neon-core.o object to be omitted from
the build entirely.

Unfortunately, this fails to work as expected in some cases, and we may
end up with a build error such as

  chacha-glue.c:(.text+0xc0): undefined reference to `chacha_4block_xor_neon'

caused by the fact that chacha_doneon() has not been eliminated from the
object code, even though it will never be called in practice.

Let's fix this by adding some IS_ENABLED(CONFIG_KERNEL_MODE_NEON) tests
that are not strictly needed from a logical point of view, but should
help the compiler infer that the NEON code paths are unreachable in
those cases.

Fixes: b36d8c09e710c71f ("crypto: arm/chacha - remove dependency on generic ...")
Reported-by: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/crypto/chacha-glue.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/crypto/chacha-glue.c
+++ b/arch/arm/crypto/chacha-glue.c
@@ -115,7 +115,7 @@ static int chacha_stream_xor(struct skci
 		if (nbytes < walk.total)
 			nbytes = round_down(nbytes, walk.stride);
 
-		if (!neon) {
+		if (!IS_ENABLED(CONFIG_KERNEL_MODE_NEON) || !neon) {
 			chacha_doarm(walk.dst.virt.addr, walk.src.virt.addr,
 				     nbytes, state, ctx->nrounds);
 			state[12] += DIV_ROUND_UP(nbytes, CHACHA_BLOCK_SIZE);
@@ -159,7 +159,7 @@ static int do_xchacha(struct skcipher_re
 
 	chacha_init_generic(state, ctx->key, req->iv);
 
-	if (!neon) {
+	if (!IS_ENABLED(CONFIG_KERNEL_MODE_NEON) || !neon) {
 		hchacha_block_arm(state, subctx.key, ctx->nrounds);
 	} else {
 		kernel_neon_begin();


