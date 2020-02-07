Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B824DC04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BDD20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="avBdl26y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgBGPIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:08:21 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37821 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgBGPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:08:21 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so1041897pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 07:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I/0v0qtR62GKNpXcdCPlvD90wom+9FXbp6NkReIN9xQ=;
        b=avBdl26ymglV2QYxcKE577CoxP0zYMzLARJ+hEvodaDcRqzImZE5+aShrg/NcDwt6w
         wtK23ZOUiAjTKWLsM9kRbfMC9GNQqSVQiqh31fczdGMfHjjLmY3IFJ7GmwFF02pCR4dw
         hob4BXYkeXFHDib1j4aB6tbTm5L7ZdAAlL7OVSnvniaNJNJOPVJ8KTl9W2xGHRG8Ge2Q
         HdR3UBOLTdhFoEpgC1SxEt1RmYyptYVACHsGyf9Ql5dmncOa8eJki7/VKJ1/RcU4nbMX
         fAJFSacQ5nRI60/eDZIu1F5lhlcUD9bjcKQnusClszsza2oghsz0hSLcFkLzWDNlWzxd
         CIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I/0v0qtR62GKNpXcdCPlvD90wom+9FXbp6NkReIN9xQ=;
        b=bsWsUU9mpr7jkC3xfoCn0e3Xl+H/9tMI8b4B6BZXadlGr1xnq8m5mW5ChOQVtYWHvW
         PC20RQU5GAfXc0NoVPHJIcSOOFDk/DrFGtKp4xjGLOztwliA/5lF/SKTZYkvXjWNfHU6
         faK5Sm+soudGw/Xyg7utZ6NctZEBTFSFStR7WGCE2/y36ibQ0DrOBCHHmJuoOyIYbIXB
         M33eZNpE4WDx5m5Enqk8zQp8xCdNoEzd+WEAdSVbG0C/fqmQPnjSRyBRd7Y0UFk4YjCO
         5gwQ7QPHz7zdlM1Efwr4U/WiBMJ7x5t8mf3M84i3xxxw2efSHHqaIo3vGO3ZfI27ZfpR
         rDjQ==
X-Gm-Message-State: APjAAAV01eZ1OWfvKYXz53UicnJtkFf+mpbzZLp1T8sdgTV2M1m5AwqT
        2Hi+tDYom5UWGQFjl1fRuLE8cjvqFdo=
X-Google-Smtp-Source: APXvYqxP7mF0k1sMFrZrmCOvccD14XV5ALBFKGEgMPGLnqPmd9O2rQ7+Ap9mZ4GeGefgwHoQEAtp3g==
X-Received: by 2002:a17:90a:7187:: with SMTP id i7mr4230255pjk.6.1581088099895;
        Fri, 07 Feb 2020 07:08:19 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id 196sm3550978pfy.86.2020.02.07.07.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 07:08:19 -0800 (PST)
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
Subject: [PATCH] random: add rng-seed= command line option
Date:   Fri,  7 Feb 2020 07:07:59 -0800
Message-Id: <20200207150809.19329-1-salyzyn@android.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
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

Always rrase all views of the rng-seed option, except early command
line parsing, to prevent leakage to applications or modules, to
eliminate any attack vector.

It is preferred to add rng-seed to the Device Tree, but some
platforms do not have this option, so this adds the ability to
provide some command-line-limited data to the entropy through this
alternate mechanism.  Expect all 8 bits to be used, but must exclude
space to be accounted in the command line.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
---
 drivers/char/random.c  |  8 +++++
 include/linux/random.h |  5 +++
 init/main.c            | 73 +++++++++++++++++++++++++++++++++++-------
 3 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c7f9584de2c8b..2f386e411fb7b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2311,3 +2311,11 @@ void add_bootloader_randomness(const void *buf, unsigned int size)
 		add_device_randomness(buf, size);
 }
 EXPORT_SYMBOL_GPL(add_bootloader_randomness);
