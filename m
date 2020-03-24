Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83B0C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B12A2076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AYn8T3ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCXHbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:31:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45599 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgCXHbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:31:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id j10so8858478pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 00:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oi42rC0je4n7md93kV9gmahD8VmOS3UfUyw23vs8Ns0=;
        b=AYn8T3ubd38OtJin3i3xmXBPcIi5ciekq98iIIYBpzHf5BnWO0Yn2D5yGf4wlJ33CB
         trXDJJACeFxaM7JRb2AUUmWkpZxS9oXYNYULjO1JekRvBuLxx+dPuGUoivxQeaREMd+D
         PYID/o///O47RXAAOkQ64oowLC9P5DkrE3l0WKdUUBVhKDpg8AGFv1C4jSdELI9n9hNw
         H2CbQtoeg6+OVgCwkS8aX09xy37pD4RYAhiaSo9+LjOVy60/KpEPejf9ZV/E5NyO3Hib
         I0QdH9ms+62I2vsBPq2vFtyvq/IEds7hyW5siVb8ItEWHYIKoTgkFcEdxTYAdJwzhFCb
         MkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oi42rC0je4n7md93kV9gmahD8VmOS3UfUyw23vs8Ns0=;
        b=N2UjiXrtQjKqIPtS329NFIVIWcOm7rdwwQ7fO+5tdvuG0rCmlMBUtKu5RSG4rCUCua
         s8It29GyQcIDmhv2Rw62epEmNVfQ8LdD4nA3kVMZY5NCmSPB9s5lfwlTMtkOV28Oy6FU
         oPDAMGrLCR4lwVcSaw26lx7iXWRuwV6TD33tYRgvhWDazJBXTrmKjiYSPGrnR2tyf1hg
         0YbysKMVxqFHSfm8WzwDfkn/LW+hRMqNx9ZtKCZBD8FoOkerDs8IMI4k4NRYf1rxwFDO
         ajiLby2ZhhpPLpJn9Cl85+FVftXvDR03UXFITzjucpj1nRcwLT1eJ0hP0Ux5aIegrcMk
         vEGg==
X-Gm-Message-State: ANhLgQ240PvASjK1IGJv/fRsyrCuL75mU37EhA5JzMPEnEMnCGkq6QY8
        M/ieqY1P78sRGvHJuLQ3M4+3PA==
X-Google-Smtp-Source: ADFU+vtDYbTt1sYmg/+1XWaDJl1dmryu65Dikphg9FI886DYT1GoTtbDvFi9lQIoqP+nxIl9GVMbiA==
X-Received: by 2002:a63:cd12:: with SMTP id i18mr24626903pgg.98.1585035064219;
        Tue, 24 Mar 2020 00:31:04 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id i187sm15124648pfg.33.2020.03.24.00.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 00:31:03 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, alex@ghiti.fr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH RFC 4/8] riscv/kaslr: randomize the kernel image offset
Date:   Tue, 24 Mar 2020 15:30:49 +0800
Message-Id: <16924c3f07b142688a3c0562d229cd67dc7bf8e6.1584352425.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1584352425.git.zong.li@sifive.com>
References: <cover.1584352425.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entropy is derived from the banner and timer, it is better than nothing
but not enough secure, so previous stage may pass entropy via the device
tree /chosen/kaslr-seed node.

We limit randomization range within 1GB, so we can exploit early page
table to map new destination of kernel image. Additionally, the kernel
offset need 2M alignment to ensure it's good in PMD page table.

We also checks the kernel offset whether it's safe by avoiding to
overlaps with dtb, initrd and reserved memory regions.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/kernel/kaslr.c | 274 +++++++++++++++++++++++++++++++++++++-
 arch/riscv/mm/init.c      |   2 +-
 2 files changed, 273 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/kaslr.c b/arch/riscv/kernel/kaslr.c
index 281b5fcca5c8..9ec2b608eb7f 100644
--- a/arch/riscv/kernel/kaslr.c
+++ b/arch/riscv/kernel/kaslr.c
@@ -11,23 +11,293 @@
 #include <asm/cacheflush.h>
 
 extern char _start[], _end[];
+extern void *dtb_early_va;
+extern phys_addr_t dtb_early_pa;
 extern void secondary_random_target(void);
 extern void kaslr_create_page_table(uintptr_t start, uintptr_t end);
 
 uintptr_t secondary_next_target __initdata;
 static uintptr_t kaslr_offset __initdata;
 
