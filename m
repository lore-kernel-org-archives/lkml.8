Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E98C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9121720767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PbpA/M6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgDXNlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726791AbgDXNk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:40:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66341C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:40:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f13so10809839wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lZIpuSXPWLsZ3Ntzn02RaqZNB9d6vv/shxve5+NZrVw=;
        b=PbpA/M6vlDjGx2msHfbPEgx/0Gh27wx83HRlNWMItDypNd1lm61IKglY2gTJqgHinR
         pAI2vwQKyWYpC2JofIrkmK4L/w5JRW9VVwabZuxF2F/EAI6fyRdtTwlFwDnJzwHavsGj
         eYkmVQCHT7SKlFeCGqLmQvVvfOC1wBlohUFmISLz858FmCRTkQxCstXuIUjjd4hz3J8l
         iYe30ZIP7XCSCzCu/Zg6EBfg2nssXmH0tNxPu5gPFmnmzwpIE8sKgzXC+yqF2EqCUwOs
         CO1u5xmMHTLIISY16OX4YAbl95NyLc04RJR967aJqJNt0Q7WM/Xcw+hslecFOvRf1d7S
         ReNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lZIpuSXPWLsZ3Ntzn02RaqZNB9d6vv/shxve5+NZrVw=;
        b=W25lFA2xFvASGJamEWETgMNWlNCHpzM22fnnVGn0MIIxGxP1/Tump1WscKpLcHEO35
         fSJNMxLMXQmoeyC0IDssipKt4iWx82kWNfh7YOCkYjVuWldPCcx7bbpFXILN8T7hMcjv
         /2SrN9WHcAWokTW4IgzymVzXcBSb9nXUJVH6kXgPlfhUfeV5SEHjImTSv62bVwQhQjON
         Ng4wee+ouLwYKPir9YM4qnO13OFGL/qTVjT16NctsD9DrAQatLUqB03/kzviHnZlFjOK
         3+YqihvYmU+QAxyoKxBKDDOoOgouF95ksC+6TNk4wGF13sjAbcyvplbWE2DWZapOM1ci
         y5Vw==
X-Gm-Message-State: AGi0Pubc1tUtL2SZJiOjwZ4CaAiTA8JTFXdEPqvG+GOo8Bbg2XHXfyjf
        scFCvoSkqZ2RXnGoOzbQdr1mXQ==
X-Google-Smtp-Source: APiQypL35SBMMUsY5m5WKFj4P1hk4bx3+QgIbAuAEuKOPI7TwoKFQzAuisIx7hpc0X/gdYCoGiqr1Q==
X-Received: by 2002:adf:fe87:: with SMTP id l7mr11890198wrr.360.1587735656113;
        Fri, 24 Apr 2020 06:40:56 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 185sm3408958wmc.32.2020.04.24.06.40.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 06:40:55 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 1/3] crypto: drbg: DRBG should select SHA512
Date:   Fri, 24 Apr 2020 13:40:45 +0000
Message-Id: <1587735647-17718-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587735647-17718-1-git-send-email-clabbe@baylibre.com>
References: <1587735647-17718-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since DRBG could use SHA384/SHA512, it should select it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index c24a47406f8f..6d27fc6a7bf5 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1810,10 +1810,12 @@ config CRYPTO_DRBG_HMAC
 	default y
 	select CRYPTO_HMAC
 	select CRYPTO_SHA256
+	select CRYPTO_SHA512
 
 config CRYPTO_DRBG_HASH
 	bool "Enable Hash DRBG"
 	select CRYPTO_SHA256
+	select CRYPTO_SHA512
 	help
 	  Enable the Hash DRBG variant as defined in NIST SP800-90A.
 
-- 
2.26.2

