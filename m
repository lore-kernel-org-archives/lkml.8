Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E5EC54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD772076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FhK74WmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgCXHbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:31:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43205 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgCXHbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:31:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id f206so8865651pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 00:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y4huE9PkydIicq5T4ToTqpbGJkd9wdfCuQCsFDoDdXI=;
        b=FhK74WmXI7hJqCemmQx1mgserzDO1KLlmRwF1MCmAA+Kk32Vbp7pUevd18ZsmLpvT1
         eSTslws5Fr6Q1SiSTdS7Ctv1cgGPZe6IA5znoEUoyB4Nf/F5CTvnvkEi2laS26D10o/Q
         FNQy/TxTbKFJKnrWyKn3FCdrYiirhY1WWqPNDxrABFQ+WEfedXn8qf5VMWRif4m4CjaD
         GKi3ADkoOUNXDdGY2mswzgS7PsayHv/+FrQy5JgrNxok89w/44MR0I+BIhpAPbLOuv4Y
         j37eYW0F/wfWKcoNvhYvcNvz5C6sjcWZNKSufkqJJDJKqBhH7H9GtX2aSisITqoZPW5H
         WlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y4huE9PkydIicq5T4ToTqpbGJkd9wdfCuQCsFDoDdXI=;
        b=Uc0kOCOOu21cIA9mXIGI8+Fwlf5kXDpNRbOD0E5ElpLlBfgPxw/+HhEiEgh3F/xU8x
         KWTwPaS9CQI++6Dea6mbbM9bxbNT6qdQJOU4oAkSdkpUIVqLqP61cvKMJEOREC77CIGU
         T2RpGnV431+CN7KrEI9u5JN26XWP4MkOyXIphfH/zq19Br+AeliO/Dw0vdOjZKiRKU2z
         Ltxg2fBCfgIdAja8HNb7TPVVKeV5TwBQv4LOKr59cF+29aFbcoY0o+zH0xcWFswNfsIB
         XMas1p7AKgL8DsIiaU9zeaEuIV/Q8S56HPCHtGbEOI+p47vvjT4Z93DbBT/J14i4MG9B
         wZXQ==
X-Gm-Message-State: ANhLgQ0f6jwW7fCU/ywHuPoWKLFdLetEan4C8nL30Ktx55JrnN//Lscc
        mXPF2e0GZXj5TZkChyLCYUHqGQ==
X-Google-Smtp-Source: ADFU+vv5SjTRjPOReGo2Qbtrxk+zEIUWvNyjITDupdkD8rEgyr3X1n0khPpCY5ThEbL31ODjAG7mwg==
X-Received: by 2002:a63:7b1a:: with SMTP id w26mr9084743pgc.298.1585035065921;
        Tue, 24 Mar 2020 00:31:05 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id i187sm15124648pfg.33.2020.03.24.00.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 00:31:05 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, alex@ghiti.fr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH RFC 5/8] riscv/kaslr: support sparse memory model
Date:   Tue, 24 Mar 2020 15:30:50 +0800
Message-Id: <b32708e9fad13e8e86c4514842c9c065841b99b5.1584352425.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1584352425.git.zong.li@sifive.com>
References: <cover.1584352425.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For sparse memory model, we select a random memory node first, then get
a random offset in this node. It gets one memory node in flat memory
model case.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/kernel/kaslr.c | 139 ++++++++++++++++++++++++++++----------
 1 file changed, 105 insertions(+), 34 deletions(-)

diff --git a/arch/riscv/kernel/kaslr.c b/arch/riscv/kernel/kaslr.c
index 9ec2b608eb7f..59001d6fdfc3 100644
--- a/arch/riscv/kernel/kaslr.c
+++ b/arch/riscv/kernel/kaslr.c
@@ -55,8 +55,9 @@ static __init int get_node_addr_size_cells(const char *path, int *addr_cell,
 
 static __init void kaslr_get_mem_info(uintptr_t *mem_start,
 				      uintptr_t *mem_size)
+				      uintptr_t kernel_size, int find_index)
 {
-	int node, root, addr_cells, size_cells;
+	int node, root, addr_cells, size_cells, idx = 0;
 	u64 base, size;
 
 	/* Get root node's address cells and size cells. */
@@ -81,14 +82,56 @@ static __init void kaslr_get_mem_info(uintptr_t *mem_start,
 			reg = get_reg_address(addr_cells, reg, &base);
 			reg = get_reg_address(size_cells, reg, &size);
 
-			*mem_start = base;
-			*mem_size = size;
+			if (size < (kernel_size * 2))
+				continue;
 
-			break;
+			if (idx == find_index) {
+				*mem_start = base;
+				*mem_size = size;
+				break;
+			}
+
+			idx++;
 		}
 	}
 }
 
