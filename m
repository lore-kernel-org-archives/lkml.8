Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ED6C47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFD420873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nu9mlTpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgD3Q7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726333AbgD3Q7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:59:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188A5C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:59:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so65951pfv.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XX0aq70X84hY++u814Jz1V6sc36fN27R1SGTRU+5Lxk=;
        b=nu9mlTpar3u/XNfH0kDV/cnsj37ANGpkNYjq6oy0KxmRXUo5UkDrGK6CktUCMy5P8M
         WTM6BS0rEEHRKU0Zo1xGFYjt6Uvo8ktaEbkX3Uj26h4O6w4B4hFR+dNFilza1FKbpNGn
         E+OVPiCjP4Rgs3jxLYvA7vgLv4BrCV0wdNavk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XX0aq70X84hY++u814Jz1V6sc36fN27R1SGTRU+5Lxk=;
        b=Pg5LpU4CZOt8OxevVyJaCa35TE25BiZupE5Y/fRsBlgHUceifZZSxNWmomxH5qJV5I
         HR8X7/F/YufvRkymUTU7moxu9d4uAQRbJPosSlgJKnnn8c8EEOuQw0IiXd+WO0DMlKSx
         s9wj6uq0s+dndnUyvFG/7uKy7B0DXTbjJWaHvQ/2Tr97RP0V9uFR7qpAIVyjgcWj7lSR
         DZPvzGNF5VSZurV9IK9uIeAR/i49QlrV8fm6fQgB7/0qRfkwa/n6+jsI57FKdf2jXB3q
         zGi6Y8pEOrSTvA6iLD5+K4/Gn0EvRn7sfiHeDjKzjqm0PSfI4a3bqOeYyWm1YqPeE1bg
         QFRA==
X-Gm-Message-State: AGi0PuZLaJ+n7FSuJopTSTB0Af6RlrzS8uFqPiz/e4n6RO8HB3AS6gzY
        Puc3C8DssXmDyuV0Kd5IiJX1lg==
X-Google-Smtp-Source: APiQypIyP+gXZupfqM8ErYtv+R9ajc1WHLeubomr124V91g66O5D1E+b1Y/haDu9gMRhAqF5AsytIA==
X-Received: by 2002:a65:5b41:: with SMTP id y1mr2856609pgr.414.1588265976440;
        Thu, 30 Apr 2020 09:59:36 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id m6sm279954pgm.67.2020.04.30.09.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 09:59:35 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     sumit.garg@linaro.org, Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH] kgdboc: Be a bit more robust about handling earlycon leaving
Date:   Thu, 30 Apr 2020 09:59:09 -0700
Message-Id: <20200430095819.1.Id37f71c69eb21747b9d9e2c7c242be130814b362@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original implementation of kgdboc_earlycon included a comment
about how it was impossible to get notified about the boot console
going away without making changes to the Linux core.  Since folks
often don't want to change the Linux core for kgdb's purposes, the
kgdboc_earlycon implementation did a bit of polling to figure out when
the boot console went away.

It turns out, though, that it is possible to get notified about the
boot console going away.  The solution is either clever or a hack
depending on your viewpoint.  ...or, perhaps, a clever hack.  All we
need to do is head-patch the "exit" routine of the boot console.  We
know that "struct console" must be writable because it has a "next"
pointer in it, so we can just put our own exit routine in, do our
stuff, and then call back to the original.

This works great to get notified about the boot console going away.
The (slight) problem is that in the context of the boot console's exit
routine we can't call tty_find_polling_driver().  We solve this by
kicking off some work on the system_wq when we get notified and this
works pretty well.

This is all still not perfect but seems as good you'll be able to do
without more intrusive changes to the Linux core.  It feels like the
window where the debugger isn't available should be tiny on all
systems now, even those systems that manage to init their tty earlier.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This is based upon Daniel's recent patch [1] which is, in turn, based
on my recent series [2].  In theory this patch could be folded into
the patches of the original series, but presumably it will be less
churn / spamming of people to just treat it as a patch atop.  I wish I
had thought of this trick earlier, but I suppose these kinds of things
only occur to people at 4 am in bed when they can't sleep.

