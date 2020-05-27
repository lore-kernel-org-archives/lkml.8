Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A30C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 692AA20787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EiqaFjvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgE0G04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgE0G0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:26:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91CBC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:26:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ci23so1069701pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jVPZG9jgNnCMirif1b9T6UzaG8riJRfarxNSjPnmxro=;
        b=EiqaFjvOtPYCTmBS9jhycj7q/HywmyjY/ekV02QlEJ8aiwWM3pNdtMad6m6HMpdnrG
         8uKqYmEp/Yh13X5wNZY1SjzS1gXK7T7xmipGfUjpBEo4QmvascfGcGSeWxby90oTZCrj
         h0qgjuWQeVMZjCBgHiS/bcAJ9Yi5XsC2JiOC2a2bYWdn8I66aupWBN/mCo3I99AWxuW+
         9c/oSSKKbioxQWna/QV5xl/wEpZ5u5icFfnhgdebjAZwM61hwiH20thX8otAAhj110r7
         VgHH57qqydumk/jXIa0tqK9616/WcN6akSyhBoh9f66x4mIErcRUFl0joS0VXqnwlWhU
         iHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jVPZG9jgNnCMirif1b9T6UzaG8riJRfarxNSjPnmxro=;
        b=hu9eD4GaARK9ENKO6DXTyUazvGIpQLlVWAdgwTyNVWt4LSdgYBO/pauNC0HB1xpOb7
         qWJ8q2y3Q7tbPNIQ3xaPkfMP1BXTO21LVMW5WXysdc1YePfke3U4Oi/WxGxJIwkKSpCL
         aBc9khvhDMhtxT5uZEq6y95yTsYrmsdCwbSw6kxyevffTKINsZbuDXWtYHZaasMylLd4
         tURMG58PyuNrw1/fIHOqG5cDAa5U0Ja4njQIIQcILmjVUNkyS+n72dOci+0eH4ixBgCg
         x/Ou7QYwx0wHijgn/a+tizY7CVPoYO2Iq/r2/vlFTdVeKEYDEvYHndEzw8dFlMKzJyKh
         rgBg==
X-Gm-Message-State: AOAM533IsS+UlFZrBHRhN0e7SyI/e2XVSXV/pxBCP/0WRcCdI7x2ep+j
        NMLRQHuww+DWbjpvLoXEJ0Z+NA==
X-Google-Smtp-Source: ABdhPJwJBWr4ddu3j+dBU3VOt1sTNmEHN4o+MswK56sYgqF3/Y1uh3K2/FKo04DuY47pgmXQxnYcmA==
X-Received: by 2002:a17:902:694b:: with SMTP id k11mr4751139plt.59.1590560815149;
        Tue, 26 May 2020 23:26:55 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.136])
        by smtp.gmail.com with ESMTPSA id m12sm1239121pjs.41.2020.05.26.23.26.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:26:54 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 4/4] kdb: Switch kdb_msg_write() to use safer polling I/O
Date:   Wed, 27 May 2020 11:55:59 +0530
Message-Id: <1590560759-21453-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
References: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kgdb NMI context, calling console handlers isn't safe due to locks
used in those handlers which could lead to a deadlock. Although, using
oops_in_progress increases the chance to bypass locks in most console
handlers but it might not be sufficient enough in case a console uses
more locks (VT/TTY is good example).

Currently when a driver provides both polling I/O and a console then kdb
will output using the console. We can increase robustness by using the
currently active polling I/O driver (which should be lockless) instead
of the corresponding console. For several common cases (e.g. an
embedded system with a single serial port that is used both for console
output and debugger I/O) this will result in no console handler being
used.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tty/serial/kgdboc.c | 17 ++++++++---------
 include/linux/kgdb.h        |  2 ++
 kernel/debug/kdb/kdb_io.c   | 46 +++++++++++++++++++++++++++++++--------------
 3 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index c9f94fa..6199fe1 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -35,7 +35,6 @@ static struct kparam_string kps = {
 };
 
 static int kgdboc_use_kms;  /* 1 if we use kernel mode switching */
-static struct tty_driver	*kgdb_tty_driver;
 static int			kgdb_tty_line;
 
 #ifdef CONFIG_KDB_KEYBOARD
@@ -154,7 +153,7 @@ static int configure_kgdboc(void)
 	}
 
 	kgdboc_io_ops.is_console = 0;
-	kgdb_tty_driver = NULL;
+	kgdboc_io_ops.tty_drv = NULL;
 
 	kgdboc_use_kms = 0;
 	if (strncmp(cptr, "kms,", 4) == 0) {
@@ -178,7 +177,7 @@ static int configure_kgdboc(void)
 		}
 	}
 
