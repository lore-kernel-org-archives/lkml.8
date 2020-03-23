Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603C2C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315A1206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+SMEnEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgCWLnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:43:08 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:45027 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgCWLnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 07:43:08 -0400
Received: by mail-wr1-f73.google.com with SMTP id u18so7198249wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 04:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=lSE+DSc9amXP//IBtR/r3PMKZC9AUFcm/JzIAvbwz4Y=;
        b=B+SMEnEmy0Cylz0cvWADVv2wy8XltTOm0SEKG3nrST2UcLXoLlZZ66WHVv8h6/y1dy
         g4G+JbQlyafqSZ+lE0Ey6y/mNIq/FnJnCKsA4SdDDGb0mS9OT1zJrwpNxHZHCH/w/rNT
         D16FUGfn33ZoZku0PmD4UYQpSZ7LWx/okUpZzVXhvJ13KojJB3f4z5P6erulhmRdZj0M
         +5emuTsRtho9Vviafk35ULhwb2iubD/ytpcVC3KpFPQTwLTKH7adD90TouY5BbaIMZyq
         tDoN/pdQ7rlPrsWvP1h8gkL484boxRo7luZJt+fqyGNmNTFs6sLzSghFUbijVJQDxbks
         SN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=lSE+DSc9amXP//IBtR/r3PMKZC9AUFcm/JzIAvbwz4Y=;
        b=KH+PD39Bwgf2MdtfnOzFBJUNbiikWPBDbDn4ksn+FyiSM7M//1fEQUU1SX41QcczLv
         QYbSeF2Xton6QsoIUpzRrLl7q6ohPlSwDOZoC0ZIMr8FFBf5CmMOaMutVi3Mn1/+t3hj
         VugGqCI+OBApmduFpyAPZnoW6XUCZPBhiz4v5ml8lshVJNFmElTBowFBUoAVE1JOnuA0
         9qtAMx/nbW4LMgEppYdKXMVTbkLiMcwAiNTtjNfCyy3DP6pUujNYr2XGaGyKNils6qqt
         DtNK29fxT3UaubnjbdVZZsieRhlKQJkTI/QPGHwhGi/DCqe/mq49/5/JdP7kGiRKZuxA
         vlpg==
X-Gm-Message-State: ANhLgQ3XUdDtJ5PHx6zajjqDe/rWHXScbqHhVH3UoiqVE1nx6GhwcLsc
        76GLl0l1CNbWUyxtznble1uxmbXe6BC5
X-Google-Smtp-Source: ADFU+vvVzcaUYjQV7bRCwqcHpFkISUOwv6YPHz5NI4aMv8jYgaNnLf5oDf7OQ7BDUyztW8V6hOcxQWzZ8Joh
X-Received: by 2002:adf:dfce:: with SMTP id q14mr30519861wrn.326.1584963785709;
 Mon, 23 Mar 2020 04:43:05 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:42:06 +0100
Message-Id: <20200323114207.222412-1-courbet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH]     x86: Alias memset to __builtin_memset.
From:   Clement Courbet <courbet@google.com>
Cc:     Clement Courbet <courbet@google.com>,
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

    In terms of code size, this grows the clang-built kernel a
    bit (+0.022%):
    440285512 vmlinux.clang.after
    440383608 vmlinux.clang.before

Signed-off-by: Clement Courbet <courbet@google.com>
---
 arch/x86/include/asm/string_64.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 75314c3dbe47..7073c25aa4a3 100644
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
+#if (__GNUC__ >= 4)
+#define memset(s, c, count) __builtin_memset(s, c, count)
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

