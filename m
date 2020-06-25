Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B255C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3E62089D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GOCuZWYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404938AbgFYNOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404875AbgFYNOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:14:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE50C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so5878012wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gqQTH97HtY38hoyHVjBtUD2yI3/M5sungIhVTZmvSaI=;
        b=GOCuZWYrfvWWj5emPIMjcBA3NlpdFL5BZ43NdBMXbB8zZ3B81DmJXO8vCVuGzVo1Xc
         Y16TbKwn9hN7elpN37ANd/VPU3tt0wE5OHP7fk/WCQzmP+YuGX4Ta2r48koYnodYRMzK
         1gC42/4mFCeRKFzvIJU7fNtipSFpX716yzu0+pIbI6JzfN5YGpgMPdnwXY+7dv+B7HdI
         ASk+l1fz6lNfAyu4YTXEMx/Mw6mlgsj4Jv18Ewe+ZGRz7ftDj6DXjyMXefYyZiiRC/u+
         vQqCYIXd7sVXaaAG4PtL1NOYOGwMdVsU+kBsKGLwZvRRVK/t4Xt7wIvoj5y+U7O4uT4U
         b0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gqQTH97HtY38hoyHVjBtUD2yI3/M5sungIhVTZmvSaI=;
        b=C0onM+hkKtO+ZS5w/s3Y2o6bzMFaIr/bWi9bGC1iiqJlol/iP6e8pFdUPxrp64oEIa
         BwHCjY353NbE2b9vNjglTVFYIA1qvCrH+DIlfoJPMyWtq9JWtkP4Zq7OJbJ3ujhoP4yx
         8fndzo+86tDdCPIy0DQKMS9S3NjA3RjovWiEumCZ8LIPS1buWkp66dzfCfhkO0S18eiI
         N6++G48DO/4JCIQHS/tS8EMExV6sFpKZ5nSYopCuPwauQYrkQauQwPwLbgNZ5Hm+J9UX
         4tPhNy1smALeVUjzE2oDGx0BKEktVOpXVbihB59S/O2WDNT2jIF0n41HawMti0slkAV8
         nMgw==
X-Gm-Message-State: AOAM5307kSendAEvXROo+qCICDUddSUOyfz7o0krZsRmvYAz+XBvRZDW
        wSO5xwVDvENkLEQskn4pcuoJfg==
X-Google-Smtp-Source: ABdhPJwaokAKPaTtdDxI+IVCVgh0HO5v1xcjChmdSVNVz+edayYBMWriz+QIPgrgrr3c2K0F2FeUug==
X-Received: by 2002:a05:600c:2241:: with SMTP id a1mr3241729wmm.168.1593090869555;
        Thu, 25 Jun 2020 06:14:29 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c126:6748:7a9d:2d])
        by smtp.gmail.com with ESMTPSA id d132sm12325895wmd.35.2020.06.25.06.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 06:14:28 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 03/15] arm64: kvm: Add build rules for separate VHE/nVHE object files
Date:   Thu, 25 Jun 2020 14:14:08 +0100
Message-Id: <20200625131420.71444-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200625131420.71444-1-dbrazdil@google.com>
References: <20200625131420.71444-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new folders arch/arm64/kvm/hyp/{vhe,nvhe} and Makefiles for building code
that runs in EL2 under VHE/nVHE KVM, repsectivelly. Add an include folder for
hyp-specific header files which will include code common to VHE/nVHE.

Build nVHE code with -D__KVM_NVHE_HYPERVISOR__, VHE code with
-D__KVM_VHE_HYPERVISOR__.

Under nVHE compile each source file into a `.hyp.tmp.o` object first, then
prefix all its symbols with "__kvm_nvhe_" using `objcopy` and produce
a `.hyp.o`. Suffixes were chosen so that it would be possible for VHE and nVHE
to share some source files, but compiled with different CFLAGS.

The nVHE ELF symbol prefix is added to kallsyms.c as ignored. EL2-only symbols
will never appear in EL1 stack traces.

Due to symbol prefixing, add a section in image-vars.h for aliases of symbols
that are defined in nVHE EL2 and accessed by kernel in EL1 or vice versa.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/image-vars.h   | 14 +++++++++++++
 arch/arm64/kvm/hyp/Makefile      | 10 +++++++---
 arch/arm64/kvm/hyp/nvhe/Makefile | 34 ++++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/vhe/Makefile  | 17 ++++++++++++++++
 scripts/kallsyms.c               |  1 +
 5 files changed, 73 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/Makefile
 create mode 100644 arch/arm64/kvm/hyp/vhe/Makefile

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index be0a63ffed23..3dc27da47712 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -51,4 +51,18 @@ __efistub__ctype		= _ctype;
 
 #endif
 
