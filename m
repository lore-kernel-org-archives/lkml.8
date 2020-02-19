Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F95C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5992465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+8azabE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgBSRML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:12:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32834 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgBSRML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:12:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id m10so840772wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fOdzg058qEPVjUO/Eo5wBbOjnngKF4TtrvgfsszM74Q=;
        b=d+8azabE8R8iGKVDsvQwKcj5AmmbzylXDfjBrSQ8XcAHmyyLSPtX/GwEY9DzETFgZn
         UJsvPwhD/+a18a+IX3KBg6PPndOQbRdFzdhaPr/prgDSyMWwVqT+vSMpEZ7BQNGO0KrW
         2vqrharIg+RWm0Yr0vQt3XBgFxWxAzP7/7LU/DjINELroutfSJmy3eiju45LUn5hOYl1
         17Dx9gMWL/JwI86EGiL4EF3S0kxaC5VkpLsKsWFw+ahgZSieFMMNY1vCdQcQPp26kcS8
         PQFDgC9eJX/qnsvOqbW5wVR7wRez/SXZlTcvoG2u5mXizoq27CrWz9GbloDPfoDf7tJY
         Y/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fOdzg058qEPVjUO/Eo5wBbOjnngKF4TtrvgfsszM74Q=;
        b=Qv9YcbguDH0ySD3/wXDiAVWnQ4K21okaKTwUnWs3H3YxXCnvLqVoVX2THwHYu9MUj6
         /ARiBU2be9EL4lOEdwGG9/qJpT20jDDZO5LikRXgkV4MDVjbqSUNau/RPeGzgbAWhUQR
         HpxTkPk3dX+Ay/fza8y4FeEccfdstVGmH78H4XmC0mB1dqmiFJZXjsjZnVHIwPEuBlGu
         trx8lS9APar34w4uu1NkHq/Mttm9c0ebw39UGlSW5dRUkgdVw3pkaXKDztos2a99eOco
         fBwVd5HPPPRiXQ+9I9wCD48CIgRMXLZtXEom2lE43yrgTSF8UOvi5ZUvyvpROTXFvu/a
         1mMg==
X-Gm-Message-State: APjAAAWHzPuaGmepW4P/YhcdTofJOpnTU0rrMhf9p0fLhDKAYp44/SUX
        2ByUUCEzjgBp5ju/h45yZ2fLwRsxIXaHDQ==
X-Google-Smtp-Source: APXvYqyRiEQr6kMvqeCucRRKszbNuvp+ZA98k3EuGCxFR1xbXelRWtS7ARw5JYyW1gWBQMNUQUhv5w==
X-Received: by 2002:a1c:688a:: with SMTP id d132mr11828776wmc.189.1582132326205;
        Wed, 19 Feb 2020 09:12:06 -0800 (PST)
Received: from kwango.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s65sm528460wmf.48.2020.02.19.09.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 09:12:05 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] vsprintf: don't obfuscate NULL and error pointers
Date:   Wed, 19 Feb 2020 18:12:25 +0100
Message-Id: <20200219171225.5547-1-idryomov@gmail.com>
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

v2:
- fix null_pointer() test case (it didn't catch the original
  regression because test_hashed() doesn't really test much)
  and add error_pointer() test case

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 2d9f520d2f27..d8f87f09b55c 100644
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
+	test(ONES "fffffff5", "%p", ERR_PTR(-EAGAIN));
+	test(ONES "fffffff5", "%px", ERR_PTR(-EAGAIN));
+	test("(efault)", "%pE", ERR_PTR(-EAGAIN));
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

