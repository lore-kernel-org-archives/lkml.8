Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C137C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C182078A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sr2qjPRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgCXOHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:07:52 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:48336 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgCXOHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:07:51 -0400
Received: by mail-vs1-f74.google.com with SMTP id x185so2211436vsc.15
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=/WDuZWap/v8Iy/M+2OXxOt9NiRFVqlUjqdsfClorLXo=;
        b=Sr2qjPRlgPkAUNThsPMi7tdJY4FEjCggCaBkUOigBm1BPouHiNu4N9XGxCUTgGGGo7
         MBN3x8/tke0Di7ut7R4kVF415AmL5EALBGN1f7adO6qTl1UrHDEwEHjAmmxqU4Dv4rWx
         mZpwn771XICjrXe7cL/CytU0ujh3ncZp/3LDdL0/9b3gJy/8VDTfn8Mcd4WYVIosktJg
         Ws9kAMw8OvJp7IA6PX7D2WE/sG38WGTxXDYK/EPAk3loQUu09yDdoj2WoYZimBl1EUtN
         ioHjfxFO1LysVbJPIzqUSX9WaWiaX97coUvoitmtypDCDNgdyZw2dvOxZhJpnGn7dXLW
         J3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=/WDuZWap/v8Iy/M+2OXxOt9NiRFVqlUjqdsfClorLXo=;
        b=MAD6Q62UrTWBLjTbek1aoeyFWWjkD4ZXrOPq1IWTK53ea/Zvm7nLpW83KSBPuIeRqD
         HN9n67EUG2qAJNOrdWWoaHk3S4vpKztIn6ark8cyLfUDMCtPzkPFZNLGhR5Hue/IvEVP
         jyIfnWPyUP0YsA98kwOVxOnubaLLu61r6q0W0RDmxRasJGkuRSDRtROCLafsQAzL+yox
         dyJX7bD7NiEPidIDkt/wI2p4nlS+hciBPfgmW/ny78C4iXOT8usC7wZKtiyxRP2ZRXv0
         JxuobTRLEGSa5hKWK+3VBzAVIRJ3siTJNdWRtjyFOJ5j1d0wab52Q5W2hgyh0mHkbtQs
         79bQ==
X-Gm-Message-State: ANhLgQ2hLqTX0faUYpxM6rKgsrwgoMJz2QH/jpG3vYDVa6+MzyHwhitH
        WB007oczA0zAd7niFWdoGamXVhjoOIF/
X-Google-Smtp-Source: ADFU+vvWAWa1ZME92RpGWIUWGOme/tyDXMElIiMWTIu0OsBqcrvCNBV955//MSXX4aTdS5Ml+8SZD/DlZaHM
X-Received: by 2002:a1f:3fc8:: with SMTP id m191mr16816183vka.71.1585058870481;
 Tue, 24 Mar 2020 07:07:50 -0700 (PDT)
Date:   Tue, 24 Mar 2020 15:07:41 +0100
In-Reply-To: <20200323114207.222412-1-courbet@google.com>
Message-Id: <20200324140742.71850-1-courbet@google.com>
Mime-Version: 1.0
References: <20200323114207.222412-1-courbet@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2]     x86: Alias memset to __builtin_memset.
From:   Clement Courbet <courbet@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

    In terms of code size, this grows the clang-built kernel a
    bit (+0.022%):
    440285512 vmlinux.clang.after
    440383608 vmlinux.clang.before

Signed-off-by: Clement Courbet <courbet@google.com>

---

changes in v2:
  - Removed ifdef(GNUC >= 4).
  - Disabled change when CONFIG_FORTIFY_SOURCE is set.
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

