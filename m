Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749FEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E54205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410159;
	bh=shx1sGlh9za0Mqaiys2YgLTeo6T/lPQsbfWBk6k3YUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c4irb47ttdR1OIWPaqFIQRtz/N6X3tXS9EIA9WqgnDb+2D5aSH1zhfn/c1WHAGeCi
	 Mw36pthopE88u3cqn6qH8zm1WAVgztPivCjic1wpLQvn9N2D8DG1Ms1wtRqsa1i+Da
	 Zm53YhnFVpcukFBLwsfjGgHKd3z9W7MugG7bVBJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbgA3StS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:49:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731611AbgA3Sss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:48:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9655020CC7;
        Thu, 30 Jan 2020 18:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580410127;
        bh=shx1sGlh9za0Mqaiys2YgLTeo6T/lPQsbfWBk6k3YUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LaP4hLOaHYR410ZAmbVFsbtCOEu87a9iVy68fsgzA1XAAbjJAwh60H+6YLxNCksdX
         DFfsPEUL5azTLpj/EAPdpqtWu7jNEvaApT76GnSgpvwt0TupgbPAnnwrVZFbs+DaA0
         QqRe9B94ga+4JjVRBsRlkhcd76CwQWSFyEi7Sf/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Atul Gupta <atul.gupta@chelsio.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 17/55] crypto: chelsio - fix writing tfm flags to wrong place
Date:   Thu, 30 Jan 2020 19:38:58 +0100
Message-Id: <20200130183611.997731512@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.563083888@linuxfoundation.org>
References: <20200130183608.563083888@linuxfoundation.org>
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
@@ -3135,9 +3135,6 @@ static int chcr_gcm_setauthsize(struct c
 		aeadctx->mayverify = VERIFY_SW;
 		break;
 	default:
-
-		  crypto_tfm_set_flags((struct crypto_tfm *) tfm,
-			CRYPTO_TFM_RES_BAD_KEY_LEN);
 		return -EINVAL;
 	}
 	return crypto_aead_setauthsize(aeadctx->sw_cipher, authsize);
@@ -3162,8 +3159,6 @@ static int chcr_4106_4309_setauthsize(st
 		aeadctx->mayverify = VERIFY_HW;
 		break;
 	default:
-		crypto_tfm_set_flags((struct crypto_tfm *)tfm,
-				     CRYPTO_TFM_RES_BAD_KEY_LEN);
 		return -EINVAL;
 	}
 	return crypto_aead_setauthsize(aeadctx->sw_cipher, authsize);
@@ -3204,8 +3199,6 @@ static int chcr_ccm_setauthsize(struct c
 		aeadctx->mayverify = VERIFY_HW;
 		break;
 	default:
-		crypto_tfm_set_flags((struct crypto_tfm *)tfm,
-				     CRYPTO_TFM_RES_BAD_KEY_LEN);
 		return -EINVAL;
 	}
 	return crypto_aead_setauthsize(aeadctx->sw_cipher, authsize);
@@ -3230,8 +3223,7 @@ static int chcr_ccm_common_setkey(struct
 		ck_size = CHCR_KEYCTX_CIPHER_KEY_SIZE_256;
 		mk_size = CHCR_KEYCTX_MAC_KEY_SIZE_256;
 	} else {
-		crypto_tfm_set_flags((struct crypto_tfm *)aead,
-				     CRYPTO_TFM_RES_BAD_KEY_LEN);
+		crypto_aead_set_flags(aead, CRYPTO_TFM_RES_BAD_KEY_LEN);
 		aeadctx->enckey_len = 0;
 		return	-EINVAL;
 	}
@@ -3269,8 +3261,7 @@ static int chcr_aead_rfc4309_setkey(stru
 	int error;
 
 	if (keylen < 3) {
-		crypto_tfm_set_flags((struct crypto_tfm *)aead,
-				     CRYPTO_TFM_RES_BAD_KEY_LEN);
+		crypto_aead_set_flags(aead, CRYPTO_TFM_RES_BAD_KEY_LEN);
 		aeadctx->enckey_len = 0;
 		return	-EINVAL;
 	}
@@ -3320,8 +3311,7 @@ static int chcr_gcm_setkey(struct crypto
 	} else if (keylen == AES_KEYSIZE_256) {
 		ck_size = CHCR_KEYCTX_CIPHER_KEY_SIZE_256;
 	} else {
-		crypto_tfm_set_flags((struct crypto_tfm *)aead,
-				     CRYPTO_TFM_RES_BAD_KEY_LEN);
+		crypto_aead_set_flags(aead, CRYPTO_TFM_RES_BAD_KEY_LEN);
 		pr_err("GCM: Invalid key length %d\n", keylen);
 		ret = -EINVAL;
 		goto out;