[1] https://lore.kernel.org/r/20200430161741.1832050-1-daniel.thompson@linaro.org
[2] https://lore.kernel.org/r/20200428211351.85055-1-dianders@chromium.org

 drivers/tty/serial/kgdboc.c | 112 ++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 596213272ec3..4bef5e8ab991 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
+#include <linux/workqueue.h>
 
 #define MAX_CONFIG_LEN		40
 
@@ -46,6 +47,7 @@ static struct platform_device *kgdboc_pdev;
 #ifdef CONFIG_KGDB_SERIAL_CONSOLE
 static struct kgdb_io		kgdboc_earlycon_io_ops;
 struct console			*earlycon;
+int				(*earlycon_orig_exit)(struct console *con);
 #else /* ! CONFIG_KGDB_SERIAL_CONSOLE */
 #define earlycon NULL
 #endif /* ! CONFIG_KGDB_SERIAL_CONSOLE */
@@ -161,20 +163,9 @@ static bool is_earlycon_still_valid(void)
 	return false;
 }
 
-static void cleanup_earlycon_if_invalid(void)
-{
-	console_lock();
-	if (earlycon && !is_earlycon_still_valid()) {
-		pr_warn("earlycon vanished; unregistering\n");
-		cleanup_earlycon();
-	}
-	console_unlock();
-}
-
 #else /* ! CONFIG_KGDB_SERIAL_CONSOLE */
 
 static inline void cleanup_earlycon(void) { ; }
-static inline void cleanup_earlycon_if_invalid(void) { ; }
 
 #endif /* ! CONFIG_KGDB_SERIAL_CONSOLE */
 
@@ -251,14 +242,6 @@ static int configure_kgdboc(void)
 	kgdboc_unregister_kbd();
 	configured = 0;
 
-	/*
-	 * Each time we run configure_kgdboc() but don't find a console, use
-	 * that as a chance to validate that our earlycon didn't vanish on
-	 * us.  If it vanished we should unregister which will disable kgdb
-	 * if we're the last I/O module.
-	 */
-	cleanup_earlycon_if_invalid();
-
 	return err;
 }
 
