Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD12C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A1720774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhzSoHHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgCXP72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:59:28 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:42129 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgCXP72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:59:28 -0400
Received: by mail-wr1-f73.google.com with SMTP id o18so6027748wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=6vaPWbP6ANUHUHOz8sns0zk878oxF/Up8fDXRsjlrW0=;
        b=PhzSoHHgm6kzqXckUj1hMJQQ00oWqkLQlPCoaVh2BlJzOv7otdTlVHco/J8wUFyoyU
         sRv2K12f0v7HbtkZXjfqo14K+kBYEg4LIDXNNy7rcLtJqtN9kl0lOAUuaFiYVB1wt7F1
         LdfNOyWEu1SSkJ4wpcuhs+fE990IJV/sELuU0t7W/miqEVL0y/OjIZLDbwJq8ERXC/lJ
         /xDui9edLVHi+oUutjdZCSf02cK8rFjNrS6Puql6opfvPr954sxDjsDzjIO4CgR3tAqr
         m9x7M30492yYD+ZzIfzSCvTVWvNR0tSoSOXTrWN9caBXY34h9BOLbXI4arRUz0YpywxJ
         y6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=6vaPWbP6ANUHUHOz8sns0zk878oxF/Up8fDXRsjlrW0=;
        b=QxgGt5xy4kvg3TzJRrPEcPG8NDhK0cNSk8uzIOdHLEJ07ya+qbeyAh2myiFIXecRmG
         3zVS+djRh6qZj0hUZ2gGGZIp2g6yAmttJJLhZswurpqL2I02qT6n/SXeQkrY+39llGea
         JLm5BsZshQFUoUKILDKwS/ait8zwLY8GJvGk48EehZrg9XK4Kf9jcTyilaKmAzzcWPaC
         TQ8GMnV0z2b00FMF4+MbeCRvpJ6otFSO51I0DV8C5lBBjdFDkULoCky/sN4W1tyYBzqA
         WsLjdBKo9mPRHiuG26/q0793q2WjSm5rJG36y4YxUNzOFH1U6qNDWR9sEKBjf63/Fu9b
         5pCw==
X-Gm-Message-State: ANhLgQ3582C1hxfsLFIYF5PnkfW9CtWg9vE8siE+60BuOWWGpQbcfQ5G
        B3/r2tCPCXFKunqoqp3H8IiUuXGtImBz
X-Google-Smtp-Source: ADFU+vtxu3m5pblacH64/JBEURHgvUseOlvDCPG7Bzrb+FzT2BiQR6E0wX3uqBX79CwEAjXozWmw9aPIHC/v
X-Received: by 2002:a5d:69c7:: with SMTP id s7mr36849068wrw.165.1585065564454;
 Tue, 24 Mar 2020 08:59:24 -0700 (PDT)
Date:   Tue, 24 Mar 2020 16:59:06 +0100
In-Reply-To: <20200323114207.222412-1-courbet@google.com>
Message-Id: <20200324155907.97184-1-courbet@google.com>
Mime-Version: 1.0
References: <20200323114207.222412-1-courbet@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v3]     x86: Alias memset to __builtin_memset.
From:   Clement Courbet <courbet@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
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
---
 arch/x86/include/asm/string_64.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 75314c3dbe47..9cfce0a840a4 100644
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

