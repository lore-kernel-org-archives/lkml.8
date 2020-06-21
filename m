Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78FBC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A76F248B4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mij5VCPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgFUTbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 15:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbgFUTb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 15:31:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8832EC061795
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:31:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so14585619wrc.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xLoFk+SNurZVpCfpASFCu44pZDZ5n7kdegjD0roxl1w=;
        b=mij5VCPvXCodJTP2uo5shATOmIQiCQB0wfvNiMxCHnltkxe5m4AZ9hdNJRN7hcwyH2
         /Z08yjldl8AyKCtB/1374Kzao+dnNRzLKA+ls6sOx53U+CQYaAh/8w7pCis3nkBylC4B
         Q5QmX2y7TJrfqO19bPaLqViYFQ/4Pf3VQUyVk3M4Yrc2ExRMO4wWBsA6XHOBbMamgc1a
         8nDfahtHbml1o9tOwe+Y3/Fl6zMeiOzHjKhHOzV9X6cW0MwWszQS30L3KLZQGMjeH454
         D5XoDZHP3tVpxS7l4UHncQwWaew9/cgvFANpG/1B/+LHOivo946mDzxLlOXpRBJn0LsT
         /eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xLoFk+SNurZVpCfpASFCu44pZDZ5n7kdegjD0roxl1w=;
        b=tmuiNhi8tTt4kVZ16xYNRFG6gXA0MntEuSkSLnWqwI862bALQrL61cMHiz138DVb+m
         TlbLLXgMJXM2BQNS0czZfIrAULvZfAvx0egLYgMqxqF+7LjC2btFiH+JERNtdlLueku8
         OKQ/XsRhexjLXRXtGuFYyATTN4CmEh5ea1WCt4x0y5IZgNulYvQ2OFVhY7XiD6ayH6zy
         3DkkDl6+6WN+XQ38Agg5IchPW0tuk9p/ucvGBCKTZp1CHoFSq3QaJG/saPqh453Agb7r
         UO+XJwc6xFj1ufVIiX2CfjqkR0ChAWnHTcItVv58UY0yWvBlijOCMivRbjnShqysNbEi
         mIsw==
X-Gm-Message-State: AOAM533HnWTFj7oaxcGVTStKNYxRRhZY3YaypdCZMfh33Tx3meAVYmgT
        stWlHNyuSFHAycAQqcAGKuIgTC4FQgA=
X-Google-Smtp-Source: ABdhPJzi9Xg6EcvR5B/VME215nn87eQCZOUzzRUxyRmN64Era0bJ0FDZPoqUavGgOiROcy7IyHJ15A==
X-Received: by 2002:a5d:6a01:: with SMTP id m1mr15891416wru.115.1592767884299;
        Sun, 21 Jun 2020 12:31:24 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e3sm16086924wrj.17.2020.06.21.12.31.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2020 12:31:23 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 12/14] crypto: sun8i-ce: Add stat_bytes debugfs
Date:   Sun, 21 Jun 2020 19:31:05 +0000
Message-Id: <1592767867-35982-13-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592767867-35982-1-git-send-email-clabbe@baylibre.com>
References: <1592767867-35982-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new stat_bytes counter in the sun8i-ce debugfs.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 19ced8b1cd89..ef2f1e5aa23a 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -274,6 +274,7 @@ struct sun8i_ce_hash_reqctx {
  * @alg:		one of sub struct must be used
  * @stat_req:		number of request done on this template
  * @stat_fb:		number of request which has fallbacked
+ * @stat_bytes:		total data size done by this template
  */
 struct sun8i_ce_alg_template {
 	u32 type;
@@ -287,6 +288,7 @@ struct sun8i_ce_alg_template {
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
 	unsigned long stat_req;
 	unsigned long stat_fb;
+	unsigned long stat_bytes;
 #endif
 };
 
-- 
2.26.2

