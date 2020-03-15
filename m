Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE8EC10F29
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2066B20637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRWB9gB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgCORJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 13:09:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38878 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbgCORJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 13:09:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id t13so9118966wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 10:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VGGErCaRDrsGcqGzSXzlpb80blPvQ3i+L003GfY75Rs=;
        b=qRWB9gB1qIdAqhbWMeSB1KFeJIgWWfz6ns1d12N6tcugRewO27xI6k4CpPodrmipDa
         6JU+9j1VDmCjoDDFslDwKOdhZdutaYH354vS3y1xiCzWExxh0Vu3NDo7oTM++0LNJ9+A
         qPurrzoTs+lzMiUrGuxFbWzi3fprnOC45XidOV4GL4TmvrSad0a7zahFBZpjrf5OD+e2
         or2NAE+SpDcgHSJVMSZyJ3gPfMhtNxCs/0ZT9maiAdNWIhLZ6mGbP7yNd09HIMDv78Zu
         V+rXQfaERY5XBMB6bXEgQT+HY2pY6YUNNytM6aw66tlzYzJMItdr5pyvWMeSQsDjhglL
         t+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGGErCaRDrsGcqGzSXzlpb80blPvQ3i+L003GfY75Rs=;
        b=P6wV8YXvVTQ4GUTSrGKElE1cNqD4vYxC3BY5CKE8+fJg0HIwpn7OI+aL+gRFlpMkOe
         /JDAg+dDDLOFUECnlmNNzKSU0nQ+mO0RORxhO6ZlFIczQeHJ8rUiF8cpt6jDFF/dAJzD
         odkU6F5G66S/slVM1EVpCIFrKz1rxfbx+H5DVN7p/FVbjXw2GihQyFveNLNH6GT0/hyE
         oLHSLmnBwqjhTRocDSX29U7EVzJBlfYbpq8hPnnaP5ewTYBdgot7mdHy50Ccf0fU0l9C
         9lpmHIVlSrjCMWCiZOHAqTRuRYnu5xLgOEf5wXVMPMpgVAIc8SZez2CImzHzIYl9D9Cd
         KQqg==
X-Gm-Message-State: ANhLgQ3mEnbQ0ZBeYVcciTGRLaP8Pl+qqI101rnkxTQ+O7QlbG0lmjey
        8bYg/XRBDQ4lRG7GxTyztX98yY1l8znPeEA6
X-Google-Smtp-Source: ADFU+vuSBuWHWp8QXcTuDoPENhKI50wScFlIY5VOnYWYdKEM5ixCqm4BkXxTSGog9hyttp5/WakjMA==
X-Received: by 2002:a1c:a502:: with SMTP id o2mr22227586wme.94.1584292193895;
        Sun, 15 Mar 2020 10:09:53 -0700 (PDT)
Received: from localhost.localdomain (ipb218f56a.dynamic.kabel-deutschland.de. [178.24.245.106])
        by smtp.gmail.com with ESMTPSA id u25sm25874774wml.17.2020.03.15.10.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 10:09:53 -0700 (PDT)
From:   Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <erosca@de.adit-jv.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [RFC PATCH 2/3] printk: add console_verbose_{start,end}
Date:   Sun, 15 Mar 2020 18:09:02 +0100
Message-Id: <20200315170903.17393-3-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200315170903.17393-1-erosca@de.adit-jv.com>
References: <20200315170903.17393-1-erosca@de.adit-jv.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider below example scenarios:
       - soft lockup
       - hard lockup
       - hung task
       - scheduling while atomic
       - rcu stall
       - oops
       - oom
       - WARN

In most of the above situations, it is up to the user to terminate the
execution with a panic (see panic_on_* in kernel/sysctl.c) or to
decide not to abort and try to recover.

A general concern applicable to the above use-cases is that, depending
on the console loglevel set by the user, precious information conveyed
by show_regs(), print_modules(), dump_stack() and friends may simply not
appear on the console. Below example commits tackle this exact concern
in the panic paths:

* commit 168e06f7937d96 ("kernel/hung_task.c: force console verbose before panic")
* commit 5b530fc1832460 ("panic: call console_verbose() in panic")

The approach behind the above commits is straightforward. Whenever
panic is imminent, they simply call console_verbose(). Unfortunately,
the same technique does not apply to non-panic paths. It requires a
counterpart of console_verbose(), which currently does not exist.

With that in mind, create a pair of functions named
console_verbose_start() and console_verbose_end() which turn the
console verbosity on and off in a lockless and SMP safe way.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 include/linux/printk.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 1e6108b8d15f..14755ef7b017 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -3,6 +3,7 @@
 #define __KERNEL_PRINTK__
 
 #include <stdarg.h>
+#include <linux/atomic.h>
 #include <linux/init.h>
 #include <linux/kern_levels.h>
 #include <linux/linkage.h>
@@ -77,6 +78,15 @@ static inline void console_verbose(void)
 		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
 }
 
+#ifdef CONFIG_PRINTK
+extern atomic_t ignore_loglevel;
+static inline void console_verbose_start(void) { atomic_inc(&ignore_loglevel); }
+static inline void console_verbose_end(void) { atomic_dec(&ignore_loglevel); }
+#else
+static inline void console_verbose_start(void) { }
+static inline void console_verbose_end(void) { }
+#endif
+
 /* strlen("ratelimit") + 1 */
 #define DEVKMSG_STR_MAX_SIZE 10
 extern char devkmsg_log_str[];
-- 
2.25.0

