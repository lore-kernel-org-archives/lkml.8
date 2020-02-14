Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D461C3B195
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B0424670
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581660651;
	bh=bZnsoue1r0Ourqy/MmpbFzBoi9thdZXm4AJn9kmhPTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KmQ7iY7H3Xo1SVMCb8yHZeXCYkPL3XhKpShkTA/bBzt3jyr+GeyM4UNe7cCFfqSYf
	 BXnpXh7UGVT4In9hi/JJ57bzo24GwBKcJwgmflLt2nz7lfoxFUmRG+2QN3ucHFnKtq
	 EM9qI8JSbO5Ry29980Dz1l2pK2D8Y9NkZQcILzP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgBNGKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgBNGKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:10:50 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 483932465D;
        Fri, 14 Feb 2020 06:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581660648;
        bh=bZnsoue1r0Ourqy/MmpbFzBoi9thdZXm4AJn9kmhPTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6Nr8R4aThWRHnOx3DwpT7/0+uPeHEFjvsy/jTUxSXeiU+hG2Z66YvMd91w65WCaL
         jGUVch8jkeBf3Iz2/Etk8vE+h3q0g2xej5gClQKIm0jDK+BwnVBlB6yJBtmUMue/Pz
         unWcqp5BPgi5HJCTt3BQYUeF3BZ2/CoVJydnaavc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Subject: [PATCH 3/3] random: add random.rng_seed= bootconfig option
Date:   Fri, 14 Feb 2020 15:10:41 +0900
Message-Id: <158166064078.9887.1754084457230746782.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158166060044.9887.549561499483343724.stgit@devnote2>
References: <158166060044.9887.549561499483343724.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Salyzyn <salyzyn@android.com>

A followup to commit 428826f5358c922dc378830a1717b682c0823160
("fdt: add support for rng-seed") to extend what was started
with Open Firmware (OF or Device Tree) parsing, but also add
it to the bootconfig.

If CONFIG_RANDOM_TRUST_BOOTLOADER is set, then feed the
random.rng_seed bootconfig data length as added trusted
entropy.

Always erase view of the random.rng_seed option from
/proc/bootconfig to prevent leakage to applications or modules,
to eliminate any attack vector.  Note that initcall embedded
code still have a chance to see it, but that will be unsafe
at different level.

It is preferred to add rng-seed to the Device Tree, but some
platforms do not have this option, so this adds the ability to
provide some bootconfig-limited data to the entropy through this
alternate mechanism.  Expect on average 6 bits of useful entropy
per character.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Potapenko <glider@google.com>
---
v4
- Use bootconfig instead of command line
- Move the documentation under Documentation/admin-guide/bootconfig/.
v3
- Add Documentation (all other new v2 patches unchanged)

v2
- Split into four bite sized patches.
- Correct spelling in commit message.
- rng-seed is assumed to be utf-8, so correct both to 6 bits/character
  of collected entropy.
- Move entropy collection to a static __always_inline helper function.
---
 Documentation/admin-guide/bootconfig/random.rst |   21 ++++++++++++
 drivers/char/Kconfig                            |    1 +
 drivers/char/random.c                           |    8 ++++
 fs/proc/bootconfig.c                            |    4 ++
 include/linux/random.h                          |    7 ++++
 init/main.c                                     |   41 ++++++++++++++++-------
 6 files changed, 70 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/admin-guide/bootconfig/random.rst

diff --git a/Documentation/admin-guide/bootconfig/random.rst b/Documentation/admin-guide/bootconfig/random.rst
new file mode 100644
index 000000000000..d4ee513c5136
--- /dev/null
+++ b/Documentation/admin-guide/bootconfig/random.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+The Random Subsystem Bootconfig
+===============================
+
+The keys start with "random." configures random number generator subsystem.
+
+Options
+=======
+
+random.rng_seed
+  Provide a trusted seed for the kernel's CRNG. Seed only trusted if
+  CONFIG_RANDOM_TRUST_BOOTLOADER=y.  After collection, this option is not
+  shown in /proc/bootconfig.
+  The seed is given a weight of 6 bits per character with the assumption that
+  it is a printable utf8 string.  It is expected that the supplier of the
+  seed, typically a bootloader or virtualization, will supply a new random
+  seed for each kernel instance.
+  A fixed serial number is typically not appropriate for security features
+  like ASLR.
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 26956c006987..43fbbd307204 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -554,6 +554,7 @@ config RANDOM_TRUST_CPU
 
 config RANDOM_TRUST_BOOTLOADER
 	bool "Trust the bootloader to initialize Linux's CRNG"
+	select BOOT_CONFIG
 	help
 	Some bootloaders can provide entropy to increase the kernel's initial
 	device randomness. Say Y here to assume the entropy provided by the
diff --git a/drivers/char/random.c b/drivers/char/random.c
index ee21a6a584b1..83c77306e18e 100644
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
diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index 9955d75c0585..6d1a819f2df4 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -8,6 +8,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/bootconfig.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 
 static char *saved_boot_config;
@@ -36,6 +37,9 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
 		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
 		if (ret < 0)
 			break;
+		/* For keeping security reason, remove randomness key */
+		if (!strcmp(key, RANDOM_SEED_XBC_KEY))
+			continue;
 		ret = snprintf(dst, rest(dst, end), "%s = ", key);
 		if (ret < 0)
 			break;
diff --git a/include/linux/random.h b/include/linux/random.h
index d319f9a1e429..c8f41ab4f342 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -20,6 +20,13 @@ struct random_ready_callback {
 
 extern void add_device_randomness(const void *, unsigned int);
 extern void add_bootloader_randomness(const void *, unsigned int);
+#if defined(CONFIG_RANDOM_TRUST_BOOTLOADER)
+extern void __init credit_trusted_entropy_bits(unsigned int nbits);
+#else
+static inline void credit_trusted_entropy_bits(unsigned int nbits) {}
+#endif
+
+#define RANDOM_SEED_XBC_KEY "random.rng_seed"
 
 #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 static inline void add_latent_entropy(void)
diff --git a/init/main.c b/init/main.c
index f95b014a5479..d0e5a95b4182 100644
--- a/init/main.c
+++ b/init/main.c
@@ -776,6 +776,34 @@ void __init __weak arch_call_rest_init(void)
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
+		 * Added bootconfig device randomness above,
+		 * now add entropy credit for just random.rng_seed=<data>
+		 */
+		const char *rng_seed = xbc_find_value(RANDOM_SEED_XBC_KEY, NULL);
+
+		if (rng_seed) {
+			add_device_randomness(rng_seed, strlen(rng_seed));
+			credit_trusted_entropy_bits(strlen(rng_seed) * 6);
+		}
+	}
+	boot_init_stack_canary();
+}
+
 asmlinkage __visible void __init start_kernel(void)
 {
 	char *command_line;
@@ -887,18 +915,7 @@ asmlinkage __visible void __init start_kernel(void)
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

