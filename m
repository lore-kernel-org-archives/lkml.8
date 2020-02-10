Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01DBC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFA2206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="YFFESfze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgBJOpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:45:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42561 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbgBJOpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id w21so4017480pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8Tf/NiIOt3+TWj+vWtQhvxIaKwL7YCUA0Ns35FwILU=;
        b=YFFESfzeS9sgCd0i3QGYRDDvZbt3NLPty9L82/5jCua44n3cv4080fkEG9I2jBjB0+
         dsyZL+EU2lPhdp5Ssb4hirWysrBv6lEPjEinPi3gflG3VaqO2LIejo5vg9mQO/q6Wcvr
         AlJJf4qLS7UhWA/DUB2PlDAIjVdlL1Q6Hn5bAfmywF2bdUOnYC3CuIQoCcOMY41i5H7w
         BXZuabq7zsZozMQ50GoSZOfytzYvFm/7B07zaiPKezEvPhBGR7M9+Zt9+WySyX1zaK8Y
         4pEJG4UPvnu7nvg8rSDnpFTbeCRIeI/5q+1cKGJC/8xDh37PgimeOkmIqLcjDLT9dgMa
         46XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8Tf/NiIOt3+TWj+vWtQhvxIaKwL7YCUA0Ns35FwILU=;
        b=dXoI0QgUeefjZTZBkazqgKLEI2XYre/Sm35ZbnJFK6OHQPjXY0wFS5/JSvEMGkshib
         Slhc71DsZmVsrnsqjDr3h2gSsAFYAT7vT8ByApgIPz4KOGqx7UNz9/gamBoSq2SO+oeH
         S59gryKTV4POKf6MPEcgupfTALoxBcJeYIw4JhnuXYAcmSe3MF/4F/a9eyLgbe53xoEK
         iEU3RIZckOwgnXXRj9kmokK4awB8FkDPsHVoPyaFAL9VAMunoIFFAaMFwZ6Kn/brZsvp
         EuQBCszo6KzUQqVjhNlMnFSr5MXz3f8ZFO7OM75Y2WXGyfKysvH5SoKkLD481lONBUPR
         peBQ==
X-Gm-Message-State: APjAAAVvuuKYzkfJTwhY7WuFYEzTazYDGOHDj09s6Smix+pXDE55SpZ9
        ZJKDDccO1C0fYmtFX4fg8MFBwolBbEc=
X-Google-Smtp-Source: APXvYqzDW5rAZskGJKxd7l7eoiqr+y84KJj9thU7YYBfNPccQJWjcc5d231wGF5anXsdXW1n8Awb2g==
X-Received: by 2002:aa7:9aeb:: with SMTP id y11mr1536138pfp.63.1581345950572;
        Mon, 10 Feb 2020 06:45:50 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id dw10sm552079pjb.11.2020.02.10.06.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:45:50 -0800 (PST)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>
Subject: [PATCH 4/4 v2] random: add rng-seed= command line option
Date:   Mon, 10 Feb 2020 06:45:05 -0800
Message-Id: <20200210144512.180348-5-salyzyn@android.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200210144512.180348-1-salyzyn@android.com>
References: <20200207150809.19329-1-salyzyn@android.com> <202002070850.BD92BDCA@keescook> <20200207155828.GB122530@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A followup to commit 428826f5358c922dc378830a1717b682c0823160
("fdt: add support for rng-seed") to extend what was started
with Open Firmware (OF or Device Tree) parsing, but also add
it to the command line.

If CONFIG_RANDOM_TRUST_BOOTLOADER is set, then feed the rng-seed
command line option length as added trusted entropy.

Always erase view of the rng-seed option, except our early command
line parsing, to prevent leakage to applications or modules, to
eliminate any attack vector.

It is preferred to add rng-seed to the Device Tree, but some
platforms do not have this option, so this adds the ability to
provide some command-line-limited data to the entropy through this
alternate mechanism.  Expect on average 6 bits of useful entropy
per character.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Potapenko <glider@google.com>
---
v2
- Split into four bite sized patches.
- Correct spelling in commit message.
- rng-seed is assumed to be utf-8, so correct both to 6 bits/character
  of collected entropy.
- Move entropy collection to a static __always_inline helper function.
---
 drivers/char/random.c  |  8 ++++
 include/linux/random.h |  5 +++
 init/main.c            | 88 ++++++++++++++++++++++++++++++++++--------
 3 files changed, 84 insertions(+), 17 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index ee21a6a584b15..83c77306e18e7 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2311,3 +2311,11 @@ void add_bootloader_randomness(const void *buf, unsigned int size)
 		add_device_randomness(buf, size);
 }
 EXPORT_SYMBOL_GPL(add_bootloader_randomness);
