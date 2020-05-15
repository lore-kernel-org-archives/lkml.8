Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F223EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB99A20709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2mePthr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgEOK7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgEOK7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:59:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D152DC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:59:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so2170117wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNlsZuKpbaQAO6z1kYuuvPgoFNE3ZTHmZItsK3A1s/4=;
        b=a2mePthrCkqiv1vOToW6CSfM1wFwyuINH7E8m7j8zyotUbo2SiNOEq+uMYyTMNBrtJ
         E/gcD+YlaC+y93uhxlTueo9WVda7X9RPZS9K9DakyLmz4dxE7PEbobbL0dVXCmzJvfwK
         uSYXjdVnwaCRcDVzs1ieIkpKYKB31AtCEcrjY/80JPlRcYqaYZHFB62siP6rxzQ62HlC
         39GnrwVZIFOPec4OPezzfAKoarg0qnJu/kfJUsLlac1ZOV5MD/UkDmsQ9mJRqlPyCIPC
         hO0pFxf+gCVfPSSf3D5JAeZ9sNEjhuHQ/Rl9LGLWrQA7jVHDWX+zL/dPlq28Yb5Vz9lH
         QAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNlsZuKpbaQAO6z1kYuuvPgoFNE3ZTHmZItsK3A1s/4=;
        b=N45576Lod4s8o0lyhFUBwHjnF0MX+Nv7jYZnFe+i6W5pTykeKXDgh7q7C2ZH+9Fb2r
         3RFAPo9oL37lMp6mAyQgBw7hkquvcWx9z70xyPGXLSs02HB3BJ/g+ZoSdQcVBKnafNn7
         0zKA+A3montFf2zSc79bos5CoSjj7nWKNoewHZLtH48Wk1c/R5bS+x8NDY3Vs2wuQ+Zn
         8J52lhQ+fc2wbODfQg9CalVUn0JDLKTHrUAidbqsIK3WG2XRYYOJ+fXLBB6D1ryLBKkJ
         bJRSv8KgwkA7nrPV0usjsLBPV/a12ltGynFLf2Gbo/MRIZ8G+DkcmH8cr0U6KDkB9sVR
         BFEw==
X-Gm-Message-State: AOAM533CzzQWmkVr0E3zKqhrM/cFRKkgIGeqwSEDSnUCB+LWMO02VKwK
        bcFYwWLRSJKPvrpemi2ARAje4A==
X-Google-Smtp-Source: ABdhPJzyvDNr0FNuz6vpDMEhT8+N3AHdMTtoUX6V7+HUHnGp3w2eUv3jrhxHrrXAFF5VEGySY19F+g==
X-Received: by 2002:a7b:c778:: with SMTP id x24mr3625426wmk.144.1589540341191;
        Fri, 15 May 2020 03:59:01 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d11b:f847:8002:7411])
        by smtp.gmail.com with ESMTPSA id p9sm3130293wrj.29.2020.05.15.03.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 03:59:00 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 04/14] arm64: kvm: Add build rules for separate nVHE object files
Date:   Fri, 15 May 2020 11:58:31 +0100
Message-Id: <20200515105841.73532-5-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515105841.73532-1-dbrazdil@google.com>
References: <20200515105841.73532-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new folder arch/arm64/kvm/hyp/nvhe and a Makefile for building code that
runs in EL2 under nVHE KVM.

Compile each source file into a `.hyp.tmp.o` object first, then prefix all
its symbols with "__kvm_nvhe_" using `objcopy` and produce a `.hyp.o`.
Suffixes were chosen so that it would be possible for VHE and nVHE to share
some source files, but compiled with different CFLAGS. nVHE build rules add
-D__KVM_NVHE_HYPERVISOR__.

The nVHE ELF symbol prefix is added to kallsyms.c as ignored. EL2-only symbols
will never appear in EL1 stack traces.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/image-vars.h   | 12 +++++++++++
 arch/arm64/kvm/hyp/Makefile      |  4 ++--
 arch/arm64/kvm/hyp/nvhe/Makefile | 35 ++++++++++++++++++++++++++++++++
 scripts/kallsyms.c               |  1 +
 4 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/Makefile

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 7f06ad93fc95..13850134fc28 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -51,4 +51,16 @@ __efistub__ctype		= _ctype;
 
 #endif
 
+#ifdef CONFIG_KVM
+
+/*
+ * KVM nVHE code has its own symbol namespace prefixed by __hyp_text_, to
+ * isolate it from the kernel proper. The following symbols are legally
+ * accessed by it, therefore provide aliases to make them linkable.
+ * Do not include symbols which may not be safely accessed under hypervisor
+ * memory mappings.
+ */
+
+#endif /* CONFIG_KVM */
+
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 5d8357ddc234..c9fd8618980d 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -6,10 +6,10 @@
 ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
 		$(DISABLE_STACKLEAK_PLUGIN)
 
-obj-$(CONFIG_KVM) += hyp.o
+obj-$(CONFIG_KVM) += vhe.o nvhe/
 obj-$(CONFIG_KVM_INDIRECT_VECTORS) += smccc_wa.o
 
-hyp-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o sysreg-sr.o \
+vhe-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o sysreg-sr.o \
 	 debug-sr.o entry.o switch.o fpsimd.o tlb.o hyp-entry.o
 
 # KVM code is run at a different exception code with a different map, so
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
new file mode 100644
index 000000000000..7d64235dba62
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Kernel-based Virtual Machine module, HYP/nVHE part
+#
+
+asflags-y := -D__KVM_NVHE_HYPERVISOR__
+ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -fno-stack-protector \
+	     -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN)
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
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 3e8dea6e0a95..523a1a337ebd 100644
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
2.26.2

