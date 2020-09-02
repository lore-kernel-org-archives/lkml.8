Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64EAC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 22:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9007620767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 22:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LywCHlL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgIBW7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBW7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 18:59:23 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D33FC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 15:59:23 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id p20so763992qvl.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DEB6TvuVII/idft8ojQbZbBbLRj/1UgvcgJGiXc75DA=;
        b=LywCHlL4O+6VwnFigc/9CULmKPvOxHgK8BrhVH1f5ogLcujoakUmDuTrNs9OZ6N+SD
         h7E5Xk2GRr7a5bcVmRtDkBZDcTB5AkYIdpIbZtqaYWeszbAcypKwa2i0VDbbYX327Gzf
         PY7BmAsuU0/mT+YVDZCX7IoiMNyre9s/CkXo1PkHlrRTpIBc6ZPrk6EI5z8NSGmza4VJ
         4JlqRHC4yA5dqNEAV5Zr9wLP1Nw50rRgTPx9+fN5dPfxJmYG23gab5qlMifc3ZVfBxwD
         zBJ3Zn1/20hnoEJ+Mn6inXjv9Dofrl5E9hC631YE8jpARM0nJuvgEuXU57dCAfYNDwSF
         G5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DEB6TvuVII/idft8ojQbZbBbLRj/1UgvcgJGiXc75DA=;
        b=c07+Mswas5YhU3O6/8zm1mpCbPYH76hTF+A5U5WHsNWZFmGT0n16Xvn1d2qoG06Kf7
         9KCTkK0pqM1+KOjYVuBgsKeuh7h8VvgO5C1HS2zKsF8uWz4vPmyDEK3Ce48q+UGr6TLc
         SCXKiMivxBC/MRWZXpn9lMuJOS0FcUAHz51qngvadAwWBhNk1x7jjU06sfytE+ivxayL
         UCq1xc9RUSyNQFBAGAFYALAIZT9Z8PWctAYYTGjt7/ENftPzXnSpUsz8xEcdVwDJbaAs
         5vil9hZQw67z3aQvVbuCg4JXa4xqGQDvznWWlNh6Vqyk2gQRko+vIYxWRqdyJhhDDnvC
         9D/Q==
X-Gm-Message-State: AOAM532EIvJTiJqHaRfd/nBWfXTZuoMzRl97eo0E/XmEEDboblFGh5Ey
        K78rPg4O96KYKEZ45ixso6rN9Lm0u77mZB87JS8=
X-Google-Smtp-Source: ABdhPJzXdwfL/Ab/m1JDmQHIJPs7f0xUTVMOsOO5/Y/GVHSp7Nn75c2TGyacSDW5eFv7gNGGQWiff3uCFBgeOtKV+nA=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:c98d:: with SMTP id
 b13mr761758qvk.1.1599087562611; Wed, 02 Sep 2020 15:59:22 -0700 (PDT)
Date:   Wed,  2 Sep 2020 15:59:05 -0700
In-Reply-To: <20200902225911.209899-1-ndesaulniers@google.com>
Message-Id: <20200902225911.209899-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200902225911.209899-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v3 1/7] compiler-clang: add build check for clang 10.0.1
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

During Plumbers 2020, we voted to just support the latest release of
Clang for now.  Add a compile time check for this.

We plan to remove workarounds for older versions now, which will break
in subtle and not so subtle ways.

Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
Acked-by: Marco Elver <elver@google.com>
Acked-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Sedat Dilek <sedat.dilek@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/9
Link: https://github.com/ClangBuiltLinux/linux/issues/941
---
 include/linux/compiler-clang.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index cee0c728d39a..230604e7f057 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -3,6 +3,14 @@
 #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
 #endif
 
+#define CLANG_VERSION (__clang_major__ * 10000	\
+		     + __clang_minor__ * 100	\
+		     + __clang_patchlevel__)
+
+#if CLANG_VERSION < 100001
+# error Sorry, your version of Clang is too old - please use 10.0.1 or newer.
+#endif
+
 /* Compiler specific definitions for Clang compiler */
 
 /* same as gcc, this was present in clang-2.6 so we can assume it works
-- 
2.28.0.402.g5ffc5be6b7-goog

