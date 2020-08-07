Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABEAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 00:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8E72075A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 00:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz7Atwns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHGAtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 20:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHGAtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 20:49:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531EDC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 17:49:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w17so235321ply.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 17:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=PP4HULyUxqDd1w6PKeB4Lgbah/DbES+FeBMEx2CugQk=;
        b=mz7Atwnsv1eAoEUP9SJmYSReTl4tBjjVonCdFFIq+nDsfdmsD5vJCgDP4EsUxtLYy3
         YfCX0gIm/IazZ/1DB5zdWsY9wlQS5GhI5/KgajMXgccP0usV2PSNOa7W2U/OaVZWLrSu
         41JisAUqEaI7RN8Og9A0l7dL/79y/ZSiOGZlHI95x8CT18JzCJWuWwKJd3C7OKxK+TY6
         yfZ5U8BgrRPvgx75joYikaYqT8odlSehyvQdBy2d6QpKEIJfD13ONSFIOH/TX+FxS2s9
         r/hqVcMwDRRrJOYQXlcW1y1dsu3QsMaM/ucSiw/dA8dju97MT9JgmcB5NcPjPae7DF5v
         mm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=PP4HULyUxqDd1w6PKeB4Lgbah/DbES+FeBMEx2CugQk=;
        b=IGLHYDPK7VCn+hRmuPPQbLDz9uGinZx5LmdvKzfPP+xZI7AQmc1qjxciiTZ/e7HdEL
         xYsq8dtKTgS4y98Mw+4CAwrOv8fVmMXk4A4HoHhtxnWFtkFbn1CcVVKpM9whKdHEf5E2
         v2VEUfp52FlAT/lOI/jdTCmKVSDdDy7xocDRNMQ6JbTT6TMAaiq3GWznwWZrjI+ir02K
         qlJ0aui2Ef75Y+bIw3sEQCx5R7z9H8i3+AH8+swmh2yA0YoGScAJcR+SdOIEJl+zcO0D
         524rjw34BVIcrDcnJGbfpd4vGF+HmOJR9+MWOXFdFuODXy2cW6dt5Keb7R0I86hGIu0Q
         f8Mg==
X-Gm-Message-State: AOAM530ZgrosVMx8sqtW91nomVcZTZm9bK/FWc3NvaHU5DpG7GvQ0jHR
        Qo+kozpydB1xc8jEYF76tg7W4AXg
X-Google-Smtp-Source: ABdhPJwaBXO8RAqfMUXeX+3Zhd54RJq4uQVPPDQO7c5NcpJJkuUkSlrKWgwXt83Mw3TuhF9YQVa1GQ==
X-Received: by 2002:a17:90a:36a7:: with SMTP id t36mr11265340pjb.36.1596761348877;
        Thu, 06 Aug 2020 17:49:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 202sm9916655pfy.6.2020.08.06.17.49.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 17:49:07 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        tytso@mit.edu, Guenter Roeck <linux@roeck-us.net>,
        Qian Cai <cai@lca.pw>, Mark Brown <broonie@kernel.org>
Subject: [PATCH] arm64: kaslr: Use standard early random function
Date:   Thu,  6 Aug 2020 17:49:04 -0700
Message-Id: <20200807004904.72893-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 585524081ecd ("random: random.h should include archrandom.h, not
the other way around") tries to fix a problem with recursive inclusion
of linux/random.h and arch/archrandom.h for arm64. Unfortunately, this
results in the following compile error if ARCH_RANDOM is disabled.

arch/arm64/kernel/kaslr.c: In function 'kaslr_early_init':
arch/arm64/kernel/kaslr.c:128:6: error: implicit declaration of function
'__early_cpu_has_rndr'; did you mean '__early_pfn_to_nid'?
[-Werror=implicit-function-declaration]
  if (__early_cpu_has_rndr()) {
      ^~~~~~~~~~~~~~~~~~~~
      __early_pfn_to_nid
arch/arm64/kernel/kaslr.c:131:7: error: implicit declaration of function
'__arm64_rndr' [-Werror=implicit-function-declaration]
   if (__arm64_rndr(&raw))
       ^~~~~~~~~~~~

Problem is that arch/archrandom.h is only included from linux/random.h if
ARCH_RANDOM is enabled. If not, __arm64_rndr() and __early_cpu_has_rndr()
are undeclared, causing the problem.

Use arch_get_random_seed_long_early() instead of arm64 specific functions
to solve the problem. As a side effect of this change, the code no longer
bypasses ARCH_RANDOM, which I consider desirable (after all, ARCH_RANDOM
was disabled for a reason).

Reported-by: Qian Cai <cai@lca.pw>
Fixes: 585524081ecd ("random: random.h should include archrandom.h, not the other way around")
Fixes: 2e8e1ea88cbc ("arm64: Use v8.5-RNG entropy for KASLR seed")
Cc: Qian Cai <cai@lca.pw>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm64/kernel/kaslr.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 9ded4237e1c1..b181e0544b79 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -84,6 +84,7 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	void *fdt;
 	u64 seed, offset, mask, module_range;
 	const u8 *cmdline, *str;
+	unsigned long raw;
 	int size;
 
 	/*
@@ -122,15 +123,12 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	}
 
 	/*
-	 * Mix in any entropy obtainable architecturally, open coded
-	 * since this runs extremely early.
+	 * Mix in any entropy obtainable architecturally if enabled
+	 * and supported.
 	 */
-	if (__early_cpu_has_rndr()) {
-		unsigned long raw;
 
-		if (__arm64_rndr(&raw))
-			seed ^= raw;
-	}
+	if (arch_get_random_seed_long_early(&raw))
+		seed ^= raw;
 
 	if (!seed) {
 		kaslr_status = KASLR_DISABLED_NO_SEED;
-- 
2.17.1

