Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47F7C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8FF2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI6jEFfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgBCQy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:54:28 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:47085 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbgBCQy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:54:27 -0500
Received: by mail-qv1-f67.google.com with SMTP id y2so7083451qvu.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 08:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hpGMGa/PI1PP+WC+wjiN2o66llJoPNYf7JDCErHl5Ac=;
        b=JI6jEFfqL+Mii8G3HK+m8c/yOwojkSlxGF+ZSVvsh6ocJEzMXC/8aa8tCqebmJTs4r
         UkagPADuzIUIIrCENIrmwNaij4j+5lZZDrzkciN7g4H/uVTzfu0OmpYXgKpUhP6hCpFk
         UPKlFeVxRVVPRu4yxOJqOlFRpi0tMELj2XqEQgaH1+ImFI5UqrKNMOhVKxuiU5F9B8Xu
         b4oxtjIaM6Sx2g+6ceHsTRkn1pYnbK10aqh2qMf8MRWGCK6Ofdud4W38ovt0p01DH4Dd
         cZwXLfrQSUn24p/0M9EmT9fSa0wzGbmQl1qawvHeSxG41msutojlkNxjsKLozMyg9LHn
         Xz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpGMGa/PI1PP+WC+wjiN2o66llJoPNYf7JDCErHl5Ac=;
        b=CLfUXEdldAsOp3sh1sBFOKmcghv0dd8SNz+WsI73w1zueZ+9YDe6ngnIepUoCal3oF
         XbMMIpgHTStv4k4/OCSXIt6jp8IwnLUPVYys3NCjoQvABUaeYLp97osuUjyuHyzJf+pY
         zr/xm0ANGZIV/uJPwfsMETOZksNhnbaKNXhogZGUAr0bqTU94KwaWi3npp6sDM3Y+PTS
         kQYtPGATvTysd1zLT1PkOI/k/5lqHtoDJKrAatKFYGqPh6AcHU2UwOnUlR5ouMgojk0e
         LLkI+KxdHHZfrr0hRJYG4a6E+hg6eylSnI+QGUDUv1vBf9/bYavo5OMu9SLcDVAbmAiJ
         4YrA==
X-Gm-Message-State: APjAAAW3k9WuLXtESOw/U01WgZDRFnOkIRGIwsSEBM6ULojW3Qj5V4KY
        kbpzoTQ32S64Br21lA6aGWUDv5j1
X-Google-Smtp-Source: APXvYqxL7A5eltrnMc1mBAES9UGM0fxDjJmgzeXgFEfdU27GvIB9xwhBArcHc9vCAIWH/br0OF03ZQ==
X-Received: by 2002:a0c:fac1:: with SMTP id p1mr23906169qvo.231.1580748866223;
        Mon, 03 Feb 2020 08:54:26 -0800 (PST)
Received: from gateway.troianet.com.br (ipv6.troianet.com.br. [2804:688:21:4::2])
        by smtp.gmail.com with ESMTPSA id 65sm10362685qtf.95.2020.02.03.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 08:54:25 -0800 (PST)
From:   Eneas U de Queiroz <cotequeiroz@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>
Subject: [PATCH 2/2] crypto: qce - use AES fallback when len <= 512
Date:   Mon,  3 Feb 2020 13:53:34 -0300
Message-Id: <20200203165334.6185-3-cotequeiroz@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200203165334.6185-1-cotequeiroz@gmail.com>
References: <20200203165334.6185-1-cotequeiroz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Process small blocks using the fallback cipher, as a workaround for an
observed failure (DMA-related, apparently) when computing the GCM ghash
key.  This brings a speed gain as well, since it avoids the latency of
using the hardware engine to process small blocks.

Using software for all 16-byte requests would be enough to make GCM
work, but to increase performance, a larger threshold would be better.
Measuring the performance of supported ciphers with openssl speed,
software matches hardware at around 768-1024 bytes.

Considering the 256-bit ciphers, software is 2-3 times faster than qce
at 256-bytes, 30% faster at 512, and about even at 768-bytes.  With
128-bit keys, the break-even point would be around 1024-bytes.

The threshold is being set a little lower, to 512 bytes, to balance the
cost in CPU usage.

Signed-off-by: Eneas U de Queiroz <cotequeiroz@gmail.com>

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 63ae75809cb7..b1b090349a80 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -166,15 +166,10 @@ static int qce_skcipher_setkey(struct crypto_skcipher *ablk, const u8 *key,
 	switch (IS_XTS(flags) ? keylen >> 1 : keylen) {
 	case AES_KEYSIZE_128:
 	case AES_KEYSIZE_256:
+		memcpy(ctx->enc_key, key, keylen);
 		break;
-	default:
-		goto fallback;
 	}
 
-	ctx->enc_keylen = keylen;
-	memcpy(ctx->enc_key, key, keylen);
-	return 0;
-fallback:
 	ret = crypto_sync_skcipher_setkey(ctx->fallback, key, keylen);
 	if (!ret)
 		ctx->enc_keylen = keylen;
@@ -224,8 +219,9 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	rctx->flags |= encrypt ? QCE_ENCRYPT : QCE_DECRYPT;
 	keylen = IS_XTS(rctx->flags) ? ctx->enc_keylen >> 1 : ctx->enc_keylen;
 
-	if (IS_AES(rctx->flags) && keylen != AES_KEYSIZE_128 &&
-	    keylen != AES_KEYSIZE_256) {
+	if (IS_AES(rctx->flags) &&
+	    ((keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_256)
+	     || req->cryptlen <= 512)) {
 		SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
 
 		skcipher_request_set_sync_tfm(subreq, ctx->fallback);
