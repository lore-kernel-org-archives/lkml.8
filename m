Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6652AC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 22:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4094720767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 22:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="oRJCPHR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgIBW7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgIBW7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 18:59:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140C1C061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 15:59:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o16so855848ybe.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PPIXCdBjPq849SuXr2dSY3KoCU2uhT3WxtZeuCs0Kz8=;
        b=oRJCPHR4hnsQL36+qRypzxIAaHy4MNX3lEMfWZaEgOeAFUTWj9lXSumVjB22KHIHdK
         wP+o1c7foQaClx9qq/+ZwtIsGOSE9tia5XhQXb3NXQnifpWGsGqDJi7WngARSS9prm0T
         lJea5n2TrpqflGlJvcPES7p42EcVubu7uMmpSa9IGQb/lbMKblhVmFjySa8GiqOZwn0o
         ZCokdSuNCgrhoG36JVIw9XqTpXgg80AYxlhh+cbTpFbluRV1P6QoLSc4zfhQHGs57z3M
         yDThxVzejAkE+GM0RRxADyyAVPFjpaYLFp6CFlF8/mLJszABIiutsn8pHkwvp1ZYeDhW
         LVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PPIXCdBjPq849SuXr2dSY3KoCU2uhT3WxtZeuCs0Kz8=;
        b=PgWA8FnAc4u4Xjh0cTcrqOfJg15RZ9B1zMsIfNUAJfO9AV3TrxRp6kYCMYcNjZghw6
         /mfNxJFkDPHOqFKIKPZew+hYj/wvmIHiVQubW8F6u793FI94779fs8snLEIbC8xlDxxv
         vbiLNYyyMEOdXS+XdZQ7YJFBQoAEp1gMNyWai9yA2W28ZnEsJveUAcGGMByI1UnMGGEt
         rvq8SbAFr7x7kabis8ReDEtBfSkBxd9aYnP1jyqmNYre8GK7eqRQUODIveCvbl3i3G29
         Hif3NpGM8rkpO61Qb2Z2YeZX/YFTd+5p2I7a2valSqcM88t0tE30y18WR6LwP8fZRP1W
         wnbw==
X-Gm-Message-State: AOAM530X1qF3TyYfRmFyDNagv22rpHfWo5qpk9fEETT10biPO9I0a/5r
        MJMPHT9oQk157dDfiVs2NFJcVvaZB+cNGebRK7s=
X-Google-Smtp-Source: ABdhPJyAu8IjWSqA9FS4h8zzh6r99B/xh5QEh6Q59mFsVeNienQyjDkXJCELGBC3IjEYlgADLjirc51CrBcO3ByTTtk=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:80d1:: with SMTP id
 c17mr4398880ybm.377.1599087568559; Wed, 02 Sep 2020 15:59:28 -0700 (PDT)
Date:   Wed,  2 Sep 2020 15:59:08 -0700
In-Reply-To: <20200902225911.209899-1-ndesaulniers@google.com>
Message-Id: <20200902225911.209899-5-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200902225911.209899-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v3 4/7] Revert "arm64: vdso: Fix compilation with clang older
 than 8"
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3acf4be235280f14d838581a750532219d67facc.

The minimum supported version of clang is clang 10.0.1.

Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm64/kernel/vdso/Makefile | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 45d5cfe46429..04021a93171c 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -43,13 +43,6 @@ ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
 endif
 
-# Clang versions less than 8 do not support -mcmodel=tiny
-ifeq ($(CONFIG_CC_IS_CLANG), y)
-  ifeq ($(shell test $(CONFIG_CLANG_VERSION) -lt 80000; echo $$?),0)
-    CFLAGS_REMOVE_vgettimeofday.o += -mcmodel=tiny
-  endif
-endif
-
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
-- 
2.28.0.402.g5ffc5be6b7-goog

