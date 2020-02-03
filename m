Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89A7C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA4720838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747282;
	bh=gedCApNfPrc//LS/tGcmI9glIz8nDSTe2XPtHdRuYwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VEX9VUWIRcdJ51VZPhdnFclBbZnYEplFYfbOSGVsPtvDQ9BB550Og1g96aLveMGIz
	 /rhE+ehkFFcUQcnESN+RFA0TIsbLnRd4Rs3M1FZknyGkBEF+vdAtihb4ZLWDPKdpXb
	 RhZEXKeXVatrSH7wpZTdepm5S8i8pPNxp/cX7DaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgBCQ2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:28:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729477AbgBCQ1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:27:48 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 601A02080C;
        Mon,  3 Feb 2020 16:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747267;
        bh=gedCApNfPrc//LS/tGcmI9glIz8nDSTe2XPtHdRuYwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cl7CiGg5ttF1NhRRSCEuNbzjLRtBduIPJzJ1sSMOpUpgMR3ptop7KCOiHAscXrFZH
         QdpC/dyvwNWRRtJeHK0ukNOJ7JlFaY044z5uY3TK6k2dZQD8yC4ouzJqFz5E7X0F+T
         kpfagv3PlYqkW7epDebAz2YY+YiOh3soHvY7bgl4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Atul Gupta <atul.gupta@chelsio.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 13/89] crypto: chelsio - fix writing tfm flags to wrong place
Date:   Mon,  3 Feb 2020 16:18:58 +0000
Message-Id: <20200203161918.621197108@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161916.847439465@linuxfoundation.org>
References: <20200203161916.847439465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit bd56cea012fc2d6381e8cd3209510ce09f9de8c9 upstream.

The chelsio crypto driver is casting 'struct crypto_aead' directly to
'struct crypto_tfm', which is incorrect because the crypto_tfm isn't the
first field of 'struct crypto_aead'.  Consequently, the calls to
crypto_tfm_set_flags() are modifying some other field in the struct.

Also, the driver is setting CRYPTO_TFM_RES_BAD_KEY_LEN in
->setauthsize(), not just in ->setkey().  This is incorrect since this
flag is for bad key lengths, not for bad authentication tag lengths.

Fix these bugs by removing the broken crypto_tfm_set_flags() calls from
->setauthsize() and by fixing them in ->setkey().

Fixes: 324429d74127 ("chcr: Support for Chelsio's Crypto Hardware")
Cc: <stable@vger.kernel.org> # v4.9+
Cc: Atul Gupta <atul.gupta@chelsio.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/chelsio/chcr_algo.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -2693,9 +2693,6 @@ static int chcr_gcm_setauthsize(struct c
 		aeadctx->mayverify = VERIFY_SW;
 		break;
 	default:
-
-		  crypto_tfm_set_flags((struct crypto_tfm *) tfm,
-			CRYPTO_TFM_RES_BAD_KEY_LEN);
 		return -EINVAL;
 	}
 	return crypto_aead_setauthsize(aeadctx->sw_cipher, authsize);
@@ -2720,8 +2717,6 @@ static int chcr_4106_4309_setauthsize(st
 		aeadctx->mayverify = VERIFY_HW;
 		break;
 	default:
-		crypto_tfm_set_flags((struct crypto_tfm *)tfm,
-				     CRYPTO_TFM_RES_BAD_KEY_LEN);
 		return -EINVAL;
 	}
 	return crypto_aead_setauthsize(aeadctx->sw_cipher, authsize);
@@ -2762,8 +2757,6 @@ static int chcr_ccm_setauthsize(struct c
 		aeadctx->mayverify = VERIFY_HW;
 		break;
 	default:
-		crypto_tfm_set_flags((struct crypto_tfm *)tfm,
-				     CRYPTO_TFM_RES_BAD_KEY_LEN);
 		return -EINVAL;
 	}
 	return crypto_aead_setauthsize(aeadctx->sw_cipher, authsize);
@@ -2790,8 +2783,7 @@ static int chcr_ccm_common_setkey(struct
 		ck_size = CHCR_KEYCTX_CIPHER_KEY_SIZE_256;
 		mk_size = CHCR_KEYCTX_MAC_KEY_SIZE_256;
 	} else {
-		crypto_tfm_set_flags((struct crypto_tfm *)aead,
-				     CRYPTO_TFM_RES_BAD_KEY_LEN);
+		crypto_aead_set_flags(aead, CRYPTO_TFM_RES_BAD_KEY_LEN);
 		aeadctx->enckey_len = 0;
 		return	-EINVAL;
 	}
@@ -2831,8 +2823,7 @@ static int chcr_aead_rfc4309_setkey(stru
 	int error;
 
 	if (keylen < 3) {
-		crypto_tfm_set_flags((struct crypto_tfm *)aead,
-				     CRYPTO_TFM_RES_BAD_KEY_LEN);
+		crypto_aead_set_flags(aead, CRYPTO_TFM_RES_BAD_KEY_LEN);
 		aeadctx->enckey_len = 0;
 		return	-EINVAL;
 	}
@@ -2883,8 +2874,7 @@ static int chcr_gcm_setkey(struct crypto
 	} else if (keylen == AES_KEYSIZE_256) {
 		ck_size = CHCR_KEYCTX_CIPHER_KEY_SIZE_256;
 	} else {
-		crypto_tfm_set_flags((struct crypto_tfm *)aead,
-				     CRYPTO_TFM_RES_BAD_KEY_LEN);
+		crypto_aead_set_flags(aead, CRYPTO_TFM_RES_BAD_KEY_LEN);
 		pr_err("GCM: Invalid key length %d\n", keylen);
 		ret = -EINVAL;
 		goto out;


