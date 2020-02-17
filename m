Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209B9C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE9420725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QqfINpR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgBQIcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:32:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37088 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgBQIci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:32:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id z12so8683645pgl.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 00:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gPsxu3vF78VOjjNcgLn5UDiKYUv2stj5MGhKdcRPAdc=;
        b=QqfINpR4S7uL5kzHi8zrFcEKpS0Hg6u0xhWvKZCxhOoVT8L95+H0av5sZv8SMIac4L
         m9Y32Pb60l6i1c8EfoTohasGi8mVKDbPiE0EDl1u6VhnGCKibAoT6zpoy+iy39KUZ04/
         FUQBEUjTIyi+2LGaFqST+8rSr2NfpNuJzZUgUftU5yT2l2zNwxGg2krVwXx0x92LIn37
         b8pR/IMMdGiJbQhsUJKH8Tl+ksvjKtjFBw4uZH39UnW+/bsuwYxlExwcEn7Ipy/wKW2Q
         AgoGrRI8Xr92quYiRyKvvcFt82qn06dATL7pOG399TqQvwYf4d3HOxfXR/ALUQqKVLEb
         BzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gPsxu3vF78VOjjNcgLn5UDiKYUv2stj5MGhKdcRPAdc=;
        b=jqPmgRtCBB6PabUWwWiIjvGWuxmgh8CtOd7p+AYq95EsraqayfmWVvlgXOFS2GgvYV
         jQ6b175/dr01uBp86Wo7sgdsEJt1GW7P3E34uPGVDGh2G+Ltdqkti0OqjUOLv88cr7tY
         oLVRQTnxdqzTvkt9oLeRNrysF/xWRK22Uw1bJ+EYTnxPnjHtDraq//PQUZsJffCxdzRq
         CQjLlUi5VrwbQyxmJKqSYlAD0R2+Vg4ZQhlQzJ/rH4+x1MAsZkh6WraauaJZMnJKQTUj
         MrUCpGOQRAlVg9UMWGqjIJMATzC2gCzqgnuDGOjCmiBoitRgl9WlupfgsCaXpVXSo9ki
         Vfzg==
X-Gm-Message-State: APjAAAUj0QlrCTYF2AoVfpq4OxEwwtjh5FhySP9eCEgHhSWw0OerHvRh
        9AwxBpj0U7WZD7TcqJutVYP9jR8Zets=
X-Google-Smtp-Source: APXvYqymt76w2DY7nuRpkPY4VFK07kmA6SpuJN4xTsV3hOUxHlwKdESWCmhnp5BoDlnAx1z2ts+Gfg==
X-Received: by 2002:a63:6441:: with SMTP id y62mr15877518pgb.86.1581928357485;
        Mon, 17 Feb 2020 00:32:37 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id z10sm16989319pgz.88.2020.02.17.00.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:32:37 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 5/8] riscv: add alignment for text, rodata and data sections
Date:   Mon, 17 Feb 2020 16:32:20 +0800
Message-Id: <20200217083223.2011-6-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217083223.2011-1-zong.li@sifive.com>
References: <20200217083223.2011-1-zong.li@sifive.com>
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
 arch/riscv/kernel/vmlinux.lds.S     |  4 +++-
 2 files changed, 16 insertions(+), 1 deletion(-)

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
index 4ba8a5397e8b..0b145b9c1778 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -37,6 +37,7 @@ SECTIONS
 	PERCPU_SECTION(L1_CACHE_BYTES)
 	__init_end = .;
 
+	. = ALIGN(SECTION_ALIGN);
 	.text : {
 		_text = .;
 		_stext = .;
@@ -53,13 +54,14 @@ SECTIONS
 	}
 
 	/* Start of data section */
-	RO_DATA(L1_CACHE_BYTES)
+	RO_DATA(SECTION_ALIGN)
 	.srodata : {
 		*(.srodata*)
 	}
 
 	EXCEPTION_TABLE(0x10)
 
+	. = ALIGN(SECTION_ALIGN);
 	_sdata = .;
 
 	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
-- 
2.25.0

