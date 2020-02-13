Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B657DC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8540C206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610240;
	bh=ZYhu1oglyVabZJCIqMih7PEUtRywOI7/sk/iy065ffc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O1aa6v9ULpBFXX4oi7AJSIRxLKH69GU5yQ6N3BJU1wNQh/R/97logJdJc+GKTcz2j
	 PJIbglMOPdlkTt7Q5Q6EfBqKwSjz8UiWSgho6OdDpDkLAw9qBdvgDlGIsU79HWl8oS
	 91IRiTJWCaA073uP1kzd53uy4pYRjX1A88nnKio4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgBMQKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:10:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgBMPWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:35 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 302B624699;
        Thu, 13 Feb 2020 15:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607355;
        bh=ZYhu1oglyVabZJCIqMih7PEUtRywOI7/sk/iy065ffc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9+rzGx7WCymVyH3c5Z36Dtv5TFi4EaRGCV1w2FKI7CyhV0KayeRvuOn36V0jkJWL
         YMMG6JYyZT7AvpBZPimnttEXSuRXb3LX4D5Ex4NidXUFI2UJdC8lfbzlN6KmwkxJNw
         95gCkzcbx9X9nhdcKIAe9u1QUz31d7uoW1e3YgSo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.4 21/91] crypto: api - Check spawn->alg under lock in crypto_drop_spawn
Date:   Thu, 13 Feb 2020 07:19:38 -0800
Message-Id: <20200213151829.841711176@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 7db3b61b6bba4310f454588c2ca6faf2958ad79f upstream.

We need to check whether spawn->alg is NULL under lock as otherwise
the algorithm could be removed from under us after we have checked
it and found it to be non-NULL.  This could cause us to remove the
spawn from a non-existent list.

Fixes: 7ede5a5ba55a ("crypto: api - Fix crypto_drop_spawn crash...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/algapi.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -653,11 +653,9 @@ EXPORT_SYMBOL_GPL(crypto_grab_spawn);
 
 void crypto_drop_spawn(struct crypto_spawn *spawn)
 {
-	if (!spawn->alg)
-		return;
-
 	down_write(&crypto_alg_sem);
-	list_del(&spawn->list);
+	if (spawn->alg)
+		list_del(&spawn->list);
 	up_write(&crypto_alg_sem);
 }
 EXPORT_SYMBOL_GPL(crypto_drop_spawn);


