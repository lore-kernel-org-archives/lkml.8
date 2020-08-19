Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C48C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC1820882
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqgI8CJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgHSTRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgHSTRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:17:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F92C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:17:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w11so26839131ybi.23
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/urKDqIkN4zGAhl6LxHMUbH10s5ZvVFc504ba3S5u7E=;
        b=RqgI8CJyXmWUn6Vo8lcLGmL7Sryn+W/FkZ33sxWqlgyz8meu39k4+6oomx7QFIBp3x
         Gg+82ihdMho3l7JJ+S2CfjEP3vQubdhyeoQjj85loSSZleZOVl/jOK3cGE8XEH01Ej2N
         AbQ/Vy7C7JnBDZKmbQ+iklaXV4MNxz3nqNMJxtOowSWnBqpDLp9YXD8p4zPXjqRgGid9
         DF9aV54NmI8wKPj4ZWIE4q6Hj/KIDGSRh80b9cn08g+O8nK8QAGEuQ1iYxBDUmPybqOx
         5zO6eUDXW1sIoB9BFjqIqf3ncr2pKUn9kYElgbeTJbWgIVBEyg7Xn7mdJSFdCsmpBLdU
         DioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/urKDqIkN4zGAhl6LxHMUbH10s5ZvVFc504ba3S5u7E=;
        b=OIGyrb63RCfDt3k+SqvizN94nLw1b1d7+ZhY9fGddu3lrXx4yt6XtC7Dnpf2dK1Ako
         py36mmhHmDyWJOdXgz+Ar4T48npZeFuTBRRtfm6yLIytag6DHGfMUIpjVsTXng4kR9/7
         ncVPDKyZRvp4EDCz2S71re2qz7UuCRnZvX6djNga1owKQWNdEB7ATQoc7CoyVQzdWPAk
         /B+lI3fXruaEfF6kSz33QTZ7DNDqq7ANZk2hMgDDiCJDyUKxCk2HsdyWkJxNF3m9X9vT
         nc0h2ykz1i6PRZNAP3v2D94vr1V60/t77iuw6sExZC+pkXg4AWK+GKYU2Gl7DYMAw+si
         m5ww==
X-Gm-Message-State: AOAM532HRCAR7vkZc4Iuf4y5WgqrDNZWC80nQ70+BtldQIT+TCE6Y8LL
        QRLox7yzMzA/PUiFcYNL+phRLQ3mPhMlI4b63W0=
X-Google-Smtp-Source: ABdhPJxkKEkPVTHl269NKfdD2vrGr8Zp3w5z/UJIqWfoTv/OqXKdyliMdkTMwO8mqpQXuu+Uw3MDyewftRdnreJ7fJE=
X-Received: by 2002:a25:c2c7:: with SMTP id s190mr34810966ybf.161.1597864642671;
 Wed, 19 Aug 2020 12:17:22 -0700 (PDT)
Date:   Wed, 19 Aug 2020 12:16:53 -0700
In-Reply-To: <20200819191654.1130563-1-ndesaulniers@google.com>
Message-Id: <20200819191654.1130563-5-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200819191654.1130563-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v2 4/5] x86/boot: use -fno-builtin-bcmp
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Andi Kleen <ak@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "=?UTF-8?q?D=C3=A1vid=20Bolvansk=C3=BD?=" <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're reverting
commit 5f074f3e192f ("lib/string.c: implement a basic bcmp")
in favor of -fno-builtin-bcmp. Remove the additional definition here,
too.

arch/x86/purgatory/Makefile uses -ffreestanding, so there's no risk of
this libcall optimization occurring for arch/x86/boot/purgatory.ro.

arch/x86/boot/Makefile resets KBUILD_CFLAGS, so make sure to reset this
flag that was set for the top level Makefile.

Fixes: 4ce97317f41d ("x86/purgatory: Do not use __builtin_memcpy and __builtin_memset")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/boot/Makefile | 1 +
 arch/x86/boot/string.c | 8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index fe605205b4ce..ef7f15bfceab 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -70,6 +70,7 @@ KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
+KBUILD_CFLAGS	+= -fno-builtin-bcmp
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 
diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 8a3fff9128bb..23d91aa7691e 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -37,14 +37,6 @@ int memcmp(const void *s1, const void *s2, size_t len)
 	return diff;
 }
 
-/*
- * Clang may lower `memcmp == 0` to `bcmp == 0`.
- */
-int bcmp(const void *s1, const void *s2, size_t len)
-{
-	return memcmp(s1, s2, len);
-}
-
 int strcmp(const char *str1, const char *str2)
 {
 	const unsigned char *s1 = (const unsigned char *)str1;
-- 
2.28.0.297.g1956fa8f8d-goog

