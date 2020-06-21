Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8328EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622962468E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AQxes4jD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgFUTcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 15:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730313AbgFUTbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 15:31:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34239C06179B
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:31:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so14518192wru.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GgwWsZ4vgrBdNIRZyns63cVZRVYxjzfpG44UZZ9qy6E=;
        b=AQxes4jDEkOJtaNCtYYi8ZGqsolaCbfgiINJB07Ifa3ZBfgCWMFUfrtivzTvAsJaj4
         VbobKmUSAkIWcQg+BudWmvWJaEbB5P+HbxpkvZm2wyQTa6auqw2a341WMs1b6RVxHgkJ
         itCZyEnCKXYnCCvH/y3zc3bpqalXoCYaCn1x34rA9BYsByYKOTWmVgpvbmWyK86+u01x
         lfCtMvn9UIMcfN4oG2kV2qyMBHUGVHtA5ZGWj+b+s/Zh6sDQeTOy32eoBEzw1P+ll9QM
         GgMkQc/oP9EOJ6B1hLc8dfvAwIUzKAZx2juNl9VHKXrgEgzMp6gUpGV5Ji9gulcUC5RW
         J/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GgwWsZ4vgrBdNIRZyns63cVZRVYxjzfpG44UZZ9qy6E=;
        b=fDkP29zUihYGyBjrBa9NcDDRBqMePO1T3YF+e+ulbf1e3WXpem5M+HMVYks3i3fiDn
         c3QTjCYoM9NvcY+Z5wGotWS7hZx6UnscwCCiZRFFlw3JNe4hTMgcCsrMprxn+P6le9WM
         pablJj0kvv29nbycP1r0QjW6km5c70Hhl9utSKu2WUNAgH4OgrI6YsrYEmc2s3Uv8RpZ
         Fp5zQyMrWMnk9iq/pIXG6fWreGlqbUnySUjl6VLaf3JypS0hGeWM4DwCJDlqi5fMi4Qh
         kBSna3pKVs9XEMrKkv+bE/bfkI1UnRIufT/PAFFm0cQ739jF8sBaMUgMfNL1II277egG
         3GNQ==
X-Gm-Message-State: AOAM531EXiqWmm5W2pKE2EfHRwybOzIbC0ccX/CgDLmoHGfilO8ajLWc
        QLCgKuKdn6xoWQkxnWN4/IFdOQ==
X-Google-Smtp-Source: ABdhPJwLip0kXrlfAv5IxYrcZDDIHaEW1U89Or8S2HyPV8an8VCkQGkclX3b3mgmSUkutC97mIBTdA==
X-Received: by 2002:adf:d852:: with SMTP id k18mr15469079wrl.177.1592767876948;
        Sun, 21 Jun 2020 12:31:16 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e3sm16086924wrj.17.2020.06.21.12.31.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2020 12:31:16 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 04/14] crypto: sun8i-ss: fix a trivial typo
Date:   Sun, 21 Jun 2020 19:30:57 +0000
Message-Id: <1592767867-35982-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592767867-35982-1-git-send-email-clabbe@baylibre.com>
References: <1592767867-35982-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a trivial typo.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index 350a611b0b9e..056fcdd14201 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -100,7 +100,7 @@ struct ss_clock {
  * @alg_hash:	list of supported hashes. for each SS_ID_ this will give the
  *              corresponding SS_ALG_XXX value
  * @op_mode:	list of supported block modes
- * @ss_clks!	list of clock needed by this variant
+ * @ss_clks:	list of clock needed by this variant
  */
 struct ss_variant {
 	char alg_cipher[SS_ID_CIPHER_MAX];
-- 
2.26.2

