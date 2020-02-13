Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521ECC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4D22073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608322;
	bh=dHeL7CXV9VZmIwpyozwNJgQsEYNVcPDI375P/GphZS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wuby38v7mfhab+dxpdDeDDFRQ+YZtzZ9O+VAT/AGraznti7W1H+iKCAoumhIcvsOe
	 EumZDLbysWUnQ/3ErJCZ5q+Wf2Y4yRDKOhlKmKJQp0IdrdumHBsjQbO/r+2soqXump
	 tex3ZmO+1aJfUJWNW4mnEyygCyOjRBp5fl6hZPmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgBMPil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:38:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729681AbgBMP3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:29:12 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 571EA24670;
        Thu, 13 Feb 2020 15:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607752;
        bh=dHeL7CXV9VZmIwpyozwNJgQsEYNVcPDI375P/GphZS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7id/n/caYU4kpKbyRpEzebwD+eJeYfXRmSY4q3KDc/Lo6H685cZAITt5cly0ufau
         RDu1DG07FERyGRoM/z8xyfdesCUGjrq1SS5V9JoGZRK929nAXKKHoYpTnqsNfI94VQ
         1r4JFxytS4owOldJECALgCtvmQCNj1u6dc5QHGZ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.5 096/120] crypto: artpec6 - return correct error code for failed setkey()
Date:   Thu, 13 Feb 2020 07:21:32 -0800
Message-Id: <20200213151933.339239596@linuxfoundation.org>
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

From: Eric Biggers <ebiggers@google.com>

commit b828f905904cd76424230c69741a4cabb0174168 upstream.

->setkey() is supposed to retun -EINVAL for invalid key lengths, not -1.

Fixes: a21eb94fc4d3 ("crypto: axis - add ARTPEC-6/7 crypto accelerator driver")
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Lars Persson <lars.persson@axis.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/axis/artpec6_crypto.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -1251,7 +1251,7 @@ static int artpec6_crypto_aead_set_key(s
 
 	if (len != 16 && len != 24 && len != 32) {
 		crypto_aead_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
-		return -1;
+		return -EINVAL;
 	}
 
 	ctx->key_length = len;


