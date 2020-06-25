Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB1BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F27C420791
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P+XqKwc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407188AbgFYUhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407178AbgFYUhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:37:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAC7C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:37:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d194so498427pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BfbOYxKLeIPqE6ZPzW8hgon31KuqJHQqU6xvmcaKi7A=;
        b=P+XqKwc+b/59wUthhc09B6vtmxG5CXTL/uoQtqWWUdzNLEnOz5dLYJovrHWXz7laXS
         IKf1ZHNwwzSvC9TofFThIw/u0MTl26+Bz6PoFAJrY2NlRgcSAOR6dG+dw4NdWor+ZZz5
         iPnPkSW3TRGLBFIo9fEYhaMM8QGTOZOdJzs+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BfbOYxKLeIPqE6ZPzW8hgon31KuqJHQqU6xvmcaKi7A=;
        b=EOiphhDRJCP7UwPSKuqWVlA/cuNq+CWwuhA0sgMpMHNnZeKqHFOK+Ob7ANZBUF0e+A
         w4wBcG1pVFwnosbeAF5pkrvZv7cTqHipu07+zz7G/PJRO1p7VCwiQoFIBJ6ixL2FOAha
         9YpW2Ln7zRCjQFG74obo/4nJX540zCmK6+ECDplTurLW/tmPzP/Mcl579Yv6B92ahwjs
         EZjqiS6qZzNCQ3eWX4YzUvfiUyDc5laWvt9od3KlFxUc2v7IKEFzuTcKWk+PB6tcOVJb
         hytB6ycqW5WgPlhwGjsamiMa09KAAMgj+mkRKbcFxDnsvZ1RQdUZCo7iOd+kR+bNvFNB
         C/7w==
X-Gm-Message-State: AOAM530D1IF9ndtcXow58douXExCiQwQBquiiEe0YGkCRbrCVZWQix+4
        7S0wQk5RA7O5nFR6xtKUznegHg==
X-Google-Smtp-Source: ABdhPJzIsRSzWksqfzO2CgtSoh+UMwMb6lOLLAlaJ+X4NJEUDDhQjf2qivW77bipnhkgdfXM8HCGjw==
X-Received: by 2002:a63:7246:: with SMTP id c6mr27896788pgn.422.1593117430937;
        Thu, 25 Jun 2020 13:37:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y12sm24064569pfm.158.2020.06.25.13.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:37:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH drivers/misc v2 4/4] lkdtm: Make arch-specific tests always available
Date:   Thu, 25 Jun 2020 13:37:04 -0700
Message-Id: <20200625203704.317097-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625203704.317097-1-keescook@chromium.org>
References: <20200625203704.317097-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like arch-specific tests to XFAIL when on a mismatched architecture
so that we can more easily compare test coverage across all systems.
Lacking kernel configs or CPU features count as a FAIL, not an XFAIL.

Additionally fixes a build failure under 32-bit UML.

Fixes: b09511c253e5 ("lkdtm: Add a DOUBLE_FAULT crash type on x86")
Fixes: cea23efb4de2 ("lkdtm/bugs: Make double-fault test always available")
Fixes: 6cb6982f42cb ("lkdtm: arm64: test kernel pointer authentication")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c               | 38 ++++++++++++++-----------
 drivers/misc/lkdtm/lkdtm.h              |  2 --
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 08c70281c380..10338800f6be 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -13,7 +13,7 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
-#ifdef CONFIG_X86_32
+#if IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_UML)
 #include <asm/desc.h>
 #endif
 
@@ -418,7 +418,7 @@ void lkdtm_UNSET_SMEP(void)
 
 void lkdtm_DOUBLE_FAULT(void)
 {
-#ifdef CONFIG_X86_32
+#if IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_UML)
 	/*
 	 * Trigger #DF by setting the stack limit to zero.  This clobbers
 	 * a GDT TLS slot, which is okay because the current task will die
@@ -453,38 +453,42 @@ void lkdtm_DOUBLE_FAULT(void)
 #endif
 }
 
-#ifdef CONFIG_ARM64_PTR_AUTH
+#ifdef CONFIG_ARM64
 static noinline void change_pac_parameters(void)
 {
-	/* Reset the keys of current task */
-	ptrauth_thread_init_kernel(current);
-	ptrauth_thread_switch_kernel(current);
+	if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH)) {
+		/* Reset the keys of current task */
+		ptrauth_thread_init_kernel(current);
+		ptrauth_thread_switch_kernel(current);
+	}
 }
+#endif
 
-#define CORRUPT_PAC_ITERATE	10
 noinline void lkdtm_CORRUPT_PAC(void)
 {
+#ifdef CONFIG_ARM64
+#define CORRUPT_PAC_ITERATE	10
 	int i;
 
+	if (!IS_ENABLED(CONFIG_ARM64_PTR_AUTH))
+		pr_err("FAIL: kernel not built with CONFIG_ARM64_PTR_AUTH\n");
+
 	if (!system_supports_address_auth()) {
-		pr_err("FAIL: arm64 pointer authentication feature not present\n");
+		pr_err("FAIL: CPU lacks pointer authentication feature\n");
 		return;
 	}
 
-	pr_info("Change the PAC parameters to force function return failure\n");
+	pr_info("changing PAC parameters to force function return failure...\n");
 	/*
-	 * Pac is a hash value computed from input keys, return address and
+	 * PAC is a hash value computed from input keys, return address and
 	 * stack pointer. As pac has fewer bits so there is a chance of
 	 * collision, so iterate few times to reduce the collision probability.
 	 */
 	for (i = 0; i < CORRUPT_PAC_ITERATE; i++)
 		change_pac_parameters();
 
-	pr_err("FAIL: %s test failed. Kernel may be unstable from here\n", __func__);
-}
-#else /* !CONFIG_ARM64_PTR_AUTH */
-noinline void lkdtm_CORRUPT_PAC(void)
-{
-	pr_err("FAIL: arm64 pointer authentication config disabled\n");
-}
+	pr_err("FAIL: survived PAC changes! Kernel may be unstable from here\n");
+#else
+	pr_err("XFAIL: this test is arm64-only\n");
 #endif
+}
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 601a2156a0d4..8878538b2c13 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -31,9 +31,7 @@ void lkdtm_CORRUPT_USER_DS(void);
 void lkdtm_STACK_GUARD_PAGE_LEADING(void);
 void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
 void lkdtm_UNSET_SMEP(void);
-#ifdef CONFIG_X86_32
 void lkdtm_DOUBLE_FAULT(void);
-#endif
 void lkdtm_CORRUPT_PAC(void);
 
 /* lkdtm_heap.c */
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 92ca32143ae5..9d266e79c6a2 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -14,6 +14,7 @@ STACK_GUARD_PAGE_LEADING
 STACK_GUARD_PAGE_TRAILING
 UNSET_SMEP CR4 bits went missing
 DOUBLE_FAULT
+CORRUPT_PAC
 UNALIGNED_LOAD_STORE_WRITE
 #OVERWRITE_ALLOCATION Corrupts memory on failure
 #WRITE_AFTER_FREE Corrupts memory on failure
-- 
2.25.1

