Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524FFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 215F120672
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT7rhkgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgG2Loc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2Lob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:44:31 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B86C061794;
        Wed, 29 Jul 2020 04:44:31 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t6so11693244plo.3;
        Wed, 29 Jul 2020 04:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UfZkFdUtm92v6lauGj0QaqJS+CN5MOYNf5dXbxttiSc=;
        b=QT7rhkgdZCfvjfbtyeRDv8IUaYMbmsEDUZT94eMpjJTFmYWV30j9KdiSxKJowYtdmD
         6eVQ+eAI1EcKJmtpSLAKkzFNXxSx21C8JIsgeA+QxXUjwxdwv1FGY4974lqRqEz9IWAJ
         r1KUIcIUewuL8+UqDxnKXU2JjLhVbr7Ngq1Nj0RWuW+HsP8HK1y6Zog60TmDAZz1sA1Y
         vK85bj4UzfQobraadr09wTEPHNl1pK9gqHjanDHIA/tjhxVHsthPmGy21GL764i/s0gL
         lITPHjGWS+QUiB6gr4nsPgy985Pdqac8vehJBPEV76pbr/+ehwAVDkh6XI1mW9rOhWkP
         4zZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UfZkFdUtm92v6lauGj0QaqJS+CN5MOYNf5dXbxttiSc=;
        b=F2XJk+W03QdQruJSZJTMKCzYSFpuvyvuMB2vbQrxSkz7RzTt7VoVLsZUhtIpPNp2lz
         2Nf1zEXX6MttCtaDHqBGgMque3DFl0lhVnC5ckqEoigREft1Vjw44JhxChofrAagx56v
         bxPlzQwJM1MCkvcV6kQJzHcTxIODBiP5fO/HB6v5s+RqX9xBU+2Rs60b795sC46UaU9O
         8NkMTdAegkn4pEBFx1p7YbPh47ukBiTw35QtxG59fergVa3HZbRMab8DsdDaA5ZjI7p5
         2gm8hMflDU5WoOxzNBO/U171XrYDZiaxx+QQFU8gSX6PACSNl/5JGV8rJKgjl9v/qiHR
         ZykA==
X-Gm-Message-State: AOAM532GQyoNQzFuuPJI0cW/KoQxNdeRnXOBE8Ak9CHx+ghSHpG4faDy
        1eFJz7zfXehMho+4chzFytkyGd7Z
X-Google-Smtp-Source: ABdhPJyIcqgm5cREtia06dSWkHUUx6dh5+uWkLfyUPbKX6kCHsUFZISxEAxg0K1hXldvozJ38kf99g==
X-Received: by 2002:a17:90a:e390:: with SMTP id b16mr9482959pjz.20.1596023070673;
        Wed, 29 Jul 2020 04:44:30 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y69sm2156083pfc.111.2020.07.29.04.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 04:44:30 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V13] printk: Add monotonic, boottime, and realtime timestamps
Date:   Wed, 29 Jul 2020 19:44:23 +0800
Message-Id: <20200729114423.30606-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prarit Bhargava <prarit@redhat.com>

printk.time=1/CONFIG_PRINTK_TIME=1 adds a unmodified local hardware clock
timestamp to printk messages.  The local hardware clock loses time each
day making it difficult to determine exactly when an issue has occurred in
the kernel log, and making it difficult to determine how kernel and
hardware issues relate to each other in real time.

Make printk output different timestamps by adding options for no
timestamp, the local hardware clock, the monotonic clock, the boottime
clock, and the real clock.  Allow a user to pick one of the clocks by
using the printk.time kernel parameter.  Output the type of clock in
/sys/module/printk/parameters/time so userspace programs can interpret the
timestamp.

v2: Use peterz's suggested Kconfig options.  Merge patchset together.
Fix i386 !CONFIG_PRINTK builds.

v3: Fixed x86_64_defconfig. Added printk_time_type enum and
printk_time_str for better output. Added BOOTTIME clock functionality.

v4: Fix messages, add additional printk.time options, and fix configs.

v5: Renaming of structures, and allow printk_time_set() to
evaluate substrings of entries (eg: allow 'r', 'real', 'realtime').  From
peterz, make fast functions return 0 until timekeeping is initialized
(removes timekeeping_active & ktime_get_boot|real_log_ts() suggested by
 tglx and adds ktime_get_real_offset()).  Switch to a function pointer
for printk_get_ts() and reference fast functions.  Make timestamp_sources enum
match choice options for CONFIG_PRINTK_TIME (adds PRINTK_TIME_UNDEFINED).

v6: Define PRINTK_TIME_UNDEFINED for !CONFIG_PRINTK builds.  Separate
timekeeping changes into separate patch.  Minor include file cleanup.

v7: Add default case to printk_set_timestamp() and add PRINTK_TIME_DEBUG
for users that want to set timestamp to different values during runtime.
Add jstultz' Kconfig to avoid defconfig churn.

