Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD42C4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5714F24693
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgB0NCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:02:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:37368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbgB0NC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:02:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F00D0B30D;
        Thu, 27 Feb 2020 13:02:26 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/3] lib/test_printf: Fix structure of basic pointer tests
Date:   Thu, 27 Feb 2020 14:01:22 +0100
Message-Id: <20200227130123.32442-3-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200227130123.32442-1-pmladek@suse.com>
References: <20200227130123.32442-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer formatting tests have been originally split by
the %p modifiers. For example, the function dentry() tested
%pd and %pD handling.

There were recently added tests that do not fit into
the existing structure, namely:

  + hashed pointer testing
  + null and invalid pointer handling with various modifiers

Reshuffle these tests to follow the original structure.

For completeness, add a test for "%px" with some "random" pointer
value. Note that it can't be tested with "%pE" because it would
cause crash.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/test_printf.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 6fa6fb606554..1ee1bb703307 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -278,28 +278,22 @@ test_hashed(const char *fmt, const void *p)
 	failed_tests++;
 }
 
-static void __init
-plain(void)
-{
-	test_hashed("%p", PTR);
-}
+#define PTR_INVALID ((void *)0x000000ab)
 
 static void __init
-null_pointer(void)
+plain_pointer(void)
 {
+	test_hashed("%p", PTR);
 	test_hashed("%p", NULL);
-	test(ZEROS "00000000", "%px", NULL);
-	test("(null)", "%pE", NULL);
+	test_hashed("%p", PTR_INVALID);
 }
 
-#define PTR_INVALID ((void *)0x000000ab)
-
 static void __init
-invalid_pointer(void)
+real_pointer(void)
 {
-	test_hashed("%p", PTR_INVALID);
+	test(PTR_STR, "%px", PTR);
+	test(ZEROS "00000000", "%px", NULL);
 	test(ZEROS "000000ab", "%px", PTR_INVALID);
-	test("(efault)", "%pE", PTR_INVALID);
 }
 
 static void __init
@@ -326,6 +320,8 @@ addr(void)
 static void __init
 escaped_str(void)
 {
+	test("(null)", "%pE", NULL);
+	test("(efault)", "%pE", PTR_INVALID);
 }
 
 static void __init
@@ -601,9 +597,8 @@ errptr(void)
 static void __init
 test_pointer(void)
 {
-	plain();
-	null_pointer();
-	invalid_pointer();
+	plain_pointer();
+	real_pointer();
 	symbol_ptr();
 	kernel_ptr();
 	struct_resource();
-- 
2.16.4

