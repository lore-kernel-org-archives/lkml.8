Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F831C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA6E20720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Fe6ZLKuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgGIUcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:32:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41004 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgGIUcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:32:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594326731; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=984wERjqBaNYiJd23F1x07cOT1uGMXOHfvWqhGpoLBI=; b=Fe6ZLKuQH8P4hR74WnCg/oaj77u+DZLlY4107RMJAzpjnXgJVwR+xwMyD4GlJX/mALwQOuTx
 pon7/lamloQqshVBflHYOS6ukgn6XOLI15PKtmVxCVVvQ+io307+3jZP+Ip/3Jyt+pi0zy1R
 Jr75tswvK5qsxzowkFn6rsjmj4k=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5f077eca1daed08ee06c15f2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 09 Jul 2020 20:32:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8747C433C8; Thu,  9 Jul 2020 20:32:09 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D48E4C433CB;
        Thu,  9 Jul 2020 20:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D48E4C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v7 3/4] remoteproc: Add inline coredump functionality
Date:   Thu,  9 Jul 2020 13:31:55 -0700
Message-Id: <1594326716-15474-4-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594326716-15474-1-git-send-email-rishabhb@codeaurora.org>
References: <1594326716-15474-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current coredump implementation uses vmalloc area to copy
all the segments. But this might put strain on low memory targets
as the firmware size sometimes is in tens of MBs. The situation
becomes worse if there are multiple remote processors undergoing
recovery at the same time. This patch adds inline coredump
functionality that avoids extra memory usage. This requires
recovery to be halted until data is read by userspace and free
function is called. Also modify the qcom_q6v5_mss driver to include
size and offset in the segment dump function.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c       |  11 ++-
 drivers/remoteproc/remoteproc_coredump.c | 160 +++++++++++++++++++++++++++----
 include/linux/remoteproc.h               |  21 +++-
 3 files changed, 166 insertions(+), 26 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index c6ce032..79df354 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1199,11 +1199,12 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 
 static void qcom_q6v5_dump_segment(struct rproc *rproc,
 				   struct rproc_dump_segment *segment,
-				   void *dest)
+				   void *dest, size_t cp_offset, size_t size)
 {
 	int ret = 0;
 	struct q6v5 *qproc = rproc->priv;
 	int offset = segment->da - qproc->mpss_reloc;
+	size_t cp_size = size ? size : segment->size;
 	void *ptr = NULL;
 
 	/* Unlock mba before copying segments */
@@ -1219,16 +1220,16 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
 	}
 
 	if (!ret)
-		ptr = ioremap_wc(qproc->mpss_phys + offset, segment->size);
+		ptr = ioremap_wc(qproc->mpss_phys + offset + cp_offset, cp_size);
 
 	if (ptr) {
-		memcpy(dest, ptr, segment->size);
+		memcpy(dest, ptr, cp_size);
 		iounmap(ptr);
 	} else {
-		memset(dest, 0xff, segment->size);
+		memset(dest, 0xff, cp_size);
 	}
 
