Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126FAC18E5C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D6720727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Sx5t7i4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCIQ4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:56:06 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51923 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgCIQ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:56:01 -0400
Received: by mail-pj1-f66.google.com with SMTP id y7so115130pjn.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOvGoomldlItgrTMe3b4RPvPtMpqmI4vOPIxgU5N5dw=;
        b=Sx5t7i4qo7aZC3e6rBAaMwJOSvAe94WC6mvx/MQEjX+d/7LAbkmXgEXeV1meT/5Rgx
         WQYUaQkMp2UN5BeERTN/yq/g384+aAor82Dq3CQsz8s3fhSQIgfhNA4Mog8V77Psp6KN
         CE8ZLqsaaRqY+gH5n7M+rHmJ6CmUOak7gZ02LWQbYgTGSKbPkQ2hmDWSDeuHYUR+lvm9
         Dz5+6J7fnjLxSNK333c7nXq2/D0eJWn6+RIhnWK4bWLBb1ztsE459vR/CerehyiWRdS8
         BiNmV3bfU/7SPip+wqhSyQR3OZckv4l7CqoOwRNyqHSIHlRL5P0s8GQtv38mgDU68BAn
         MFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOvGoomldlItgrTMe3b4RPvPtMpqmI4vOPIxgU5N5dw=;
        b=DKBrEiVmoYmKpX28kzL9YfN+Q4mayYJQER6pZAqL+nc93wIxhjK5CHZkkkYBPgcroY
         OES9tyWUp/qKGJT7ks3xw8NqK3v+wmj03aC3U2ZBseJ14srDAPzpw01i3vF5fuR+0ej+
         aSHCT0DVoI61N0NdTOMd1cUyn2EwWHIi51OXcLMzjc7TlVUpEO8fz/cTaiUF0V5EOCFV
         E+7ZZ1+BQi0DiFFJ1Z7adhHKS6a8HJX01GDXMBju5VUDr1XDIjxC/wLqvRI0Gx2y1EzL
         u4o/gaRbFzuBZ+sthWzBeftajJFIpQJrCYbWOTydGyXhrpn/456s4s5Mz+UFeqC6h7bC
         DhFA==
X-Gm-Message-State: ANhLgQ3goUsu4pNo8hx7rNW/+6/6bf7eHdtMQXZ5lYDqpNQ3BAcM6RnP
        496XqWERTp+0oYtMuDFStLMwvg==
X-Google-Smtp-Source: ADFU+vs7rseCVIQDvOgK+WTfSYKco3QVTCiqheNNtMu77pT1JjgjykTot1HoW3biIyEloUH6n7nrtg==
X-Received: by 2002:a17:902:b485:: with SMTP id y5mr15847694plr.4.1583772960751;
        Mon, 09 Mar 2020 09:56:00 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id cm2sm104013pjb.23.2020.03.09.09.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 09:56:00 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 5/9] riscv: add alignment for text, rodata and data sections
Date:   Tue, 10 Mar 2020 00:55:40 +0800
Message-Id: <0e60e503eefbebeb9c9a24a125feef876a80c148.1583772574.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583772574.git.zong.li@sifive.com>
References: <cover.1583772574.git.zong.li@sifive.com>
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
2.25.1

