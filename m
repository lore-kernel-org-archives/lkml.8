Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3317C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA8520848
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="awPv9oW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgCIIWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:22:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38110 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgCIIWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:22:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id g21so4491102pfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44ohgZ8deiXiTIWwACgPHy8hMdjRJxnancDlAiZcvyo=;
        b=awPv9oW3EDFrhC3b4wM/bLCaObQLwOZcmR0v3cSNMbRubNZydG4GBRmw2qgyDfscSV
         3Da8e+Kvt0g9MmNe51rnNWHxdbfGfqfJAMCOBqjzLWnwogCLPHk9Tyus3c7GaE4sSV9M
         EI5bwBc6VD4DcMCAn+2O9vCfIMv8duwyf6+OUtGTL3iC10/ZvECvsWmp131n3nqNJcKp
         K1agHyJswK88v5mgWvRofyoIY3aW5JB9LXSTux6LcZgxwXnVOorb2aLXmQ3EYhU6OPwd
         GV+5gwz1cpF96eUpXy9ck6Hh8y5RUvJ4AfOWRwM44o83zJMda12rMhfGDKjr7GHTf5oe
         nxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44ohgZ8deiXiTIWwACgPHy8hMdjRJxnancDlAiZcvyo=;
        b=mZsRl74vTp5X0qkK4uZFlGaEOhvM6oylE6n3SppIHHpaF/SF9FudnDa+r8YtmjVAkM
         Sa72jxgBFKw4ZgPOV2R9Y04AJxQhfZpkOk+J5EnI8ftPtaPm1+jsLIEAxWimEb86ZrUU
         vGlzl4ropLWwwdXmX4Jj/AhTWnaB2+K7krXJ8BqWC0k615Ueg49Opq+uW3eBhu4PTp4E
         W5uFn89WkJeaU13yrs+Xo1y2+nf6QlyVVqRtNL6Cw8XPMgGaHr+f2lNlGeTJpsFXUqFC
         +kpgymaI+uq6u3fS0QpIF4NU7kss6QPAhy8jqgpHPYsGxHShOamMzWakd9rr2Ia+4M7X
         PigQ==
X-Gm-Message-State: ANhLgQ3yCessyH4cwzQ6EtLOvoeSLDyvba5yPyX6AVNlE4n5vvUiU6yv
        mnUYujNrXOGITWi7bw50p35uMw==
X-Google-Smtp-Source: ADFU+vtQuVeRfU0FUd3mIl1FEf4n9oKe/9HwnFdEtQ1z449xsA5qMr8VjoM1AtqtwOJNIq/dL7exOg==
X-Received: by 2002:a63:161e:: with SMTP id w30mr15126334pgl.110.1583742167548;
        Mon, 09 Mar 2020 01:22:47 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id v5sm18364779pfn.64.2020.03.09.01.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 01:22:47 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 5/9] riscv: add alignment for text, rodata and data sections
Date:   Mon,  9 Mar 2020 16:22:25 +0800
Message-Id: <dc6082fd444e6999d9fe965f05d798a71258e800.1583741997.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583741997.git.zong.li@sifive.com>
References: <cover.1583741997.git.zong.li@sifive.com>
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
---
 arch/riscv/include/asm/set_memory.h | 13 +++++++++++++
 arch/riscv/kernel/vmlinux.lds.S     |  5 ++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index a9783a878dca..a91f192063c2 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -6,6 +6,7 @@
 #ifndef _ASM_RISCV_SET_MEMORY_H
 #define _ASM_RISCV_SET_MEMORY_H
 
+#ifndef __ASSEMBLY__
 /*
  * Functions to change memory attributes.
  */
@@ -17,4 +18,16 @@ int set_memory_nx(unsigned long addr, int numpages);
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
2.25.1

