Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB94BC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEF3215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LuNRf2B0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgCJVFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:05:50 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44977 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgCJVFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:05:48 -0400
Received: by mail-wr1-f49.google.com with SMTP id l18so7615039wru.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 14:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FGYfQIh9wQobh/6Rhp+ohpDYSO5gZAqtEh8Zv2JwpXk=;
        b=LuNRf2B0fGHZf+MZKjsth4jgDkByxYLeWUqVjJ2tjXeELiAUHVqHodja4Ca5If9zd+
         DijJfhSdmJ0u0iAiLnMWtHUb4EBKYnEFzIbqnqd/YeEU6xhfYsI5XQKdDCGPfNE+apFC
         FPyHFo7UHCRuQJI2d3pobnvESVkqzN+9dIf4WCFRI0OZuU8L0bz6D+mq4JRpp6HyqKZz
         zY/pB2KQAFz0yONKXkyv4FmogXG/hMXylTWfldz1Fl9xZFmIUdvW5ujlSFnPU4NSbm1F
         Olj/e2JNEv5h3hd4P6QJvVl4pneS6Xo0dhHEfZEtes0wBw45xwgH+Nx9ke7qMhngrr2R
         1aiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FGYfQIh9wQobh/6Rhp+ohpDYSO5gZAqtEh8Zv2JwpXk=;
        b=Y7pg7aq7pSHur+bervM0v2UT8tQdpdJ3wUyPsg/090ZdDtlUSyoNm4K7AcPhDcrlPq
         tItKQ1H2ETHDe/vnTi33D4KvGE5V2xNc36IW4gZosEmIvB10PF+Qlo7sZ5EqWsrOhGo5
         sPdKJuJT3g6R36ggMLFnDJzl9KcoSDSi1Sz6pOty4l4fvuHeOeEdWMgeruOelonPAz6G
         aYnpsgGuN0TpDYvFxchSC4/nJDDkja1DedW5kE8kl2g49r44PluoG/BsaBLH543n8Vmj
         LDI/2rN4kSOWU3rP4DU+d+LylPeMetNAru7L3B7rj9/u9PJ8P1142wnSzKRhqj6zkwuQ
         y0Fg==
X-Gm-Message-State: ANhLgQ0XMWBnbfCCNVB/HRAiRJUw/YBLHfgkfSdo40ETX/sFzUQNzlWR
        A1oUJduhoAOFMhLGt/HEomhLpw==
X-Google-Smtp-Source: ADFU+vuXKsOvVtJQKFzcYHrMl5dCj1zPN3CK19ZjAdiV7PYEEX2MfPoT5FA9kk81vQ7HEumhf0oxLw==
X-Received: by 2002:a5d:480c:: with SMTP id l12mr8606519wrq.19.1583874346504;
        Tue, 10 Mar 2020 14:05:46 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id f127sm5783049wma.4.2020.03.10.14.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Mar 2020 14:05:45 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 2/2] crypto: drbg: DRBG_CTR should select CTR
Date:   Tue, 10 Mar 2020 21:05:38 +0000
Message-Id: <1583874338-38321-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583874338-38321-1-git-send-email-clabbe@baylibre.com>
References: <1583874338-38321-1-git-send-email-clabbe@baylibre.com>
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
ialg: drbg: Test 0 failed for drbg_nopr_ctr_aes256

Since setting DRBG_CTR=CTR lead to a recursive dependency, let's depends
on CTR=y

Just selecting CTR lead also to a recursive dependency:
crypto/Kconfig:1800:error: recursive dependency detected!
crypto/Kconfig:1800:    symbol CRYPTO_DRBG_MENU is selected by
CRYPTO_RNG_DEFAULT
crypto/Kconfig:83:      symbol CRYPTO_RNG_DEFAULT is selected by
CRYPTO_SEQIV
crypto/Kconfig:330:     symbol CRYPTO_SEQIV is selected by CRYPTO_CTR
crypto/Kconfig:370:     symbol CRYPTO_CTR is selected by CRYPTO_DRBG_CTR
crypto/Kconfig:1822:    symbol CRYPTO_DRBG_CTR depends on
CRYPTO_DRBG_MENU

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- Updated commit message with recursive dependency

 crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 6d27fc6a7bf5..eddeb43fc01c 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1822,7 +1822,7 @@ config CRYPTO_DRBG_HASH
 config CRYPTO_DRBG_CTR
 	bool "Enable CTR DRBG"
 	select CRYPTO_AES
-	depends on CRYPTO_CTR
+	depends on CRYPTO_CTR=y
 	help
 	  Enable the CTR DRBG variant as defined in NIST SP800-90A.
 
-- 
2.24.1

