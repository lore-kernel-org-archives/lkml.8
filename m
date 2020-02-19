Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6C4C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E56208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Cm0jHNzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgBSIWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:22:01 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40969 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgBSIWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:22:01 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so26097344ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 00:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QocX4xe51J3RSXYlXcQqHwsZ0qHMm3/L1TgcBAZQ+18=;
        b=Cm0jHNzMc1wmARq03auILfDgmxjx8hfusAXEN/NwWQEsQBIwbiehu3i/OXuo8MCUqe
         UK01W2dHxUcersBp1PLHwu4XScDXkYvJIlowTtjV4wf9B4SqgLlTdsa/GHPJBOkJWcZb
         1J85DJvKFxy3ico7+zzcsRRLWuyFpJxWZ0iz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QocX4xe51J3RSXYlXcQqHwsZ0qHMm3/L1TgcBAZQ+18=;
        b=SS/jwXo9BOT/jvxhJGa3KHhVNDHCbOhpiobfknR9Uh9zvyH5xzOZM1iqDcjF3H/UW/
         imSJzUj5dfzePk5liO0/+m2VuBR/SgmlSfpOT/C/JbboEcw2gzRlaXboTpYzdcBebWtc
         GOI1je6wBTIzahNrUYbj1V4uYhKs5CB3C3RXE64Cl0fq8rgeEEoUJ2jzw2/NNV0I54O3
         xjQiSAwuAeSSSOIfB4SnLCUvQLR86XKgvR8EqNn5up8EhxaT6lEwPrcoVzvSwvRzDuKv
         wnHA+5Ao3eF7HP4URswIspZwChTp7FVLe3K/+ytdmg51LsODw2tLkgPIkDB0Y5cZzCll
         4Spg==
X-Gm-Message-State: APjAAAVD7kbeVpC9KTKn7jwo0+XhF6u0OUz0N2lgBfIcG3vGWg4Uws3U
        FjqzPyF8w0VDXszACghmXy7rpg==
X-Google-Smtp-Source: APXvYqzjQ7poQEj9Hw7Tcdbo3KnqE29g1euQ3vNK0hzI4uLgZ2V+I7OOd8vEE+X3k+9GXDA5rDXoMw==
X-Received: by 2002:a2e:b68c:: with SMTP id l12mr14792534ljo.36.1582100519172;
        Wed, 19 Feb 2020 00:21:59 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s18sm821624ljj.36.2020.02.19.00.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 00:21:58 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vsprintf: sanely handle NULL passed to %pe
Date:   Wed, 19 Feb 2020 09:21:55 +0100
Message-Id: <20200219082155.6787-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend %pe to pretty-print NULL in addition to ERR_PTRs,
i.e. everything IS_ERR_OR_NULL().

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Something like this? The actual code change is +2,-1 with another +1
for a test case.

 Documentation/core-api/printk-formats.rst | 9 +++++----
 lib/errname.c                             | 4 ++++
 lib/test_printf.c                         | 1 +
 lib/vsprintf.c                            | 4 ++--
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 8ebe46b1af39..964b55291445 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -86,10 +86,11 @@ Error Pointers
 
 	%pe	-ENOSPC
 
-For printing error pointers (i.e. a pointer for which IS_ERR() is true)
-as a symbolic error name. Error values for which no symbolic name is
-known are printed in decimal, while a non-ERR_PTR passed as the
-argument to %pe gets treated as ordinary %p.
+For printing error pointers (i.e. a pointer for which IS_ERR() is
+true) as a symbolic error name. Error values for which no symbolic
+name is known are printed in decimal. A NULL pointer is printed as
+NULL. All other pointer values (i.e. anything !IS_ERR_OR_NULL()) get
+treated as ordinary %p.
 
 Symbols/Function Pointers
 -------------------------
diff --git a/lib/errname.c b/lib/errname.c
index 0c4d3e66170e..7757bc00f564 100644
--- a/lib/errname.c
+++ b/lib/errname.c
@@ -11,9 +11,13 @@
  * allocated errnos (with EHWPOISON = 257 on parisc, and EDQUOT = 1133
  * on mips), so this wastes a bit of space on those - though we
  * special case the EDQUOT case.
+ *
+ * For the benefit of %pe being able to print any ERR_OR_NULL pointer
+ * symbolically, 0 is also treated specially.
  */
 #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
 static const char *names_0[] = {
+	[0] = "NULL",
 	E(E2BIG),
 	E(EACCES),
 	E(EADDRINUSE),
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 2d9f520d2f27..3a37d0e9e735 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -641,6 +641,7 @@ errptr(void)
 	test("[-EIO    ]", "[%-8pe]", ERR_PTR(-EIO));
 	test("[    -EIO]", "[%8pe]", ERR_PTR(-EIO));
 	test("-EPROBE_DEFER", "%pe", ERR_PTR(-EPROBE_DEFER));
+	test("[NULL]", "[%pe]", NULL);
 #endif
 }
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7c488a1ce318..b7118d78eb20 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2247,8 +2247,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'x':
 		return pointer_string(buf, end, ptr, spec);
 	case 'e':
-		/* %pe with a non-ERR_PTR gets treated as plain %p */
-		if (!IS_ERR(ptr))
+		/* %pe with a non-ERR_OR_NULL ptr gets treated as plain %p */
+		if (!IS_ERR_OR_NULL(ptr))
 			break;
 		return err_ptr(buf, end, ptr, spec);
 	}
-- 
2.23.0

