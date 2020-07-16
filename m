Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50DEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CADC206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fxPQnWz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgGPPUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgGPPUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:20:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8A9C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:20:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so7515045wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bt894HzKEOa1juEk1zUwT+0wI2k83kLqjbCs4ktmwwU=;
        b=fxPQnWz59Up3zrl0RzjlzsOI92Vi4xDMdkMXTsmF5eF0O69S/9QxQx9W5N0gO6uQYd
         KMdRrpjWnQyRnQJhnI6HgyildgntrisyLJWqjKqgeKOSYhViY94se2D0JSclNyQnA7db
         /fQRmh33E3YqGzdcKag+knbWwqpO2rA1HbbXG8iZ20YU/Zz9EcyhlYo/iDnsTKFSEgz8
         +BRuUnqW73/9iSuxSWWRFjGUnIRJA12dw1cdtZODQbLbyaGOD2jj2/KVPM8esB70T8Xm
         8d31C4aC+oKfEyti14BQW7FsyMfy65bFrwItW48j94uqHi2wA1eBpeyR9pj7QXhoSVIG
         5u8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bt894HzKEOa1juEk1zUwT+0wI2k83kLqjbCs4ktmwwU=;
        b=JFCFhKagg6msuIeKaqk5Z9/X2ZVRQyX+KjGz+stbE58zzX+4h7ntxnqZ/K/QSB61qj
         LqWKvi8nDIHfRnx8xPSw8gWdj9a+vcR0Y4QOgx0WoF9WN/B8IogX8SY8YTOMukHaNy7S
         oBa7+MK5c1nfBcDe7DA/rEPjNYjWaztJl6d2WQ6ZnHXuBmmZ9FV0GxtjNi1p9HqaQF0C
         mDg6rPo0bBDh0lt2yCJGzwdceaecc1bDNGP5rOVUmUdvH71c4JaCAJuj/JnPrkMMDnyV
         jVSo0t8a7tVxY6+RYrWvBDFxNaKvvZO+9C0a4lKimVaXqT7xyP64lzfw88oHYg0+7eTP
         6a3g==
X-Gm-Message-State: AOAM5304QsHY/zTauoi5PjRWCau/jFzRE/zAzD2K1K+vUD92CLwlTTZG
        U36U38eWc7A4B7HvsCrBD5xgQA==
X-Google-Smtp-Source: ABdhPJxL8ueR/OcnC3ZDGghtoI6P4Ks6MOUOjDetInyQZqPmjy2evPI+PENXwSQ2/p8MNK4GuK8RpA==
X-Received: by 2002:adf:f14c:: with SMTP id y12mr5460591wro.30.1594912805876;
        Thu, 16 Jul 2020 08:20:05 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u17sm9877687wrp.70.2020.07.16.08.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:20:05 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v2 1/3] kgdb: Honour the kprobe blocklist when setting breakpoints
Date:   Thu, 16 Jul 2020 16:19:41 +0100
Message-Id: <20200716151943.2167652-2-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200716151943.2167652-1-daniel.thompson@linaro.org>
References: <20200716151943.2167652-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kgdb has absolutely no safety rails in place to discourage or
prevent a user from placing a breakpoint in dangerous places such as
the debugger's own trap entry/exit and other places where it is not safe
to take synchronous traps.

Introduce a new config symbol KGDB_HONOUR_BLOCKLIST and modify the
default implementation of kgdb_validate_break_address() so that we use
the kprobe blocklist to prohibit instrumentation of critical functions
if the config symbol is set. The config symbol dependencies are set to
ensure that the blocklist will be enabled by default if we enable KGDB
and are compiling for an architecture where we HAVE_KPROBES.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 include/linux/kgdb.h      | 18 ++++++++++++++++++
 kernel/debug/debug_core.c |  4 ++++
 kernel/debug/kdb/kdb_bp.c |  9 +++++++++
 lib/Kconfig.kgdb          | 14 ++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 529116b0cabe..7caba4604edc 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -16,6 +16,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/atomic.h>
+#include <linux/kprobes.h>
 #ifdef CONFIG_HAVE_ARCH_KGDB
 #include <asm/kgdb.h>
 #endif
@@ -323,6 +324,23 @@ extern int kgdb_nmicallin(int cpu, int trapnr, void *regs, int err_code,
 			  atomic_t *snd_rdy);
 extern void gdbstub_exit(int status);
 
+/*
+ * kgdb and kprobes both use the same (kprobe) blocklist (which makes sense
+ * given they are both typically hooked up to the same trap meaning on most
+ * architectures one cannot be used to debug the other)
+ *
+ * However on architectures where kprobes is not (yet) implemented we permit
+ * breakpoints everywhere rather than blocking everything by default.
+ */
+static inline bool kgdb_within_blocklist(unsigned long addr)
+{
+#ifdef CONFIG_KGDB_HONOUR_BLOCKLIST
+	return within_kprobe_blacklist(addr);
+#else
+	return false;
+#endif
+}
+
 extern int			kgdb_single_step;
 extern atomic_t			kgdb_active;
 #define in_dbg_master() \
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 9e5934780f41..133a361578dc 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -188,6 +188,10 @@ int __weak kgdb_validate_break_address(unsigned long addr)
 {
 	struct kgdb_bkpt tmp;
 	int err;
+
+	if (kgdb_within_blocklist(addr))
+		return -EINVAL;
+
 	/* Validate setting the breakpoint and then removing it.  If the
 	 * remove fails, the kernel needs to emit a bad message because we
 	 * are deep trouble not being able to put things back the way we
diff --git a/kernel/debug/kdb/kdb_bp.c b/kernel/debug/kdb/kdb_bp.c
index d7ebb2c79cb8..ec4940146612 100644
--- a/kernel/debug/kdb/kdb_bp.c
+++ b/kernel/debug/kdb/kdb_bp.c
@@ -306,6 +306,15 @@ static int kdb_bp(int argc, const char **argv)
 	if (!template.bp_addr)
 		return KDB_BADINT;
 
+	/*
+	 * This check is redundant (since the breakpoint machinery should
+	 * be doing the same check during kdb_bp_install) but gives the
+	 * user immediate feedback.
+	 */
+	diag = kgdb_validate_break_address(template.bp_addr);
+	if (diag)
+		return diag;
+
 	/*
 	 * Find an empty bp structure to allocate
 	 */
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index ffa7a76de086..9d0d408f81b1 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -19,6 +19,20 @@ menuconfig KGDB
 
 if KGDB
 
+config KGDB_HONOUR_BLOCKLIST
+	bool "KGDB: use kprobe blocklist to prohibit unsafe breakpoints"
+	depends on HAVE_KPROBES
+	select KPROBES
+	default y
+	help
+	  If set to Y the debug core will use the kprobe blocklist to
+	  identify symbols where it is unsafe to set breakpoints.
+	  In particular this disallows instrumentation of functions
+	  called during debug trap handling and thus makes it very
+	  difficult to inadvertently provoke recursive trap handling.
+
+	  If unsure, say Y.
+
 config KGDB_SERIAL_CONSOLE
 	tristate "KGDB: use kgdb over the serial console"
 	select CONSOLE_POLL
-- 
2.25.4

