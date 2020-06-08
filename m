Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBA6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCDC82068D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oo1e6e+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgFHU5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgFHU5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:57:17 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB3FC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 13:57:16 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a6so15418757qka.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 13:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n0Z0MVW9fjL11OJnRXmUnpTQPi7wV6ggXRGNscFMQpE=;
        b=oo1e6e+nKKXbeOsMhQCwbm6s/L45uVQdd/hGh3/yPQQOcvkOLFMzvCnGOkZ/M4dVDX
         1oVCNc2iXN7++m4+rOZmjF0iFk1fuK/YEPAZXwUCVC7IVo878hSqVKtkRBhYi6aPbt9H
         iIStaqx25B2k3CpwnBtkUyxXbpbpZZG/SSlqAD3nKeW/3YfkmWxbR5TyhkKstzLoqyUH
         Yy90d3w2oPVcq4YL6lYzFLyB2mh8sXBHbuNJjNjZOutWJsBC9ylJF4mXEwj0O6IbUvHk
         BQzUSOYm0OUb6Xnqj5jfUYvyej9eIoZCxE9ERJwYLUo7hRSehhA1kZVJC3cTkVB0YfFM
         XHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n0Z0MVW9fjL11OJnRXmUnpTQPi7wV6ggXRGNscFMQpE=;
        b=AAMkx/hX0c78LVYBoux5NQ3nZqEPuUCHNd6bmbC+BJnDy7Pc7/cjY4AxwmIqB5Sil8
         Dqv+q2fSn2V8A97Ir40Kxh7mLglon5YaK7I8nWPbeXAH1NCcSOteoSkmgDfkqxGFn2Ss
         gH6d5KwpDrq0QnGYeFxtpSLkDx1Vn0l3j9Z8xLXpxTDlFWwJbkw8Sfk2e8EsEBGeMmmj
         hwzgAmiTmeOvtf6e/KXdrVWa1iTL9n30wc/A2rwD+iLnccmt/rZqbsfW0fs+y5JMiJVb
         S2s3fg7Zh0S7u4IBQpTOkvmjN1XsGb5wSJaUdH4usJH00FsBrynBWefQz1cCKZeI3hrA
         ucRg==
X-Gm-Message-State: AOAM531SJ6Y8zgKsfphu7C7e6plMFN31THsBwtaU+VZViWnVR/Fh6mKQ
        G1XXC2NnUquMKTfJGwEgJaW6+xmARP/eppgQ7wg=
X-Google-Smtp-Source: ABdhPJwVKC1j3i6Ut6j8xgrtVABDjElPORqoydWyMT9uIcnpRaKe05GOFjjqf5w7zzY2GkvtF57h3f/PX45fHBLS67A=
X-Received: by 2002:a0c:f652:: with SMTP id s18mr597254qvm.96.1591649835537;
 Mon, 08 Jun 2020 13:57:15 -0700 (PDT)
Date:   Mon,  8 Jun 2020 13:57:08 -0700
In-Reply-To: <20200528072031.GA22156@willie-the-truck>
Message-Id: <20200608205711.109418-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200528072031.GA22156@willie-the-truck>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2] arm64: vdso32: add CONFIG_THUMB2_COMPAT_VDSO
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Boyd <swboyd@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Luis Lozano <llozano@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the compat vdso (32b) to be compiled as either THUMB2 (default) or
ARM.

For THUMB2, the register r7 is reserved for the frame pointer, but
code in arch/arm64/include/asm/vdso/compat_gettimeofday.h
uses r7. Explicitly set -fomit-frame-pointer, since unwinding through
interworked THUMB2 and ARM is unreliable anyways. See also how
CONFIG_UNWINDER_FRAME_POINTER cannot be selected for
CONFIG_THUMB2_KERNEL for ARCH=arm.

This also helps toolchains that differ in their implicit value if the
choice of -f{no-}omit-frame-pointer is left unspecified, to not error on
the use of r7.

2019 Q4 ARM AAPCS seeks to standardize the use of r11 as the reserved
frame pointer register, but no production compiler that can compile the
Linux kernel currently implements this.  We're actively discussing such
a transition with ARM toolchain developers currently.

Link: https://static.docs.arm.com/ihi0042/i/aapcs32.pdf
Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1084372
Cc: Stephen Boyd <swboyd@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Reported-by: Luis Lozano <llozano@google.com>
Tested-by: Manoj Gupta <manojgupta@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1 -> V2:
* add THUMB2_COMPAT_VDSO config, making -mthumb/-marm configurable
  rather than hard coding.
* Fixed https://reviews.llvm.org/D80828 in Clang, but still an issue.
  Not due to implicit state of -marm vs -mthumb, but actually
  -f{no-}omit-frame-pointer due to
  https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/third_party/toolchain-utils/compiler_wrapper/config.go;l=110,
  which prefixes -fno-omit-frame-pointer for all arches and projects.
  Projects that don't set -f{no-}omit-frame-pointer thus don't overwrite
  the prefixed -fno-omit-frame-pointer, which is an issue when inline
  asm compiled as -mthumb uses r7.
* I don't have a strong preference on the default state of this config.

 arch/arm64/Kconfig                | 8 ++++++++
 arch/arm64/kernel/vdso32/Makefile | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7f9d38444d6d..fe9e6b231cac 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1299,6 +1299,14 @@ config COMPAT_VDSO
 	  You must have a 32-bit build of glibc 2.22 or later for programs
 	  to seamlessly take advantage of this.
 
+config THUMB2_COMPAT_VDSO
+	bool "Compile the vDSO in THUMB2 mode"
+	depends on COMPAT_VDSO
+	default y
+	help
+	  Compile the compat vDSO with -mthumb -fomit-frame-pointer if y, otherwise
+	  as -marm.
+
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
 	depends on SYSCTL
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 3964738ebbde..7ea1e827e505 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -105,6 +105,14 @@ VDSO_CFLAGS += -D__uint128_t='void*'
 VDSO_CFLAGS += $(call cc32-disable-warning,shift-count-overflow)
 VDSO_CFLAGS += -Wno-int-to-pointer-cast
 
+# Compile as THUMB2 or ARM. Unwinding via frame-pointers in THUMB2 is
+# unreliable.
+ifeq ($(CONFIG_THUMB2_COMPAT_VDSO), y)
+VDSO_CFLAGS += -mthumb -fomit-frame-pointer
+else
+VDSO_CFLAGS += -marm
+endif
+
 VDSO_AFLAGS := $(VDSO_CAFLAGS)
 VDSO_AFLAGS += -D__ASSEMBLY__
 
-- 
2.27.0.278.ge193c7cf3a9-goog

