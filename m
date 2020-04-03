Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EEFC2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3DA206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zNYI2Bz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgDCTvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:51:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54674 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgDCTuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:50:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id h2so378440wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6dyRuU0qv/GfpSwaUpO6HqsZ5FNV24sN7mKJHA69ZbQ=;
        b=zNYI2Bz2ZZvxRiGQWc2aqfXuQwlHzVy/1JcTsIrA5fNpzW1UBC2MNvUaEIJH/MeS0R
         b4NbRNp5RSpQVi6DIwGBkW0nzYlv+8ulLfhvFYhiqcTS7l0WRwpDS1T5InYY4hUUWdU4
         GIH/RmJUL5QP1ejC0BPdEr2eLrm+oOVUgIf8xIr8M0nDHbcof2qdD0U/Hh+9Jp0PMYel
         iG1Yds8CmordrP3frOlREDxf09MxB53pUr7RCAlkL3arlQlX9bXAClR6IjBJzTGoAMgL
         bKah+oTIGcEAFbim7HTaEiZKAd6EoieAGKqL76O/mYidEdUL/Matv98UArNfDudYrZ6C
         E8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6dyRuU0qv/GfpSwaUpO6HqsZ5FNV24sN7mKJHA69ZbQ=;
        b=KiyvHHmFhTEihs+rBsnamtoPpbqXubE+qII/JMjcSZaRcnW5VW1lwXa1YAc9087Gt8
         gNvNXo3t9SyRWppZAERPJH6QHZGxV1yyuPvje0iE0mWuwfPD3pPG8R9JaGsTjqHmcCKn
         /vXuxnMsP+jw/Y1PnTHUESDmxGLRCYbMDUnNJYHi/QfijEJq+LGHM/uYvRMyT+gZYDz/
         gc7aPVVde7sJEtZ8hvh5ywqcF2LNAR5t9H5Sizw/dM6FVIDiLUz97z9uPeNVY8FnBZhS
         fpblnKqShFq1bWf5iqxX9K1e58BTbv/E9UcdWBHkXUWeqFUWpFSjEP6GC3ega7fvQO5S
         gbzQ==
X-Gm-Message-State: AGi0PublQjLp4SK2y02aF58sJVHIgnK+n10Ab23EaMizGSPFBl+WltMI
        bxFDWTheLXrNOf502laG9OFy6Q==
X-Google-Smtp-Source: APiQypK1L403HNRMCm4e7EzTNVx3G7MJ++mQkJ655tG116RXQ/l009JoC493CMtHX26eyzZI0Iznlg==
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr10639456wmm.137.1585943452353;
        Fri, 03 Apr 2020 12:50:52 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id c17sm8102448wrp.28.2020.04.03.12.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2020 12:50:51 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 5/7] crypto: sun8i-ss: fix a trivial typo
Date:   Fri,  3 Apr 2020 19:50:36 +0000
Message-Id: <1585943438-862-6-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585943438-862-1-git-send-email-clabbe@baylibre.com>
References: <1585943438-862-1-git-send-email-clabbe@baylibre.com>
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
2.24.1

