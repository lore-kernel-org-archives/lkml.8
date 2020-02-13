Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924A2C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAA824649
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581606233;
	bh=xJDzUg752RTCgQ099nYCogfdb8GoRR0BYKPXxhfiwtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KGarPACC5hHZ/92uvN33m3g8NewmhBv3BB0zfN/0I8XxndofAoz4WeFcHS+rRK3r+
	 A/fQ5S3qp4a1SEfKjQZBHpicGhEHCXC4+F0oDfuuYf/wZGaXE1+iymDhGYBY/1bDyy
	 PZOry9WJC36CatQc/G9ha5iGktvEu8Y26GdwDQ6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgBMPDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:03:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMPDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:03:51 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 194872073C;
        Thu, 13 Feb 2020 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581606230;
        bh=xJDzUg752RTCgQ099nYCogfdb8GoRR0BYKPXxhfiwtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OJWQc3v4NV/h+hSVaL2cAfhcR4jWZJHgG0m1hjq9I2aRtBVfRHEJHmXxWlUI2tZ/9
         3TkFlX0wFoUTPBxsZ+aavcu7aqHP/NOGpIwUOT7jXs/WttOSvwcUTfPMALIgzETlt8
         +7VdpzK2ZD596lAKlUBwJ7dMhX3vIc/9MUZ2djWU=
Date:   Fri, 14 Feb 2020 00:03:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Mark Salyzyn <salyzyn@android.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] random: add rng-seed= command line option
Message-Id: <20200214000343.a3b49deb2f0455568b371d0e@kernel.org>
In-Reply-To: <20200213202454.f1bb0e65ccc429bde039111b@kernel.org>
References: <20200207150809.19329-1-salyzyn@android.com>
        <20200207155828.GB122530@mit.edu>
        <d35bacd4-ba3f-335d-85c4-57e87abd8e9a@android.com>
        <20200208004922.GE122530@mit.edu>
        <20200207195326.0344ef82@oasis.local.home>
        <20200213202454.f1bb0e65ccc429bde039111b@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 20:24:54 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > > My preference would be to pass in the random seed *not* on the
> > > command-line at all, but as a separate parameter which is passed to
> > > the bootloader, just as we pass in the device-tree, the initrd and the
> > > command-line as separate things.  The problem is that how we pass in
> > > extra boot parameters is architecture specific, and how we might do it
> > > for x86 is different than for arm64.  So yeah, it's a bit more
> > > inconvenient to do things that way; but I think it's also much
> > > cleaner.
> > 
> > Hmm, if the boot loader could add on to the bootconfig that Masami just
> > added, then it could add some "random" seed for each boot! The
> > bootconfig is just an appended file at the end of the initrd.
> 
> Yeah, it is easy to add bootconfig support to a bootloader. It can add
> a entropy number as "rng.seed=XXX" text after initrd image with size
> and checksum. That is architecutre independent way to pass such hidden
> parameter.
> (hidden key must be filtered out when printing out the /proc/bootconfig,
> but that is very easy too, just need a strncmp)
> 

And here is the patch to support "random.rng_seed = XXX" option by
bootconfig. Now you can focus on what you want to do. No need to
modify command line strings.

BTW, if you think you need to pass UTF-8 code as a data, I'm happy to
update the bootconfig to support it. Just for the safeness, I have
limited it by isprint() || isspace().

Thank you,

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
index c7f9584de2c8..0ae33bbbd338 100644
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
index 9955d75c0585..aace466c56ed 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -36,6 +36,9 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
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
index f95b014a5479..6c3f51bc76d5 100644
--- a/init/main.c
+++ b/init/main.c
@@ -776,6 +776,32 @@ void __init __weak arch_call_rest_init(void)
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
+		if (rng_seed)
+			credit_trusted_entropy_bits(strlen(rng_seed) * 6);
+	}
+	boot_init_stack_canary();
+}
+
 asmlinkage __visible void __init start_kernel(void)
 {
 	char *command_line;
@@ -887,18 +913,7 @@ asmlinkage __visible void __init start_kernel(void)
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
Masami Hiramatsu <mhiramat@kernel.org>
