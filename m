Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0588C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80322068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uOQX4Rem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbgGUTHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbgGUTGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:06:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BC7C0619DF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:06:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so22241969wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FT+2gDwi+eo+TtESsfWRD1fT3NbLCZL+Gr5RVIpvd9A=;
        b=uOQX4RemIlR0j2HEHYAaSyo3IqUDYdlmOlxPQ8DlFtEKtOE53r7MP7XCcOEHMkMcHH
         Ulh3ZeeY73gxeE74lSsmmWLXvrX0EeRl6W8bVRrphQEBYd9ce0TLQdQYffZ11LXNWCyi
         VFMmDZlpQCtHTwnuCaH+oCq19pVS/bfFtW7MUVbnGLSqo0l/OFyN+0FoFP2gH9nbiN19
         qGdb6mgA27UMGMGglxrim2z6f9en91J858w8rai7XZzzRTxZfHOTIJa2RPi0eB8Vt9d2
         cCOeWcwe2ITKSyw/jnn8xkY/97eZXUktTy3hl0AqijRVwmbkgYecCtABCp6bO31rT5hF
         LxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FT+2gDwi+eo+TtESsfWRD1fT3NbLCZL+Gr5RVIpvd9A=;
        b=t5B85yFyenmT2c2lSZCNSHJ2ekApZ6D5KJj/axQ0mfNN7bFHg3iSK6P7wP4DBjSHW0
         ZCuedEIFw97WsNbRFDSWKO6XTEN0Futw5NMZ6TKhF/0HLQd3ZB/hHZEedbBFGG2Lwcb/
         QXpJPrLzwBL5xwTUUJgRsUuUgvDAjIseqqh4eExvAIyDp3X4XNhKUF8DOCU6Ge6QCLwA
         WaqvJ8p0svyst3iYoZ9hePF/L6d2OjjlhfCmzVEBp21ow3GnPvPawZZCHlnjyWnkfxhB
         EEnM3A4HsXMzGFpxuUiG5jaN8Qe0tr0Jhhdkb8GADud41MQ62dtbjveqqlOBQRtveqbR
         TiVQ==
X-Gm-Message-State: AOAM530vyFTmSUUIXJWkuqmFZY9ovDIXwe6+urHEwAzNyuWcRFGPFiQi
        S/UZcTvZzY4btigOHMqjMF/NCw==
X-Google-Smtp-Source: ABdhPJz58pWhTIJIjUQBlthHYEQooH2Rg4duKviDGhSiJw15kYwqUhlPOF/VCsElr8LdruZUhIeb/w==
X-Received: by 2002:adf:e704:: with SMTP id c4mr345406wrm.81.1595358405986;
        Tue, 21 Jul 2020 12:06:45 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id s14sm25794848wrv.24.2020.07.21.12.06.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 12:06:45 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 04/17] crypto: sun8i-ss: fix a trivial typo
Date:   Tue, 21 Jul 2020 19:06:18 +0000
Message-Id: <1595358391-34525-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
References: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
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
index 377ea7acb54d..da71d8059019 100644
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