+#ifdef CONFIG_KVM
+
+/*
+ * KVM nVHE code has its own symbol namespace prefixed with __kvm_nvhe_, to
+ * separate it from the kernel proper. The following symbols are legally
+ * accessed by it, therefore provide aliases to make them linkable.
+ * Do not include symbols which may not be safely accessed under hypervisor
+ * memory mappings.
+ */
+
+#define KVM_NVHE_ALIAS(sym) __kvm_nvhe_##sym = sym;
+
+#endif /* CONFIG_KVM */
+
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 5d8357ddc234..9c5dfe6ff80b 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -3,10 +3,14 @@
 # Makefile for Kernel-based Virtual Machine module, HYP part
 #
 
-ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
-		$(DISABLE_STACKLEAK_PLUGIN)
+incdir := $(srctree)/$(src)/include
+subdir-asflags-y := -I$(incdir)
+subdir-ccflags-y := -I$(incdir)				\
+		    -fno-stack-protector		\
+		    -DDISABLE_BRANCH_PROFILING		\
+		    $(DISABLE_STACKLEAK_PLUGIN)
 
-obj-$(CONFIG_KVM) += hyp.o
+obj-$(CONFIG_KVM) += hyp.o nvhe/
 obj-$(CONFIG_KVM_INDIRECT_VECTORS) += smccc_wa.o
 
 hyp-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o sysreg-sr.o \
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
new file mode 100644
index 000000000000..955f4188e00f
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Kernel-based Virtual Machine module, HYP/nVHE part
+#
+
+asflags-y := -D__KVM_NVHE_HYPERVISOR__
+ccflags-y := -D__KVM_NVHE_HYPERVISOR__
+
+obj-y :=
+
+obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
+extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
+
+$(obj)/%.hyp.tmp.o: $(src)/%.c FORCE
+	$(call if_changed_rule,cc_o_c)
+$(obj)/%.hyp.tmp.o: $(src)/%.S FORCE
+	$(call if_changed_rule,as_o_S)
+$(obj)/%.hyp.o: $(obj)/%.hyp.tmp.o FORCE
+	$(call if_changed,hypcopy)
+
+quiet_cmd_hypcopy = HYPCOPY $@
+      cmd_hypcopy = $(OBJCOPY) --prefix-symbols=__kvm_nvhe_ $< $@
+
+# KVM nVHE code is run at a different exception code with a different map, so
+# compiler instrumentation that inserts callbacks or checks into the code may
+# cause crashes. Just disable it.
+GCOV_PROFILE	:= n
+KASAN_SANITIZE	:= n
+UBSAN_SANITIZE	:= n
+KCOV_INSTRUMENT	:= n
+
+# Skip objtool checking for this directory because nVHE code is compiled with
+# non-standard build rules.
+OBJECT_FILES_NON_STANDARD := y
diff --git a/arch/arm64/kvm/hyp/vhe/Makefile b/arch/arm64/kvm/hyp/vhe/Makefile
new file mode 100644
index 000000000000..e04375546081
--- /dev/null
+++ b/arch/arm64/kvm/hyp/vhe/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Kernel-based Virtual Machine module, HYP/nVHE part
+#
+
+asflags-y := -D__KVM_VHE_HYPERVISOR__
+ccflags-y := -D__KVM_VHE_HYPERVISOR__
+
+obj-y :=
+
+# KVM code is run at a different exception code with a different map, so
+# compiler instrumentation that inserts callbacks or checks into the code may
+# cause crashes. Just disable it.
+GCOV_PROFILE	:= n
+KASAN_SANITIZE	:= n
+UBSAN_SANITIZE	:= n
+KCOV_INSTRUMENT	:= n
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 6dc3078649fa..0096cd965332 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -109,6 +109,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		".LASANPC",		/* s390 kasan local symbols */
 		"__crc_",		/* modversions */
 		"__efistub_",		/* arm64 EFI stub namespace */
+		"__kvm_nvhe_",		/* arm64 non-VHE KVM namespace */
 		NULL
 	};
 
-- 
2.27.0

