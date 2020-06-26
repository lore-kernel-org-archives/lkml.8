Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809E7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61AE520B80
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FaG6BPJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgFZVJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgFZVJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:09:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F56C03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s9so11128856ybj.18
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0yqonjfzX9QxirGgFehpVVIaduO9UwtK5AmrI3GZ6yQ=;
        b=FaG6BPJOXqjkyKLdRnfSYXHm4L0jMa167g8811Lc7KLLlCTrzx/EQhd2p1zEmN8PgZ
         eB/39SbjyqN9BS8uPjwCNk7B5FsKAFwGTf1tuQeTrrcWg0NmPDwVVJs2OdysNF250ny5
         VYaIvUovIyhI0P7CGnSMLOC4oR5g5U3C2mMCTEaBeRjRz4nSG9vfnZlX1rK6IaoepxUC
         OETugj/DQlGSwMOcs9b8H9dJLwc6Tt/4GycvP67g10bX3dUOb3wTDg7Yur+2thuv7XMd
         8zfhI3HS7mzzji3B8LIE8DyWvvEPyzQNBqzsZvR7kNzhDpKtRNvWLOtXRNexo7z4c1j/
         ay6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0yqonjfzX9QxirGgFehpVVIaduO9UwtK5AmrI3GZ6yQ=;
        b=aFtGKBmu91Ka2ABMLNzZaSZOL7aqif8uBLqPUJAMUu9YqP2JTaHa+V34EHutKNcl2L
         cYC3Ew//iMEajkqLCCLUNYTHRaXIJfEuuf3jPm3nD7GDhf/5pVQCadTNiVxd9rzNjsK8
         SSPcPimlN3oXBxAlpB73AgYIBZLet5CautIFcbEUsqFfOE8UvxMejcIAr8LhEYUfSZhW
         4bLEgQkQusz0BtptMNjpRKS0eXe92kccvB9zyHG5ZMUeR1ZuYoN6NMYEMomqOE6+xEcT
         iSBLtIZ3r7etGlS67eTqJMSw0OA0Zwoz15jt7OVAJmeIdV6jWPoM8GtdzoJ7kzZVml61
         lSfw==
X-Gm-Message-State: AOAM532mdjl3KYYNNerfGN/3rDOqhQazgKrBt6DN92i6Ezs/P3nvTMM/
        0K9mUDs8zBeVrPEN1dSU9lBF7vPZOlTlSEVR0SJXaw==
X-Google-Smtp-Source: ABdhPJxVflv3SCvp9JwoHo/UGnaxlb8CfXLJfB6dEMmcpSpa5wRtOC4xX2AOsngFm6ZmdW4ISlhdBDuYipqi7x98m3Pohg==
X-Received: by 2002:a25:e8b:: with SMTP id 133mr8080620ybo.13.1593205778812;
 Fri, 26 Jun 2020 14:09:38 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:13 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 08/12] init: main: add KUnit to kernel init
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove KUnit from init calls entirely, instead call directly from
kernel_init().

Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/kunit/test.h | 9 +++++++++
 init/main.c          | 4 ++++
 lib/kunit/executor.c | 4 +---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index f3e86c3953a2b..795039d9f1917 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -228,6 +228,15 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites);
 
 void __kunit_test_suites_exit(struct kunit_suite **suites);
 
+#if IS_BUILTIN(CONFIG_KUNIT)
+int kunit_run_all_tests(void);
+#else
+static inline int kunit_run_all_tests(void)
+{
+	return 0;
+}
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
+
 /**
  * kunit_test_suites() - used to register one or more &struct kunit_suite
  *			 with KUnit.
diff --git a/init/main.c b/init/main.c
index 0ead83e86b5aa..d3101d8874dea 100644
--- a/init/main.c
+++ b/init/main.c
@@ -106,6 +106,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/initcall.h>
 
+#include <kunit/test.h>
+
 static int kernel_init(void *);
 
 extern void init_IRQ(void);
@@ -1504,6 +1506,8 @@ static noinline void __init kernel_init_freeable(void)
 
 	do_basic_setup();
 
+	kunit_run_all_tests();
+
 	console_on_rootfs();
 
 	/*
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 7015e7328dce7..4aab7f70a88c3 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -11,7 +11,7 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
-static int kunit_run_all_tests(void)
+int kunit_run_all_tests(void)
 {
 	struct kunit_suite * const * const *suites;
 
@@ -23,6 +23,4 @@ static int kunit_run_all_tests(void)
 	return 0;
 }
 
-late_initcall(kunit_run_all_tests);
-
 #endif /* IS_BUILTIN(CONFIG_KUNIT) */
-- 
2.27.0.212.ge8ba1cc988-goog