v8: Add CONFIG_PRINTK_TIME_DEBUG to allow timestamp runtime switching.
Rename PRINTK_TIME_DISABLE to PRINTK_TIME_DISABLED.  Rename
printk_set_timestamp() to printk_set_ts_func().  Separate
printk_set_ts_func() and printk_get_first_ts() portions.  Rename param
functions.  Adjust configs, enum, and timestamp_sources_str to be 0-4.
Add mention realtime clock is UTC in Documentation.

v9: Fix typo.  Add __ktime_get_real_fast_ns_unsafe().

v10: Remove time parameter restrictions.

v11: Rework using tglx's real time patch

v12: Reword Kconfig names.  Simplify timestamp logic and remove
recursive code.

v13: This patch seems have being forgotten for 3 years. Rebase it on
the latest kernel v5.8, reolve conflicts and fix compiling errors.
Change code to adapt new printk_time usage.
Petr's concern on printk_time is addressed by current version of kernel, too.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Christoffer Dall <cdall@linaro.org>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-doc@vger.kernel.org
[jstultz: reworked Kconfig settings to avoid defconfig noise]
Signed-off-by: John Stultz <john.stultz@linaro.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
[orson: rebase on v5.8 and make necessary changes]
Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
---
 Documentation/admin-guide/kernel-parameters.txt |   6 +-
 kernel/printk/printk.c                          | 127 +++++++++++++++++++++++-
 lib/Kconfig.debug                               |  48 ++++++++-
 3 files changed, 174 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad..0bf5f69 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3874,8 +3874,10 @@
 			ratelimit - ratelimit the logging
 			Default: ratelimit
 
-	printk.time=	Show timing data prefixed to each printk message line
-			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
+	printk.time=	Show timestamp prefixed to each printk message line
+			Format: <string>
+				(0/N/n/disable, 1/Y/y/local,
+				 b/boot, m/monotonic, r/realtime (in UTC))
 
 	processor.max_cstate=	[HW,ACPI]
 			Limit processor to maximum C-state
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b71eaf5..ba35f89 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -612,6 +612,9 @@ static u32 truncate_msg(u16 *text_len, u16 *trunc_msg_len,
 	return msg_used_size(*text_len + *trunc_msg_len, 0, pad_len);
 }
 
