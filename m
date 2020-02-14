Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD6AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC9B2467B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701269;
	bh=G49HKmQTKtA+wr4UsRFhIrWrbndFXkiqlz9M8hDvXhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qnRoNKKikgKfFxHiYAWSlCCHG1dInfkGMOgY7jkkNHbo+3DjXertfAo1D3tBQ2a/N
	 zbIR4mUHYekZzN5Cdikwmuy7kmCtlEV+9MUajCk6Znq7Uazfb2y7jQb1/M3tmmjsrp
	 VE7EF/hZohp+Zm3/TragDnQMR5CIu1tW7AxALvKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390880AbgBNQIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:08:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390696AbgBNQHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:07:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F478206D7;
        Fri, 14 Feb 2020 16:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696451;
        bh=G49HKmQTKtA+wr4UsRFhIrWrbndFXkiqlz9M8hDvXhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UF6C2ybz3VbRcyUbc7k/hK2Iyt/CN1nbJVGnsJNMJavr1rv9TMZAw0nty4WmyfAS4
         LS3bFb6B3hsx1EpnYxV4UgTW0xa0Qkj2MLKLivGqN9IyfGmWw7XRYB/nchvROjv4xu
         8BRkzqCKC4KT6yX1N8oYrX5qwTK/lk3vPGkVZAKk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Biggers <ebiggers@google.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, linux-arm-kernel@axis.com,
        linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 264/459] crypto: artpec6 - return correct error code for failed setkey()
Date:   Fri, 14 Feb 2020 10:58:34 -0500
Message-Id: <20200214160149.11681-264-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit b828f905904cd76424230c69741a4cabb0174168 ]

->setkey() is supposed to retun -EINVAL for invalid key lengths, not -1.

Fixes: a21eb94fc4d3 ("crypto: axis - add ARTPEC-6/7 crypto accelerator driver")
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Lars Persson <lars.persson@axis.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/axis/artpec6_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 4b20606983a43..22ebe40f09f53 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -1251,7 +1251,7 @@ static int artpec6_crypto_aead_set_key(struct crypto_aead *tfm, const u8 *key,
 
 	if (len != 16 && len != 24 && len != 32) {
 		crypto_aead_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
-		return -1;
+		return -EINVAL;
 	}
 
 	ctx->key_length = len;
-- 
2.20.1

