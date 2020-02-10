Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F192C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106092072C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="bDHwf3XH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBJWTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:19:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37080 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgBJWTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:19:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id z12so4638682pgl.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 14:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W4+bXOYA7di4EtSAPlqTcU8yDs9ZmyX+rKNZ6zxUfJM=;
        b=bDHwf3XHXyXL++azeW+mtkWbAkHjfstlK28gQAT8IcD+XRHkVP9wJ57RA131g+giRf
         1NXN/7TIJqONaT01x4mlS1N90gZtUfZwBV1zlZ3r7/qXXCeJcs8m2+pdAiWiJwFnqqYO
         Ilht536LJyDnv/UngbGHjMJVlqplBcpNfdXzPaCWO6k5nJeTdCxFVUqDh7nxknhlyXaT
         taxFN33U9M19g1wb3/mOk1vn0oqJ9vD2dJtXiGFKDV+7wZAhidfJ4slSM/vENT8Z8S1s
         yoKcivrtLBfl/CXH2I+FwFNSHsfeU97ipNaQn/Jz7jS3AOq6v7TP8JAQYrcRW9AdI7yP
         2iHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W4+bXOYA7di4EtSAPlqTcU8yDs9ZmyX+rKNZ6zxUfJM=;
        b=ZMj8k7UY8UOKrtDxxWRq7BjFXPCP9MMELy7JUSYbTP/tMZ+iNdkZe0rrkFZ0T4qNmw
         qcHr38eQxFwgxDZ3N6Y6IFRdkWKcBG2NZAuvNkqXj+HXjcFhibKubCgcdViKy8400gd/
         yAgFvuNslAj36ZnoFn4JIaA7dXvby42/ydM+f/agU7jPcPKwCY5A/Die3Q36rgiQW38I
         XZYmrWQ2LXTPGVbYzMcdoqsBuxmk4OpJdIdsP5C3rS25eSoB+aELDpmAG4810xded1Bm
         4ArFxkzVCS+YBAxV5hQg8WQR9yk3LRh5ryj5oJuSeHLfodztFGvGstXcJoaRbAIshlfm
         3m+g==
X-Gm-Message-State: APjAAAW8L9V0TuSdkuHmsqZ+N87vkETJ9fttDqp9DPUMUhh1/uzJYEYN
        w3IhXfWV70M8v4fudjvEPaN4lkSVKu8=
X-Google-Smtp-Source: APXvYqyfxVBCIHmE5puMAKDHBvRaiQUs4Nl2flhb6YjONf7dL03y8wjdziP/Ca25QgcEo+SwbtLx8g==
X-Received: by 2002:a63:2f04:: with SMTP id v4mr3702404pgv.33.1581373174335;
        Mon, 10 Feb 2020 14:19:34 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id f81sm1323393pfa.118.2020.02.10.14.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 14:19:33 -0800 (PST)
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
        Alexander Potapenko <glider@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH 4/4 v3] random: add rng-seed= command line option
Date:   Mon, 10 Feb 2020 14:19:16 -0800
Message-Id: <20200210221925.43533-1-salyzyn@android.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <4bd0d1cb-44cb-d02e-6aac-2b2cfce52eba@infradead.org>
References: <20200207150809.19329-1-salyzyn@android.com> <202002070850.BD92BDCA@keescook> <20200207155828.GB122530@mit.edu> <20200210144512.180348-5-salyzyn@android.com>
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
v3
- Add Documentation (all other new v2 patches unchanged)

v2
- Split into four bite sized patches.
- Correct spelling in commit message.
- rng-seed is assumed to be utf-8, so correct both to 6 bits/character
  of collected entropy.
- Move entropy collection to a static __always_inline helper function.
---
 .../admin-guide/kernel-parameters.txt         | 11 +++
 drivers/char/random.c                         |  8 ++
 include/linux/random.h                        |  5 ++
 init/main.c                                   | 88 +++++++++++++++----
 4 files changed, 95 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dbc22d6846275..f3c373cc40f9a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4334,6 +4334,17 @@
 			[KNL] Disable ring 3 MONITOR/MWAIT feature on supported
 			CPUs.
 
+	rng-seed=	[KNL] Provide a trusted seed for the kernel's CRNG.
+			Seed only trusted if CONFIG_RANDOM_TRUST_BOOTLOADER.
+			After collection, this option is wiped from the command
+			line views.  The seed is given a weight of 6 bits per
+			character with the assumption that it is a printable
+			utf8 string.  It is expected that the supplier of the
+			seed, typically a bootloader or virtualization, will
+			supply a new random seed for each kernel instance.
+			A fixed serial number is typically not appropriate
+			for security features like ASLR.
+
 	ro		[KNL] Mount root device read-only on boot
 
 	rodata=		[KNL]
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

