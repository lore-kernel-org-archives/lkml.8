Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C043C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4CC2075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyy7A/8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgHGOpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHGOpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:45:24 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC13C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 07:45:24 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a79so1098531pfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 07:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=zxXsF5v4kySUXX8zekd8kr4bDxHN8XmHqdakABYtG0g=;
        b=eyy7A/8gb8nHja2j11uzp8oHZ6E98tg2hH3eO0ZwrKbQ5UQaOFP/jzDAL3HpSDSQ7V
         6z5ODYeZkmoyziFq6M7nb2plZ4qEbXU5fltUB6mNKaQ+dsXl2D0nX1SKPZR+1uIahI3F
         tiuPMoX909fG7aaNDcVG5PhBNUl/s9UwT+ncsjw4F4uhupZgEbiBv2e49aZXwFGWJSYs
         3IOCjNvoX+dLw850w7iRmno/uWfSSOlMAaRKYHBnJ7aWk2haScLlboEs9vTq+TabeVs+
         wvHE54nzX0yZi2FsqOxykr08hJiB5RujuDmU3VDf5x+B4tXF7lfINJhbJfviaXHhgvRO
         1NDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=zxXsF5v4kySUXX8zekd8kr4bDxHN8XmHqdakABYtG0g=;
        b=nG85Mr35JzxI3qARGcQq0PW1+1T8elv2VN5L0enmda3Gso6OOPxpGoA33VcZnqsVTc
         Yhzqf6yNtKxhkYTfGVFKRHHucPKme1qdbwjQNQCnkCuSXw2B9ME49ctOL4HiDmv3DdOU
         wJkBcdF87B6WLyoqRfshWl4NmS0WiqQHTGnzsbvbyhqchxZOLGrb05LCbmWw/gd4e9lC
         x+EvN7o2b0WKixMguPVKBusn3gxFmuIC4ZfU5NsBXDggvKOZ4UQSWRvQCZWCnY9yBS84
         IVk0e1yxzRZBfU5GtcOaH/SyfQyttYxzv7F6bhoTsqVNWoM4LLqQ5ACvAmJ4euIQa+d3
         3NSg==
X-Gm-Message-State: AOAM533FiAZllACheDh162wo57Bz5sf/aD8GAP6CT2ensbqKbzCD4Duc
        sobEn8CBj2y//6NOwDG+zLE=
X-Google-Smtp-Source: ABdhPJwCUSP9BQrZXdhJpcJmeIwQobyUtdREgxCv7vpjeBZ9e3qvFLc520Ft6/bc1SXVUS9ygapc2w==
X-Received: by 2002:a62:830d:: with SMTP id h13mr13130034pfe.269.1596811524143;
        Fri, 07 Aug 2020 07:45:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b23sm5730657pfo.12.2020.08.07.07.45.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Aug 2020 07:45:23 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        tytso@mit.edu, Guenter Roeck <linux@roeck-us.net>,
        Qian Cai <cai@lca.pw>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] arm64: kaslr: Use standard early random function
Date:   Fri,  7 Aug 2020 07:45:21 -0700
Message-Id: <20200807144521.34732-1-linux@roeck-us.net>
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
to solve the problem.

Reported-by: Qian Cai <cai@lca.pw>
Fixes: 585524081ecd ("random: random.h should include archrandom.h, not the other way around")
Cc: Qian Cai <cai@lca.pw>
Cc: Mark Brown <broonie@kernel.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Reviewed-by: and Tested-by: tags
    Removed comment about side effect
        (it wasn't correct; code functionality is the same)
    Removed second Fixes: tag (did not apply)

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

