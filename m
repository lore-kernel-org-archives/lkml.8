Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174DFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3FE32073A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="S3eFnG8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIAAXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 20:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgIAAXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 20:23:35 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059B0C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:35 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l1so6515108qvr.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3f6P4/29utvTQL2GbGI3HgjsLcJrX6x4YOwPd3tFDyY=;
        b=S3eFnG8+sorcBhvmcVFUYcSmbnqwDg9vhBuEha2PkLKLFW5zy/aB6SWb/NhARC7GXp
         k6lJ5Uj8PRWOv4JOJl+GgLzkK/51RCneo95Xn8dfpjwOxpCIGpGHQbxx/ZGVZ0t/QRnj
         +eVFUjnnmHG83H7zZfea6xjU+0tragsHllMhnfX3jieYZZWFvKsWIzrFyUcgoZXhpI9a
         AMGlCpwxyZz6SE/BA6DB9dq7sTkrIzxlzPyaagWhIsq/FDYQNF0z3HOWZ6DDd2fY3hLG
         XDrreheevwfuYtIJtYE/SqtVTg5Bz+XCQ1iYsLVhN5o0fejGapWtdhFjS2V63kYDGBHt
         7Ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3f6P4/29utvTQL2GbGI3HgjsLcJrX6x4YOwPd3tFDyY=;
        b=FPmskzk6VPE/Zyx0GBY3IGOWeVk3+TkgyGgJTqN4HzhcECm8U6Vh5DifPztjfxxzKw
         IbUuT2iLMO3O6Al3OobcF8W/gtj2M8rJ+yaiSbCLfYvb8deCyn48nK+0riMOBhw1mX81
         +w9v5j+SH8uUy1o8AplXz57dpxEo3navhmRIhlW5MozZWT64pCX8eLwcRpzqm8Xyuldv
         V7/EAzFdYmH7e/wROyVnx8C3no2lTo4GopJ6YUPudDAsng8373koa2raHSiZ4RQ8NeXa
         KeLHwQn56/VssemaY7PnJNqVjV+FgD4ySr0qTWG/cdR6Aq12bCBsMINLTvvnwSI4cSHk
         0LqA==
X-Gm-Message-State: AOAM532psUYb1QbptjWjnIqQyFdWK+fa0a5d+KsFDdANqm0UO4aTuIX/
        +N4FxQDsBBqu8g7UNtbs9KL5NYbECR5dbNvanpk=
X-Google-Smtp-Source: ABdhPJwg2KrlBwEav1UpLXshbbRbiBLX1pkO+xoWxbV6hLzpr9JwUIqGxhGz2r+p5O50tia9KN1uigzuw1N3gQxt+Cw=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:b89b:: with SMTP id
 y27mr3706168qvf.215.1598919813459; Mon, 31 Aug 2020 17:23:33 -0700 (PDT)
Date:   Mon, 31 Aug 2020 17:23:20 -0700
In-Reply-To: <20200901002326.1137289-1-ndesaulniers@google.com>
Message-Id: <20200901002326.1137289-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200901002326.1137289-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v2 1/7] compiler-clang: add build check for clang 10.0.1
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

Link: https://github.com/ClangBuiltLinux/linux/issues/9
Link: https://github.com/ClangBuiltLinux/linux/issues/941
Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Acked-by: Marco Elver <elver@google.com>
Acked-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1 -> V2:
* use a more informational error, as per Kees.
* collect tags.

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

