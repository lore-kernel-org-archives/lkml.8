Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10E1C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B385221D93
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048624;
	bh=YTCURO/wpL4mZgGhN38MtVtgTdD2kwxE6Zl9cpyaaFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M9k29wQW3oTn0Eqyw/FKCpgrjjO6hm8+4ZcY1hj6EYinbTzg5lr1qr/prNBC3R4JF
	 O4lpSSs5kHwVKRIvC1uzPlqFg7P1hQxVtImzgbKdOwheFKbSDINMqfhSxK0KYqWjo5
	 T+8+tnYw0ZbOobgXAUoCGjYhIRE+AFcrHUPIsbzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394738AbgDPOuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405693AbgDPN62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:58:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AB462078B;
        Thu, 16 Apr 2020 13:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045508;
        bh=YTCURO/wpL4mZgGhN38MtVtgTdD2kwxE6Zl9cpyaaFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uoIogT3c1Unh82B2EI5KaVS5pP2UxHO70AQZz+oJrN3LOFEX7TUrddG3hprQtltlP
         Z7fh1txeGcUegw5hS7AHxQnijd4Dzf+btJEoQgfqFn0xsux0nbs8wQ8OZ1fYFHLx9S
         HFdeRM94qQieW62wPm5Lq53h1Tz4PJd/iYZYoJCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.6 163/254] crypto: rng - Fix a refcounting bug in crypto_rng_reset()
Date:   Thu, 16 Apr 2020 15:24:12 +0200
Message-Id: <20200416131346.958192326@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit eed74b3eba9eda36d155c11a12b2b4b50c67c1d8 upstream.

We need to decrement this refcounter on these error paths.

Fixes: f7d76e05d058 ("crypto: user - fix use_after_free of struct xxx_request")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/rng.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/crypto/rng.c
+++ b/crypto/rng.c
@@ -37,12 +37,16 @@ int crypto_rng_reset(struct crypto_rng *
 	crypto_stats_get(alg);
 	if (!seed && slen) {
 		buf = kmalloc(slen, GFP_KERNEL);
-		if (!buf)
+		if (!buf) {
+			crypto_alg_put(alg);
 			return -ENOMEM;
+		}
 
 		err = get_random_bytes_wait(buf, slen);
-		if (err)
+		if (err) {
+			crypto_alg_put(alg);
 			goto out;
+		}
 		seed = buf;
 	}
 


