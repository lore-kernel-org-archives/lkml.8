Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2B8C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AD8206F8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJmHc86j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgC0KIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:08:43 -0400
Received: from mail-wm1-f73.google.com ([209.85.128.73]:38289 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgC0KIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:08:43 -0400
Received: by mail-wm1-f73.google.com with SMTP id y1so4163320wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 03:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=a9Dk/kbnbTaFBBTCzZO5pdMTQ5WVDyWCyCYn/tuqlvo=;
        b=FJmHc86jTWilHccHv/Qtxijls7tX6vwQd9QVFRcr4ULmjCslDhbAUbT/QGLyMiPMYm
         tP+9f4g4yGrvQziUFuqcgvIvvPGmPltssF3bc/u+v48G3ILPSh5Bhc5oxTlslJVaKdM0
         G/SkaNPT7mu6fQfidkpNkePPd1cE4RVebXj+4HE3Qt/B86Y1zGVKngXmZb+J4hpr1E6o
         /eP74Th/f9RC9r3NyHNJ708a7Je0jhvMkcY/xLS8hKJGeWuB+h0qUGbentWjZLRMAoXa
         Noapslt5eHx21oA4wFLj/DOS4EppFcYhlhx0CROLwFPc99KXzpLLyq/LJmuSGGZKkipk
         Us7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=a9Dk/kbnbTaFBBTCzZO5pdMTQ5WVDyWCyCYn/tuqlvo=;
        b=izNjzcqRjII1QZGL88PkKKDqjjmhXYiJDGrSbbC6EUD9YsprRJzr0FPW6xKMUNlIzY
         90mDh+9rXM3+/QnBccfolytf5uhuoi9s0Qog58h1VHO1nlIhCHk1uec1Sz1fnfVJTgBR
         HdrGGdpsCL5/7OGy1SiKJ5+fK5MOa+cp+ks0LvxniwE52jl0zjKyCQNZpsJzYlrI1EEG
         ZC7jiHSI7WTZcIi/4o0r5wijdJtrLbwTfWQleVi+qL2XvX+lWJTWvlbvu3ueX+/CZiwA
         rmIIzvuwA65dJ9OP246hO73QjNIkUre//cj7BnMjupmCgjJVoxboUalVqLY/8fR9tAcw
         atnQ==
X-Gm-Message-State: ANhLgQ1CyEMUhgV3IdpoNi+so6/4R0zc+ZfOUiuosGe5DsGIKDuxqAar
        vOjLI+vFCzIb//7KqlWT/pniQ/fu/yA7
X-Google-Smtp-Source: ADFU+vtojvBkE1GLoPL2bhvgPGCs6QCLPLJwQAyX+NrE9rnGyOJoaHaAy73LIj85K4haau67QXrr6O028hc9
X-Received: by 2002:adf:9e08:: with SMTP id u8mr3411115wre.155.1585303720723;
 Fri, 27 Mar 2020 03:08:40 -0700 (PDT)
Date:   Fri, 27 Mar 2020 11:07:56 +0100
Message-Id: <20200327100801.161671-1-courbet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v1] powerpc: Make setjmp/longjump signature standard
From:   Clement Courbet <courbet@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Clement Courbet <courbet@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declaring setjmp()/longjmp() as taking longs makes the signature
non-standard, and makes clang complain. In the past, this has been
worked around by adding -ffreestanding to the compile flags.

The implementation looks like it only ever propagates the value
(in longjmp) or sets it to 1 (in setjmp), and we only call longjmp
with integer parameters.

This allows removing -ffreestanding from the compilation flags.

Context:
https://lore.kernel.org/patchwork/patch/1214060
https://lore.kernel.org/patchwork/patch/1216174

Signed-off-by: Clement Courbet <courbet@google.com>
---
 arch/powerpc/include/asm/setjmp.h | 6 ++++--
 arch/powerpc/kexec/Makefile       | 3 ---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/setjmp.h b/arch/powerpc/include/asm/setjmp.h
index e9f81bb3f83b..84bb0d140d59 100644
--- a/arch/powerpc/include/asm/setjmp.h
+++ b/arch/powerpc/include/asm/setjmp.h
@@ -7,7 +7,9 @@
 
 #define JMP_BUF_LEN    23
 
-extern long setjmp(long *) __attribute__((returns_twice));
-extern void longjmp(long *, long) __attribute__((noreturn));
+typedef long *jmp_buf;
+
+extern int setjmp(jmp_buf env) __attribute__((returns_twice));
+extern void longjmp(jmp_buf env, int val) __attribute__((noreturn));
 
 #endif /* _ASM_POWERPC_SETJMP_H */
diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
index 378f6108a414..86380c69f5ce 100644
--- a/arch/powerpc/kexec/Makefile
+++ b/arch/powerpc/kexec/Makefile
@@ -3,9 +3,6 @@
 # Makefile for the linux kernel.
 #
 
-# Avoid clang warnings around longjmp/setjmp declarations
-CFLAGS_crash.o += -ffreestanding
-
 obj-y				+= core.o crash.o core_$(BITS).o
 
 obj-$(CONFIG_PPC32)		+= relocate_32.o
-- 
2.25.1.696.g5e7596f4ac-goog

