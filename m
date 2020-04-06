Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAF7C2BB54
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3447206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LwoWFesn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDFXQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:16:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36595 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgDFXQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 19:16:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id c23so797014pgj.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 16:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+xhCyqQB0W40O85FTKh55+NUFCgAzlVgGvF/KPoh1Gc=;
        b=LwoWFesn1H5UXh6fxlgOTqCRawwYzGBkOsIJMdXLsW9VNmWZh7FlN5g0w5ME0mavLf
         En4DY8Qr/H4pZXCOY4PL6HPF/8zw4SdQLpp2BhqVIanjk6OLqEW7lqoonhxVawZOThPI
         RmDZ3S1j9plwAD/vf8OX3Fgc4njkJ0a8Khu3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+xhCyqQB0W40O85FTKh55+NUFCgAzlVgGvF/KPoh1Gc=;
        b=X8Rho0NwYSB2rZeSgagRWBe6FH4PWUxhEokpJ3UOUtuaE+21XOnETycdpxcr6I85Od
         NBAfrIFLWFe3YlFEDNjY2VzxtQys5hpKlw26jiA8s8cOM3YLW0Mu5E6oEKxY20xHaMqt
         1siNpVTKMBvr6Y0WdVtf7o8yigym96EnzNbdvpBY/lTMpZWQX6erGMoYxInmw1odcmeo
         NTHoGR8uOzv21T11rqwNSUakrLb/2/S8+NJvrne7ItUujnk05YL2dH6kJ1MFOyN43ogp
         vLW6G1JYejknNJwQOziWvVxvLMWtnyedFm5fF66r7qVrtq8pcy11MjFCOZt86MUk+3wS
         ETNQ==
X-Gm-Message-State: AGi0Pub9Z6lmgQMAY/2cWFnig0MK96lVDuALQnr10KayD0kDEfY2QH3E
        pgXQj0F80FlY6BTb+RXsUZS7jg==
X-Google-Smtp-Source: APiQypIdiCJFOXl5opnnyyI8GIGFkvdvihjT0dOslocyOZv32kqWFFk5saHzi7q9MToGH7pRu5xnlA==
X-Received: by 2002:a63:7b1d:: with SMTP id w29mr1421905pgc.4.1586214972791;
        Mon, 06 Apr 2020 16:16:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c190sm12363077pfa.66.2020.04.06.16.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 16:16:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] jump_label: Provide CONFIG-driven build state defaults
Date:   Mon,  6 Apr 2020 16:16:02 -0700
Message-Id: <20200406231606.37619-2-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406231606.37619-1-keescook@chromium.org>
References: <20200406231606.37619-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Choosing the initial state of static branches changes the assembly
layout (if the condition is expected to be likely, inline, or unlikely,
out of line via a jump). A few places in the kernel use (or could be
using) a CONFIG to choose the default state, so provide the
infrastructure to do this and convert the existing cases (init_on_alloc
and init_on_free) to the new macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/jump_label.h | 19 +++++++++++++++++++
 include/linux/mm.h         | 12 ++----------
 mm/page_alloc.c            | 12 ++----------
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 3526c0aee954..615fdfb871a3 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -382,6 +382,21 @@ struct static_key_false {
 		[0 ... (count) - 1] = STATIC_KEY_FALSE_INIT,	\
 	}
 
+#define _DEFINE_STATIC_KEY_1(name)	DEFINE_STATIC_KEY_TRUE(name)
+#define _DEFINE_STATIC_KEY_0(name)	DEFINE_STATIC_KEY_FALSE(name)
+#define DEFINE_STATIC_KEY_MAYBE(cfg, name)			\
+	__PASTE(_DEFINE_STATIC_KEY_, IS_ENABLED(cfg))(name)
+
+#define _DEFINE_STATIC_KEY_RO_1(name)	DEFINE_STATIC_KEY_TRUE_RO(name)
+#define _DEFINE_STATIC_KEY_RO_0(name)	DEFINE_STATIC_KEY_FALSE_RO(name)
+#define DEFINE_STATIC_KEY_MAYBE_RO(cfg, name)			\
+	__PASTE(_DEFINE_STATIC_KEY_RO_, IS_ENABLED(cfg))(name)
+
+#define _DECLARE_STATIC_KEY_1(name)	DECLARE_STATIC_KEY_TRUE(name)
+#define _DECLARE_STATIC_KEY_0(name)	DECLARE_STATIC_KEY_FALSE(name)
+#define DECLARE_STATIC_KEY_MAYBE(cfg, name)			\
+	__PASTE(_DECLARE_STATIC_KEY_, IS_ENABLED(cfg))(name)
+
 extern bool ____wrong_branch_error(void);
 
 #define static_key_enabled(x)							\
@@ -482,6 +497,10 @@ extern bool ____wrong_branch_error(void);
 
 #endif /* CONFIG_JUMP_LABEL */
 
+#define static_branch_maybe(config, x)					\
+	(IS_ENABLED(config) ? static_branch_likely(x)			\
+			    : static_branch_unlikely(x))
+
 /*
  * Advanced usage; refcount, branch is enabled when: count != 0
  */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c54fb96cb1e6..059658604dd6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2662,11 +2662,7 @@ static inline void kernel_poison_pages(struct page *page, int numpages,
 					int enable) { }
 #endif
 
-#ifdef CONFIG_INIT_ON_ALLOC_DEFAULT_ON
-DECLARE_STATIC_KEY_TRUE(init_on_alloc);
-#else
-DECLARE_STATIC_KEY_FALSE(init_on_alloc);
-#endif
+DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 static inline bool want_init_on_alloc(gfp_t flags)
 {
 	if (static_branch_unlikely(&init_on_alloc) &&
@@ -2675,11 +2671,7 @@ static inline bool want_init_on_alloc(gfp_t flags)
 	return flags & __GFP_ZERO;
 }
 
-#ifdef CONFIG_INIT_ON_FREE_DEFAULT_ON
-DECLARE_STATIC_KEY_TRUE(init_on_free);
-#else
-DECLARE_STATIC_KEY_FALSE(init_on_free);
-#endif
+DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 static inline bool want_init_on_free(void)
 {
 	return static_branch_unlikely(&init_on_free) &&
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..1f625e5a03c0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -135,18 +135,10 @@ unsigned long totalcma_pages __read_mostly;
 
 int percpu_pagelist_fraction;
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
-#ifdef CONFIG_INIT_ON_ALLOC_DEFAULT_ON
-DEFINE_STATIC_KEY_TRUE(init_on_alloc);
-#else
-DEFINE_STATIC_KEY_FALSE(init_on_alloc);
-#endif
+DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 EXPORT_SYMBOL(init_on_alloc);
 
-#ifdef CONFIG_INIT_ON_FREE_DEFAULT_ON
-DEFINE_STATIC_KEY_TRUE(init_on_free);
-#else
-DEFINE_STATIC_KEY_FALSE(init_on_free);
-#endif
+DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 EXPORT_SYMBOL(init_on_free);
 
 static int __init early_init_on_alloc(char *buf)
-- 
2.20.1

