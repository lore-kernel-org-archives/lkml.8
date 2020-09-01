Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D47C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E22020578
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="G1fcxj7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgIAWZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIAWZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:25:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9ABC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 15:25:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v77so2861968ybi.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 15:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1Vm2QqyX/OUi6RR2IULKGjS+daCT8Blmd+/gKY17G40=;
        b=G1fcxj7NZ2HKC3O3tMp7OaMWLaYHaeE9KsxbMa4zRsJJVBwflae1qaQvhTrD9ZrJKX
         8uxzDbP9UDghqhvAq0e/p57waEeBVCZp7eZsU0L/Iil4/f58FCSkNr0QUELw0+sdJm6h
         9hNL1cAJRg+9Lf6PDKIX25eLT/Cwx/RrCkrslPykkYujMCe+LxOhh8pzlUeaoInYxUfK
         R9Sw0QwRRwHq9avL6LlzpI0vtTMG23d+i+ypHwy8d3KRRF3lB5tAK+UIImMkMCY4hCSr
         3ys0h9VjnvAfa/z0G8Y7tXq9BSVMTq0jEtayzVpuu6d0aGlBultoPKdf8EDn+n0Wq7Hz
         aoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1Vm2QqyX/OUi6RR2IULKGjS+daCT8Blmd+/gKY17G40=;
        b=f+scgCn4Z7mrtWS2uVNHVi4WztDJecOMxDONO2Pkqmm6SfdIDVxAmaVpMOjTSXn9oB
         vYYQ+609TpWvY/gdqtoX7pjVTE70OTFH6fZr9i7xgdSCGnVj4Vozo+2QxEsu3ZpNam0a
         xmEAOv2lDsxv5BovrazOl9Tr9hTHyzdlW92/aShspNaMFgu6Bm74hwvERauzvWeNr/D+
         BdVC8LPr5su7B+UYle41WKWQquZpHhDCBGYZidh8TICfTp43oaf59B42nHCez9q3sXJX
         6Q3Z38SjMa441d7PToQc/HUwRwzhj32zO3AcV5OUyzTUHA89+P69hEjFBgcjR5YZTpkM
         AoKg==
X-Gm-Message-State: AOAM532EVWQA8pKaiGjIaxfF5+DoIDqQ5VhMheJqdjJMz4GcPmRe+SSP
        FI3HCGd8JEg1uANwauo/wcGPTNfnWU6kNwMXbgk=
X-Google-Smtp-Source: ABdhPJx5yf3WNW7Q5w2bD1WYoDV7Na2wjlaEIzL4kF+ReKd10GAYtHjsF7mnqYQo7KV+jgGCvau1EGlVhk8NOTuv0R4=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:7509:: with SMTP id
 q9mr5300885ybc.317.1598999136478; Tue, 01 Sep 2020 15:25:36 -0700 (PDT)
Date:   Tue,  1 Sep 2020 15:25:22 -0700
In-Reply-To: <20200901222523.1941988-1-ndesaulniers@google.com>
Message-Id: <20200901222523.1941988-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200901222523.1941988-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH 1/2] powerpc/vdso64: link vdso64 with linker
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than invoke the compiler as the driver, use the linker. That way
we can check --orphan-handling=warn support correctly, as cc-ldoption
was removed in
commit 055efab3120b ("kbuild: drop support for cc-ldoption").

Painstakingly compared the output between `objdump -a` before and after
this change. Now function symbols have the correct type of FUNC rather
than NONE, and the entry is slightly different (which doesn't matter for
the vdso). Binary size is the same.

Fixes: commit f2af201002a8 ("powerpc/build: vdso linker warning for orphan sections")
Link: https://lore.kernel.org/lkml/CAKwvOdnn3wxYdJomvnveyD_njwRku3fABWT_bS92duihhywLJQ@mail.gmail.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/powerpc/include/asm/vdso.h         | 17 ++---------------
 arch/powerpc/kernel/vdso64/Makefile     |  8 ++++++--
 arch/powerpc/kernel/vdso64/vdso64.lds.S |  1 -
 3 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
index 2ff884853f97..11b2ecf49f79 100644
--- a/arch/powerpc/include/asm/vdso.h
+++ b/arch/powerpc/include/asm/vdso.h
@@ -24,19 +24,7 @@ int vdso_getcpu_init(void);
 
 #else /* __ASSEMBLY__ */
 
-#ifdef __VDSO64__
-#define V_FUNCTION_BEGIN(name)		\
-	.globl name;			\
-	name:				\
-
-#define V_FUNCTION_END(name)		\
-	.size name,.-name;
-
-#define V_LOCAL_FUNC(name) (name)
-#endif /* __VDSO64__ */
-
-#ifdef __VDSO32__
-
+#if defined(__VDSO32__) || defined (__VDSO64__)
 #define V_FUNCTION_BEGIN(name)		\
 	.globl name;			\
 	.type name,@function; 		\
@@ -46,8 +34,7 @@ int vdso_getcpu_init(void);
 	.size name,.-name;
 
 #define V_LOCAL_FUNC(name) (name)
-
-#endif /* __VDSO32__ */
+#endif /* __VDSO{32|64}__ */
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index 38c317f25141..7ea3ce537d0a 100644
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -32,9 +32,13 @@ $(obj)/%.so: OBJCOPYFLAGS := -S
 $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
+ldflags-y := -shared -soname linux-vdso64.so.1 \
+	$(call ld-option, --eh-frame-hdr) \
+	$(call ld-option, --orphan-handling=warn) -T
+
 # actual build commands
-quiet_cmd_vdso64ld = VDSO64L $@
-      cmd_vdso64ld = $(CC) $(c_flags) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^) $(call cc-ldoption, -Wl$(comma)--orphan-handling=warn)
+quiet_cmd_vdso64ld = LD      $@
+      cmd_vdso64ld = $(cmd_ld)
 
 # install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
diff --git a/arch/powerpc/kernel/vdso64/vdso64.lds.S b/arch/powerpc/kernel/vdso64/vdso64.lds.S
index 4e3a8d4ee614..58c33b704b6a 100644
--- a/arch/powerpc/kernel/vdso64/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso64/vdso64.lds.S
@@ -11,7 +11,6 @@ OUTPUT_FORMAT("elf64-powerpcle", "elf64-powerpcle", "elf64-powerpcle")
 OUTPUT_FORMAT("elf64-powerpc", "elf64-powerpc", "elf64-powerpc")
 #endif
 OUTPUT_ARCH(powerpc:common64)
-ENTRY(_start)
 
 SECTIONS
 {
-- 
2.28.0.402.g5ffc5be6b7-goog