@@ -481,15 +464,11 @@ static void kgdboc_earlycon_put_char(u8 chr)
 static void kgdboc_earlycon_pre_exp_handler(void)
 {
 	/*
-	 * We don't get notified when the boot console is unregistered.
-	 * Double-check when we enter the debugger.  Unfortunately we
-	 * can't really unregister ourselves now, so we panic.  We rely
-	 * on kgdb's ability to detect re-entrancy to make the panic
-	 * take effect.
-	 *
-	 * NOTE: if you're here in the lull when the real console has
-	 * replaced the boot console but our init hasn't run yet it's
-	 * possible that the "keep_bootcon" argument may help.
+	 * There's a small window where the boot console exited but
+	 * kgdb_earlycon is still registered because
+	 * kgdboc_earlycon_exit_work_fn() hasn't run yet.  See the comments
+	 * in that function.  The window should be tiny so hopefully nobody
+	 * will ever hit this panic() but it's better to be safe than sorry.
 	 */
 	if (earlycon && !is_earlycon_still_valid())
 		panic("KGDB earlycon vanished and nothing replaced it\n");
@@ -509,10 +488,75 @@ static struct kgdb_io kgdboc_earlycon_io_ops = {
 	.is_console		= true,
 };
 
+static void kgdboc_earlycon_exit_work_fn(struct work_struct *work)
+{
+	/*
+	 * Often this function races with init_kgdboc() since (due to probe
+	 * ordering) init_kgdboc() often gets called right after serial drivers
+	 * have registered.  It doesn't matter which one wins.  Both places try
+	 * to configure because, even though they _often_ happen at nearly the
+	 * same time, the two functions are not _guaranteed_ to happen
+	 * at nearly the same time.  Maybe, for instance, someone managed to
+	 * init their main tty at an earlier initcall level.  In such a case
+	 * we'd run much earlier than init_kgdboc().
+	 */
+	mutex_lock(&config_mutex);
+
+	/* See if the real kgdboc is ready */
+	if (configured != 1)
+		configure_kgdboc();
+
+	/* Cleanup earlycon even if real kgdboc wasn't ready */
+	cleanup_earlycon();
+
+	mutex_unlock(&config_mutex);
+}
+
+DECLARE_WORK(kgdboc_earlycon_exit_work, kgdboc_earlycon_exit_work_fn);
+
 #define MAX_CONSOLE_NAME_LEN (sizeof((struct console *) 0)->name)
 static char kgdboc_earlycon_param[MAX_CONSOLE_NAME_LEN] __initdata;
 static bool kgdboc_earlycon_late_enable __initdata;
 
+int kgdboc_earlycon_trap_exit(struct console *con)
+{
+	int ret = 0;
+
+	/*
+	 * The earlycon is gone.  Presumably a real tty for the main kgdboc
+	 * is ready for us.  Ideally we'd register right here right now but
+	 * we're being called under some locks.  Queue some work so we can
+	 * do it ASAP.
+	 *
+	 * NOTE: there's a bit of time between now and when our worker will
+	 * get called and the earlycon is gone, though testing on one system
+	 * showed the worker starting even before our function exited.  The
+	 * possibility of a little bit of time is why the
+	 * kgdboc_earlycon_pre_exp_handler() function double-checks that
+	 * earlycon is valid.
+	 *
+	 * In theory we would be "safer" if we unregistered kgdb_earlycon
+	 * here and then just registered the main kgdboc in our worker.  We
+	 * don't do that because the debug core is expecting earlycon to be
+	 * _replaced_ by the main kgdboc.  If instead we do an
+	 * unregister/reregister and someone had gdb attached then the debug
+	 * core will throw a hissyfit.  The worst thing that will happen if
+	 * we try to drop in the debugger (because we hit a breakpoint or
+	 * we crashed) and then we'll panic.  ...but what else should we have
+	 * done between these two points in time?
+	 */
+	queue_work(system_wq, &kgdboc_earlycon_exit_work);
+
+	/* Our trap has done its work.  Disarm it now */
+	if (earlycon_orig_exit) {
+		con->exit = earlycon_orig_exit;
+		earlycon_orig_exit = NULL;
+		ret = con->exit(con);
+	}
+
+	return ret;
+}
+
 static int __init kgdboc_earlycon_init(char *opt)
 {
 	struct console *con;
@@ -530,7 +574,6 @@ static int __init kgdboc_earlycon_init(char *opt)
 		    (!opt || !opt[0] || strcmp(con->name, opt) == 0))
 			break;
 	}
-	console_unlock();
 
 	if (!con) {
 		/*
@@ -551,7 +594,7 @@ static int __init kgdboc_earlycon_init(char *opt)
 		} else {
 			pr_info("Couldn't find kgdb earlycon\n");
 		}
-		return 0;
+		goto unlock;
 	}
 
 	earlycon = con;
@@ -559,9 +602,16 @@ static int __init kgdboc_earlycon_init(char *opt)
 	if (kgdb_register_io_module(&kgdboc_earlycon_io_ops) != 0) {
 		earlycon = NULL;
 		pr_info("Failed to register kgdb with earlycon\n");
-		return 0;
+	} else {
+		/* Trap exit so we know when earlycon goes away. */
+		earlycon_orig_exit = earlycon->exit;
+		earlycon->exit = kgdboc_earlycon_trap_exit;
 	}
 
+unlock:
+	console_unlock();
+
+	/* Non-zero means malformed option so we always return zero */
 	return 0;
 }
 early_param("kgdboc_earlycon", kgdboc_earlycon_init);
-- 
2.26.2.303.gf8c07b1a785-goog

