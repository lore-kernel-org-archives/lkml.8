Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57BBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F31F20776
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i8xeTUYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgFVTbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgFVTbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:31:52 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F46FC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:31:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d12so2018961ply.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4nbp+NPCtqAP+1aCZB+BxvvOvC8Ydbr5MOs46Iqp71U=;
        b=i8xeTUYkhUyZD/ZejYoQPEhDfLdlYyCVxvPsD8xQpm+zO42lEdDiJvk8BDYgGEcuJQ
         qLArX4e0fAxdqKPkGHLw5VUwjVETfJ760S8EqnIUxpKn48TOqu7uedsiGT2X2OlwBuzf
         rL0LTOtoD7Ifjax5kOpx8Vz+vl26lvwToxEYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4nbp+NPCtqAP+1aCZB+BxvvOvC8Ydbr5MOs46Iqp71U=;
        b=P+HvTEFJAyeENZ/qUWnFyN6B4UiWmqUVRrXZn7iICo1Rc5Vcvhb6e07v0dMB6t/L+8
         wLdTka6F5whkuz/TcVGT6i0+XLZzrvV09ZxlRa6kZsatkp2PtwIVwJyLqBVm6okV4bkV
         P5Xlv5b2mEHkFn9O2wueySltPDxibDlW9gABVikHUprgQEn8C0WNhXaj9Kau2BcaHCjf
         MrAbavJg0lNIjZCNmiipkL9vJL/Kb8mTDYstiug2YeCEukI+hdUb3hEvytQJiE9+NuEJ
         6XW3ofSlX+SBk+oFraqJNwwKfzIg1LgWe9krnP5Q3r7YXQV/W5B5IvAaN4TbO4LmegcD
         r/BA==
X-Gm-Message-State: AOAM533ncUJSoKWq3RCntmnB/2uibyvP3LjRArlhHqno8bqdhyM8Q7yl
        hLuIzehSj+TXgd/rCj+TWXdleA==
X-Google-Smtp-Source: ABdhPJx7b/cjaG3iRKt8wz6ljAUXxwMmy0SXSiUuqqLbeMskXHHKqA0MuLk0OKzDDvDp/IX6avXBCw==
X-Received: by 2002:a17:90a:5a07:: with SMTP id b7mr18992351pjd.130.1592854311856;
        Mon, 22 Jun 2020 12:31:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q22sm14396934pfg.192.2020.06.22.12.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:31:50 -0700 (PDT)
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
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] jump_label: Provide CONFIG-driven build state defaults
Date:   Mon, 22 Jun 2020 12:31:42 -0700
Message-Id: <20200622193146.2985288-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622193146.2985288-1-keescook@chromium.org>
References: <20200622193146.2985288-1-keescook@chromium.org>
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

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
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
index dc7b87310c10..0e6824fd4458 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2889,11 +2889,7 @@ static inline void kernel_poison_pages(struct page *page, int numpages,
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
@@ -2902,11 +2898,7 @@ static inline bool want_init_on_alloc(gfp_t flags)
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
index 48eb0f1410d4..5885a612fa18 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -136,18 +136,10 @@ unsigned long totalcma_pages __read_mostly;
 
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
2.25.1

