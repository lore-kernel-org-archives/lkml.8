Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D743DC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA2220747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="S5QTx2CF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgDHH52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:57:28 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34242 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgDHH50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:57:26 -0400
Received: by mail-pj1-f67.google.com with SMTP id q16so1953417pje.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 00:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=geDMvpdyp4eREUjGenxPiMAgszPzsf8hdgTrRUcyDVI=;
        b=S5QTx2CFt98Mt0i/C+3txkabVRmjPH9b1pHlRJMR81mtdW58kYh3qyK64Fxh3p+xSf
         aAW3UKDWwCxdsOUs10tw5Ieny0e/pYI/NixKjBtIvtsme6hq16mKn0ItpbINHGIfLrgl
         ahuZAlc1+dGCD+d7DCjrGl9v4lTLPWjkH+eMkZ2iyLMgWUlGt93OeiLRRj5jrflGGofw
         K+B3X0TIF3SIYc19ebpPfRZ0nORpsN0mnJSbba8ZifizsOIGjzaTmsoSA6e1xANjcnWr
         C2IZ5SKoe/ACv7Ijz+iMtf02S2kQM754MH/kuVyZkMTV6803o5EHrqrVFleBcaWMTS8a
         lPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=geDMvpdyp4eREUjGenxPiMAgszPzsf8hdgTrRUcyDVI=;
        b=GM4LUOq7vnyOa36EWsq+Kg4dEG5QNY/J/FbmAafBxDmyY0/HQCyB/GFFWUEbnEiieP
         CeAN67OPw8/MJowtzPXAB+YHjfGN5iftd8KCBgi+U9h/IeGlRd8iRBGfIh+oe1A9puwM
         9vhRrnVWFSMhI9ht6Q547xATie77+jf9rAdAa6hdT9sfzxmHTIg9xPPY4VV82LqeBox/
         rKJs7Kev46bNIvfP5rgXsT3gPs2983i0GqlbYzoeyf87fjHYg/l7NXFPGzNY6i0causV
         mDSOodosx1KjjLudYN7fhzzFXEh0IfASdJdyQEuyEC4sd3jefDzVdDs/dh7Y3yuLqeDI
         NgLA==
X-Gm-Message-State: AGi0PubMvspWwUAFBlMxAZMDkgP0EE7exvhen2nmZtg2YJPYfSrpNFJF
        SW1tmN+1KqVxWkGcGs5GCPqLqA==
X-Google-Smtp-Source: APiQypI5ixhPVxiaOZYKBPMsxFPDPz2i1VrQzUF3bngypFXRTDQ8GJzp3IxjnJPFrgBfCklRUsc91A==
X-Received: by 2002:a17:90a:1b6b:: with SMTP id q98mr3859791pjq.107.1586332644756;
        Wed, 08 Apr 2020 00:57:24 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d85sm485599pfd.157.2020.04.08.00.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 00:57:24 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v5 8/9] riscv: add alignment for text, rodata and data sections
Date:   Wed,  8 Apr 2020 15:57:03 +0800
Message-Id: <d78c601d553dde791057b54252064221f960546e.1586332296.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586332296.git.zong.li@sifive.com>
References: <cover.1586332296.git.zong.li@sifive.com>
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

