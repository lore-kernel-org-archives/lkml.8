Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0F2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 21:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C826D20774
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 21:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JuuCrSJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgHLVvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 17:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLVvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 17:51:55 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA1DC061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 14:51:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f193so1685884pfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=V87j311e4SaSage1A0MUzbfGo+GdO8JYJCvpjXUYsdU=;
        b=JuuCrSJHL05yDhCIgMWwssihbT/0FU6HagnQ/Wc0qs8cW6L58XlfMSxbmLCUUtjU1v
         e/jNDvxxuRg4YcxyWBm75ZSjMCMDVFTLy3WCkDteVC8Aw4gPTCv1vjasMtQDtl1ANk+L
         m5KNdxdg0YrAP6Rd4Y24h25/3aYpE1yLmAboo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=V87j311e4SaSage1A0MUzbfGo+GdO8JYJCvpjXUYsdU=;
        b=YQ4WfgOAIuWB3H4/q16TRwt/n6Uc8rA0GBouspVwdIiHqDDGPPAJwTVcIR7cK9LRWv
         q4sTTINFBK4nQg+Dpl/Sen81nSAeWFnB/HcrVFhTZTp9wDA/u+jUDxoIFEruzgNG4eyT
         Iz7eCn6rDWblaxDhObDzJZ4c9yfaZatGI/nMwK+wXFgT8SayFmUIe/pe7wZKj8wPV01J
         95TLCkRhr1WjRHRjd+E00oOQxJGZtbBagIqTSokFt1TUGsUa5wnACE4zpxzw+Rw0M2bV
         Y20aUx7Y+nt2kGl6pT+UmWCofvEoAl9iCRShxVaHAvNvMN8baBbGS8n8ZTudm0DLr79v
         Qr+Q==
X-Gm-Message-State: AOAM533HD4tp6sIFDjCmtHIlYXKT1+NKpu/UjEVdv1LMUnR/FlDfV3bC
        7FeE7v2BRISbInNve5d1Qb9mIQ==
X-Google-Smtp-Source: ABdhPJyiDFbmD/3ui8ViAYloP9167Bsd8mPA+tiO4XJENWoDt8gRZlflrI+O2XqLK4gRQNiqHiUtkw==
X-Received: by 2002:a65:6287:: with SMTP id f7mr1039468pgv.307.1597269114622;
        Wed, 12 Aug 2020 14:51:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bv17sm2939108pjb.0.2020.08.12.14.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 14:51:53 -0700 (PDT)
Date:   Wed, 12 Aug 2020 14:51:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH] overflow: Add __must_check attribute to check_*() helpers
Message-ID: <202008121450.405E4A3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the destination variable of the check_*_overflow() helpers will
contain a wrapped value on failure, it would be best to make sure callers
really did check the return result of the helper. Adjust the macros to use
a bool-wrapping static inline that is marked with __must_check. This means
the macros can continue to have their type-agnostic behavior while gaining
the function attribute (that cannot be applied directly to macros).

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 51 +++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 93fcef105061..ef7d538c2d08 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -43,6 +43,16 @@
 #define is_non_negative(a) ((a) > 0 || (a) == 0)
 #define is_negative(a) (!(is_non_negative(a)))
 
+/*
+ * Allows to effectively us apply __must_check to a macro so we can have
+ * both the type-agnostic benefits of the macros while also being able to
+ * enforce that the return value is, in fact, checked.
+ */
+static inline bool __must_check __must_check_bool(bool condition)
+{
+	return unlikely(condition);
+}
+
 #ifdef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
 /*
  * For simplicity and code hygiene, the fallback code below insists on
@@ -52,32 +62,32 @@
  * alias for __builtin_add_overflow, but add type checks similar to
  * below.
  */
-#define check_add_overflow(a, b, d) ({		\
+#define check_add_overflow(a, b, d) __must_check_bool(({	\
 	typeof(a) __a = (a);			\
 	typeof(b) __b = (b);			\
 	typeof(d) __d = (d);			\
 	(void) (&__a == &__b);			\
 	(void) (&__a == __d);			\
 	__builtin_add_overflow(__a, __b, __d);	\
-})
+}))
 
-#define check_sub_overflow(a, b, d) ({		\
+#define check_sub_overflow(a, b, d) __must_check_bool(({	\
 	typeof(a) __a = (a);			\
 	typeof(b) __b = (b);			\
 	typeof(d) __d = (d);			\
 	(void) (&__a == &__b);			\
 	(void) (&__a == __d);			\
 	__builtin_sub_overflow(__a, __b, __d);	\
-})
+}))
 
-#define check_mul_overflow(a, b, d) ({		\
+#define check_mul_overflow(a, b, d) __must_check_bool(({	\
 	typeof(a) __a = (a);			\
 	typeof(b) __b = (b);			\
 	typeof(d) __d = (d);			\
 	(void) (&__a == &__b);			\
 	(void) (&__a == __d);			\
 	__builtin_mul_overflow(__a, __b, __d);	\
-})
+}))
 
 #else
 
@@ -190,21 +200,20 @@
 })
 
 
-#define check_add_overflow(a, b, d)					\
-	__builtin_choose_expr(is_signed_type(typeof(a)),		\
-			__signed_add_overflow(a, b, d),			\
-			__unsigned_add_overflow(a, b, d))
+#define check_add_overflow(a, b, d)					   \
+	__must_check_bool(__builtin_choose_expr(is_signed_type(typeof(a)), \
+				__signed_add_overflow(a, b, d),		   \
+				__unsigned_add_overflow(a, b, d)))
 
-#define check_sub_overflow(a, b, d)					\
-	__builtin_choose_expr(is_signed_type(typeof(a)),		\
-			__signed_sub_overflow(a, b, d),			\
-			__unsigned_sub_overflow(a, b, d))
-
-#define check_mul_overflow(a, b, d)					\
-	__builtin_choose_expr(is_signed_type(typeof(a)),		\
-			__signed_mul_overflow(a, b, d),			\
-			__unsigned_mul_overflow(a, b, d))
+#define check_sub_overflow(a, b, d)					   \
+	__must_check_bool(__builtin_choose_expr(is_signed_type(typeof(a)), \
+				__signed_sub_overflow(a, b, d),		   \
+				__unsigned_sub_overflow(a, b, d)))
 
+#define check_mul_overflow(a, b, d)					   \
+	__must_check_bool(__builtin_choose_expr(is_signed_type(typeof(a)), \
+				__signed_mul_overflow(a, b, d),		   \
+				__unsigned_mul_overflow(a, b, d)))
 
 #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
 
@@ -227,7 +236,7 @@
  * '*d' will hold the results of the attempted shift, but is not
  * considered "safe for use" if false is returned.
  */
-#define check_shl_overflow(a, s, d) ({					\
+#define check_shl_overflow(a, s, d) __must_check_bool(({		\
 	typeof(a) _a = a;						\
 	typeof(s) _s = s;						\
 	typeof(d) _d = d;						\
@@ -237,7 +246,7 @@
 	*_d = (_a_full << _to_shift);					\
 	(_to_shift != _s || is_negative(*_d) || is_negative(_a) ||	\
 	(*_d >> _to_shift) != _a);					\
-})
+}))
 
 /**
  * array_size() - Calculate size of 2-dimensional array.
-- 
2.25.1


-- 
Kees Cook
