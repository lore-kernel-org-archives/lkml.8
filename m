Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C3FC2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ECB20772
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="i0IEvGyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgCZDYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:24:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36267 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgCZDYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id m33so4205421qtb.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Br14IEdrQ+h/TluYq6M39j0SJ67HIdjC6baxG9oa0nU=;
        b=i0IEvGyBqoriM4CG8hBTaH9CpgOJ+6Ro/7wdzybTtPbDV3e3M8UaJfMXQB9ptG5KVI
         FMkd79h+wUDdq/swltuqmENldbzxosdhpw4megU23U4lXShTmo9RkplMrnpRO+HWT58l
         bz1J8NxmTMNbonU7mU9LYAok6D8F5cpdxBduNMeJ9AUQNYRgM80AiwlQuWMdnGlMnVXe
         agnuQ8xBU3v88CVQjZNvk6TyyQa75h7hXBgx/asxBD+iZKo8GNG41Q9syhdbNqf6i43O
         tG+TvCUOkbFnoZd8PT3+ZRr6ee5z6WwOgYig4/oYl1Wel8/aw2hCIU7IPxIaPJrIFEwF
         80yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Br14IEdrQ+h/TluYq6M39j0SJ67HIdjC6baxG9oa0nU=;
        b=Da9TfXk60sxZbeZSzeIMqtpEXEZkn55DWEzoDrVpKRITsXAt4S0pGSeTn2C3+N8NKo
         zqCG4JTyOVs241tBFya8VBSF3XMqHIw7cupGGlobp7fuEQgSbYXLDPUSutVJsX6oroL/
         9H4z3/FIyujFks7cZLrmXYlmT7EWqOq3YNX2PTNfZF2ZTpvchnXKEUV7S9uD0QoMZeuL
         nEVGINRO29CGXHdcNohzCCqrs/ggP6P01MhHy6f3o+5vEIvoe2jt7qyKWry5Wp6jKbGL
         SVDrRZO4qCz6LTnVn88hnL/vSBWVQVToLK3WmuH5I6INU/EmBDsz5QzvQp7jCp0SGCxO
         fzxA==
X-Gm-Message-State: ANhLgQ0ZRtyLIMKeQeDCMrCz07OmquhYwvY6ocDZaUCULSCjW5XfJKUo
        4WqE6z0csmVYfNRFYD4Q1uaDJA==
X-Google-Smtp-Source: ADFU+vtm27PkglkxZBWZNSEtrtj7Md3gNLlQXHWm/UbMjvs5l2SaL7nAgQ6PGID3oJSqgIkAG7pfhQ==
X-Received: by 2002:aed:3c4b:: with SMTP id u11mr6160095qte.208.1585193084262;
        Wed, 25 Mar 2020 20:24:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm620034qka.35.2020.03.25.20.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 20:24:43 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de, selindag@gmail.com
Subject: [PATCH v9 14/18] arm64: kexec: offset for relocation function
Date:   Wed, 25 Mar 2020 23:24:16 -0400
Message-Id: <20200326032420.27220-15-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326032420.27220-1-pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soon, relocation function will share the same page with EL2 vectors.
Add offset within this page to arm64_relocate_new_kernel, and also
the total size of relocation code which will include both the function
and the EL2 vectors.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h      |  7 +++++++
 arch/arm64/kernel/machine_kexec.c   | 13 ++++---------
 arch/arm64/kernel/relocate_kernel.S | 16 +++++++++++-----
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 990185744148..d944c2e289b2 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -90,6 +90,13 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#if defined(CONFIG_KEXEC_CORE)
+/* The beginning and size of relcation code to stage 2 kernel */
+extern const unsigned long kexec_relocate_code_size;
+extern const unsigned char kexec_relocate_code_start[];
+extern const unsigned long kexec_kern_reloc_offset;
+#endif
+
 /*
  * kern_reloc_arg is passed to kernel relocation function as an argument.
  * head		kimage->head, allows to traverse through relocation segments.
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index b1122eea627e..ab571fca9bd1 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -23,10 +23,6 @@
 
 #include "cpu-reset.h"
 
-/* Global variables for the arm64_relocate_new_kernel routine. */
-extern const unsigned char arm64_relocate_new_kernel[];
-extern const unsigned long arm64_relocate_new_kernel_size;
-
 /**
  * kexec_image_info - For debugging output.
  */
@@ -82,9 +78,8 @@ int machine_kexec_post_load(struct kimage *kimage)
 	if (!kern_reloc_arg)
 		return -ENOMEM;
 
-	memcpy(reloc_code, arm64_relocate_new_kernel,
-	       arm64_relocate_new_kernel_size);
-	kimage->arch.kern_reloc = __pa(reloc_code);
+	memcpy(reloc_code, kexec_relocate_code_start, kexec_relocate_code_size);
+	kimage->arch.kern_reloc = __pa(reloc_code) + kexec_kern_reloc_offset;
 	kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
 	kern_reloc_arg->head = kimage->head;
 	kern_reloc_arg->entry_addr = kimage->start;
@@ -189,7 +184,7 @@ void machine_kexec(struct kimage *kimage)
 		"Some CPUs may be stale, kdump will be unreliable.\n");
 
 	/* Flush the reboot_code_buffer in preparation for its execution. */
-	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
+	__flush_dcache_area(reboot_code_buffer, kexec_relocate_code_size);
 
 	/*
 	 * Although we've killed off the secondary CPUs, we don't update
@@ -198,7 +193,7 @@ void machine_kexec(struct kimage *kimage)
 	 * the offline CPUs. Therefore, we must use the __* variant here.
 	 */
 	__flush_icache_range((uintptr_t)reboot_code_buffer,
-			     arm64_relocate_new_kernel_size);
+			     kexec_relocate_code_size);
 
 	/* Flush the kimage list and its buffers. */
 	kexec_list_flush(kimage);
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 22ccdcb106d3..aa9f2b2cd77c 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -14,6 +14,9 @@
 #include <asm/page.h>
 #include <asm/sysreg.h>
 
+.globl kexec_relocate_code_start
+kexec_relocate_code_start:
+
 /*
  * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
  *
@@ -86,13 +89,16 @@ ENTRY(arm64_relocate_new_kernel)
 .ltorg
 END(arm64_relocate_new_kernel)
 
-.Lcopy_end:
+.Lkexec_relocate_code_end:
 .org	KEXEC_CONTROL_PAGE_SIZE
 .align 3	/* To keep the 64-bit values below naturally aligned. */
 /*
- * arm64_relocate_new_kernel_size - Number of bytes to copy to the
+ * kexec_relocate_code_size - Number of bytes to copy to the
  * control_code_page.
  */
-.globl arm64_relocate_new_kernel_size
-arm64_relocate_new_kernel_size:
-	.quad	.Lcopy_end - arm64_relocate_new_kernel
+.globl kexec_relocate_code_size
+kexec_relocate_code_size:
+	.quad	.Lkexec_relocate_code_end - kexec_relocate_code_start
+.globl kexec_kern_reloc_offset
+kexec_kern_reloc_offset:
+	.quad	arm64_relocate_new_kernel - kexec_relocate_code_start
-- 
2.17.1

