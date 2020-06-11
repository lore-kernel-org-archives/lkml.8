Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D745EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B575A20691
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cantona-net.20150623.gappssmtp.com header.i=@cantona-net.20150623.gappssmtp.com header.b="JKGaHrcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgFKLvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgFKLvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:51:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CF1C08C5C3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:51:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 64so2565503pfv.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cantona-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9Q/bNkudx/YR8T/B5Qf2u+kTeExsliJmsxeBA26Blw=;
        b=JKGaHrcf2jc9qy+g5pQeMoevubkdV/zG02pyqPwKWK4rz/OUqyT2TOpF6FwZfNIpCe
         pHOm5C4qToDAzCmIyC8AhTRiJ4j63/UNOQ0KHMj1ZKZvOwoU2kyhiojEXcBrx/V9tWqV
         9+3SFthgS3XB98Ut8JWVVA9g9all0AXqyZd7Ny5n4cTyFEe/ONXF9RVCHLMgJCXAtmla
         HHVVbOpeWibgfQXq/ggZBDGO5vDss7N7IFok7Nt8c9VRCnpBRJ3BVoR2c6deicaoL5gq
         KbjF5ImxoCd8jf+P911IhCPmXNKFxcEb71las8aY/UPEfsQmm8112xoYw+k9ov9CqZ98
         KL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9Q/bNkudx/YR8T/B5Qf2u+kTeExsliJmsxeBA26Blw=;
        b=f9BCSSfUEgV0w6GJCFEKginVStF3SHeiySm4qrdPWkvpyDzcJ5z5o8XEMvIMncIrJo
         g9ozcsgp1weKPHkTzqubys62+/2T7MBTZ8p4bfwKD2caFrT3nfKSZNxHF+MLIK8y3eol
         lR98BJ8XTq8nr62Q+qagzc2YfVjP9d4arbFZjIcjzetLxkP7HmBxVqsPFNiJ2OVG9qUr
         UOxhfEa6F8TeAUDXhKemJUvFcectCTIh9VW+6OWex4qP4Q2RJ02Zeuaytxzp9WIL24/d
         Sl6dcE/u8eEQEaTCUYyoUCUjrOS3GcvkT1ixkbtqQS0Goqk/CNqKi+FEFA1q4nRety49
         Fxug==
X-Gm-Message-State: AOAM532gFS39JDAbhnoCQ63h59XvUfOLAtyYcgEeFSx86Z/7+0/bs4F5
        L1vRKN/ainUi9O5uGbC1vRAvAQ==
X-Google-Smtp-Source: ABdhPJz00MVpj1U5fsaTtfPOKDam7osjU7/Rl6iXaxC3mlR38BMRaavOXsHXIuqaNDWewtELx2LZCQ==
X-Received: by 2002:a62:6385:: with SMTP id x127mr6790482pfb.49.1591876299934;
        Thu, 11 Jun 2020 04:51:39 -0700 (PDT)
Received: from localhost.localdomain (059148043022.ctinets.com. [59.148.43.22])
        by smtp.googlemail.com with ESMTPSA id t186sm1511342pfc.39.2020.06.11.04.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 04:51:39 -0700 (PDT)
From:   Su Kang Yin <cantona@cantona.net>
To:     gregkh@linuxfoundation.org, linux-crypto@vger.kernel.org,
        christophe.leroy@c-s.fr, stable@vger.kernel.org
Cc:     Su Kang Yin <cantona@cantona.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] crypto: talitos - fix ECB and CBC algs ivsize
Date:   Thu, 11 Jun 2020 19:50:47 +0800
Message-Id: <20200611115048.21677-1-cantona@cantona.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cantona@cantona.net>
References: <cantona@cantona.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e1de42fdfc6a ("crypto: talitos - fix ECB algs ivsize")
wrongly modified CBC algs ivsize instead of ECB aggs ivsize.

This restore the CBC algs original ivsize of removes ECB's ones.

Fixes: e1de42fdfc6a ("crypto: talitos - fix ECB algs ivsize")
Signed-off-by: Su Kang Yin <cantona@cantona.net>
---
Patch for 4.9 upstream.
---
 drivers/crypto/talitos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 8b383d3d21c2..059c2d4ad18f 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2631,17 +2631,16 @@ static struct talitos_alg_template driver_algs[] = {
 			.cra_name = "ecb(aes)",
 			.cra_driver_name = "ecb-aes-talitos",
 			.cra_blocksize = AES_BLOCK_SIZE,
 			.cra_flags = CRYPTO_ALG_TYPE_ABLKCIPHER |
 				     CRYPTO_ALG_ASYNC,
 			.cra_ablkcipher = {
 				.min_keysize = AES_MIN_KEY_SIZE,
 				.max_keysize = AES_MAX_KEY_SIZE,
-				.ivsize = AES_BLOCK_SIZE,
 			}
 		},
 		.desc_hdr_template = DESC_HDR_TYPE_COMMON_NONSNOOP_NO_AFEU |
 				     DESC_HDR_SEL0_AESU,
 	},
 	{	.type = CRYPTO_ALG_TYPE_ABLKCIPHER,
 		.alg.crypto = {
 			.cra_name = "cbc(aes)",
@@ -2665,16 +2664,17 @@ static struct talitos_alg_template driver_algs[] = {
 			.cra_name = "ctr(aes)",
 			.cra_driver_name = "ctr-aes-talitos",
 			.cra_blocksize = 1,
 			.cra_flags = CRYPTO_ALG_TYPE_ABLKCIPHER |
 				     CRYPTO_ALG_ASYNC,
 			.cra_ablkcipher = {
 				.min_keysize = AES_MIN_KEY_SIZE,
 				.max_keysize = AES_MAX_KEY_SIZE,
+				.ivsize = AES_BLOCK_SIZE,
 				.setkey = ablkcipher_aes_setkey,
 			}
 		},
 		.desc_hdr_template = DESC_HDR_TYPE_AESU_CTR_NONSNOOP |
 				     DESC_HDR_SEL0_AESU |
 				     DESC_HDR_MODE0_AESU_CTR,
 	},
 	{	.type = CRYPTO_ALG_TYPE_ABLKCIPHER,
-- 
2.21.0