+static __init int get_memory_nodes_num(uintptr_t kernel_size)
+{
+	int node, root, addr_cells, size_cells, total_nodes = 0;
+	u64 base, size;
+
+	/* Get root node's address cells and size cells. */
+	root = get_node_addr_size_cells("/", &addr_cells, &size_cells);
+	if (root < 0)
+		return 0;
+
+	/* Get memory base address and size. */
+	fdt_for_each_subnode(node, dtb_early_va, root) {
+		const char *dev_type;
+		const u32 *reg;
+
+		dev_type = fdt_getprop(dtb_early_va, node, "device_type", NULL);
+		if (!dev_type)
+			continue;
+
+		if (!strcmp(dev_type, "memory")) {
+			reg = fdt_getprop(dtb_early_va, node, "reg", NULL);
+			if (!reg)
+				return 0;
+
+			reg = get_reg_address(addr_cells, reg, &base);
+			reg = get_reg_address(size_cells, reg, &size);
+
+			/* Candidate ensures that it don't overlap itself. */
+			if (size > kernel_size * 2)
+				total_nodes++;
+		}
+	}
+
+	return total_nodes;
+}
+
 /* Return a default seed if there is no HW generator. */
 static u64 kaslr_default_seed = ULL(-1);
 static __init u64 kaslr_get_seed(void)
@@ -198,10 +241,11 @@ static __init bool has_regions_overlapping(uintptr_t start_addr,
 	return false;
 }
 
-static inline __init unsigned long get_legal_offset(int random_index,
-						    int max_index,
-						    uintptr_t mem_start,
-						    uintptr_t kernel_size)
+static inline __init unsigned long get_legal_offset_in_node(int random_index,
+							    int max_index,
+							    uintptr_t mem_start,
+							    uintptr_t
+							    kernel_size)
 {
 	uintptr_t start_addr, end_addr;
 	int idx, stop_idx;
@@ -214,7 +258,8 @@ static inline __init unsigned long get_legal_offset(int random_index,
 
 		/* Check overlap to other regions. */
 		if (!has_regions_overlapping(start_addr, end_addr))
-			return idx * SZ_2M + kernel_size;
+			return idx * SZ_2M + kernel_size + (mem_start -
+							    __pa(PAGE_OFFSET));
 
 		if (idx-- < 0)
 			idx = max_index;
@@ -224,6 +269,56 @@ static inline __init unsigned long get_legal_offset(int random_index,
 	return 0;
 }
 
+#define MEM_RESERVE_START	__pa(PAGE_OFFSET)
+static inline __init unsigned long get_legal_offset(u64 random,
+						    uintptr_t kernel_size)
+{
+	int mem_nodes, idx, stop_idx, index;
+	uintptr_t mem_start = 0, mem_size = 0, random_size, ret;
+
+	mem_nodes = get_memory_nodes_num(kernel_size);
+
+	idx = stop_idx = random % mem_nodes;
+
+	do {
+		kaslr_get_mem_info(&mem_start, &mem_size, kernel_size, idx);
+
+		if (!mem_size)
+			return 0;
+
+		if (mem_start < MEM_RESERVE_START) {
+			mem_size -= MEM_RESERVE_START - mem_start;
+			mem_start = MEM_RESERVE_START;
+		}
+
+		/*
+		 * Limit randomization range within 1G, so we can exploit
+		 * early_pmd/early_pte during early page table phase.
+		 */
+		random_size = min_t(u64,
+				    mem_size - (kernel_size * 2),
+				    SZ_1G - (kernel_size * 2));
+
+		if (!random_size || random_size < SZ_2M)
+			return 0;
+
+		/* The index of 2M block in whole available region */
+		index = random % (random_size / SZ_2M);
+
+		ret =
+		    get_legal_offset_in_node(index, random_size / SZ_2M,
+					     mem_start, kernel_size);
+		if (ret)
+			break;
+
+		if (idx-- < 0)
+			idx = mem_nodes - 1;
+
+	} while (idx != stop_idx);
+
+	return ret;
+}
+
 static inline __init u64 rotate_xor(u64 hash, const void *area, size_t size)
 {
 	size_t i;
@@ -238,12 +333,9 @@ static inline __init u64 rotate_xor(u64 hash, const void *area, size_t size)
 	return hash;
 }
 
-#define MEM_RESERVE_START	__pa(PAGE_OFFSET)
 static __init uintptr_t get_random_offset(u64 seed, uintptr_t kernel_size)
 {
-	uintptr_t mem_start = 0, mem_size= 0, random_size;
 	uintptr_t kernel_size_align = round_up(kernel_size, SZ_2M);
-	int index;
 	u64 random = 0;
 	cycles_t time_base;
 
@@ -261,28 +353,7 @@ static __init uintptr_t get_random_offset(u64 seed, uintptr_t kernel_size)
 	if (seed)
 		random = rotate_xor(random, &seed, sizeof(seed));
 
-	kaslr_get_mem_info(&mem_start, &mem_size);
-	if (!mem_size)
-		return 0;
-
-	if (mem_start < MEM_RESERVE_START) {
-		mem_size -= MEM_RESERVE_START - mem_start;
-		mem_start = MEM_RESERVE_START;
-	}
-
-	/*
-	 * Limit randomization range within 1G, so we can exploit
-	 * early_pmd/early_pte during early page table phase.
-	 */
-	random_size = min_t(u64,
-			    mem_size - (kernel_size_align * 2),
-			    SZ_1G - (kernel_size_align * 2));
-
-	/* The index of 2M block in whole avaliable region */
-	index = random % (random_size / SZ_2M);
-
-	return get_legal_offset(index, random_size / SZ_2M,
-				mem_start, kernel_size_align);
+	return get_legal_offset(random, kernel_size_align);
 }
 
 uintptr_t __init kaslr_early_init(void)
-- 
2.25.1

