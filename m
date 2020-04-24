Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD42C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA7B2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FuoPfzJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgDXOCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728414AbgDXOCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:02:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FAAC09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:02:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r26so10880969wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SU0E9luozURTZ9TC+AsIeijArTCKSbuhSsq3JPq3G+Q=;
        b=FuoPfzJUK/ct5OaBTFDq9xyu8VZKYeQiFwCDQAeXPwGBBmcCFdiZLenmH3KNChIAjM
         c+Zax04FMpjAF11s0LW7x4jKqmzTHMzPYvIXkBqY5XF3YXiPsqRxXPmNQm0Q6/520H++
         HPxrRjWNsHr/lqXPWUKY8XQjN0VB3QUzRfJuPw3zgfd15dEIGQ57jpSRi7fE3p6cXdkx
         6NLzXSr4vNC9bN937sTzCCxJHmkGQLUwwcDJnpVBdpT9/yDiGxyps94d2eKaYsXjW8nI
         magVDUKbL+sJZKEDdI3RHiVbTHBQEFwb5y4azCLqdR1LABFCY4rDHAA0MYDddOaimcrL
         qdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SU0E9luozURTZ9TC+AsIeijArTCKSbuhSsq3JPq3G+Q=;
        b=UJxYdv62wPBVkZMNhrB1FWPVvnMxhMxi4Y7BkVgi8B1zr2xThHqOZYdxoZ5OhujTDL
         DzTi6k7YTOoBe8w7khcseD0qjnuV/gWEkZTdzrRZyIs42f0osPswC5uKpv5RvVVz27kY
         gSSfSGYHS1+ndzQ+lgPQ7r06+QXRWla+xb6n0n0l25tUbj/5OIMU8ijd3dzTZPEs1vh6
         XL6OoOy7g+8j76J68NOL0cSSBR8FCSMCE1zcaEoPzVKpIP41U5yr1rhbqKb8bLuom7el
         t3RUdsUGzAcgZjUiHxN7DKenVz1pQVBZy5T00W7I7qijZj3pKrQiQVxhBsSWdnh/DHCF
         QEvA==
X-Gm-Message-State: AGi0PuaB0SF5K+f8wpK0wIrPNdYGXphcbZsfErtKKdKTNhRZxUjUX7yq
        SpBHViDU6XUezma5ZKajI27xEQ==
X-Google-Smtp-Source: APiQypI0A8PJKVgaS0meuPVlaPvfocGUfiVkxmyRS+dPjkui9z0Cj6/x2YMQuD8fNlV3vVje8fNMtQ==
X-Received: by 2002:a1c:4304:: with SMTP id q4mr11080546wma.152.1587736955755;
        Fri, 24 Apr 2020 07:02:35 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id v131sm3061051wmb.19.2020.04.24.07.02.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 07:02:34 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 06/14] crypto: sun8i-ss: better debug printing
Date:   Fri, 24 Apr 2020 14:02:06 +0000
Message-Id: <1587736934-22801-7-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587736934-22801-1-git-send-email-clabbe@baylibre.com>
References: <1587736934-22801-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reworks the way debug info are printed.
Instead of printing raw numbers, let's add a bit of context.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index cd408969bd03..8ab154842c9e 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -420,19 +420,19 @@ static int sun8i_ss_dbgfs_read(struct seq_file *seq, void *v)
 			continue;
 		switch (ss_algs[i].type) {
 		case CRYPTO_ALG_TYPE_SKCIPHER:
-			seq_printf(seq, "%s %s %lu %lu\n",
+			seq_printf(seq, "%s %s reqs=%lu fallback=%lu\n",
 				   ss_algs[i].alg.skcipher.base.cra_driver_name,
 				   ss_algs[i].alg.skcipher.base.cra_name,
 				   ss_algs[i].stat_req, ss_algs[i].stat_fb);
 			break;
 		case CRYPTO_ALG_TYPE_RNG:
-			seq_printf(seq, "%s %s %lu %lu\n",
+			seq_printf(seq, "%s %s reqs=%lu tsize=%lu\n",
 				   ss_algs[i].alg.rng.base.cra_driver_name,
 				   ss_algs[i].alg.rng.base.cra_name,
 				   ss_algs[i].stat_req, ss_algs[i].stat_bytes);
 			break;
 		case CRYPTO_ALG_TYPE_AHASH:
-			seq_printf(seq, "%s %s %lu %lu\n",
+			seq_printf(seq, "%s %s reqs=%lu fallback=%lu\n",
 				   ss_algs[i].alg.hash.halg.base.cra_driver_name,
 				   ss_algs[i].alg.hash.halg.base.cra_name,
 				   ss_algs[i].stat_req, ss_algs[i].stat_fb);
-- 
2.26.2

