Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920EBC54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3282076A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FFPXtP0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCXHbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:31:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35689 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgCXHbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:31:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id 7so8616157pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 00:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XEXvf7YM3IfG8+Nza4lz7YWo/aCxS7DRWP5Lj0YYBjc=;
        b=FFPXtP0JGFZuxhK64DdBrFFIn56NYFvcpNK4yw2jPsrNBzClysK7yzg71194N9zxlm
         DahcEGASnS2ix5XgdwV4Lo9/xTQnS7dbdexFOYf9D9V/N1n6i5a6r5ro0rFbNJFZcj11
         zLkBMr4Vt++GfCQOzTAFEa0m+Wvc+ZyFp5Z8gZl6H6Yrdc0JCKu7QON2n2vuswysspfK
         FjefZR8RpVRjH6rQq94sITHb2ZfhG8tVOzJJsl4bUe2bFTLcio7f5m4GDprt6yrHDQlf
         fJJiesOscjpShsShndfOjML8ZFBlEYONjEBWGDRYn6lcWE46TdJ+ecom/MTHMqdtm32f
         wAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XEXvf7YM3IfG8+Nza4lz7YWo/aCxS7DRWP5Lj0YYBjc=;
        b=BiOjW87uIBct9YMAy7/Xk+vabTQg6QGirhjDjFJohX6OkwOhJvDO12F+IJKPVXjxaw
         jnaj0ayESQZ6+Z4fzSOnxt1jyPpoDU3cX1Sg4r73V5H+wMYTmIhvkQizdEZRK2HN8BRE
         L8RAbLltVrJALjvUOmYNph4uC9EZVrfI+wnHMetNXXsKYAmTaRszVELt7NB7M4zcumfo
         AqrokJ4G4/+TJpIjc2jPtUrJNAOv26h9kqsbpTANzut5MbwbpJpkdQ15RHtK3ChlSj2n
         HaX/9uZl9AtpEpwapqKHPHJBBVJqkjeLY8Wleky2zyMBRtfBOMhJeFyRpjkYPaq7XXz3
         4Wsw==
X-Gm-Message-State: ANhLgQ1vPS9gsqJDV9rYroi3srVPGOS/dUv0nNIFCYDnNjK/6UESYA9F
        1Xku5+KB46OmVIK02OsWWZb18A==
X-Google-Smtp-Source: ADFU+vsdrPgNn4KpM07PAP6pvwMAOBhla8yo85VYdbcgVyUYoPwTMJ1rmnsy6w33qY/lkhlyJ+8YlQ==
X-Received: by 2002:a63:7c02:: with SMTP id x2mr26880475pgc.236.1585035067681;
        Tue, 24 Mar 2020 00:31:07 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id i187sm15124648pfg.33.2020.03.24.00.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 00:31:07 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, alex@ghiti.fr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH RFC 6/8] riscv/kaslr: clear the original kernel image
Date:   Tue, 24 Mar 2020 15:30:51 +0800
Message-Id: <8373a9d18958b99b72ed9499786dffe45adf9617.1584352425.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1584352425.git.zong.li@sifive.com>
References: <cover.1584352425.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After completing final page table, we can clear original kernel image
and remove executable permission.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/include/asm/kaslr.h | 12 ++++++++++++
 arch/riscv/kernel/kaslr.c      | 12 ++++++++++++
 arch/riscv/mm/init.c           |  6 ++++++
 3 files changed, 30 insertions(+)
 create mode 100644 arch/riscv/include/asm/kaslr.h

diff --git a/arch/riscv/include/asm/kaslr.h b/arch/riscv/include/asm/kaslr.h
new file mode 100644
index 000000000000..b165fe71dd4a
--- /dev/null
+++ b/arch/riscv/include/asm/kaslr.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 SiFive
+ * Copyright (C) 2020 Zong Li <zong.li@sifive.com>
+ */
+
+#ifndef _ASM_RISCV_KASLR_H
+#define _ASM_RISCV_KASLR_H
+
+void __init kaslr_late_init(void);
+
+#endif /* _ASM_RISCV_KASLR_H */
diff --git a/arch/riscv/kernel/kaslr.c b/arch/riscv/kernel/kaslr.c
index 59001d6fdfc3..0bd30831c455 100644
--- a/arch/riscv/kernel/kaslr.c
+++ b/arch/riscv/kernel/kaslr.c
@@ -356,6 +356,18 @@ static __init uintptr_t get_random_offset(u64 seed, uintptr_t kernel_size)
 	return get_legal_offset(random, kernel_size_align);
 }
 
+void __init kaslr_late_init(void)
+{
+	uintptr_t kernel_size;
+
+	/* Clear original kernel image. */
+	if (kaslr_offset) {
+		kernel_size = (uintptr_t) _end - (uintptr_t) _start;
+		memset((void *)PAGE_OFFSET, 0, kernel_size);
+		set_memory_nx(PAGE_OFFSET, kaslr_offset >> PAGE_SHIFT);
+	}
+}
+
 uintptr_t __init kaslr_early_init(void)
 {
 	u64 seed;
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 34c6ecf2c599..08e2ce170533 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -15,6 +15,7 @@
 #include <linux/set_memory.h>
 #ifdef CONFIG_RELOCATABLE
 #include <linux/elf.h>
+#include <asm/kaslr.h>
 #endif
 
 #include <asm/fixmap.h>
@@ -649,6 +650,11 @@ static void __init setup_vm_final(void)
 	/* Move to swapper page table */
 	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
 	local_flush_tlb_all();
+
+#ifdef CONFIG_RANDOMIZE_BASE
+	/* Clear orignial kernel image and set the right permission. */
+	kaslr_late_init();
+#endif
 }
 
 void free_initmem(void)
-- 
2.25.1