+
+#if defined(CONFIG_RANDOM_TRUST_BOOTLOADER)
+/* caller called add_device_randomness, but it is from a trusted source */
+void __init credit_trusted_entropy_bits(unsigned int nbits)
+{
+	credit_entropy_bits(&input_pool, nbits);
+}
+#endif
diff --git a/include/linux/random.h b/include/linux/random.h
index d319f9a1e4290..efe8cbe2255ab 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -20,6 +20,11 @@ struct random_ready_callback {
 
 extern void add_device_randomness(const void *, unsigned int);
 extern void add_bootloader_randomness(const void *, unsigned int);
+#if defined(CONFIG_RANDOM_TRUST_BOOTLOADER)
+extern void __init credit_trusted_entropy_bits(unsigned int nbits);
+#else
+static inline void credit_trusted_entropy_bits(unsigned int nbits) {}
+#endif
 
 #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 static inline void add_latent_entropy(void)
diff --git a/init/main.c b/init/main.c
index 9f4ce0356057e..ad52f03fb8de4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -524,6 +524,31 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
  * parsing is performed in place, and we should allow a component to
  * store reference of name/value for future reference.
  */
+static const char rng_seed_str[] __initconst = "rng-seed=";
+/* try to clear rng-seed so it won't be found by user applications. */
+static void __init copy_command_line(char *dest, char *src, size_t r)
+{
+	char *rng_seed = strnstr(src, rng_seed_str, r);
+
+	if (rng_seed) {
+		size_t l = rng_seed - src;
+		char *end;
+
+		memcpy(dest, src, l);
+		dest += l;
+		src = rng_seed + strlen(rng_seed_str);
+		r -= l + strlen(rng_seed_str);
+		end = strnchr(src, r, ' ');
+		if (end) {
+			if (l && rng_seed[-1] == ' ')
+				++end;
+			r -= end - src;
+			src = end;
+		}
+	}
+	strlcpy(dest, src, r);
+}
+
 static const char alloc_fail_msg[] __initconst =
 	"%s: Failed to allocate %zu bytes\n";
 static void __init setup_command_line(char *command_line)
@@ -552,11 +577,15 @@ static void __init setup_command_line(char *command_line)
 		 * lines because there could be dashes (separator of init
 		 * command line) in the command lines.
 		 */
-		strcpy(saved_command_line, extra_command_line);
-		strcpy(static_command_line, extra_command_line);
+		copy_command_line(saved_command_line, extra_command_line,
+				  xlen + 1);
+		copy_command_line(static_command_line, extra_command_line,
+				  xlen + 1);
 	}
-	strlcpy(saved_command_line + xlen, boot_command_line, len - xlen);
-	strcpy(static_command_line + xlen, command_line);
+	copy_command_line(saved_command_line + xlen, boot_command_line,
+			  len - xlen);
+	copy_command_line(static_command_line + xlen, command_line,
+			  len - xlen);
 
 	if (ilen) {
 		/*
@@ -572,7 +601,8 @@ static void __init setup_command_line(char *command_line)
 		} else
 			saved_command_line[len++] = ' ';
 
-		strcpy(saved_command_line + len, extra_init_args);
+		copy_command_line(saved_command_line + len, extra_init_args,
+				  ilen - strlen(argsep_str) + 1);
 	}
 }
 
@@ -757,6 +787,41 @@ void __init __weak arch_call_rest_init(void)
 	rest_init();
 }
 
+static __always_inline void __init collect_entropy(const char *command_line)
+{
+	/*
+	 * For best initial stack canary entropy, prepare it after:
+	 * - setup_arch() for any UEFI RNG entropy and boot cmdline access
+	 * - timekeeping_init() for ktime entropy used in rand_initialize()
+	 * - rand_initialize() to get any arch-specific entropy like RDRAND
+	 * - add_latent_entropy() to get any latent entropy
+	 * - adding command line entropy
+	 */
+	rand_initialize();
+	add_latent_entropy();
+	add_device_randomness(command_line, strlen(command_line));
+	if (IS_BUILTIN(CONFIG_RANDOM_TRUST_BOOTLOADER)) {
+		/*
+		 * Added command line device randomness above,
+		 * now add entropy credit for just rng-seed=<data>
+		 */
+		size_t l = strlen(command_line);
+		char *rng_seed = strnstr(command_line, rng_seed_str, l);
+
+		if (rng_seed) {
+			char *end;
+
+			rng_seed += strlen(rng_seed_str);
+			l -= rng_seed - command_line;
+			end = strnchr(rng_seed, l, ' ');
+			if (end)
+				l = end - rng_seed;
+			credit_trusted_entropy_bits(l * 6);
+		}
+	}
+	boot_init_stack_canary();
+}
+
 asmlinkage __visible void __init start_kernel(void)
 {
 	char *command_line;
@@ -868,18 +933,7 @@ asmlinkage __visible void __init start_kernel(void)
 	softirq_init();
 	timekeeping_init();
 
-	/*
-	 * For best initial stack canary entropy, prepare it after:
-	 * - setup_arch() for any UEFI RNG entropy and boot cmdline access
-	 * - timekeeping_init() for ktime entropy used in rand_initialize()
-	 * - rand_initialize() to get any arch-specific entropy like RDRAND
-	 * - add_latent_entropy() to get any latent entropy
-	 * - adding command line entropy
-	 */
-	rand_initialize();
-	add_latent_entropy();
-	add_device_randomness(command_line, strlen(command_line));
-	boot_init_stack_canary();
+	collect_entropy(command_line);
 
 	time_init();
 	printk_safe_init();
-- 
2.25.0.341.g760bfbb309-goog

