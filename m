Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAE9C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB70820732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hic0LQuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgDMKGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728186AbgDMKEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:04:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5793C008749
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:58:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a201so9021624wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZwalgJuNdjnU0AH+11/7zFoA2oqP3wkRvVgbyS9b41k=;
        b=hic0LQuAXzvi55O0zIA1+YYH0IaWo9xC6vNrqNKXLLE6t0L6s65KOJhN2ySvxwcaE2
         UfpBNhMUnreUZzRG1E2zPrmC6E882yDFM38Nqmou6PyCY3k8V+xPS7+g12jaoJ40sbtd
         Na78pDLRDN972JR27+HedgP0hp2YZr+kaZn7+6ffaTRd5EpINuUaixRJk+H8oTDDVm0x
         1zgcOCRHq9S4JbpMWp9Ov9y8sZ3zgzPPIg2qqd4fzqCI7cLTI0AbSyXIXKxCAFObL179
         r0l+C857kcmKVfYtAQon5Het54zWNG1nzv3p8J10WWj9y1jJ5kbLOXTccIXAHxj2DJ0h
         OQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZwalgJuNdjnU0AH+11/7zFoA2oqP3wkRvVgbyS9b41k=;
        b=c6f0yFR4eeEmz2Aur1gpXAxUvwTH1z18DCVRiqzATOWjO3XsjzhiqO4d7dTzZ/ivT/
         wJW1k4DMf/MqRlcI6NLjgMsbmSnKbRYF/4vmyAc3k0daRAvQejyXvJsJft961nPS8/Xm
         tw6XtbFz2YBpNQZ+nNS4/3+YL1ycu6u5VQhs+K/1SVwuPiIbRpmCPkPzVX4wJsWagzon
         71vM+pyn2N7J5BhZTuvr4bQLTTdFjo35aaJvF04wLI3jD54UdrjEfoZs5w4WJBuTY153
         8D+GaboaU9WtQShK3i+PPdMSR5Xt8PjU053eGcDcmeIuvZSGKQloVRGfk2BFsa4yhA/7
         m4aw==
X-Gm-Message-State: AGi0PuYyn9GgP7hWnSnUVNglMHJmZcBBbHbTaN1dCNmkIXe2kzyC1Bfp
        0NiFgFU1L2vgVOiqtM4qlMf1bA==
X-Google-Smtp-Source: APiQypJGFd0fTWn2WQshxc7mhyVpmXdUe15UiicQpmsE/HOuu386yGM2whwLZD+UKBrpdMA2K809kg==
X-Received: by 2002:a1c:750a:: with SMTP id o10mr17606357wmc.124.1586771897331;
        Mon, 13 Apr 2020 02:58:17 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id v21sm13594491wmj.8.2020.04.13.02.58.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 02:58:16 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/9] crypto: rng - add missing __crypto_rng_cast to the rng header
Date:   Mon, 13 Apr 2020 09:58:01 +0000
Message-Id: <1586771889-3299-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586771889-3299-1-git-send-email-clabbe@baylibre.com>
References: <1586771889-3299-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add __crypto_rng_cast() to the rng header like other
__algo_cast functions.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/crypto/rng.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/crypto/rng.h b/include/crypto/rng.h
index 8b4b844b4eef..0e140f132efe 100644
--- a/include/crypto/rng.h
+++ b/include/crypto/rng.h
@@ -198,4 +198,9 @@ static inline int crypto_rng_seedsize(struct crypto_rng *tfm)
 	return crypto_rng_alg(tfm)->seedsize;
 }
 
+static inline struct crypto_rng *__crypto_rng_cast(struct crypto_tfm *tfm)
+{
+	return container_of(tfm, struct crypto_rng, base);
+}
+
 #endif
-- 
2.24.1

