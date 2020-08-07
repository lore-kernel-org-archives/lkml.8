Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C50BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 23:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BAF2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 23:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgHGXc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 19:32:26 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:24146 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbgHGXcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 19:32:22 -0400
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Aug 2020 16:32:21 -0700
Received: from th-lint-015.qualcomm.com ([10.63.177.64])
  by ironmsg04-sd.qualcomm.com with ESMTP; 07 Aug 2020 16:32:21 -0700
Received: by th-lint-015.qualcomm.com (Postfix, from userid 2383757)
        id E4086174B; Fri,  7 Aug 2020 16:32:20 -0700 (PDT)
From:   Gurbir Arora <gurbaror@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, rishabhb@codeaurora.org,
        Gurbir Arora <gurbaror@codeaurora.org>
Subject: [PATCH 2/3] remoteproc: qcom: Add capability to collect minidumps
Date:   Fri,  7 Aug 2020 16:32:00 -0700
Message-Id: <1596843121-82576-3-git-send-email-gurbaror@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1596843121-82576-1-git-send-email-gurbaror@codeaurora.org>
References: <1596843121-82576-1-git-send-email-gurbaror@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for collecting minidump in the
event of remoteproc crash. Parse the minidump table
based on remoteproc's unique minidump-id, read all
memory regions from the remoteproc's minidump table
entry and expose the memory to userspace.
The remoteproc platform driver can choose to collect
a full/mini dump by specifying the coredump op.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Signed-off-by: Gurbir Arora <gurbaror@codeaurora.org>
---
 drivers/remoteproc/qcom_minidump.h          |  64 +++++++++
 drivers/remoteproc/qcom_q6v5_pas.c          |  20 ++-
 drivers/remoteproc/remoteproc_core.c        |   1 +
 drivers/remoteproc/remoteproc_coredump.c    | 211 +++++++++++++++++++++++++++-
 drivers/remoteproc/remoteproc_elf_helpers.h |  27 ++++
 drivers/remoteproc/remoteproc_internal.h    |   2 +
 include/linux/remoteproc.h                  |   2 +
 7 files changed, 324 insertions(+), 3 deletions(-)
 create mode 100644 drivers/remoteproc/qcom_minidump.h

diff --git a/drivers/remoteproc/qcom_minidump.h b/drivers/remoteproc/qcom_minidump.h
new file mode 100644
index 0000000..437e030
--- /dev/null
+++ b/drivers/remoteproc/qcom_minidump.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __QCOM_MINIDUMP_H
+#define __QCOM_MINIDUMP_H
+
+#define MAX_NUM_OF_SS           10
+#define MAX_REGION_NAME_LENGTH  16
+#define SBL_MINIDUMP_SMEM_ID	602
+#define MD_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
+#define MD_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
+#define MD_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
+
+/**
+ * md_ss_region - Minidump region
+ * @name		: Name of the region to be dumped
+ * @seq_num:		: Use to differentiate regions with same name.
+ * @md_valid		: This entry to be dumped (if set to 1)
+ * @region_base_address	: Physical address of region to be dumped
+ * @region_size		: Size of the region
+ */
+struct md_ss_region {
+	char	name[MAX_REGION_NAME_LENGTH];
+	u32	seq_num;
+	u32	md_valid;
+	u64	region_base_address;
+	u64	region_size;
+};
+
+/**
+ * md_ss_toc: Subsystem's SMEM Table of content
+ * @md_ss_toc_init : Subsystem toc init status
+ * @md_ss_enable_status : if set to 1, this region would be copied during coredump
+ * @encryption_status: Encryption status for this subsystem
+ * @encryption_required : Decides to encrypt the subsystem regions or not
+ * @ss_region_count : Number of regions added in this subsystem toc
+ * @md_ss_smem_regions_baseptr : regions base pointer of the subsystem
+ */
+struct md_ss_toc {
+	u32			md_ss_toc_init;
+	u32			md_ss_enable_status;
+	u32			encryption_status;
+	u32			encryption_required;
+	u32			ss_region_count;
+	u64			md_ss_smem_regions_baseptr;
+};
+
+/**
+ * md_global_toc: Global Table of Content
+ * @md_toc_init : Global Minidump init status
+ * @md_revision : Minidump revision
+ * @md_enable_status : Minidump enable status
+ * @md_ss_toc : Array of subsystems toc
+ */
+struct md_global_toc {
+	u32			md_toc_init;
+	u32			md_revision;
+	u32			md_enable_status;
+	struct md_ss_toc	md_ss_toc[MAX_NUM_OF_SS];
+};
+
+#endif
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 3837f23..270c640 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -33,6 +33,7 @@ struct adsp_data {
 	int crash_reason_smem;
 	const char *firmware_name;
 	int pas_id;
+	int minidump_id;
 	bool has_aggre2_clk;
 	bool auto_boot;
 
@@ -258,6 +259,15 @@ static unsigned long adsp_panic(struct rproc *rproc)
 	.panic = adsp_panic,
 };
 
