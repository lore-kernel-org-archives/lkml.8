Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA347C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2C22071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="eWgnUHUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgC0X5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 19:57:03 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57292 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726071AbgC0X5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 19:57:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585353422; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=zC2emTwPKxUPRv3bLCjD97NRgGeOHFMYAI7D8CPHheg=; b=eWgnUHUaKRcrx+AOdFRw4MCBabNCt12ZMTrQEFbg7gsGTY4qAUF4GnYFEHsdhfQYDoaDCxzr
 PLiMdL06xHt2FFfy1MQGcAB6TgNNeZeSiNrxeqlnUk3kYYaJ8DPkmrWkYp+fcuMsBfEDdliH
 vq6FolX9W/ONE63f/+TI7JixiZM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7e92cb.7f8e54293e30-smtp-out-n03;
 Fri, 27 Mar 2020 23:56:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6E62BC433BA; Fri, 27 Mar 2020 23:56:59 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A1C5C433D2;
        Fri, 27 Mar 2020 23:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A1C5C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH] remoteproc: core: Add a memory efficient coredump function
Date:   Fri, 27 Mar 2020 16:56:52 -0700
Message-Id: <1585353412-19644-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current coredump implementation uses vmalloc area to copy
all the segments. But this might put a lot of strain on low memory
targets as the firmware size sometimes is in ten's of MBs.
The situation becomes worse if there are multiple remote processors
undergoing recovery at the same time.
This patch directly copies the device memory to userspace buffer
and avoids extra memory usage. This requires recovery to be halted
until data is read by userspace and free function is called.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 107 +++++++++++++++++++++++++++++------
 include/linux/remoteproc.h           |   4 ++
 2 files changed, 94 insertions(+), 17 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 097f33e..2d881e5 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1516,6 +1516,86 @@ int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size)
 }
 EXPORT_SYMBOL(rproc_coredump_add_segment);
 
+
+void rproc_free_dump(void *data)
+{
+	struct rproc *rproc = data;
+
+	dev_info(&rproc->dev, "Userspace done reading rproc dump\n");
+	complete(&rproc->dump_done);
+}
+
+static unsigned long get_offset(loff_t user_offset, struct list_head *segments,
+				unsigned long *data_left)
+{
+	struct rproc_dump_segment *segment;
+
+	list_for_each_entry(segment, segments, node) {
+		if (user_offset >= segment->size)
+			user_offset -= segment->size;
+		else
+			break;
+	}
+
+	if (&segment->node == segments) {
+		*data_left = 0;
+		return 0;
+	}
+
+	*data_left = segment->size - user_offset;
+
+	return segment->da + user_offset;
+}
+
+static ssize_t rproc_read_dump(char *buffer, loff_t offset, size_t count,
+				void *data, size_t elfcorelen)
+{
+	void *device_mem = NULL;
+	unsigned long data_left = 0;
+	unsigned long bytes_left = count;
+	unsigned long addr = 0;
+	size_t copy_size = 0;
+	struct rproc *rproc = data;
+
+	if (offset < elfcorelen) {
+		copy_size = elfcorelen - offset;
+		copy_size = min(copy_size, bytes_left);
+
+		memcpy(buffer, rproc->elfcore + offset, copy_size);
+		offset += copy_size;
+		bytes_left -= copy_size;
+		buffer += copy_size;
+	}
+
+	while (bytes_left) {
+		addr = get_offset(offset - elfcorelen, &rproc->dump_segments,
+				&data_left);
+	/* EOF check */
+		if (data_left == 0) {
+			pr_info("Ramdump complete. %lld bytes read.", offset);
+			return 0;
+		}
+
+		copy_size = min_t(size_t, bytes_left, data_left);
+
+		device_mem = rproc->ops->da_to_va(rproc, addr, copy_size);
+		if (!device_mem) {
+			pr_err("Unable to ioremap: addr %lx, size %zd\n",
+				 addr, copy_size);
+			return -ENOMEM;
+		}
+		memcpy(buffer, device_mem, copy_size);
+
+		offset += copy_size;
+		buffer += copy_size;
+		bytes_left -= copy_size;
+		dev_dbg(&rproc->dev, "Copied %d bytes to userspace\n",
+			copy_size);
+	}
+
+	return count;
+}
+
 /**
  * rproc_coredump_add_custom_segment() - add custom coredump segment
  * @rproc:	handle of a remote processor
@@ -1566,27 +1646,27 @@ static void rproc_coredump(struct rproc *rproc)
 	struct rproc_dump_segment *segment;
 	struct elf32_phdr *phdr;
 	struct elf32_hdr *ehdr;
-	size_t data_size;
+	size_t header_size;
 	size_t offset;
 	void *data;
-	void *ptr;
 	int phnum = 0;
 
 	if (list_empty(&rproc->dump_segments))
 		return;
 
-	data_size = sizeof(*ehdr);
+	header_size = sizeof(*ehdr);
 	list_for_each_entry(segment, &rproc->dump_segments, node) {
-		data_size += sizeof(*phdr) + segment->size;
+		header_size += sizeof(*phdr);
 
 		phnum++;
 	}
 
-	data = vmalloc(data_size);
+	data = vmalloc(header_size);
 	if (!data)
 		return;
 
 	ehdr = data;
+	rproc->elfcore = data;
 
 	memset(ehdr, 0, sizeof(*ehdr));
 	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
@@ -1618,23 +1698,14 @@ static void rproc_coredump(struct rproc *rproc)
 
 		if (segment->dump) {
 			segment->dump(rproc, segment, data + offset);
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
 
 		offset += phdr->p_filesz;
 		phdr++;
 	}
+	dev_coredumpm(&rproc->dev, NULL, rproc, header_size, GFP_KERNEL,
+			rproc_read_dump, rproc_free_dump);
 
-	dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
+	wait_for_completion(&rproc->dump_done);
 }
 
 /**
@@ -1665,6 +1736,7 @@ int rproc_trigger_recovery(struct rproc *rproc)
 
 	/* generate coredump */
 	rproc_coredump(rproc);
+	reinit_completion(&rproc->dump_done);
 
 	/* load firmware */
 	ret = request_firmware(&firmware_p, rproc->firmware, dev);
@@ -2067,6 +2139,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	INIT_LIST_HEAD(&rproc->rvdevs);
 	INIT_LIST_HEAD(&rproc->subdevs);
 	INIT_LIST_HEAD(&rproc->dump_segments);
+	init_completion(&rproc->dump_done);
 
 	INIT_WORK(&rproc->crash_handler, rproc_crash_handler_work);
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 16ad666..461b235 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -481,6 +481,8 @@ struct rproc_dump_segment {
  * @auto_boot: flag to indicate if remote processor should be auto-started
  * @dump_segments: list of segments in the firmware
  * @nb_vdev: number of vdev currently handled by rproc
+ * @dump_done: completion variable when dump is complete
+ * @elfcore: pointer to elf header buffer
  */
 struct rproc {
 	struct list_head node;
@@ -514,6 +516,8 @@ struct rproc {
 	bool auto_boot;
 	struct list_head dump_segments;
 	int nb_vdev;
+	struct completion dump_done;
+	void *elfcore;
 };
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
