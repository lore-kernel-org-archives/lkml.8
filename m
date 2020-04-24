Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43C5C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01E620736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="G81Ll6c5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgDXNlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727034AbgDXNk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:40:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57295C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:40:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d15so9243503wrx.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O3kXCksVkplPGu3RGgTbI+iq8pciZUYI4GkLsC8wbL8=;
        b=G81Ll6c5opzW5zFc63Alaqh/e+btp5X6IQl1HpHHDi6dl0xRO4wvNA9qi3J59TOz+o
         SvXiRP6tetznCFSbdETva7YcrKJmDPcBMJKNIJZJXgO4RpYRS0sWAgEILBButaqg8W80
         TW5Uls5hswSlnuMz0fv//No+aoD9XjRGTWb1ulgHJ7j1xVCLGjNzXQ0Mh/oGWgTND94d
         pgQZhaaJ3DvAWxn1eKeoZpZcc7JEp3EX/WsQO7pD6nvwBYGG5Lcj3dlk38mwmXMFmzT4
         gFSb4lLr6W+VJpwRLk296Jzz3kTCeajnhE4WJLkLXLhFvqPqegy7ZGijF5hEV1mPB7uk
         /OoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O3kXCksVkplPGu3RGgTbI+iq8pciZUYI4GkLsC8wbL8=;
        b=ZiP7uFWGc8LzrUYdkoDhJqmxS+KzVAHfYq73M/eq/eLjCr5dBAzN6iJ7TuCLoJojan
         Q0uuyqGLNFnZGfAr+bFnJm5ppkO/TX0u4VpbscU/DbdR6mlN00xUg9Xre/U1mB7pWFli
         XBIOwgD60QmEpJV9eHv66imFhRoHvQTaevSc47ry7VZkcMm3JcoenXBHeDlqiwaTmuvT
         YmBysokLafGpjJEQxArZEiZcXk5PE+Dp4Zww3BFeiIMvvP8ibQj4vETHkpsRRBVOZj6O
         JhmXZUDANsYMnTEFWXiIS5pW5Q/k9YEJ/ZZzAaAOeOLjFhs+VJ8+rdoGQhAFO8ZZrHRA
         IbeA==
X-Gm-Message-State: AGi0PuZHOjqYgB9NWnQpYN4ZewIsGpb55Xz0OnU76cQc66DbMk7bWum0
        vkeFWilWkkfVAJXBC/p7/ljEkg==
X-Google-Smtp-Source: APiQypKnTfqip7b5mE8+3UKvsXuGNUavHQ6pIWXq2hDs60y/tQb8fIgLHxsyOKmb1F51FZBX1GVKNg==
X-Received: by 2002:adf:d091:: with SMTP id y17mr10891464wrh.418.1587735658098;
        Fri, 24 Apr 2020 06:40:58 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 185sm3408958wmc.32.2020.04.24.06.40.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 06:40:57 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 3/3] crypto: drbg: DRBG_CTR should select CTR
Date:   Fri, 24 Apr 2020 13:40:47 +0000
Message-Id: <1587735647-17718-4-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587735647-17718-1-git-send-email-clabbe@baylibre.com>
References: <1587735647-17718-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if CRYPTO_DRBG_CTR is builtin and CTR is module, allocating such algo
will fail.
DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
alg: drbg: Failed to reset rng
alg: drbg: Test 0 failed for drbg_pr_ctr_aes128
DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
alg: drbg: Failed to reset rng
alg: drbg: Test 0 failed for drbg_nopr_ctr_aes128
DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
alg: drbg: Failed to reset rng
alg: drbg: Test 0 failed for drbg_nopr_ctr_aes192
DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
alg: drbg: Failed to reset rng
alg: drbg: Test 0 failed for drbg_nopr_ctr_aes256

So let's select CTR instead of just depend on it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index a5936e967fe2..7c2c09a76173 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1821,7 +1821,7 @@ config CRYPTO_DRBG_HASH
 config CRYPTO_DRBG_CTR
 	bool "Enable CTR DRBG"
 	select CRYPTO_AES
-	depends on CRYPTO_CTR
+	select CRYPTO_CTR
 	help
 	  Enable the CTR DRBG variant as defined in NIST SP800-90A.
 
-- 
2.26.2

