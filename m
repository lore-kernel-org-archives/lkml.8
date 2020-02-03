Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93F2C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765F22086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748276;
	bh=ckcf98rypvLsz0Vp0cFslnWN27jANYoCwPDwd2GDQGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nLn9yxQr/vsh8TURGkeYQcHGBV8Q+sW5Q9ZPuC+yqRaPJ3ayqRqjqe/IVdE1AogFK
	 whGHUroN2zEPPH5aR2gPGLYJ8dAcIVruPhWSDxKfrKxKIfuIWkfHgRoCuZJjQmtov4
	 5KEv9YFMXlQbLz+DXRqPLPciU4UNADay9FZBecT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgBCQof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:44:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730199AbgBCQbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:31:23 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 643C621744;
        Mon,  3 Feb 2020 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747482;
        bh=ckcf98rypvLsz0Vp0cFslnWN27jANYoCwPDwd2GDQGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BM1cxcPqU9dov3Zp//GTlHhmqQaOyX/X7p50KT/VI8PCtNke4/TD7C12I2Ojh5qGd
         tX/uFckMAGccfl4Zy+NnH3ThxuQuR6pzG3fswe5QQsoP2Z9CL4x+0qgGaxZUYBfTob
         ofSqSVKe4cCs5rSz/+PWTuiwoj6+LlDk0/Ictr1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 05/70] crypto: pcrypt - Fix user-after-free on module unload
Date:   Mon,  3 Feb 2020 16:19:17 +0000
Message-Id: <20200203161913.126861716@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 07bfd9bdf568a38d9440c607b72342036011f727 ]

On module unload of pcrypt we must unregister the crypto algorithms
first and then tear down the padata structure.  As otherwise the
crypto algorithms are still alive and can be used while the padata
structure is being freed.

Fixes: 5068c7a883d1 ("crypto: pcrypt - Add pcrypt crypto...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/pcrypt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index a5718c0a3dc4e..1348541da463a 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -505,11 +505,12 @@ static int __init pcrypt_init(void)
 
 static void __exit pcrypt_exit(void)
 {
+	crypto_unregister_template(&pcrypt_tmpl);
+
 	pcrypt_fini_padata(&pencrypt);
 	pcrypt_fini_padata(&pdecrypt);
 
 	kset_unregister(pcrypt_kset);
-	crypto_unregister_template(&pcrypt_tmpl);
 }
 
 module_init(pcrypt_init);
-- 
2.20.1



