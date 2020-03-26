Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8232C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5F32070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQByxbVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgCZM0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:26:06 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:46879 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgCZM0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:26:06 -0400
Received: by mail-qk1-f202.google.com with SMTP id a136so4598214qkc.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 05:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=O3ShDQrtiu8+pg3UlxnzbuJX0+OLY5w2L0aep49Ejc0=;
        b=MQByxbVlVJp4RopLJjrhk7Cl5OOK7Z+tE981XejY58sfAFufb6q/1G2a3BfPZGejnV
         umD5pTupvm7YF8SSgtRtm+hbn5I1XSPO39a2rKTFL3Udk3TGY9tq2XPYAdYHz9jC5gWv
         8Q7BFJNq7+Vhk+qxMkP2IaxqVqPoj2Jwmos8HOINzfnicBXv1G7X/IQBe4hjwPHM8s6k
         d3hbVLkcLut0rX3Rj/82jBPQ+qnGXw8neY9lMNW74/7lupmyalzA9rQ8jslqVEI5AfSR
         ssB2+oFXJFmnrDNYasZgdATjeHLU5wifQ1CU9uKHbjZ9xOBgqx2Vht9fGzgJRLaXJOfH
         DikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=O3ShDQrtiu8+pg3UlxnzbuJX0+OLY5w2L0aep49Ejc0=;
        b=ihcjjjDEOKDiTQrM2UAT5vTWUwFNkxXlkctb0BbYW67orTFvAxWID3vLsN4OrQHdX9
         szm5/0wWNVCSUto9PkxJgjOgQOKS687nSeJ1vzIt8Yx7T9jERX5bCgzO25pmMNPPKAYd
         l74VMVHlDoUyb/Rkk80lGwHNp9nzO11TMKUC4hWOWCEp65HWismuTZS9ObFp5t+uz2ki
         Dc/81bjpABmP0PiOKUpXWVFVZXNQDUvBauK354H7EBfXtsnvq4Sge3uGH/BsjKkAPqez
         dBq618OAg7J3mPWW+cCT6kr+K0KiCBC7gqgodCu1djqRKXJFZ3D7IbbnZMhc0YOoMqpn
         FK0g==
X-Gm-Message-State: ANhLgQ0JZF+485yGcd1xOdRrdaC6asX+sVubO78xqCK1uRVUklW2zGz/
        fMBYD2iKRZlUl28zzrKhmuUdXTzl5RJ4
X-Google-Smtp-Source: ADFU+vuM3EAedB+BfY4Wg6CbL2JJgBzDNbKT82s9N1sws3PTOvHzgmHXEdpXVZCAAofBknnbQLzuaxjn5lUs
X-Received: by 2002:ac8:6918:: with SMTP id e24mr7741961qtr.141.1585225563444;
 Thu, 26 Mar 2020 05:26:03 -0700 (PDT)
Date:   Thu, 26 Mar 2020 13:25:54 +0100
In-Reply-To: <20200323114207.222412-1-courbet@google.com>
Message-Id: <20200326122555.129831-1-courbet@google.com>
Mime-Version: 1.0
References: <20200323114207.222412-1-courbet@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v4]     x86: Alias memset to __builtin_memset.
From:   Clement Courbet <courbet@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        Clement Courbet <courbet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Recent compilers know the meaning of builtins (`memset`,
    `memcpy`, ...) and can replace calls by inline code when
    deemed better. For example, `memset(p, 0, 4)` will be lowered
    to a four-byte zero store.

    When using -ffreestanding (this is the case e.g. building on
    clang), these optimizations are disabled. This means that **all**
    memsets, including those with small, constant sizes, will result
    in an actual call to memset.

    We have identified several spots where we have high CPU usage
    because of this. For example, a single one of these memsets is
    responsible for about 0.3% of our total CPU usage in the kernel.

    Aliasing `memset` to `__builtin_memset` allows the compiler to
    perform this optimization even when -ffreestanding is used.
    There is no change when -ffreestanding is not used.

    Below is a diff (clang) for `update_sg_lb_stats()`, which
    includes the aforementionned hot memset:
        memset(sgs, 0, sizeof(*sgs));

    Diff:
        movq %rsi, %rbx        ~~~>  movq $0x0, 0x40(%r8)
        movq %rdi, %r15        ~~~>  movq $0x0, 0x38(%r8)
        movl $0x48, %edx       ~~~>  movq $0x0, 0x30(%r8)
        movq %r8, %rdi         ~~~>  movq $0x0, 0x28(%r8)
        xorl %esi, %esi        ~~~>  movq $0x0, 0x20(%r8)
        callq <memset>         ~~~>  movq $0x0, 0x18(%r8)
                               ~~~>  movq $0x0, 0x10(%r8)
                               ~~~>  movq $0x0, 0x8(%r8)
                               ~~~>  movq $0x0, (%r8)

    In terms of code size, this shrins the clang-built kernel a
    bit (-0.022%):
    440383608 vmlinux.clang.before
    440285512 vmlinux.clang.after

Signed-off-by: Clement Courbet <courbet@google.com>

---

changes in v2:
  - Removed ifdef(GNUC >= 4).
  - Disabled change when CONFIG_FORTIFY_SOURCE is set.

changes in v3:
  - Fixed commit message: the kernel shrinks in size.

changes in v4:
  - Properly parenthesize the macro.
---
 arch/x86/include/asm/string_64.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 75314c3dbe47..1bfa825e9ad3 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -18,6 +18,15 @@ extern void *__memcpy(void *to, const void *from, size_t len);
 void *memset(void *s, int c, size_t n);
 void *__memset(void *s, int c, size_t n);
 
+/* Recent compilers can generate much better code for known size and/or
+ * fill values, and will fallback on `memset` if they fail.
+ * We alias `memset` to `__builtin_memset` explicitly to inform the compiler to
+ * perform this optimization even when -ffreestanding is used.
+ */
+#if !defined(CONFIG_FORTIFY_SOURCE)
+#define memset(s, c, count) __builtin_memset((s), (c), (count))
+#endif
+
 #define __HAVE_ARCH_MEMSET16
 static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 {
@@ -74,6 +83,7 @@ int strcmp(const char *cs, const char *ct);
 #undef memcpy
 #define memcpy(dst, src, len) __memcpy(dst, src, len)
 #define memmove(dst, src, len) __memmove(dst, src, len)
+#undef memset
 #define memset(s, c, n) __memset(s, c, n)
 
 #ifndef __NO_FORTIFY
-- 
2.25.1.696.g5e7596f4ac-goog

