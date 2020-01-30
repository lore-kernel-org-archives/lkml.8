Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6127C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A643E20702
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410405;
	bh=O6+CZwV5/GKO30XluKSVwYLUjTq2JGzDCBB2SFqBBys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gSAqr7N2yLiiPJ6eCieC7KPDfSp7KVQaZyELtE3hyCuRKUcUo17idkUWK/kPr+mrF
	 BpwTZm7H6w0/HiOSee30K2Z1YAPQtqNkcIruC3Bxtrd/nL8zXEMMRcXRKXQPtvgdoO
	 zIduqT9POrw/uxrULjBG6PMy2vNzXD2JJIHY1JdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgA3Slm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:41:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbgA3Slg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:41:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32A2F205F4;
        Thu, 30 Jan 2020 18:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409695;
        bh=O6+CZwV5/GKO30XluKSVwYLUjTq2JGzDCBB2SFqBBys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogAMtGSYZxHEYNzJuoXkKBlKJDcRKnQc5aQnflORUgYTHURTsc4zypNa21zRbmzCQ
         meVLxwuAsueFl5zb3NnbDr8nw7qX8hqFnAXgUPL8neNO2vTaluTQctFDFcMu5sVVr9
         4Gti8zPVrPXcpCAvc6rw7KCKZFISVc4I1RTcQuBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.5 53/56] crypto: pcrypt - Fix user-after-free on module unload
Date:   Thu, 30 Jan 2020 19:39:10 +0100
Message-Id: <20200130183618.357157371@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.849023566@linuxfoundation.org>
References: <20200130183608.849023566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 07bfd9bdf568a38d9440c607b72342036011f727 upstream.

On module unload of pcrypt we must unregister the crypto algorithms
first and then tear down the padata structure.  As otherwise the
crypto algorithms are still alive and can be used while the padata
structure is being freed.

Fixes: 5068c7a883d1 ("crypto: pcrypt - Add pcrypt crypto...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/pcrypt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -362,11 +362,12 @@ err:
 
 static void __exit pcrypt_exit(void)
 {
+	crypto_unregister_template(&pcrypt_tmpl);
+
 	pcrypt_fini_padata(pencrypt);
 	pcrypt_fini_padata(pdecrypt);
 
 	kset_unregister(pcrypt_kset);
-	crypto_unregister_template(&pcrypt_tmpl);
 }
 
 subsys_initcall(pcrypt_init);