+
+#if defined(CONFIG_RANDOM_TRUST_BOOTLOADER)
+/* caller called add_device_randomness, but it is from a trusted source */
+void __init credit_trusted_entropy(unsigned int size)
+{
+	credit_entropy_bits(&input_pool, size * 8);
+}
+#endif
diff --git a/include/linux/random.h b/include/linux/random.h
index d319f9a1e4290..1e09eeadc613c 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -20,6 +20,11 @@ struct random_ready_callback {
 
 extern void add_device_randomness(const void *, unsigned int);
 extern void add_bootloader_randomness(const void *, unsigned int);
+#if defined(CONFIG_RANDOM_TRUST_BOOTLOADER)
+extern void __init credit_trusted_entropy(unsigned int b);
+#else
+static inline void credit_trusted_entropy(unsigned int b) {}
+#endif
 
 #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 static inline void add_latent_entropy(void)
diff --git a/init/main.c b/init/main.c
index cc0ee4873419c..ae976b2dea5dc 100644
--- a/init/main.c
+++ b/init/main.c
@@ -524,24 +524,53 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
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
+	memcpy(dest, src, r);
+	dest[r] = '\0';
+}
+
 static void __init setup_command_line(char *command_line)
 {
 	size_t len, xlen = 0, ilen = 0;
+	static const char argsep_str[] __initconst = " -- ";
+	static const char alloc_fail_msg[] __initconst =
+		"%s: Failed to allocate %zu bytes\n";
 
 	if (extra_command_line)
 		xlen = strlen(extra_command_line);
 	if (extra_init_args)
-		ilen = strlen(extra_init_args) + 4; /* for " -- " */
+		ilen = strlen(extra_init_args) + strlen(argsep_str);
 
-	len = xlen + strlen(boot_command_line) + 1;
+	len = xlen + strnlen(boot_command_line, sizeof(boot_command_line)) + 1;
 
 	saved_command_line = memblock_alloc(len + ilen, SMP_CACHE_BYTES);
 	if (!saved_command_line)
-		panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
+		panic(alloc_fail_msg, __func__, len + ilen);
 
 	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!static_command_line)
-		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+		panic(alloc_fail_msg, __func__, len);
 
 	if (xlen) {
 		/*
@@ -549,11 +578,14 @@ static void __init setup_command_line(char *command_line)
 		 * lines because there could be dashes (separator of init
 		 * command line) in the command lines.
 		 */
-		strcpy(saved_command_line, extra_command_line);
-		strcpy(static_command_line, extra_command_line);
+		copy_command_line(saved_command_line, extra_command_line, xlen);
+		copy_command_line(static_command_line, extra_command_line,
+				  xlen);
 	}
-	strcpy(saved_command_line + xlen, boot_command_line);
-	strcpy(static_command_line + xlen, command_line);
+	copy_command_line(saved_command_line + xlen, boot_command_line,
+			  len - xlen - 1);
+	copy_command_line(static_command_line + xlen, command_line,
+			  len - xlen - 1);
 
 	if (ilen) {
 		/*
@@ -562,13 +594,15 @@ static void __init setup_command_line(char *command_line)
 		 * to init.
 		 */
 		len = strlen(saved_command_line);
-		if (!strstr(boot_command_line, " -- ")) {
-			strcpy(saved_command_line + len, " -- ");
-			len += 4;
+		if (!strnstr(boot_command_line, argsep_str,
+			     sizeof(boot_command_line))) {
+			strcpy(saved_command_line + len, argsep_str);
+			len += strlen(argsep_str);
 		} else
 			saved_command_line[len++] = ' ';
 
-		strcpy(saved_command_line + len, extra_init_args);
+		copy_command_line(saved_command_line + len, extra_init_args,
+				  ilen - strlen(argsep_str));
 	}
 }
 
@@ -875,6 +909,21 @@ asmlinkage __visible void __init start_kernel(void)
 	rand_initialize();
 	add_latent_entropy();
 	add_device_randomness(command_line, strlen(command_line));
+	if (IS_BUILTIN(CONFIG_RANDOM_TRUST_BOOTLOADER)) {
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
+			credit_trusted_entropy(l);
+		}
+	}
 	boot_init_stack_canary();
 
 	time_init();
-- 
2.25.0.341.g760bfbb309-goog

