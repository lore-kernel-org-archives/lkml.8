Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B7EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200CC206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX4DoIYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgESL1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 07:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgESL1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 07:27:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E080C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 04:27:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u1so1886801wmn.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 04:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X9s1mFt4Y+m2GazZ8OD2weZt7bXYsBrAFY1mL2LOceo=;
        b=cX4DoIYH4zV4RRwh3M8eeDx2prhyfWGoLozgWJzLGaCQtFLdCN3mhGyaLeM0u24A2y
         KdvyIoGFULIuT3yUVPC1yPJ6zHpKBN5VDF1reoaLRfxBGUBc8KEVy+GWtOiBpKv3ScU9
         KQJjY4quqA7OwJ8jdkg67DLfYm0taMb1LXsyfGcyPVV0AlO180hzrG/nE8WyVVZO3dhq
         VTkzUoE/hKL+ZjAyql7ShrqsToG/V+iHDqxStHhbDhl8ii4upu0rT8j7w54FMM6PXx2Q
         N1Zu6dseEeAEI5BVJyXwQ8unjhF4jqR19YWH+dwRli6DO4VJz/wxBgrVqn9lLG4FEZJq
         uVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X9s1mFt4Y+m2GazZ8OD2weZt7bXYsBrAFY1mL2LOceo=;
        b=OIyBi9ssIEmU1S+uODte7cJJJD0zXZmmgsFGu0p/1o7bOOaHymUcT+19NhF9H5oA8c
         eDb38s10Lg2hkL9Y/QEXUg2zCOh0rKlgQATe1JXFJHX5HfmoDdJDfcE+cC8bZg+w8Jg4
         NP8z1ZmwHpwzHPl+rRJu73zAEnLYaETjgd3DSOUkzTpE2Wda5sisoE9kS0i+kEQ7kGto
         CkV/t02v2C0OyKwk5jTY4ACfkVC0e4CMAbEDNpajWtc2SadlnmIg/Lo94XIvDVIYb+os
         avVJbk/CVqjNj8ZTZBNeGRUqff5BmmasbJk2kuC6hb6SLdPuJQyQFx4Mrk6GQuhC3uFk
         4Low==
X-Gm-Message-State: AOAM531xhh4fjNBWZX4e4Wl7kfExL6hydDNpM9M2SfAIkMv16O8V6Eyk
        9gZ2+ak80vZPyNx4PsPp9rc=
X-Google-Smtp-Source: ABdhPJy0KfucZ/8phPGAZvlHvMxbheNSTC8rSaxIMz+lsRz3mXKl136S8UVrc4oLFoGta6/hrjU2kQ==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr5015488wmj.100.1589887633716;
        Tue, 19 May 2020 04:27:13 -0700 (PDT)
Received: from kwango.local (ip-94-112-129-237.net.upcbroadband.cz. [94.112.129.237])
        by smtp.gmail.com with ESMTPSA id 88sm19886645wrq.77.2020.05.19.04.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 04:27:12 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] vsprintf: don't obfuscate NULL and error pointers
Date:   Tue, 19 May 2020 13:26:57 +0200
Message-Id: <20200519112657.17098-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see what security concern is addressed by obfuscating NULL
and IS_ERR() error pointers, printed with %p/%pK.  Given the number
of sites where %p is used (over 10000) and the fact that NULL pointers
aren't uncommon, it probably wouldn't take long for an attacker to
find the hash that corresponds to 0.  Although harder, the same goes
for most common error values, such as -1, -2, -11, -14, etc.

