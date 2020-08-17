Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C9AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79DA8205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690842;
	bh=2K2iG1CjBSTPdSLSG5ajTMC50p1FwenSlUrZitpjRWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C+acrsqOj+dFQs/XnI8Clhy+/du7goiGYgLHxE0QxIYxkwGnRZ/rR1VVP6UX2Ng7Z
	 KTijNT/neU+Y2yoQ1ogQepUACAXHq4AhSvmGmxZ4lJ/eHBSIZUKZJXdxfbiDEq0FxD
	 4MgY5SpltCWjoV4/KyGbXf9322Lvf8/Ra0z3ZoDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404002AbgHQTAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730842AbgHQPsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:48:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 357002067C;
        Mon, 17 Aug 2020 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679289;
        bh=2K2iG1CjBSTPdSLSG5ajTMC50p1FwenSlUrZitpjRWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oegW66dysqiskC83vyZ1y93AKbVTIl7YHDFHE1+O88AxJFSxF0EK7O8GwtwNUhS9N
         bZrbwXLIBm6J9gPY/sYa1kHPUNpzzfZ4zQmuVvQbveYVwAG76Zsy9mIshXGEUIUWp1
         takhr69R9NoJCHcyjVERXOWD7ftASRx7ptmXi8OI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 120/393] crypto: caam - silence .setkey in case of bad key length
Date:   Mon, 17 Aug 2020 17:12:50 +0200
Message-Id: <20200817143825.433597223@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geantă <horia.geanta@nxp.com>

[ Upstream commit da6a66853a381864f4b040832cf11f0dbba0a097 ]

In case of bad key length, driver emits "key size mismatch" messages,
but only for xts(aes) algorithms.

Reduce verbosity by making them visible only when debugging.
This way crypto fuzz testing log cleans up a bit.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/caam/caamalg.c     | 2 +-
 drivers/crypto/caam/caamalg_qi.c  | 2 +-
 drivers/crypto/caam/caamalg_qi2.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index b2f9882bc010f..bf90a4fcabd1f 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -838,7 +838,7 @@ static int xts_skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	u32 *desc;
 
 	if (keylen != 2 * AES_MIN_KEY_SIZE  && keylen != 2 * AES_MAX_KEY_SIZE) {
-		dev_err(jrdev, "key size mismatch\n");
+		dev_dbg(jrdev, "key size mismatch\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index 27e36bdf6163b..315d53499ce85 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -728,7 +728,7 @@ static int xts_skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	int ret = 0;
 
 	if (keylen != 2 * AES_MIN_KEY_SIZE  && keylen != 2 * AES_MAX_KEY_SIZE) {
-		dev_err(jrdev, "key size mismatch\n");
+		dev_dbg(jrdev, "key size mismatch\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 28669cbecf77c..e1b6bc6ef091b 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -1058,7 +1058,7 @@ static int xts_skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	u32 *desc;
 
 	if (keylen != 2 * AES_MIN_KEY_SIZE  && keylen != 2 * AES_MAX_KEY_SIZE) {
-		dev_err(dev, "key size mismatch\n");
+		dev_dbg(dev, "key size mismatch\n");
 		return -EINVAL;
 	}
 
-- 
2.25.1