+static struct rproc_ops adsp_minidump_ops = {
+	.start = adsp_start,
+	.stop = adsp_stop,
+	.da_to_va = adsp_da_to_va,
+	.load = adsp_load,
+	.coredump = rproc_minidump,
+	.panic = adsp_panic,
+};
+
 static int adsp_init_clock(struct qcom_adsp *adsp)
 {
 	int ret;
@@ -398,14 +408,20 @@ static int adsp_probe(struct platform_device *pdev)
 	if (ret < 0 && ret != -EINVAL)
 		return ret;
 
-	rproc = rproc_alloc(&pdev->dev, pdev->name, &adsp_ops,
-			    fw_name, sizeof(*adsp));
+	if (desc->minidump_id)
+		rproc = rproc_alloc(&pdev->dev, pdev->name, &adsp_minidump_ops,
+				    fw_name, sizeof(*adsp));
+	else
+		rproc = rproc_alloc(&pdev->dev, pdev->name, &adsp_ops, fw_name,
+				    sizeof(*adsp));
+
 	if (!rproc) {
 		dev_err(&pdev->dev, "unable to allocate remoteproc\n");
 		return -ENOMEM;
 	}
 
 	rproc->auto_boot = desc->auto_boot;
+	rproc->minidump_id = desc->minidump_id;
 	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 
 	adsp = (struct qcom_adsp *)rproc->priv;
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 283ecb6..1835821 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1324,6 +1324,7 @@ void rproc_resource_cleanup(struct rproc *rproc)
 	list_for_each_entry_safe(rvdev, rvtmp, &rproc->rvdevs, node)
 		kref_put(&rvdev->refcount, rproc_vdev_release);
 
+	rproc_cleanup_priv(rproc);
 	rproc_coredump_cleanup(rproc);
 }
 EXPORT_SYMBOL(rproc_resource_cleanup);
diff --git a/drivers/remoteproc/remoteproc_coredump.c b/drivers/remoteproc/remoteproc_coredump.c
index bb15a29..232804d 100644
--- a/drivers/remoteproc/remoteproc_coredump.c
+++ b/drivers/remoteproc/remoteproc_coredump.c
@@ -12,6 +12,11 @@
 #include <linux/remoteproc.h>
 #include "remoteproc_internal.h"
 #include "remoteproc_elf_helpers.h"
+#include <linux/soc/qcom/smem.h>
+#include "qcom_minidump.h"
+
+static struct md_global_toc *g_md_toc;
+#define MAX_STRTBL_SIZE 512
 
 struct rproc_coredump_state {
 	struct rproc *rproc;
@@ -20,7 +25,7 @@ struct rproc_coredump_state {
 };
 
 /**
- * rproc_coredump_cleanup() - clean up dump_segments list
+ * rproc_coredump_cleanup() - clean up dump_segment's list
  * @rproc: the remote processor handle
  */
 void rproc_coredump_cleanup(struct rproc *rproc)
@@ -34,6 +39,18 @@ void rproc_coredump_cleanup(struct rproc *rproc)
 }
 
 /**
+ * rproc_coredump_cleanup() - free the dump_segment's private elements.
+ * @rproc: the remote processor handle
+ */
+void rproc_cleanup_priv(struct rproc *rproc)
+{
+	struct rproc_dump_segment *entry;
+
+	list_for_each_entry(entry, &rproc->dump_segments, node)
+		kfree(entry->priv);
+}
+
+/**
  * rproc_coredump_add_segment() - add segment of device memory to coredump
  * @rproc:	handle of a remote processor
  * @da:		device address
@@ -323,3 +340,195 @@ void rproc_coredump(struct rproc *rproc)
 	 */
 	wait_for_completion(&dump_state.dump_done);
 }
