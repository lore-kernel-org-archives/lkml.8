Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B63C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88B92072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oRMDaAXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389557AbgFXGyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389362AbgFXGyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:54:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC53C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:54:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so936543pge.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ywxv9OwnLOQvjhOVa6aBFsjba1STIoK1SGOYCmSlb0A=;
        b=oRMDaAXfoorMUjr1vNElAczDKwqw4GDulKqfDLEym5vAu19kOMj7aRceNQYFVlH/OR
         mdR07rvIilO5gBxD7o5FoaOdUtwOjOyaVpancJ2ZIzfMEWfJ7AGELXUXm7EC0f10V2Z0
         m9O7ivrlFq0QWK8FgrzW9kJOzGN3x0tczFJvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ywxv9OwnLOQvjhOVa6aBFsjba1STIoK1SGOYCmSlb0A=;
        b=GPEtR/RYMPxrU2BgEvalG2OwPvLSG8OfydTrjq4CoeTIk0pxrib/XR0Z/0+pouKfQU
         7C62Es3BVQyA1O6WNQE1DbskNabrM6YpmaX1TlIP1FPRKvSRcEO1Iq1H9IsxetsPxScW
         cE6phgpyF3q1IKkjU7rrSk42UuZS6L8d2RJBHCylNlAOKIXmn4Y5tIvV6NIEn7Bx+WeF
         qJXM72ghGIwtEKnyY2qjb3dLwdW86UdwRq2ZvvdyEozUNdX8qACT6EaWrtOsKPgWAJp1
         4mZcxWjkXlRfEug/Dr3YwgW/d97d2bFeHB4KNpeJnI+TnVfkBUWnnAuS9ACQQG9gqnay
         63Mw==
X-Gm-Message-State: AOAM531tFZNKGyXX4AOP1Ofcev6w+yju24npK6pFF90EnKn//o6ZzNgz
        mkQpn1jyPevOJMfFcpSbW2W2gw==
X-Google-Smtp-Source: ABdhPJwcV7hh6quZB851yan/y+oLpH+J3ljFFQP22NERN7czcdXI6Y0N970V6T0YnCzDfzktG7w7aw==
X-Received: by 2002:a65:6846:: with SMTP id q6mr19228615pgt.397.1592981692914;
        Tue, 23 Jun 2020 23:54:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y4sm2307364pfn.28.2020.06.23.23.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 23:54:51 -0700 (PDT)
Date:   Tue, 23 Jun 2020 23:54:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v3 07/10] x86/boot/compressed: change definition of STATIC
Message-ID: <202006232159.F3B4A4F4@keescook>
References: <20200623172327.5701-1-kristen@linux.intel.com>
 <20200623172327.5701-8-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623172327.5701-8-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:23:24AM -0700, Kristen Carlson Accardi wrote:
> In preparation for changes to the upcoming fgkaslr commit, change misc.c
> to not define STATIC as static, but instead set STATIC to "". This allows
> memptr to become accessible to multiple files.

Thanks for splitting this out!

After looking at the results, I think I finally understand the issue
getting solved. tl;dr: I think your patch isn't the right solution
(basically making "malloc_ptr" a global so that multiple static copies
of malloc() all behave the same). I think the right solution is to avoid
the multiple copies of malloc()/free().

I think this patch should be used instead:


Subject: [PATCH] x86/boot/compressed: Avoid duplicate malloc() implementations

The preboot malloc() (and free()) implementation in
include/linux/decompress/mm.h (which is also included by the
static decompressors) is static. This is fine when the only thing
interested in using malloc() is the decompression code, but the
x86 preboot environment uses malloc() in a couple places, leading to a
potential collision when the static copies of the available memory
region ("malloc_ptr") gets reset to the global "free_mem_ptr" value.
As it happens, the existing usage pattern happened to be safe because each
user did 1 malloc() and 1 free() before returning and were not nested:

extract_kernel() (misc.c)
	choose_random_location() (kaslr.c)
		mem_avoid_init()
			handle_mem_options()
				malloc()
				...
				free()
	...
	parse_elf() (misc.c)
		malloc()
		...
		free()