+static const __init u32 *get_reg_address(int root_cells,
+					 const u32 *value, u64 *result)
+{
+	int cell;
+	*result = 0;
+
+	for (cell = root_cells; cell > 0; --cell)
+		*result = (*result << 32) + fdt32_to_cpu(*value++);
+
+	return value;
+}
+
+static __init int get_node_addr_size_cells(const char *path, int *addr_cell,
+					   int *size_cell)
+{
+	int node = fdt_path_offset(dtb_early_va, path);
+	fdt64_t *prop;
+
+	if (node < 0)
+		return -EINVAL;
+
+	prop = fdt_getprop_w(dtb_early_va, node, "#address-cells", NULL);
+	if (!prop)
+		return -EINVAL;
+	*addr_cell = fdt32_to_cpu(*prop);
+
+	prop = fdt_getprop_w(dtb_early_va, node, "#size-cells", NULL);
+	if (!prop)
+		return -EINVAL;
+	*size_cell = fdt32_to_cpu(*prop);
+
+	return node;
+}
+
+static __init void kaslr_get_mem_info(uintptr_t *mem_start,
+				      uintptr_t *mem_size)
+{
+	int node, root, addr_cells, size_cells;
+	u64 base, size;
+
+	/* Get root node's address cells and size cells. */
+	root = get_node_addr_size_cells("/", &addr_cells, &size_cells);
+	if (root < 0)
+		return;
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
+				return;
+
+			reg = get_reg_address(addr_cells, reg, &base);
+			reg = get_reg_address(size_cells, reg, &size);
+
+			*mem_start = base;
+			*mem_size = size;
+
+			break;
+		}
+	}
+}
+
+/* Return a default seed if there is no HW generator. */
+static u64 kaslr_default_seed = ULL(-1);
+static __init u64 kaslr_get_seed(void)
+{
+	int node, len;
+	fdt64_t *prop;
+	u64 ret;
+
+	node = fdt_path_offset(dtb_early_va, "/chosen");
+	if (node < 0)
+		return kaslr_default_seed++;
+
+	prop = fdt_getprop_w(dtb_early_va, node, "kaslr-seed", &len);
+	if (!prop || len != sizeof(u64))
+		return kaslr_default_seed++;
+
+	ret = fdt64_to_cpu(*prop);
+
+	/* Re-write to zero for checking whether get seed at second time */
+	*prop = 0;
+
+	return ret;
+}
+
+static __init bool is_overlap(uintptr_t s1, uintptr_t e1, uintptr_t s2,
+			      uintptr_t e2)
+{
+	return e1 >= s2 && e2 >= s1;
+}
+
+static __init bool is_overlap_reserved_mem(uintptr_t start_addr,
+					   uintptr_t end_addr)
+{
+	int node, rsv_mem, addr_cells, size_cells;
+
+	/* Get the reserved-memory node. */
+	rsv_mem = get_node_addr_size_cells("/reserved-memory",
+					   &addr_cells,
+					   &size_cells);
+	if (rsv_mem < 0)
+		return false;
+
+	/* Get memory base address and size. */
+	fdt_for_each_subnode(node, dtb_early_va, rsv_mem) {
+		uint64_t base, size;
+		const uint32_t *reg;
+
+		reg = fdt_getprop(dtb_early_va, node, "reg", NULL);
+		if (!reg)
+			return 0;
+
+		reg = get_reg_address(addr_cells, reg, &base);
+		reg = get_reg_address(size_cells, reg, &size);
+
+		if (is_overlap(start_addr, end_addr, base, base + size))
+			return true;
+	}
+
+	return false;
+}
+
+static __init bool is_overlap_initrd(uintptr_t start_addr, uintptr_t end_addr)
+{
+	int node;
+	uintptr_t initrd_start, initrd_end;
+	fdt64_t *prop;
+
+	node = fdt_path_offset(dtb_early_va, "/chosen");
+	if (node < 0)
+		return false;
+
+	prop = fdt_getprop_w(dtb_early_va, node, "linux,initrd-start", NULL);
+	if (!prop)
+		return false;
+
+	initrd_start = fdt64_to_cpu(*prop);
+
+	prop = fdt_getprop_w(dtb_early_va, node, "linux,initrd-end", NULL);
+	if (!prop)
+		return false;
+
+	initrd_end = fdt64_to_cpu(*prop);
+
+	return is_overlap(start_addr, end_addr, initrd_start, initrd_end);
+}
+
+static __init bool is_overlap_dtb(uintptr_t start_addr, uintptr_t end_addr)
+{
+	uintptr_t dtb_start = dtb_early_pa;
+	uintptr_t dtb_end = dtb_start + fdt_totalsize(dtb_early_va);
+
+	return is_overlap(start_addr, end_addr, dtb_start, dtb_end);
+}
+
+static __init bool has_regions_overlapping(uintptr_t start_addr,
+					   uintptr_t end_addr)
+{
+	if (is_overlap_dtb(start_addr, end_addr))
+		return true;
+
+	if (is_overlap_initrd(start_addr, end_addr))
+		return true;
+
+	if (is_overlap_reserved_mem(start_addr, end_addr))
+		return true;
+
+	return false;
+}
+
+static inline __init unsigned long get_legal_offset(int random_index,
+						    int max_index,
+						    uintptr_t mem_start,
+						    uintptr_t kernel_size)
+{
+	uintptr_t start_addr, end_addr;
+	int idx, stop_idx;
+
+	idx = stop_idx = random_index;
+
+	do {
+		start_addr = mem_start + idx * SZ_2M + kernel_size;
+		end_addr = start_addr + kernel_size;
+
+		/* Check overlap to other regions. */
+		if (!has_regions_overlapping(start_addr, end_addr))
+			return idx * SZ_2M + kernel_size;
+
+		if (idx-- < 0)
+			idx = max_index;
+
+	} while (idx != stop_idx);
+
+	return 0;
+}
+
+static inline __init u64 rotate_xor(u64 hash, const void *area, size_t size)
+{
+	size_t i;
+	uintptr_t *ptr = (uintptr_t *) area;
+
+	for (i = 0; i < size / sizeof(hash); i++) {
+		/* Rotate by odd number of bits and XOR. */
+		hash = (hash << ((sizeof(hash) * 8) - 7)) | (hash >> 7);
+		hash ^= ptr[i];
+	}
+
+	return hash;
+}
+
+#define MEM_RESERVE_START	__pa(PAGE_OFFSET)
+static __init uintptr_t get_random_offset(u64 seed, uintptr_t kernel_size)
+{
+	uintptr_t mem_start = 0, mem_size= 0, random_size;
+	uintptr_t kernel_size_align = round_up(kernel_size, SZ_2M);
+	int index;
+	u64 random = 0;
+	cycles_t time_base;
+
+	/* Attempt to create a simple but unpredictable starting entropy */
+	random = rotate_xor(random, linux_banner, strlen(linux_banner));
+
+	/*
+	 * If there is no HW random number generator, use timer to get a random
+	 * number. This is better than nothing but not enough secure.
+	 */
+	time_base = get_cycles() << 32;
+	time_base ^= get_cycles();
+	random = rotate_xor(random, &time_base, sizeof(time_base));
+
+	if (seed)
+		random = rotate_xor(random, &seed, sizeof(seed));
+
+	kaslr_get_mem_info(&mem_start, &mem_size);
+	if (!mem_size)
+		return 0;
+
+	if (mem_start < MEM_RESERVE_START) {
+		mem_size -= MEM_RESERVE_START - mem_start;
+		mem_start = MEM_RESERVE_START;
+	}
+
+	/*
+	 * Limit randomization range within 1G, so we can exploit
+	 * early_pmd/early_pte during early page table phase.
+	 */
+	random_size = min_t(u64,
+			    mem_size - (kernel_size_align * 2),
+			    SZ_1G - (kernel_size_align * 2));
+
+	/* The index of 2M block in whole avaliable region */
+	index = random % (random_size / SZ_2M);
+
+	return get_legal_offset(index, random_size / SZ_2M,
+				mem_start, kernel_size_align);
+}
+
 uintptr_t __init kaslr_early_init(void)
 {
+	u64 seed;
 	uintptr_t dest_start, dest_end;
 	uintptr_t kernel_size = (uintptr_t) _end - (uintptr_t) _start;
 
 	/* Get zero value at second time to avoid doing randomization again. */
-	if (kaslr_offset)
+	seed = kaslr_get_seed();
+	if (!seed)
 		return 0;
 
 	/* Get the random number for kaslr offset. */
-	kaslr_offset = 0x10000000;
+	kaslr_offset = get_random_offset(seed, kernel_size);
 
 	/* Update kernel_virt_addr for get_kaslr_offset. */
 	kernel_virt_addr += kaslr_offset;
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2f5b25f02b6c..34c6ecf2c599 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -125,7 +125,7 @@ static void __init setup_initrd(void)
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-static phys_addr_t dtb_early_pa __initdata;
+phys_addr_t dtb_early_pa __initdata;
 
 void __init setup_bootmem(void)
 {
-- 
2.25.1

