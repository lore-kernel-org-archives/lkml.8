Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE92C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FF02173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222530;
	bh=dh2i587zdnnXchzuqp6Q+w7nspJszCKKud0jJOZMldg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eYGu93Xvga0qJX2Ayu891OjeoVv3LkLkt89hDLANU3lKjP5TQdcQ1vC8GB6DucGk1
	 +iiQLJHP9bt67ftk11XQCN1c7ZzGHWJtYJbsHpRUBkPeYBAFvn6KZPq/+RsOktnJMv
	 hLw6g9qbK/TsvURKOR60fZqrprhRqG9vAbwkqU44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgA1OmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:42:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729692AbgA1ON0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:13:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBAA24688;
        Tue, 28 Jan 2020 14:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220806;
        bh=dh2i587zdnnXchzuqp6Q+w7nspJszCKKud0jJOZMldg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BTgTb789Jg5zQs56UHHP8Lh7rlg4927iEOQcG0RBHUHEAhwCC3JWXv2Z558kh48dK
         ubcAETRM955UR2qFfXCBs9wKHPfbJz5FeSRGGaaRBJ4yD9MyyX1R5uspplagAHqikL
         1uFozVx2OViiuM1tMKhwUpAe81NJ3vl4gXS1ZzfQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Iuliana Prodan <iuliana.prodan@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 118/183] crypto: caam - free resources in case caam_rng registration failed
Date:   Tue, 28 Jan 2020 15:05:37 +0100
Message-Id: <20200128135841.729152110@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

[ Upstream commit c59a1d41672a89b5cac49db1a472ff889e35a2d2 ]

Check the return value of the hardware registration for caam_rng and free
resources in case of failure.

Fixes: e24f7c9e87d4 ("crypto: caam - hwrng support")
Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/caam/caamrng.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index 9b92af2c72412..a77319bf221d8 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -361,7 +361,10 @@ static int __init caam_rng_init(void)
 		goto free_rng_ctx;
 
 	dev_info(dev, "registering rng-caam\n");
-	return hwrng_register(&caam_rng);
+
+	err = hwrng_register(&caam_rng);
+	if (!err)
+		return err;
 
 free_rng_ctx:
 	kfree(rng_ctx);
-- 
2.20.1



