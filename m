Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06068C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8CB2073A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fVms6Qsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgIAAX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 20:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgIAAXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 20:23:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3245DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v11so11007051ybm.22
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pi3QdKLaSBYHipbQP2OJPwq0eZQkVdLTCOuN85yE044=;
        b=fVms6QscBRH8AiO1MkY49J0TtfW/piuC7bAqq4WXgy4nhYFWpBjrWCW3jlyADzHlII
         EWF93Ip2um7u+Z3o6U07VnkA7xaVMbV1rn47phivCjFf3IhtRQ5gwnj7ImJ5Z+UzfZNe
         MSAtMqIzV34lb1IdxlcRDwvUsGfCeH+cSRzWZRrwChtsAnYTi5lo2EK8/yAVsxuwNaJW
         YtZg8fcjQUJPdbjq8xZuQ+C+0de1s+M0R9BvP/5CrQI6bGuYzALMRs5oAlDVeWAPqzc5
         1ygwMdWTfLc5629S8itJgIgwEM1D/xHNs8vB+osjVov/OeTblBLjVhqJOl9iqLmAzV8E
         E9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pi3QdKLaSBYHipbQP2OJPwq0eZQkVdLTCOuN85yE044=;
        b=hTUw0Es7STH+cDKwcVhthsfT4300EMhLnLGCxufpfNZmYAakWxKjlhRY2G6/2BRASd
         28I2w6MFS1Nu3suWbIoifCcZHXVJxw9C4viU3jlWZyQm4xw48yHq1FJz1+klLP07NekR
         BcCkE8pbNyJL0Jeah1YGXoLtcablIEKIb+jengJex+xRkG/cteFn8yTvI8SHrdHe6ehr
         ctIyxcN+Pxo7K33i36UnynQZRJV3xyYAAXY0Lu+Io84R7owUjSPB9/wzeOEyST/JzZqH
         iHYYb/NSmcoJbE2ulItOvWK7PJxFjcSRJfJ41fuKluLodTBEr5YcrzeT7xc5jkUurDRF
         EWzA==
X-Gm-Message-State: AOAM53186Z4ZnKumJLVQSfO80hCi4N2TuQKO6eFNU1UFgtfRZNmCEiGb
        OufMQmXc0A+BIb+fzwbmAhXfD3GQiEXuvywqkuc=
X-Google-Smtp-Source: ABdhPJy8QDFsrATttaFvj4/7adWYxIH3879dKnZf971t/EmVLxTguOBUGskoTzF3i4hz++IAHJLBV8I/KYlnICy1Olk=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:1025:: with SMTP id
 x5mr6385851ybt.58.1598919819398; Mon, 31 Aug 2020 17:23:39 -0700 (PDT)
Date:   Mon, 31 Aug 2020 17:23:23 -0700
In-Reply-To: <20200901002326.1137289-1-ndesaulniers@google.com>
Message-Id: <20200901002326.1137289-5-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200901002326.1137289-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v2 4/7] Revert "arm64: vdso: Fix compilation with clang older
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

