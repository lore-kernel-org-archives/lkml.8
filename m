Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A780C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1673F2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgATIzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:55:43 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59849 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgATIzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:55:42 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1itSqH-0002Vq-QC; Mon, 20 Jan 2020 09:55:29 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1itSqE-0006rz-Rh; Mon, 20 Jan 2020 09:55:26 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] printf: add support for printing symbolic error names from numbers
Date:   Mon, 20 Jan 2020 09:55:07 +0100
Message-Id: <20200120085508.25522-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200120085508.25522-1-u.kleine-koenig@pengutronix.de>
References: <20200120085508.25522-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an extension of the ability introduced in commit 57f5677e535b
("printf: add support for printing symbolic error names") that
made %pe consume an error valued pointer and emit a symbolic error name.

Here the same is done for numbers:

	printk("%de\n", -EIO);

now emits "-EIO\n".

To keep printk flexible enough to emit an 'e' after a number the
character ` can be used which is just swallowed by *printf and ends
interpreting the format code. So

	printk("%d`e\n", -5);

emits "-5e\n". (Note that the implementation of ` isn't complete, it
only works for numbers for now. It might make sense to implement the
same for %s and %p.)

For non-error valued numbers %de falls back to emit the plain number (as
%d would do).

Some runtime tests are added to cover %de.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 lib/test_printf.c |  8 ++++++++
 lib/vsprintf.c    | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 2d9f520d2f27..a18a7742d5fe 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -13,6 +13,7 @@
 #include <linux/rtc.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/stringify.h>
 
 #include <linux/bitmap.h>
 #include <linux/dcache.h>
@@ -628,6 +629,8 @@ static void __init
 errptr(void)
 {
 	test("-1234", "%pe", ERR_PTR(-1234));
+	test("-4321", "%de", -4321);
+	test("-5e", "%d`e", -5);
 
 	/* Check that %pe with a non-ERR_PTR gets treated as ordinary %p. */
 	BUILD_BUG_ON(IS_ERR(PTR));
@@ -641,6 +644,11 @@ errptr(void)
 	test("[-EIO    ]", "[%-8pe]", ERR_PTR(-EIO));
 	test("[    -EIO]", "[%8pe]", ERR_PTR(-EIO));
 	test("-EPROBE_DEFER", "%pe", ERR_PTR(-EPROBE_DEFER));
+
+	test("-ERESTARTSYS", "%de", -ERESTARTSYS);
+#else
+
+	test("-" __stringify(ERESTARTSYS), "%de", -ERESTARTSYS);
 #endif
 }
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7c488a1ce318..1bcd1ce2c319 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2637,7 +2637,39 @@ int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 				num = va_arg(args, unsigned int);
 			}
 
-			str = number(str, end, num, spec);
+			if (*fmt != 'e') {
+				str = number(str, end, num, spec);
+			} else {
+				unsigned long num_err = 0;
+
+				fmt++;
+
+				/*
+				 * error values are negative numbers near zero.
+				 * If num represents such a number, it must be
+				 * big (as it is unsigned), otherwise print it
+				 * as an ordinary number.
+				 */
+				if (num > (unsigned long long)-UINT_MAX)
+					num_err = num;
+
+				if (IS_ENABLED(CONFIG_SYMBOLIC_ERRNAME) &&
+				    IS_ERR_VALUE(num_err))
+					str = err_ptr(str, end, ERR_PTR(num), spec);
+				else
+					str = number(str, end, num, spec);
+			}
+
+			if (*fmt == '`')
+				/*
+				 * When a format specifier is followed by `,
+				 * this ends parsing. This way a string can be
+				 * printed that has an int followed by a literal
+				 * 'e' (using "%d`e") which otherwise (i.e. by
+				 * using "%de") would be interpreted as request
+				 * to format the int as error code.
+				 */
+				++fmt;
 		}
 	}
 
-- 
2.24.0

