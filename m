Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EF4C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456F720656
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610012;
	bh=nue5T3gYIodIk7hAlwR2JIdhQ6M5D4n4gZHo6VdSTpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o/G9Yrj4uubMPRAFF4mKPjU45M9KTHdI6I8CXd38++t4Scv/sUVOq3aK4FrPVXXbt
	 Jz5uSfXT+ir+gFcAZtNZUQ0omBHQp1FfwZzURCjbOxA6s801BmakIactRfnIBMtM/O
	 bGM9jM66Y76xW49XK/+Kh897ea8oEaFKwR9T9Sgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388062AbgBMQGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:06:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbgBMPXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:33 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3679F246AD;
        Thu, 13 Feb 2020 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607413;
        bh=nue5T3gYIodIk7hAlwR2JIdhQ6M5D4n4gZHo6VdSTpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=brkUth03IIBPcwd4c5horHUTHxPBed/Sm+5UR1ff+nw+WhC3oQfyI7VegwjU1qbhA
         6fqS3ruGdKZZWtBzQmj2Rrv2a0YJCwNyjdBe7hV9eYiI5RFuKzl5N2bk2nZmeasb7L
         dClNWwZoIa/MZJRgu53lIa9qoyP65IUVW52/U5S4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 036/116] crypto: pcrypt - Do not clear MAY_SLEEP flag in original request
Date:   Thu, 13 Feb 2020 07:19:40 -0800
Message-Id: <20200213151857.161403531@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

commit e8d998264bffade3cfe0536559f712ab9058d654 upstream.

We should not be modifying the original request's MAY_SLEEP flag
upon completion.  It makes no sense to do so anyway.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Fixes: 5068c7a883d1 ("crypto: pcrypt - Add pcrypt crypto...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Tested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/pcrypt.c |    1 -
 1 file changed, 1 deletion(-)

--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -130,7 +130,6 @@ static void pcrypt_aead_done(struct cryp
 	struct padata_priv *padata = pcrypt_request_padata(preq);
 
 	padata->info = err;
-	req->base.flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	padata_do_serial(padata);
 }


