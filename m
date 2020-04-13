Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1BCC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EBC9206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="V6JnyI75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgDMKFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728265AbgDMKEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:04:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3C9C008611
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:58:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z6so9412067wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=270315LatKcm38YiOphCjAz8sg6iPQPMFxeWxayqEdo=;
        b=V6JnyI75UT97f+5QqWt2Mq+/Bb3RSLqVqHd4i2+jJkGS980UK2nb3+RYrwiMJiZIL0
         R7mZBwwvs8f5TDSpz1+ZJEwWO6fnF3S1xw24ZzWMCAwr78HaSBU19UxVWYHc7JvtznSJ
         V0XsHSJifoS5OnY7BaHuznRqgm/cVLmkwPSod3mZY0ITbptLlwnjtdl0mAdBcPMwrjQw
         VHSlAp6JIGRmE5UVVHp5Hn38aJZijAsioiBoevIctpCN+dujrqdDoHxwdbxaYjzBxlL4
         Hqr4ZL9ta5PO+1HiguM8G9zmpUNWCW78Qtzmh2y5DRJVth0Dshlryj1gQrsEY30PLO9T
         GzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=270315LatKcm38YiOphCjAz8sg6iPQPMFxeWxayqEdo=;
        b=D6wG5X2o3fML6I/7oOEKMDXXweW+m+WUpttfaA4Xml+chGv5WT3fAa9rKRzrdNUEmJ
         99k+evEkh65k0OWakGB7QIFeFmvsMAgo6qFF0qh46+xzgr5uwT2q9W6GMDhgmLRYQEYC
         FTacthHGQNdLiZf/w4BTMnnPMLI4L/RwN2hMfakyCV1tkzknwp9cADjQwuFG9EAh+Jdz
         1HyS64e7jocAUeiEsXfyedIPA7n1cQr/f9Xx6zQoSVtRIiqd0meOM6QJdegHztyXImnx
         L9PsjR7j9L4tICjrEa1O7NwnFsibsXaExbFDZD6rr2T7uKGYkJdSM2dPeBNg+ZgNuEnu
         s6xQ==
X-Gm-Message-State: AGi0PuZ7yr66UsIDSgUPQ6Q26V3pv+9vAGTLxQWVpUd3YQN1CV/Yw9bH
        m6Nj7urQMuCbZUFzOBXbHSE6yg==
X-Google-Smtp-Source: APiQypIANujX5GHsxzoYJ0LgpUK0yajFTkKBgNnm04d5pRrhJmcngZ9YuxjjrUOOI3lQx00GwMm3hg==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr6020114wmc.76.1586771901101;
        Mon, 13 Apr 2020 02:58:21 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id v21sm13594491wmj.8.2020.04.13.02.58.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 02:58:20 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 5/9] crypto: sun8i-ce: rename has_t_dlen_in_bytes to cipher_t_dlen_in_bytes
Date:   Mon, 13 Apr 2020 09:58:05 +0000
Message-Id: <1586771889-3299-6-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586771889-3299-1-git-send-email-clabbe@baylibre.com>
References: <1586771889-3299-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hash algorithms will need also a spetial t_dlen handling, but since the
meaning will be different, rename the current flag to specify it apply
only on ciphers algorithms.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c | 2 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c   | 2 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h        | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index fc0a2299c701..0af1e4db2beb 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -122,7 +122,7 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 	common |= rctx->op_dir | CE_COMM_INT;
 	cet->t_common_ctl = cpu_to_le32(common);
 	/* CTS and recent CE (H6) need length in bytes, in word otherwise */
-	if (ce->variant->has_t_dlen_in_bytes)
+	if (ce->variant->cipher_t_dlen_in_bytes)
 		cet->t_dlen = cpu_to_le32(areq->cryptlen);
 	else
 		cet->t_dlen = cpu_to_le32(areq->cryptlen / 4);
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index dbe2e0c3a4f2..7dcdf674058b 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -61,7 +61,7 @@ static const struct ce_variant ce_h6_variant = {
 	},
 	.op_mode = { CE_OP_ECB, CE_OP_CBC
 	},
-	.has_t_dlen_in_bytes = true,
+	.cipher_t_dlen_in_bytes = true,
 	.ce_clks = {
 		{ "bus", 0, 200000000 },
 		{ "mod", 300000000, 0 },
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index ed1a91da967b..0a70fcc102f1 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -97,7 +97,7 @@ struct ce_clock {
  * @alg_cipher:	list of supported ciphers. for each CE_ID_ this will give the
  *              coresponding CE_ALG_XXX value
  * @op_mode:	list of supported block modes
- * @has_t_dlen_in_bytes:	Does the request size for cipher is in
+ * @cipher_t_dlen_in_bytes:	Does the request size for cipher is in
  *				bytes or words
  * @ce_clks:	list of clocks needed by this variant
  * @esr:	The type of error register
@@ -105,7 +105,7 @@ struct ce_clock {
 struct ce_variant {
 	char alg_cipher[CE_ID_CIPHER_MAX];
 	u32 op_mode[CE_ID_OP_MAX];
-	bool has_t_dlen_in_bytes;
+	bool cipher_t_dlen_in_bytes;
 	struct ce_clock ce_clks[CE_MAX_CLOCKS];
 	int esr;
 };
-- 
2.24.1

