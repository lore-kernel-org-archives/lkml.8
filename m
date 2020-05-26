Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C15C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF304207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="O1fSBWC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbgEZHDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731493AbgEZHDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:03:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C7CC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:03:17 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f21so6569481pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UTa6e4uati/mC1lpRGebfubs1gwZzy90fbCylq5T17w=;
        b=O1fSBWC+2oXmb5j7RceiWUwGAfEkuKAVD/tgEAq8i4EcQOlTa1aEPwBiS8cy6cZTlp
         U8wWupuOcEpZ9siGvFKdl7GQR5spvRfuxpUN1D1XV6Rq83IbxHr0ziiTnIq0Xpt+/zWi
         UkZoEz7MxtXVPrJxXk+gdY4vSBZaJQuygPRYPmIMq7tTcFKOxb7nNYb88nz9tQz45CKg
         /jCoArJVUV/IslA3BGUx41iWrU5VnBcdiu2xqXlQY6CBJ7SQsTvQumZHxgRzVmyrEyUP
         gdeanKKVfpi+SEo3yYx4LnWiugMDftofxx79qxefwLcIKhnUe+tDrxtMcvfVWtTjc7ax
         k3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UTa6e4uati/mC1lpRGebfubs1gwZzy90fbCylq5T17w=;
        b=bqSe6fT1GyajQ/cMWU0ef3DNy+/SmjMQhFnmdDggTbeHHWsBE5oWuzUdDffdPKNevS
         8TFCS2a6ffEfL0wdme4bCbmn5TjPAno+U8hTGSQyQOwCPBHnQDVEUUxWHuJm9ayfQ9cc
         tBDwJfHS5mIVzgQ0975BUo3GBWX2s+WK/HhLD8HPuhvy72zayLl+7OhtK6lZTMsNtKGW
         48aofLq/dnlC96Eukl50SG+wZbMnArNUb/P5yzJsc6RUJ5jgLsNFwL5fDPtdyhv+JNPg
         j3h08bMmezB70tiVeQfLchVkCoqTVTnqIpa7zmTAEeykukuIvvXThvh7Tbpgqvd5tgy7
         KB1Q==
X-Gm-Message-State: AOAM530Duco1NcUtVZycei9qsxVjVy+Rnt5IWZYRJMdXtfIdKZDUUYXe
        FxPmJyzfRrX8N1TFSas41Wkq0g==
X-Google-Smtp-Source: ABdhPJyHLPVIbiZnTPLCFOkJTGyiNtB6HY85/M77vYHMbqVoSrDV0Qu/gbZiDjtkaW6HxGhnv9srjQ==
X-Received: by 2002:aa7:9106:: with SMTP id 6mr7958314pfh.245.1590476596842;
        Tue, 26 May 2020 00:03:16 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q34sm15167431pja.22.2020.05.26.00.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:03:16 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v4 13/13] riscv: signal: Report signal frame size to userspace via auxv
Date:   Tue, 26 May 2020 15:02:42 +0800
Message-Id: <fbf926cd6a835a8210fd0dfec8f25611eb2592fb.1590474856.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590474856.git.greentime.hu@sifive.com>
References: <cover.1590474856.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen <vincent.chen@sifive.com>

The vector register belongs to the signal context. They need to be stored
and restored as entering and leaving the signal handler. According to the
V-extension specification, the maximum length of the vector registers can
be 2^(XLEN-1). Hence, if userspace refers to the MINSIGSTKSZ #define
(2KB) to create a sigframe, it may not be enough. To resolve this problem,
this patch refers to the commit 94b07c1f8c39c
("arm64: signal: Report signal frame size to userspace via auxv") to enable
userspace to know the minimum required sigframe size through the auxiliary
vector and use it to allocate enough memory for signal context.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/include/asm/elf.h         | 17 +++++++++++++----
 arch/riscv/include/asm/processor.h   |  2 ++
 arch/riscv/include/uapi/asm/auxvec.h |  2 ++
 arch/riscv/kernel/setup.c            |  5 +++++
 arch/riscv/kernel/signal.c           | 16 ++++++++++++++++
 5 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index d83a4efd052b..b6b15fc5f784 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -57,10 +57,19 @@ extern unsigned long elf_hwcap;
 #define ELF_PLATFORM	(NULL)
 
 #ifdef CONFIG_MMU
-#define ARCH_DLINFO						\
-do {								\
-	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
-		(elf_addr_t)current->mm->context.vdso);		\
+#define ARCH_DLINFO						 \
+do {								 \
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,				 \
+		(elf_addr_t)current->mm->context.vdso);		 \
+	/*							 \
+	 * Should always be nonzero unless there's a kernel bug. \
+	 * If we haven't determined a sensible value to give to	 \
+	 * userspace, omit the entry:				 \
+	 */							 \
+	if (likely(signal_minsigstksz))				 \
+		NEW_AUX_ENT(AT_MINSIGSTKSZ, signal_minsigstksz); \
+	else							 \
+		NEW_AUX_ENT(AT_IGNORE, 0);			 \
 } while (0)
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 217273375cfb..5be2da702897 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -7,6 +7,7 @@
 #define _ASM_RISCV_PROCESSOR_H
 
 #include <linux/const.h>
+#include <linux/cache.h>
 
 #include <asm/ptrace.h>
 
@@ -79,6 +80,7 @@ int riscv_of_processor_hartid(struct device_node *node);
 
 extern void riscv_fill_hwcap(void);
 
+extern unsigned long signal_minsigstksz __ro_after_init;
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/uapi/asm/auxvec.h
index d86cb17bbabe..9745a01e5e61 100644
--- a/arch/riscv/include/uapi/asm/auxvec.h
+++ b/arch/riscv/include/uapi/asm/auxvec.h
@@ -10,4 +10,6 @@
 /* vDSO location */
 #define AT_SYSINFO_EHDR 33
 
+#define AT_MINSIGSTKSZ 51
+
 #endif /* _UAPI_ASM_RISCV_AUXVEC_H */
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 145128a7e560..6220e25ea9b0 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -17,6 +17,7 @@
 #include <linux/sched/task.h>
 #include <linux/swiotlb.h>
 #include <linux/smp.h>
+#include <linux/processor.h>
 
 #include <asm/clint.h>
 #include <asm/cpu_ops.h>
@@ -62,6 +63,8 @@ void __init parse_dtb(void)
 #endif
 }
 
+extern void __init minsigstksz_setup(void);
+
 void __init setup_arch(char **cmdline_p)
 {
 	init_mm.start_code = (unsigned long) _stext;
@@ -95,6 +98,8 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	riscv_fill_hwcap();
+
+	minsigstksz_setup();
 }
 
 static int __init topology_init(void)
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 9ada6f74bb95..4f81251867e6 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -404,3 +404,19 @@ asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
 		tracehook_notify_resume(regs);
 	}
 }
+
+unsigned long __ro_after_init signal_minsigstksz;
+
+/*
+ * Determine the stack space required for guaranteed signal devliery.
+ * This function is used to populate AT_MINSIGSTKSZ at process startup.
+ * cpufeatures setup is assumed to be complete.
+ */
+void __init minsigstksz_setup(void)
+{
+	signal_minsigstksz = sizeof(struct rt_sigframe);
+#ifdef CONFIG_VECTOR
+	if (has_vector)
+		signal_minsigstksz += riscv_vsize;
+#endif
+}
-- 
2.26.2