-	qproc->current_dump_size += segment->size;
+	qproc->current_dump_size += cp_size;
 
 	/* Reclaim mba after copying segments */
 	if (qproc->current_dump_size == qproc->total_dump_size) {
diff --git a/drivers/remoteproc/remoteproc_coredump.c b/drivers/remoteproc/remoteproc_coredump.c
index ded0244..646886f 100644
--- a/drivers/remoteproc/remoteproc_coredump.c
+++ b/drivers/remoteproc/remoteproc_coredump.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2020, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/completion.h>
 #include <linux/devcoredump.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -12,6 +13,12 @@
 #include "remoteproc_internal.h"
 #include "remoteproc_elf_helpers.h"
 
+struct rproc_coredump_state {
+	struct rproc *rproc;
+	void *header;
+	struct completion dump_done;
+};
+
 /**
  * rproc_coredump_cleanup() - clean up dump_segments list
  * @rproc: the remote processor handle
@@ -72,7 +79,8 @@ int rproc_coredump_add_custom_segment(struct rproc *rproc,
 				      dma_addr_t da, size_t size,
 				      void (*dumpfn)(struct rproc *rproc,
 						     struct rproc_dump_segment *segment,
-						     void *dest),
+						     void *dest, size_t offset,
+						     size_t size),
 				      void *priv)
 {
 	struct rproc_dump_segment *segment;
@@ -114,12 +122,110 @@ int rproc_coredump_set_elf_info(struct rproc *rproc, u8 class, u16 machine)
 }
 EXPORT_SYMBOL(rproc_coredump_set_elf_info);
 
+static void rproc_coredump_free(void *data)
+{
+	struct rproc_coredump_state *dump_state = data;
+
+	complete(&dump_state->dump_done);
+	vfree(dump_state->header);
+}
+
+static void *rproc_coredump_find_segment(loff_t user_offset,
+					 struct list_head *segments,
+					 size_t *data_left)
+{
+	struct rproc_dump_segment *segment;
+
+	list_for_each_entry(segment, segments, node) {
+		if (user_offset < segment->size) {
+			*data_left = segment->size - user_offset;
+			return segment;
+		}
+		user_offset -= segment->size;
+	}
+
+	*data_left = 0;
+	return NULL;
+}
+
+static void rproc_copy_segment(struct rproc *rproc, void *dest,
+			       struct rproc_dump_segment *segment,
+			       size_t offset, size_t size)
+{
+	void *ptr;
+
+	if (segment->dump) {
+		segment->dump(rproc, segment, dest, offset, size);
+	} else {
+		ptr = rproc_da_to_va(rproc, segment->da + offset, size);
+		if (!ptr) {
+			dev_err(&rproc->dev,
+				"invalid copy request for segment %pad with offset %zu and size %zu)\n",
+				&segment->da, offset, size);
+			memset(dest, 0xff, size);
+		} else {
+			memcpy(dest, ptr, size);
+		}
+	}
+}
+
+static ssize_t rproc_coredump_read(char *buffer, loff_t offset, size_t count,
+				   void *data, size_t header_sz)
+{
+	size_t seg_data, bytes_left = count;
+	ssize_t copy_sz;
+	struct rproc_dump_segment *seg;
+	struct rproc_coredump_state *dump_state = data;
+	struct rproc *rproc = dump_state->rproc;
+	void *elfcore = dump_state->header;
+
+	/* Copy the vmalloc'ed header first. */
+	if (offset < header_sz) {
+		copy_sz = memory_read_from_buffer(buffer, count, &offset,
+						  elfcore, header_sz);
+
+		return copy_sz;
+	}
+
+	/*
+	 * Find out the segment memory chunk to be copied based on offset.
+	 * Keep copying data until count bytes are read.
+	 */
+	while (bytes_left) {
+		seg = rproc_coredump_find_segment(offset - header_sz,
+						  &rproc->dump_segments,
+						  &seg_data);
+		/* EOF check */
+		if (!seg) {
+			dev_info(&rproc->dev, "Ramdump done, %lld bytes read",
+				 offset);
+			break;
+		}
+
+		copy_sz = min_t(size_t, bytes_left, seg_data);
+
+		rproc_copy_segment(rproc, buffer, seg, seg->size - seg_data,
+				   copy_sz);
+
+		offset += copy_sz;
+		buffer += copy_sz;
+		bytes_left -= copy_sz;
+	}
+
+	return count - bytes_left;
+}
+
 /**
  * rproc_coredump() - perform coredump
  * @rproc:	rproc handle
  *
  * This function will generate an ELF header for the registered segments
- * and create a devcoredump device associated with rproc.
+ * and create a devcoredump device associated with rproc. Based on the
+ * coredump configuration this function will directly copy the segments
+ * from device memory to userspace or copy segments from device memory to
+ * a separate buffer, which can then be read by userspace.
+ * The first approach avoids using extra vmalloc memory. But it will stall
+ * recovery flow until dump is read by userspace.
  */
 void rproc_coredump(struct rproc *rproc)
 {
@@ -129,11 +235,13 @@ void rproc_coredump(struct rproc *rproc)
 	size_t data_size;
 	size_t offset;
 	void *data;
-	void *ptr;
 	u8 class = rproc->elf_class;
 	int phnum = 0;
+	struct rproc_coredump_state dump_state;
+	enum rproc_dump_mechanism dump_conf = rproc->dump_conf;
 
-	if (list_empty(&rproc->dump_segments))
+	if (list_empty(&rproc->dump_segments) ||
+	    dump_conf == RPROC_COREDUMP_DISABLED)
 		return;
 
 	if (class == ELFCLASSNONE) {
@@ -143,7 +251,14 @@ void rproc_coredump(struct rproc *rproc)
 
 	data_size = elf_size_of_hdr(class);
 	list_for_each_entry(segment, &rproc->dump_segments, node) {
-		data_size += elf_size_of_phdr(class) + segment->size;
+		/*
+		 * For default configuration buffer includes headers & segments.
+		 * For inline dump buffer just includes headers as segments are
+		 * directly read from device memory.
+		 */
+		data_size += elf_size_of_phdr(class);
+		if (dump_conf == RPROC_COREDUMP_DEFAULT)
+			data_size += segment->size;
 
 		phnum++;
 	}
@@ -182,23 +297,30 @@ void rproc_coredump(struct rproc *rproc)
 		elf_phdr_set_p_flags(class, phdr, PF_R | PF_W | PF_X);
 		elf_phdr_set_p_align(class, phdr, 0);
 
-		if (segment->dump) {
-			segment->dump(rproc, segment, data + offset);
-		} else {
-			ptr = rproc_da_to_va(rproc, segment->da, segment->size);
-			if (!ptr) {
-				dev_err(&rproc->dev,
-					"invalid coredump segment (%pad, %zu)\n",
-					&segment->da, segment->size);
-				memset(data + offset, 0xff, segment->size);
-			} else {
-				memcpy(data + offset, ptr, segment->size);
-			}
-		}
+		if (dump_conf == RPROC_COREDUMP_DEFAULT)
+			rproc_copy_segment(rproc, data + offset, segment, 0,
+					   segment->size);
 
 		offset += elf_phdr_get_p_filesz(class, phdr);
 		phdr += elf_size_of_phdr(class);
 	}
 
-	dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
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
+	/*
+	 * Wait until the dump is read and free is called. Data is freed
+	 * by devcoredump framework automatically after 5 minutes.
+	 */
+	wait_for_completion(&dump_state.dump_done);
 }
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e7b7bab..38d037d 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -435,6 +435,20 @@ enum rproc_crash_type {
 };
 
 /**
+ * enum rproc_dump_mechanism - Coredump options for core
+ * @RPROC_COREDUMP_DEFAULT:	Copy dump to separate buffer and carry on with
+				recovery
+ * @RPROC_COREDUMP_INLINE:	Read segments directly from device memory. Stall
+				recovery until all segments are read
+ * @RPROC_COREDUMP_DISABLED:	Don't perform any dump
+ */
+enum rproc_dump_mechanism {
+	RPROC_COREDUMP_DEFAULT,
+	RPROC_COREDUMP_INLINE,
+	RPROC_COREDUMP_DISABLED,
+};
+
+/**
  * struct rproc_dump_segment - segment info from ELF header
  * @node:	list node related to the rproc segment list
  * @da:		device address of the segment
@@ -451,7 +465,7 @@ struct rproc_dump_segment {
 
 	void *priv;
 	void (*dump)(struct rproc *rproc, struct rproc_dump_segment *segment,
-		     void *dest);
+		     void *dest, size_t offset, size_t size);
 	loff_t offset;
 };
 
@@ -466,6 +480,7 @@ struct rproc_dump_segment {
  * @dev: virtual device for refcounting and common remoteproc behavior
  * @power: refcount of users who need this rproc powered up
  * @state: state of the device
+ * @dump_conf: Currently selected coredump configuration
  * @lock: lock which protects concurrent manipulations of the rproc
  * @dbg_dir: debugfs directory of this rproc device
  * @traces: list of trace buffers
@@ -499,6 +514,7 @@ struct rproc {
 	struct device dev;
 	atomic_t power;
 	unsigned int state;
+	enum rproc_dump_mechanism dump_conf;
 	struct mutex lock;
 	struct dentry *dbg_dir;
 	struct list_head traces;
@@ -630,7 +646,8 @@ int rproc_coredump_add_custom_segment(struct rproc *rproc,
 				      dma_addr_t da, size_t size,
 				      void (*dumpfn)(struct rproc *rproc,
 						     struct rproc_dump_segment *segment,
-						     void *dest),
+						     void *dest, size_t offset,
+						     size_t size),
 				      void *priv);
 int rproc_coredump_set_elf_info(struct rproc *rproc, u8 class, u16 machine);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