+static u64 printk_get_first_ts(void);
+static u64 (*printk_get_ts)(void) = printk_get_first_ts;
+
 /* insert record into the buffer, discard old ones, update heads */
 static int log_store(u32 caller_id, int facility, int level,
 		     enum log_flags flags, u64 ts_nsec,
@@ -660,7 +663,7 @@ static int log_store(u32 caller_id, int facility, int level,
 	if (ts_nsec > 0)
 		msg->ts_nsec = ts_nsec;
 	else
-		msg->ts_nsec = local_clock();
+		msg->ts_nsec = printk_get_ts();
 #ifdef CONFIG_PRINTK_CALLER
 	msg->caller_id = caller_id;
 #endif
@@ -1284,8 +1287,124 @@ static inline void boot_delay_msec(int level)
 }
 #endif
 
-static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
-module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);
+/**
+ * enum timestamp_sources - Timestamp sources for printk() messages.
+ * @PRINTK_TIME_DISABLED: No time stamp.
+ * @PRINTK_TIME_LOCAL: Local hardware clock timestamp.
+ * @PRINTK_TIME_BOOT: Boottime clock timestamp.
+ * @PRINTK_TIME_MONO: Monotonic clock timestamp.
+ * @PRINTK_TIME_REAL: Realtime clock timestamp.
+ */
+enum timestamp_sources {
+	PRINTK_TIME_DISABLED = 0,
+	PRINTK_TIME_LOCAL = 1,
+	PRINTK_TIME_BOOT = 2,
+	PRINTK_TIME_MONO = 3,
+	PRINTK_TIME_REAL = 4,
+};
+
+static const char * const timestamp_sources_str[5] = {
+	"disabled",
+	"local",
+	"boottime",
+	"monotonic",
+	"realtime",
+};
+
+static int printk_time = CONFIG_PRINTK_TIME_TYPE;
+
+static int printk_set_ts_source(enum timestamp_sources ts_source)
+{
+	int err = 0;
+
+	switch (ts_source) {
+	case PRINTK_TIME_LOCAL:
+		printk_get_ts = local_clock;
+		break;
+	case PRINTK_TIME_BOOT:
+		printk_get_ts = ktime_get_boot_fast_ns;
+		break;
+	case PRINTK_TIME_MONO:
+		printk_get_ts = ktime_get_mono_fast_ns;
+		break;
+	case PRINTK_TIME_REAL:
+		printk_get_ts = ktime_get_real_fast_ns;
+		break;
+	case PRINTK_TIME_DISABLED:
+	/*
+	 * The timestamp is always stored into the log buffer.
+	 * Keep the current one.
+	 */
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	if (!err)
+		printk_time = ts_source;
+	return err;
+}
+
+static u64 printk_get_first_ts(void)
+{
+	printk_set_ts_source(printk_time);
+
+	/* Fallback for invalid or disabled timestamp source */
+	if (printk_get_ts == printk_get_first_ts)
+		printk_get_ts = local_clock;
+
+	return printk_get_ts();
+}
+
+static int param_set_time(const char *val, const struct kernel_param *kp)
+{
+	char *param = strstrip((char *)val);
+	int time_source = -1;
+	int ts;
+	int err;
+
+	if (strlen(param) == 1) {
+		/* Preserve legacy boolean settings */
+		if ((param[0] == '0') || (param[0] == 'n') ||
+		    (param[0] == 'N'))
+			time_source = PRINTK_TIME_DISABLED;
+		if ((param[0] == '1') || (param[0] == 'y') ||
+		    (param[0] == 'Y'))
+			time_source = PRINTK_TIME_LOCAL;
+	}
+	if (time_source == -1) {
+		for (ts = 0; ts < ARRAY_SIZE(timestamp_sources_str); ts++) {
+			if (!strncmp(timestamp_sources_str[ts], param,
+				     strlen(param))) {
+				time_source = ts;
+				break;
+			}
+		}
+	}
+
+	err = printk_set_ts_source(time_source);
+	if (err) {
+		pr_warn("printk: invalid timestamp option %s\n", param);
+		return err;
+	}
+
+	pr_info("printk: timestamp set to %s\n",
+		timestamp_sources_str[printk_time]);
+	return 0;
+}
+
+static int param_get_time(char *buffer, const struct kernel_param *kp)
+{
+	return scnprintf(buffer, PAGE_SIZE, "%s",
+			 timestamp_sources_str[printk_time]);
+}
+
+static struct kernel_param_ops printk_time_ops = {
+	.set = param_set_time,
+	.get = param_get_time,
+};
+module_param_cb(time, &printk_time_ops, NULL, 0644);
 
 static size_t print_syslog(unsigned int level, char *buf)
 {
@@ -1876,7 +1995,7 @@ static bool cont_add(u32 caller_id, int facility, int level,
 		cont.facility = facility;
 		cont.level = level;
 		cont.caller_id = caller_id;
-		cont.ts_nsec = local_clock();
+		cont.ts_nsec = printk_get_ts();
 		cont.flags = flags;
 	}
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210..e34b905 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -11,12 +11,58 @@ config PRINTK_TIME
 	  messages to be added to the output of the syslog() system
 	  call and at the console.
 
+choice
+	prompt "printk default clock timestamp" if PRINTK_TIME
+	default PRINTK_TIME_LOCAL if PRINTK_TIME
+	help
+	  This option is selected by setting one of
+	  PRINTK_TIME_[DISABLE|LOCAL|BOOT|MONO|REAL] and causes time stamps of
+	  the printk() messages to be added to the output of the syslog()
+	  system call and at the console.
+
 	  The timestamp is always recorded internally, and exported
 	  to /dev/kmsg. This flag just specifies if the timestamp should
 	  be included, not that the timestamp is recorded.
 
 	  The behavior is also controlled by the kernel command line
-	  parameter printk.time=1. See Documentation/admin-guide/kernel-parameters.rst
+	  parameter printk.time. See
+	  Documentation/admin-guide/kernel-parameters.rst
+
+config PRINTK_TIME_LOCAL
+	bool "Local Clock"
+	help
+	  Selecting this option causes the time stamps of printk() to be
+	  stamped with the unadjusted hardware clock.
+
+config PRINTK_TIME_BOOT
+	bool "Boot Time Clock"
+	help
+	  Selecting this option causes the time stamps of printk() to be
+	  stamped with the adjusted boottime clock.
+
+config PRINTK_TIME_MONO
+	bool "Monotonic Clock"
+	help
+	  Selecting this option causes the time stamps of printk() to be
+	  stamped with the adjusted monotonic clock.
+
+config PRINTK_TIME_REAL
+	bool "Real Time Clock"
+	help
+	  Selecting this option causes the time stamps of printk() to be
+	  stamped with the adjusted realtime clock (UTC).
+endchoice
+
+config PRINTK_TIME_TYPE
+	int
+	depends on PRINTK
+	range 0 4
+	default 0 if !PRINTK_TIME
+	default 1 if PRINTK_TIME_LOCAL
+	default 2 if PRINTK_TIME_BOOT
+	default 3 if PRINTK_TIME_MONO
+	default 4 if PRINTK_TIME_REAL
+
 
 config PRINTK_CALLER
 	bool "Show caller information on printks"
-- 
2.7.4