+
+static void do_rproc_minidump(struct rproc *rproc)
+{
+	struct rproc_dump_segment *segment;
+	void *shdr;
+	void *ehdr;
+	size_t data_size;
+	size_t offset;
+	void *data;
+	u8 class = rproc->elf_class;
+	int shnum;
+	struct rproc_coredump_state dump_state;
+	unsigned int dump_conf = rproc->dump_conf;
+	char *str_tbl = "STR_TBL";
+
+	if (list_empty(&rproc->dump_segments) ||
+	    dump_conf == RPROC_COREDUMP_DISABLED)
+		return;
+
+	if (class == ELFCLASSNONE) {
+		dev_err(&rproc->dev, "Elf class is not set\n");
+		return;
+	}
+
+	/*
+	 * We allocate two extra section headers. The first one is null.
+	 * Second section header is for the string table. Also space is
+	 * allocated for string table.
+	 */
+	data_size = elf_size_of_hdr(class) + 2 * elf_size_of_shdr(class) +
+		    MAX_STRTBL_SIZE;
+	shnum = 2;
+
+	list_for_each_entry(segment, &rproc->dump_segments, node) {
+		data_size += elf_size_of_shdr(class);
+		if (dump_conf == RPROC_COREDUMP_DEFAULT)
+			data_size += segment->size;
+		shnum++;
+	}
+
+	data = vmalloc(data_size);
+	if (!data)
+		return;
+
+	ehdr = data;
+	memset(ehdr, 0, elf_size_of_hdr(class));
+	/* e_ident field is common for both elf32 and elf64 */
+	elf_hdr_init_ident(ehdr, class);
+
+	elf_hdr_set_e_type(class, ehdr, ET_CORE);
+	elf_hdr_set_e_machine(class, ehdr, rproc->elf_machine);
+	elf_hdr_set_e_version(class, ehdr, EV_CURRENT);
+	elf_hdr_set_e_entry(class, ehdr, rproc->bootaddr);
+	elf_hdr_set_e_shoff(class, ehdr, elf_size_of_hdr(class));
+	elf_hdr_set_e_ehsize(class, ehdr, elf_size_of_hdr(class));
+	elf_hdr_set_e_shentsize(class, ehdr, elf_size_of_shdr(class));
+	elf_hdr_set_e_shnum(class, ehdr, shnum);
+	elf_hdr_set_e_shstrndx(class, ehdr, 1);
+
+	/* Set the first section header as null and move to the next one. */
+	shdr = data + elf_hdr_get_e_shoff(class, ehdr);
+	memset(shdr, 0, elf_size_of_shdr(class));
+	shdr += elf_size_of_shdr(class);
+
+	/* Initialize the string table. */
+	offset = elf_hdr_get_e_shoff(class, ehdr) +
+		 elf_size_of_shdr(class) * elf_hdr_get_e_shnum(class, ehdr);
+	memset(data + offset, 0, MAX_STRTBL_SIZE);
+
+	/* Fill in the string table section header. */
+	memset(shdr, 0, elf_size_of_shdr(class));
+	elf_shdr_set_sh_type(class, shdr, SHT_STRTAB);
+	elf_shdr_set_sh_offset(class, shdr, offset);
+	elf_shdr_set_sh_size(class, shdr, MAX_STRTBL_SIZE);
+	elf_shdr_set_sh_entsize(class, shdr, 0);
+	elf_shdr_set_sh_flags(class, shdr, 0);
+	elf_shdr_set_sh_name(class, shdr, set_section_name(str_tbl, ehdr, class));
+	offset += elf_shdr_get_sh_size(class, shdr);
+	shdr += elf_size_of_shdr(class);
+
+	list_for_each_entry(segment, &rproc->dump_segments, node) {
+		memset(shdr, 0, elf_size_of_shdr(class));
+		elf_shdr_set_sh_type(class, shdr, SHT_PROGBITS);
+		elf_shdr_set_sh_offset(class, shdr, offset);
+		elf_shdr_set_sh_addr(class, shdr, segment->da);
+		elf_shdr_set_sh_size(class, shdr, segment->size);
+		elf_shdr_set_sh_entsize(class, shdr, 0);
+		elf_shdr_set_sh_flags(class, shdr, SHF_WRITE);
+		elf_shdr_set_sh_name(class, shdr,
+				     set_section_name(segment->priv, ehdr, class));
+
+		/* No need to copy segments for inline dumps */
+		if (dump_conf == RPROC_COREDUMP_DEFAULT)
+			rproc_copy_segment(rproc, data + offset, segment, 0,
+					   segment->size);
+		offset += elf_shdr_get_sh_size(class, shdr);
+		shdr += elf_size_of_shdr(class);
+	}
+
+	if (dump_conf == RPROC_COREDUMP_DEFAULT) {
+		dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
+		return;
+	}
+
+	/* Initialize the dump state struct to be used by rproc_coredump_read */
+	dump_state.rproc = rproc;
+	dump_state.header = data;
+	init_completion(&dump_state.dump_done);
+
+	dev_coredumpm(&rproc->dev, NULL, &dump_state, data_size, GFP_KERNEL,
+		      rproc_coredump_read, rproc_coredump_free);
+
+	/* Wait until the dump is read and free is called. Data is freed
+	 * by devcoredump framework automatically after 5 minutes.
+	 */
+	wait_for_completion(&dump_state.dump_done);
+}
+
+static void add_minidump_segments(struct rproc *rproc, struct md_ss_toc *minidump_ss)
+{
+	struct md_ss_region __iomem *region_info, *ptr;
+	int i, seg_cnt = minidump_ss->ss_region_count;
+	void __iomem *offset;
+	dma_addr_t da;
+	size_t size;
+	char *name;
+
+	if (!list_empty(&rproc->dump_segments))
+		goto minidump;
+
+	region_info = ioremap((unsigned long)minidump_ss->md_ss_smem_regions_baseptr,
+			      seg_cnt * sizeof(struct md_ss_region));
+
+	if (!region_info) {
+		dev_err(&rproc->dev, "invalid minidump subsystem table\n");
+		return;
+	}
+
+	/* Iterate over the subsystem's segments and create rproc custom dump segments */
+	ptr = region_info;
+	offset = ptr;
+	for (i = 0; i < seg_cnt; i++) {
+		offset = region_info;
+		offset += sizeof(region_info->name) + sizeof(region_info->seq_num);
+		if (__raw_readl(offset) == MD_REGION_VALID) {
+			name = kmalloc(MAX_REGION_NAME_LENGTH, GFP_KERNEL);
+			memcpy(name, region_info, sizeof(region_info->name));
+			offset += sizeof(region_info->md_valid);
+			memcpy(&da, offset, sizeof(region_info->region_base_address));
+			offset += sizeof(region_info->region_base_address);
+			memcpy(&size, offset, sizeof(region_info->region_size));
+			rproc_coredump_add_custom_segment(rproc, da, size, NULL, name);
+		}
+		region_info++;
+	}
+
+minidump:
+	return do_rproc_minidump(rproc);
+}
+
+void rproc_minidump(struct rproc *rproc)
+{
+	struct md_ss_toc *minidump_ss;
+	size_t size;
+
+	/* Get Global minidump ToC*/
+	if (!g_md_toc)
+		g_md_toc = qcom_smem_get(QCOM_SMEM_HOST_ANY,
+					 SBL_MINIDUMP_SMEM_ID, &size);
+
+	/* check if global table pointer exists and init is set */
+	if (IS_ERR(g_md_toc) || !(g_md_toc->md_toc_init)) {
+		dev_err(&rproc->dev, "SMEM is not initialized.\n");
+		return;
+	}
+
+	/* Get subsystem table of contents using the minidump id */
+	minidump_ss = &g_md_toc->md_ss_toc[rproc->minidump_id];
+
+	/**
+	 * Collect minidump if SS ToC is valid and segment table
+	 * is initialized in memory and encryption status is set.
+	 */
+	if (minidump_ss->md_ss_smem_regions_baseptr != 0 &&
+	    minidump_ss->md_ss_toc_init == 1 &&
+	    minidump_ss->md_ss_enable_status == MD_SS_ENABLED &&
+	    minidump_ss->encryption_status == MD_SS_ENCR_DONE)
+		return add_minidump_segments(rproc, minidump_ss);
+
+	dev_err(&rproc->dev, "Minidump not ready!! Aborting\n");
+}
+EXPORT_SYMBOL(rproc_minidump);
diff --git a/drivers/remoteproc/remoteproc_elf_helpers.h b/drivers/remoteproc/remoteproc_elf_helpers.h
index 4b6be7b..d83ebca 100644
--- a/drivers/remoteproc/remoteproc_elf_helpers.h
+++ b/drivers/remoteproc/remoteproc_elf_helpers.h
@@ -11,6 +11,7 @@
 #include <linux/elf.h>
 #include <linux/types.h>
 
