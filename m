Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3972C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C215920708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339707;
	bh=7OTbkjHlNEdy+CXRaMfUslaLkdTv82A7etR1wjm5MEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=apE3m6+GeRApx2I7uwW6dg9mrRUnTbcbitgpUsMGn9eQxF9uwlu9Ev3Gm69jPvF6y
	 cCWLK1tuoB/nBaA/QJZoG0KelBlSEMfzpHW9aX9VHi4XvZUJmmXL3zheYvJwGGqzHJ
	 4PyiUWYvJNT65N2oYsUeW+Daz25QzKkpO0GvB0Es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgBJNBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:01:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729786AbgBJMkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:43 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09EBD20733;
        Mon, 10 Feb 2020 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338443;
        bh=7OTbkjHlNEdy+CXRaMfUslaLkdTv82A7etR1wjm5MEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJpl4wGF8+eIfrdhK1iTJuOh7dsRK6uxMDQ0oh/Buo6NKrMYhoo9FQ3x9PG/5Qzho
         Hkvlkus1mfxDhNy0ZvpvgJTT9V7lFo2Q+1sEuf2ZUU4CEhHntFbBCbgrGkB1z31QsG
         kl/beXiMA9bWJc/LCD3noJ2WbOP6tC3+rIKy2Ne4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.5 182/367] crypto: pcrypt - Do not clear MAY_SLEEP flag in original request
Date:   Mon, 10 Feb 2020 04:31:35 -0800
Message-Id: <20200210122441.541661971@linuxfoundation.org>
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
@@ -71,7 +71,6 @@ static void pcrypt_aead_done(struct cryp
 	struct padata_priv *padata = pcrypt_request_padata(preq);
 
 	padata->info = err;
-	req->base.flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	padata_do_serial(padata);
 }


