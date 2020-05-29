Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73669C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50693207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WExBOCKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgE2UEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbgE2UD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:03:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6814C0A88B4
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:03:58 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f21so423735pgg.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ur0tRoXDFgucIHCcDSOWNJgdTr4CPZcipEuAfudLDPs=;
        b=WExBOCKa/51JjvlYoHp9ASlcwtLNRpRKa8pS+Z8PisY4y16S1bwkNPZvmaFrXQ2XZx
         ejqQJS1fBSF7ohENJ1qHiiqpyj1YrhivQLx1DRdFbyeoT5TH4Cja0qj3rKU+T4QWFDKa
         WooH8sPPQLfkbzjb0NOudXvhGaXEPmZaQA4tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ur0tRoXDFgucIHCcDSOWNJgdTr4CPZcipEuAfudLDPs=;
        b=LaKpU+BAQWZ9/FGw6pyQP5SbupLGUyR+eFWf8BAp+jtK/HZUVDieO3Vlg7jtY0oNWg
         KMpyZDl5qHPWF+Bw+LoEY8K+Fm5NqiqjDVWV4K0cDEyKixQjmDMZdizA653YKYXvR8G7
         FOVezssbLVCq1JhABDWJohPaA1J7rLuOstweWX7AdmTZYdkyfSjE1G01U/UK/mBekZdi
         JzXB7LOifT7L16hz3s1qG9zbJi/qz/uRjK/W2PJrJbyOEezS/lSefFsHzgOVizOjga8v
         P31NiffT+iTiCAbskHZc28j/ueat+6nzs/KSZhXG4liTXyB0mnMYdrqw4lHJpNNmPtnC
         mkaw==
X-Gm-Message-State: AOAM53348yZRFi9sMOrdIHJPL8pR0wx6MofUIxG4AiwjIxaFgDgZBqo0
        VpSA6755WKRQ4T0al1IINVwq+A==
X-Google-Smtp-Source: ABdhPJycncKsGEo8qJO+uytPUmbryktBpqNRcCiN+8goKytec/Tpui9cWq+9vCo2nCvXAd8MEj2XKQ==
X-Received: by 2002:aa7:84da:: with SMTP id x26mr10167890pfn.24.1590782638413;
        Fri, 29 May 2020 13:03:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k11sm1110168pgq.10.2020.05.29.13.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 13:03:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] lkdtm: Make arch-specific tests always available
Date:   Fri, 29 May 2020 13:03:47 -0700
Message-Id: <20200529200347.2464284-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200529200347.2464284-1-keescook@chromium.org>
References: <20200529200347.2464284-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like arch-specific tests to XFAIL when on a mismatched architecture
so that we can more easily compare test coverage across all systems.
Lacking kernel configs or CPU features count as a FAIL, not an XFAIL.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c               | 34 ++++++++++++++-----------
 drivers/misc/lkdtm/lkdtm.h              |  2 --
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index e1b43f615549..f3fde0759f2c 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
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