+#define MAX_NAME_LENGTH 16
 /**
  * fw_elf_get_class - Get elf class
  * @fw: the ELF firmware image
@@ -65,6 +66,7 @@ static inline void elf_hdr_init_ident(struct elf32_hdr *hdr, u8 class)
 ELF_GEN_FIELD_GET_SET(hdr, e_version, u32)
 ELF_GEN_FIELD_GET_SET(hdr, e_ehsize, u32)
 ELF_GEN_FIELD_GET_SET(hdr, e_phentsize, u16)
+ELF_GEN_FIELD_GET_SET(hdr, e_shentsize, u16)
 
 ELF_GEN_FIELD_GET_SET(phdr, p_paddr, u64)
 ELF_GEN_FIELD_GET_SET(phdr, p_vaddr, u64)
@@ -74,6 +76,9 @@ static inline void elf_hdr_init_ident(struct elf32_hdr *hdr, u8 class)
 ELF_GEN_FIELD_GET_SET(phdr, p_offset, u64)
 ELF_GEN_FIELD_GET_SET(phdr, p_flags, u32)
 ELF_GEN_FIELD_GET_SET(phdr, p_align, u64)
+ELF_GEN_FIELD_GET_SET(shdr, sh_type, u32)
+ELF_GEN_FIELD_GET_SET(shdr, sh_flags, u32)
+ELF_GEN_FIELD_GET_SET(shdr, sh_entsize, u16)
 
 ELF_GEN_FIELD_GET_SET(shdr, sh_size, u64)
 ELF_GEN_FIELD_GET_SET(shdr, sh_offset, u64)
@@ -93,4 +98,26 @@ static inline void elf_hdr_init_ident(struct elf32_hdr *hdr, u8 class)
 ELF_STRUCT_SIZE(phdr)
 ELF_STRUCT_SIZE(hdr)
 
+static inline unsigned int set_section_name(const char *name, void *ehdr,
+					    u8 class)
+{
+	u16 shstrndx = elf_hdr_get_e_shstrndx(class, ehdr);
+	void *shdr;
+	char *strtab;
+	static int strtable_idx = 1;
+	int idx, ret = 0;
+
+	shdr = ehdr + elf_size_of_hdr(class) + shstrndx * elf_size_of_shdr(class);
+	strtab = ehdr + elf_shdr_get_sh_offset(class, shdr);
+	idx = strtable_idx;
+	if (!strtab || !name)
+		return 0;
+
+	ret = idx;
+	idx += strlcpy((strtab + idx), name, MAX_NAME_LENGTH);
+	strtable_idx = idx + 1;
+
+	return ret;
+}
+
 #endif /* REMOTEPROC_ELF_LOADER_H */
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index c340028..1bb69ee 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -51,7 +51,9 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
 
 /* from remoteproc_coredump.c */
 void rproc_coredump_cleanup(struct rproc *rproc);
+void rproc_cleanup_priv(struct rproc *rproc);
 void rproc_coredump(struct rproc *rproc);
+void rproc_minidump(struct rproc *rproc);
 
 #ifdef CONFIG_REMOTEPROC_CDEV
 void rproc_init_cdev(void);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 0ed1a2b..f6f1f34 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -513,6 +513,7 @@ struct rproc_dump_segment {
  * @nb_vdev: number of vdev currently handled by rproc
  * @char_dev: character device of the rproc
  * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
+ * @minidump_id: Unique id to identify remoteproc in the minidump table
  */
 struct rproc {
 	struct list_head node;
@@ -552,6 +553,7 @@ struct rproc {
 	u16 elf_machine;
 	struct cdev cdev;
 	bool cdev_put_on_release;
+	int minidump_id;
 };
 
 /**
-- 
1.9.1

