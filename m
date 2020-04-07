Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62D1C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BCF208FE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JBxizfUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgDGOrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:47:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33700 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbgDGOrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:47:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id d17so1844570pgo.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=geDMvpdyp4eREUjGenxPiMAgszPzsf8hdgTrRUcyDVI=;
        b=JBxizfUVQ4VwCje90RdukKZBh/ywXEy+VAtWwgau09WHsbrygimeUgLaDGNihbFdPZ
         eDybrac2/Ma3vtwVtZ+dV10ejldg12V79mPPn+6PEcb+pYiamkJfHvdVCc3pQywEgffS
         61nByA/bmGC+KvIQ961VXAVS+jeOKfdvsn2YvlzRhS4+b9g+s7hBJOhV9Zurmg6tfc88
         hRFeb/pdtnq4jQdvIW1maqRVT/GoZMh6q3OCXYlUAxtVz2Sa7KW7AhM451d55reG1kbv
         bdvnAWUvHjr7PiJ0CRL0hEJnBVdf4VVNAcT2NTV9xOdaANofRCoMNuG4j0Ia+W6wAhRU
         xUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=geDMvpdyp4eREUjGenxPiMAgszPzsf8hdgTrRUcyDVI=;
        b=PDD+Wp1b4qdo/aC5XpAIHJ8i2ULXGhhUh0nY5LVwinExX6VVkivLQgimS6RXsRkRH9
         9m8lg0fZ8b1mreDEua8dy4kKJzxXPQndPgDO2o2tCmqY5nOGavljq+AyRuy8Yn9KHvQQ
         rtklDlZNMMeDmKCxVNe8Rqu0CiaZ5uEqRRIUMYVwZYfDONLchU1Jv5lC5wlSbjvKxFud
         nU7dniQTItKIMPyrPVDtzOSFcBNPVpJ1wf/nPK7dE81oXcyvWFOnzI6LenqZdaL06RIy
         D7w/F3La2MkiVolGCyxF2oqfQbX7EYU2QsXOsjovPJsDKd8P1WhWPQissFncGlPUpwLM
         mz7g==
X-Gm-Message-State: AGi0PuZ6tW8rIyB1tzMIBHteVrVyz1PyIWRAmWc+IfIVEXw8ogkUi41R
        ie4fTZxWAV4K6DIDib0Levlbwg==
X-Google-Smtp-Source: APiQypJSC+TFUHwlK7PTtzsWm3RbNjRWth5EDoVm2mJoigQnMWAkG6PwXQSKKLPQx1AAHMmzFA/bEg==
X-Received: by 2002:aa7:9a08:: with SMTP id w8mr2724871pfj.317.1586270835251;
        Tue, 07 Apr 2020 07:47:15 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id y15sm14190093pfc.206.2020.04.07.07.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:47:14 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v4 8/9] riscv: add alignment for text, rodata and data sections
Date:   Tue,  7 Apr 2020 22:46:53 +0800
Message-Id: <24d705447a3033ee94c3dc9687b97870e2521090.1586265122.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586265122.git.zong.li@sifive.com>
References: <cover.1586265122.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel mapping will tried to optimize its mapping by using bigger
size. In rv64, it tries to use PMD_SIZE, and tryies to use PGDIR_SIZE in
rv32. To ensure that the start address of these sections could fit the
mapping entry size, make them align to the biggest alignment.

Define a macro SECTION_ALIGN because the HPAGE_SIZE or PMD_SIZE, etc.,
are invisible in linker script.

This patch is prepared for STRICT_KERNEL_RWX support.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/set_memory.h | 13 +++++++++++++
 arch/riscv/kernel/vmlinux.lds.S     |  5 ++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index 620d81c372d9..4c5bae7ca01c 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -6,6 +6,7 @@
 #ifndef _ASM_RISCV_SET_MEMORY_H
 #define _ASM_RISCV_SET_MEMORY_H
 
+#ifndef __ASSEMBLY__
 /*
  * Functions to change memory attributes.
  */
@@ -24,4 +25,16 @@ static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 
+#endif /* __ASSEMBLY__ */
+
+#ifdef CONFIG_ARCH_HAS_STRICT_KERNEL_RWX
+#ifdef CONFIG_64BIT
+#define SECTION_ALIGN (1 << 21)
+#else
+#define SECTION_ALIGN (1 << 22)
+#endif
+#else /* !CONFIG_ARCH_HAS_STRICT_KERNEL_RWX */
+#define SECTION_ALIGN L1_CACHE_BYTES
+#endif /* CONFIG_ARCH_HAS_STRICT_KERNEL_RWX */
+
 #endif /* _ASM_RISCV_SET_MEMORY_H */
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 02e948b620af..ef87deea0350 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -9,6 +9,7 @@
 #include <asm/page.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
+#include <asm/set_memory.h>
 
 OUTPUT_ARCH(riscv)
 ENTRY(_start)
@@ -36,6 +37,7 @@ SECTIONS
 	PERCPU_SECTION(L1_CACHE_BYTES)
 	__init_end = .;
 
+	. = ALIGN(SECTION_ALIGN);
 	.text : {
 		_text = .;
 		_stext = .;
@@ -53,13 +55,14 @@ SECTIONS
 
 	/* Start of data section */
 	_sdata = .;
-	RO_DATA(L1_CACHE_BYTES)
+	RO_DATA(SECTION_ALIGN)
 	.srodata : {
 		*(.srodata*)
 	}
 
 	EXCEPTION_TABLE(0x10)
 
+	. = ALIGN(SECTION_ALIGN);
 	_data = .;
 
 	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
-- 
2.26.0