-	kgdb_tty_driver = p;
+	kgdboc_io_ops.tty_drv = p;
 	kgdb_tty_line = tty_line;
 
 do_register:
@@ -216,18 +215,18 @@ static int __init init_kgdboc(void)
 
 static int kgdboc_get_char(void)
 {
-	if (!kgdb_tty_driver)
+	if (!kgdboc_io_ops.tty_drv)
 		return -1;
-	return kgdb_tty_driver->ops->poll_get_char(kgdb_tty_driver,
-						kgdb_tty_line);
+	return kgdboc_io_ops.tty_drv->ops->poll_get_char(kgdboc_io_ops.tty_drv,
+							 kgdb_tty_line);
 }
 
 static void kgdboc_put_char(u8 chr)
 {
-	if (!kgdb_tty_driver)
+	if (!kgdboc_io_ops.tty_drv)
 		return;
-	kgdb_tty_driver->ops->poll_put_char(kgdb_tty_driver,
-					kgdb_tty_line, chr);
+	kgdboc_io_ops.tty_drv->ops->poll_put_char(kgdboc_io_ops.tty_drv,
+						  kgdb_tty_line, chr);
 }
 
 static int param_set_kgdboc_var(const char *kmessage,
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index b072aeb..05d165d 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -275,6 +275,7 @@ struct kgdb_arch {
  * for the I/O driver.
  * @is_console: 1 if the end device is a console 0 if the I/O device is
  * not a console
+ * @tty_drv: Pointer to polling tty driver.
  */
 struct kgdb_io {
 	const char		*name;
@@ -285,6 +286,7 @@ struct kgdb_io {
 	void			(*pre_exception) (void);
 	void			(*post_exception) (void);
 	int			is_console;
+	struct tty_driver	*tty_drv;
 };
 
 extern const struct kgdb_arch		arch_kgdb_ops;
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index f848482..c2efa52 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -24,6 +24,7 @@
 #include <linux/kgdb.h>
 #include <linux/kdb.h>
 #include <linux/kallsyms.h>
+#include <linux/tty_driver.h>
 #include "kdb_private.h"
 
 #define CMD_BUFLEN 256
@@ -542,13 +543,18 @@ static int kdb_search_string(char *searched, char *searchfor)
 	return 0;
 }
 
-static void kdb_io_write(char *cp, int len, void (*io_put_char)(u8 ch))
+static void kdb_io_write(char *cp, int len, void (*io_put_char)(u8),
+			 struct tty_driver *p, int line,
+			 void (*poll_put_char)(struct tty_driver *, int, char))
 {
 	if (len <= 0)
 		return;
 
 	while (len--) {
-		io_put_char(*cp);
+		if (io_put_char)
+			io_put_char(*cp);
+		if (poll_put_char)
+			poll_put_char(p, line, *cp);
 		cp++;
 	}
 }
@@ -561,22 +567,34 @@ static void kdb_msg_write(char *msg, int msg_len)
 		return;
 
 	if (dbg_io_ops && !dbg_io_ops->is_console)
-		kdb_io_write(msg, msg_len, dbg_io_ops->write_char);
+		kdb_io_write(msg, msg_len, dbg_io_ops->write_char,
+			     NULL, 0, NULL);
 
 	for_each_console(c) {
+		int line;
+		struct tty_driver *p;
+
 		if (!(c->flags & CON_ENABLED))
 			continue;
-		/*
-		 * While rounding up CPUs via NMIs, its possible that
-		 * a rounded up CPU maybe holding a console port lock
-		 * leading to kgdb master CPU stuck in a deadlock during
-		 * invocation of console write operations. So in order
-		 * to avoid such a deadlock, enable oops_in_progress
-		 * prior to invocation of console handlers.
-		 */
-		++oops_in_progress;
-		c->write(c, msg, msg_len);
-		--oops_in_progress;
+
+		p = c->device ? c->device(c, &line) : NULL;
+		if (p && dbg_io_ops && p == dbg_io_ops->tty_drv && p->ops &&
+		    p->ops->poll_put_char) {
+			kdb_io_write(msg, msg_len, NULL, p, line,
+				     p->ops->poll_put_char);
+		} else {
+			/*
+			 * While rounding up CPUs via NMIs, its possible that
+			 * a rounded up CPU maybe holding a console port lock
+			 * leading to kgdb master CPU stuck in a deadlock during
+			 * invocation of console write operations. So in order
+			 * to avoid such a deadlock, enable oops_in_progress
+			 * prior to invocation of console handlers.
+			 */
+			++oops_in_progress;
+			c->write(c, msg, msg_len);
+			--oops_in_progress;
+		}
 		touch_nmi_watchdog();
 	}
 }
-- 
2.7.4

