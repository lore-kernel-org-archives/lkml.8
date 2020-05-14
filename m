Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECB3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B3F2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="iW+Fasnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgENUIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:08:36 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:50686 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728270AbgENUIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:08:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589486913; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=vEavDoNmgke+5hyVpEhndjtTdWmEjrbJZFYt8sTDhMI=; b=iW+FasnzoF7uazf/h3IUX5hVKOK5GGwaatHTb6tX8O4CDQ46yASy9acIk+Me3xFhTyORtssl
 kM+JA8iTfJ868D5yRGwyaO+/87DnsNJCqgq+n8UUiEDwkqGz+JiOm1wkY/I8+Zjgp4hbadLR
 +Cx/XqplfxkU6YUz4mKkf/OufqE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebda53b.7f707f769998-smtp-out-n01;
 Thu, 14 May 2020 20:08:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F4069C447A1; Thu, 14 May 2020 20:08:26 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 367C7C447A1;
        Thu, 14 May 2020 20:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 367C7C447A1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v3 2/3] remoteproc: Add inline coredump functionality
Date:   Thu, 14 May 2020 13:07:35 -0700
Message-Id: <1589486856-23440-3-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1589486856-23440-1-git-send-email-rishabhb@codeaurora.org>
References: <1589486856-23440-1-git-send-email-rishabhb@codeaurora.org>
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
function is called.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/remoteproc_coredump.c | 129 +++++++++++++++++++++++++++++--
 include/linux/remoteproc.h               |  15 ++++
 2 files changed, 139 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_coredump.c b/drivers/remoteproc/remoteproc_coredump.c
index ded0244..de75e89 100644
--- a/drivers/remoteproc/remoteproc_coredump.c
+++ b/drivers/remoteproc/remoteproc_coredump.c
@@ -12,6 +12,12 @@
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
@@ -114,12 +120,96 @@ int rproc_coredump_set_elf_info(struct rproc *rproc, u8 class, u16 machine)
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
+static unsigned long rproc_coredump_find_segment(loff_t user_offset,
+						  struct list_head *segments,
+						  size_t *data_left)
+{
+	struct rproc_dump_segment *segment;
+
+	list_for_each_entry(segment, segments, node) {
+		if (user_offset < segment->size) {
+			*data_left = segment->size - user_offset;
+			return segment->da + user_offset;
+		}
+		user_offset -= segment->size;
+	}
+
+	*data_left = 0;
+	return 0;
+}
+
+static ssize_t rproc_coredump_read(char *buffer, loff_t offset, size_t count,
+				    void *data, size_t header_sz)
+{
+	void *device_mem;
+	size_t seg_data;
+	size_t copy_sz, bytes_left = count;
+	unsigned long addr;
+	struct rproc_coredump_state *dump_state = data;
+	struct rproc *rproc = dump_state->rproc;
+	void *elfcore = dump_state->header;
+
+	/* Copy the vmalloc'ed header first. */
+	if (offset < header_sz) {
+		copy_sz = memory_read_from_buffer(buffer, count, &offset,
+						  elfcore, header_sz);
+		if (copy_sz < 0)
+			return -EINVAL;
+
+		return copy_sz;
+	}
+
+	/* Find out the segment memory chunk to be copied based on offset.
+	 * Keep copying data until count bytes are read.
+	 */
+	while (bytes_left) {
+		addr = rproc_coredump_find_segment(offset - header_sz,
+						   &rproc->dump_segments,
+						   &seg_data);
+		/* EOF check */
+		if (seg_data == 0) {
+			dev_info(&rproc->dev, "Ramdump done, %lld bytes read",
+				 offset);
+			break;
+		}
+
+		copy_sz = min_t(size_t, bytes_left, seg_data);
+
+		device_mem = rproc_da_to_va(rproc, addr, copy_sz);
+		if (!device_mem) {
+			dev_err(&rproc->dev, "Coredump: %lx with size %zd out of remoteproc carveout\n",
+				addr, copy_sz);
+			return -ENOMEM;
+		}
+		memcpy(buffer, device_mem, copy_sz);
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
@@ -132,8 +222,10 @@ void rproc_coredump(struct rproc *rproc)
 	void *ptr;
 	u8 class = rproc->elf_class;
 	int phnum = 0;
+	struct rproc_coredump_state dump_state;
+	enum rproc_dump_mechanism dump_conf = rproc->dump_conf;
 
-	if (list_empty(&rproc->dump_segments))
+	if (list_empty(&rproc->dump_segments) || dump_conf == COREDUMP_DISABLED)
 		return;
 
 	if (class == ELFCLASSNONE) {
@@ -143,7 +235,14 @@ void rproc_coredump(struct rproc *rproc)
 
 	data_size = elf_size_of_hdr(class);
 	list_for_each_entry(segment, &rproc->dump_segments, node) {
-		data_size += elf_size_of_phdr(class) + segment->size;
+
+		/* For default configuration buffer includes headers & segments.
+		 * For inline dump buffer just includes headers as segments are
+		 * directly read from device memory.
+		 */
+		data_size += elf_size_of_phdr(class);
+		if (dump_conf == COREDUMP_DEFAULT)
+			data_size += segment->size;
 
 		phnum++;
 	}
@@ -182,6 +281,10 @@ void rproc_coredump(struct rproc *rproc)
 		elf_phdr_set_p_flags(class, phdr, PF_R | PF_W | PF_X);
 		elf_phdr_set_p_align(class, phdr, 0);
 
+		/* No need to copy segments for inline dumps */
+		if (dump_conf == COREDUMP_INLINE)
+			goto next_seg;
+
 		if (segment->dump) {
 			segment->dump(rproc, segment, data + offset);
 		} else {
@@ -195,10 +298,26 @@ void rproc_coredump(struct rproc *rproc)
 				memcpy(data + offset, ptr, segment->size);
 			}
 		}
-
+next_seg:
 		offset += elf_phdr_get_p_filesz(class, phdr);
 		phdr += elf_size_of_phdr(class);
 	}
 
-	dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
+	if (dump_conf == COREDUMP_DEFAULT) {
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
 }
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 0468be4..ab2b9b7 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -435,6 +435,19 @@ enum rproc_crash_type {
 };
 
 /**
+ * enum rproc_dump_mechanism - Coredump options for core
+ * @COREDUMP_DEFAULT:	Copy dump to separate buffer and carry on with recovery
+ * @COREDUMP_INLINE:	Read segments directly from device memory. Stall
+			recovery until all segments are read
+ * @COREDUMP_DISABLED:	Don't perform any dump
+ */
+enum rproc_dump_mechanism {
+	COREDUMP_DEFAULT,
+	COREDUMP_INLINE,
+	COREDUMP_DISABLED,
+};
+
+/**
  * struct rproc_dump_segment - segment info from ELF header
  * @node:	list node related to the rproc segment list
  * @da:		device address of the segment
@@ -466,6 +479,7 @@ struct rproc_dump_segment {
  * @dev: virtual device for refcounting and common remoteproc behavior
  * @power: refcount of users who need this rproc powered up
  * @state: state of the device
+ * @dump_conf: Currenlty selected coredump configuration
  * @lock: lock which protects concurrent manipulations of the rproc
  * @dbg_dir: debugfs directory of this rproc device
  * @traces: list of trace buffers
@@ -499,6 +513,7 @@ struct rproc {
 	struct device dev;
 	atomic_t power;
 	unsigned int state;
+	enum rproc_dump_mechanism dump_conf;
 	struct mutex lock;
 	struct dentry *dbg_dir;
 	struct list_head traces;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