Adding FGKASLR, however, will insert additional malloc() calls local to
fgkaslr.c in the middle of parse_elf()'s malloc()/free() pair:

	parse_elf() (misc.c)
		malloc()
		if (...) {
			layout_randomized_image(output, &ehdr, phdrs);
				malloc() <- boom
				...
		else
			layout_image(output, &ehdr, phdrs);
		free()

To avoid collisions, there must be a single implementation of malloc().
Adjust include/linux/decompress/mm.h so that visibility can be
controlled, provide prototypes in misc.h, and implement the functions in
misc.c. This also results in a small size savings:

$ size vmlinux.before vmlinux.after
   text    data     bss     dec     hex filename
8842314     468  178320 9021102  89a6ae vmlinux.before
8842240     468  178320 9021028  89a664 vmlinux.after

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/kaslr.c |    4 ----
 arch/x86/boot/compressed/misc.c  |    3 +++
 arch/x86/boot/compressed/misc.h  |    2 ++
 include/linux/decompress/mm.h    |   12 ++++++++++--
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 7667415417dc..ae6691e8bb08 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -44,12 +44,12 @@ void *memmove(void *dest, const void *src, size_t n);
  */
 struct boot_params *boot_params;
 
+/* Initial heap area used to initialize malloc()/free() internals.*/
 memptr free_mem_ptr;
 memptr free_mem_end_ptr;
-#ifdef CONFIG_FG_KASLR
+/* Global internals for malloc()/free() implementations. */
 unsigned long malloc_ptr;
 int malloc_count;
-#endif
 
 static char *vidmem;
 static int vidport;
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 86a5f00b018f..45644056572b 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -36,15 +36,14 @@
 #define memptr unsigned
 #endif
 
-/* misc.c */
-extern memptr free_mem_ptr;
-extern memptr free_mem_end_ptr;
-#define STATIC
-#ifdef CONFIG_FG_KASLR
+/* malloc()/free() */
+#define STATIC static
 #define STATIC_RW_DATA extern
-#endif
 #include <linux/decompress/mm.h>
 
+/* misc.c */
+extern memptr free_mem_ptr;
+extern memptr free_mem_end_ptr;
 extern struct boot_params *boot_params;
 void __putstr(const char *s);
 void __puthex(unsigned long value);



However, after all that, I actually think the correct way to solve this
is actually to have only one implementation of malloc()/free(). i.e.
replace this patch with this:

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d7408af55738..6f596bd5b6e5 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -39,10 +39,6 @@
 #include <generated/utsrelease.h>
 #include <asm/efi.h>
 
-/* Macros used by the included decompressor code below. */
-#define STATIC
-#include <linux/decompress/mm.h>
-
 #ifdef CONFIG_X86_5LEVEL
 unsigned int __pgtable_l5_enabled;
 unsigned int pgdir_shift __ro_after_init = 39;
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 1c8b8aa5539f..f52150ec3ee7 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -28,6 +28,9 @@
 
 /* Macros used by the included decompressor code below. */
 #define STATIC		static
+/* Define an externally visible malloc()/free(). */
+#define MALLOC_VISIBLE
+#include <linux/decompress/mm.h>
 
 /*
  * Use normal definitions of mem*() from string.c. There are already
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 214ef31db468..fd0c63cfaa4a 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -39,6 +39,8 @@
 /* misc.c */
 extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
+extern void *malloc(int size);
+extern void free(void *where);
 extern struct boot_params *boot_params;
 void __putstr(const char *s);
 void __puthex(unsigned long value);
diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
index 868e9eacd69e..9192986b1a73 100644
--- a/include/linux/decompress/mm.h
+++ b/include/linux/decompress/mm.h
@@ -25,13 +25,21 @@
 #define STATIC_RW_DATA static
 #endif
 
+/*
+ * When an architecture needs to share the malloc()/free() implementation
+ * between compilation units, it needs to have non-local visibility.
+ */
+#ifndef MALLOC_VISIBLE
+#define MALLOC_VISIBLE static
+#endif
+
 /* A trivial malloc implementation, adapted from
  *  malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
  */
 STATIC_RW_DATA unsigned long malloc_ptr;
 STATIC_RW_DATA int malloc_count;
 
-static void *malloc(int size)
+MALLOC_VISIBLE void *malloc(int size)
 {
 	void *p;
 
@@ -52,7 +60,7 @@ static void *malloc(int size)
 	return p;
 }
 
-static void free(void *where)
+MALLOC_VISIBLE void free(void *where)
 {
 	malloc_count--;
 	if (!malloc_count)




-- 
Kees Cook
