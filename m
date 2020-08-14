Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1D4C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 194D820768
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p38WSimo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgHNRa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbgHNR1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:27:54 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FE4C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:54 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id w1so3611793wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gbewbhEM/mrEwI9f62OGQ1mBf+mvC6G7M7H1HOVG3uM=;
        b=p38WSimo2cpemTGnb7ho4xiQdRAKLTT5gOfsAtwG2IJI5IW6e0rFAfadPWj7eFRGop
         d+rTuTnYeYpjVEx//C+3vfi/7a3XuVT6VGoT/Cc0vMEPRLmWlzDrUn/zXDVrxwqZGNMp
         Z6TsIZBuG6iydGz5PoTKMNraX8uDzql36SZEQsHuhgNlSKVp4bcKvvHWDXYvjbkIvVFF
         V+nFIxR/wJk0bKGoF+u3bumLIrRe0GIfupVJcFJQ4/50TQ6NOEU2x2AQjy72yglzoIhC
         5YuS544qqFRtck75v8RS7rptoaIjIUCZnmv1mBtiYJVtaNGLd//dR8xRa2vXbt4PidYs
         kTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gbewbhEM/mrEwI9f62OGQ1mBf+mvC6G7M7H1HOVG3uM=;
        b=CACQI3NHJS/2SKQmKq89wV9jRw5+6fYnEZFIiPNhLb4hSvCsinFMiI3wVSfwiKQX5c
         u3QfD7tc7mahDL3QHS8BhSLdvsQZvkIzCtVtPQq6JlAiaZ4Xmuz1L7djvXUkf0eSEcHg
         5bY9r+LSa4EOGFFqhvyB13ro+2mWi+4c5TxrAU7I5dtkSIpKPUxP/DrFpsIZ5WaLVwfV
         4VRJM8UnfDSjlgLkh7ZQdgNGC10eeoPfhc+wKdrcBIJ9NRWdOcwHYWstdurzSDvVUUkM
         R29v4RX5hgaFsfSFED/KYiSNC6AZQEW4P0TZO3LAC08u3rYjYN1peOq6Z8hSQItmzBPu
         2BgQ==
X-Gm-Message-State: AOAM531lrCO3Z7H/VKPBRJ5269+oxP1RtFUDR6mx99wv/mhJy/Nve7si
        fvq1LOfujVGZUUoxcjcFQo/yELvlwoHcwtIx
X-Google-Smtp-Source: ABdhPJyuuU97eSpS4icZpwsOHx+U2pkrSyE9d1bvaPq4xdMC1pLHfzAVpabPi/a/WtW8O3//dWoEdWo8B9DvLadS
X-Received: by 2002:a7b:ca4b:: with SMTP id m11mr3338115wml.120.1597426072804;
 Fri, 14 Aug 2020 10:27:52 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:26:54 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <63a51e69950d6d93714a96d51165cdc332552393.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 12/35] kasan, arm64: only init shadow for software modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

Hardware tag-based KASAN won't be using shadow memory. Only initialize
it when one of the software KASAN modes are enabled.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/kasan.h |  8 ++++++--
 arch/arm64/mm/kasan_init.c     | 15 ++++++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index b0dc4abc3589..f7ea70d02cab 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -13,6 +13,12 @@
 #define arch_kasan_get_tag(addr)	__tag_get(addr)
 
 #ifdef CONFIG_KASAN
+void kasan_init(void);
+#else
+static inline void kasan_init(void) { }
+#endif
+
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 /*
  * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
@@ -33,12 +39,10 @@
 #define _KASAN_SHADOW_START(va)	(KASAN_SHADOW_END - (1UL << ((va) - KASAN_SHADOW_SCALE_SHIFT)))
 #define KASAN_SHADOW_START      _KASAN_SHADOW_START(vabits_actual)
 
-void kasan_init(void);
 void kasan_copy_shadow(pgd_t *pgdir);
 asmlinkage void kasan_early_init(void);
 
 #else
-static inline void kasan_init(void) { }
 static inline void kasan_copy_shadow(pgd_t *pgdir) { }
 #endif
 
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 7291b26ce788..4d35eaf3ec97 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -21,6 +21,8 @@
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+
 static pgd_t tmp_pg_dir[PTRS_PER_PGD] __initdata __aligned(PGD_SIZE);
 
 /*
@@ -208,7 +210,7 @@ static void __init clear_pgds(unsigned long start,
 		set_pgd(pgd_offset_k(start), __pgd(0));
 }
 
-void __init kasan_init(void)
+static void __init kasan_init_shadow(void)
 {
 	u64 kimg_shadow_start, kimg_shadow_end;
 	u64 mod_shadow_start, mod_shadow_end;
@@ -269,6 +271,17 @@ void __init kasan_init(void)
 
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+}
+
+#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) */
+
+static inline void __init kasan_init_shadow(void) { }
+
+#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+
+void __init kasan_init(void)
+{
+	kasan_init_shadow();
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
-- 
2.28.0.220.ged08abb693-goog