The NULL part actually fixes a regression: NULL pointers weren't
obfuscated until commit 3e5903eb9cff ("vsprintf: Prevent crash when
dereferencing invalid pointers") which went into 5.2.  I'm tacking
the IS_ERR() part on here because error pointers won't leak kernel
addresses and printing them as pointers shouldn't be any different
from e.g. %d with PTR_ERR_OR_ZERO().  Obfuscating them just makes
debugging based on existing pr_debug and friends excruciating.

Note that the "always print 0's for %pK when kptr_restrict == 2"
behaviour which goes way back is left as is.

Example output with the patch applied:

                            ptr         error-ptr              NULL
%p:            0000000001f8cc5b  fffffffffffffff2  0000000000000000
%pK, kptr = 0: 0000000001f8cc5b  fffffffffffffff2  0000000000000000
%px:           ffff888048c04020  fffffffffffffff2  0000000000000000
%pK, kptr = 1: ffff888048c04020  fffffffffffffff2  0000000000000000
%pK, kptr = 2: 0000000000000000  0000000000000000  0000000000000000

Fixes: 3e5903eb9cff ("vsprintf: Prevent crash when dereferencing invalid pointers")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 lib/test_printf.c | 19 ++++++++++++++++++-
 lib/vsprintf.c    |  7 +++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

Hi Petr,

This just came up again, please consider sending this to Linus
for 5.7.

Prior discussion was split in three threads and revolved around the
vision for how lib/test_printf.c should be structured between Rasmus
and yourself.  The fix itself wasn't disputed and has several acks.

If you want to restructure the test suite before adding any new
test cases, v1 doesn't have them, but I'm reposting with test cases
because I think it's best to add them right away to prevent further
regressions.

v3:
- don't use EAGAIN macro in error_pointer() test case as the
  actual error code varies between architectures

v2:
- fix null_pointer() test case (it didn't catch the original
  regression because test_hashed() doesn't really test much)
  and add error_pointer() test case

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 2d9f520d2f27..6b1622f4d7c2 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -214,6 +214,7 @@ test_string(void)
 #define PTR_STR "ffff0123456789ab"
 #define PTR_VAL_NO_CRNG "(____ptrval____)"
 #define ZEROS "00000000"	/* hex 32 zero bits */
+#define ONES "ffffffff"		/* hex 32 one bits */
 
 static int __init
 plain_format(void)
@@ -245,6 +246,7 @@ plain_format(void)
 #define PTR_STR "456789ab"
 #define PTR_VAL_NO_CRNG "(ptrval)"
 #define ZEROS ""
+#define ONES ""
 
 static int __init
 plain_format(void)
@@ -330,14 +332,28 @@ test_hashed(const char *fmt, const void *p)
 	test(buf, fmt, p);
 }
 
+/*
+ * NULL pointers aren't hashed.
+ */
 static void __init
 null_pointer(void)
 {
-	test_hashed("%p", NULL);
+	test(ZEROS "00000000", "%p", NULL);
 	test(ZEROS "00000000", "%px", NULL);
 	test("(null)", "%pE", NULL);
 }
 
+/*
+ * Error pointers aren't hashed.
+ */
+static void __init
+error_pointer(void)
+{
+	test(ONES "fffffff5", "%p", ERR_PTR(-11));
+	test(ONES "fffffff5", "%px", ERR_PTR(-11));
+	test("(efault)", "%pE", ERR_PTR(-11));
+}
+
 #define PTR_INVALID ((void *)0x000000ab)
 
 static void __init
@@ -649,6 +665,7 @@ test_pointer(void)
 {
 	plain();
 	null_pointer();
+	error_pointer();
 	invalid_pointer();
 	symbol_ptr();
 	kernel_ptr();
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7c488a1ce318..f0f0522cd5a7 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -794,6 +794,13 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
 	unsigned long hashval;
 	int ret;
 
+	/*
+	 * Print the real pointer value for NULL and error pointers,
+	 * as they are not actual addresses.
+	 */
+	if (IS_ERR_OR_NULL(ptr))
+		return pointer_string(buf, end, ptr, spec);
+
 	/* When debugging early boot use non-cryptographically secure hash. */
 	if (unlikely(debug_boot_weak_hash)) {
 		hashval = hash_long((unsigned long)ptr, 32);
-- 
2.19.2

