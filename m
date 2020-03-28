Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5697C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 05:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61B82073B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 05:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgC1FKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 01:10:32 -0400
Received: from mta01.start.ca ([162.250.196.97]:44034 "EHLO mta01.start.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgC1FKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 01:10:32 -0400
Received: from mta01.start.ca (localhost [127.0.0.1])
        by mta01.start.ca (Postfix) with ESMTP id B518742923;
        Sat, 28 Mar 2020 01:10:31 -0400 (EDT)
Received: from localhost (dhcp-24-53-240-163.cable.user.start.ca [24.53.240.163])
        by mta01.start.ca (Postfix) with ESMTPS id 8561442922;
        Sat, 28 Mar 2020 01:10:27 -0400 (EDT)
From:   Nick Bowler <nbowler@draconx.ca>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 1/2] nvme: Fix compat NVME_IOCTL_SUBMIT_IO numbering
Date:   Sat, 28 Mar 2020 01:09:08 -0400
Message-Id: <20200328050909.30639-2-nbowler@draconx.ca>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200328050909.30639-1-nbowler@draconx.ca>
References: <20200328050909.30639-1-nbowler@draconx.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When __u64 has 64-bit alignment, the nvme_user_io structure has trailing
padding.  This causes problems in the compat case with 32-bit userspace
that has less strict alignment because the size of the structure differs.

Since the NVME_IOCTL_SUBMIT_IO macro encodes the structure size itself,
the result is that this ioctl does not work at all in such a scenario:

  # nvme read /dev/nvme0n1 -z 512
  submit-io: Inappropriate ioctl for device

But by the same token, this makes it easy to handle both cases and
since the structures differ only in unused trailing padding bytes
we can simply not read those bytes.

Signed-off-by: Nick Bowler <nbowler@draconx.ca>
---
 drivers/nvme/host/core.c        | 19 +++++++++++++------
 include/uapi/linux/nvme_ioctl.h | 25 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a4d8c90ee7cc..9eccf56494de 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1248,14 +1248,19 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 	queue_work(nvme_wq, &ctrl->async_event_work);
 }
 
-static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
+static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio,
+			  size_t uio_size)
 {
 	struct nvme_user_io io;
 	struct nvme_command c;
 	unsigned length, meta_len;
 	void __user *metadata;
 
-	if (copy_from_user(&io, uio, sizeof(io)))
+	/*
+	 * To handle the compat case the amount of data read may be reduced as
+	 * the only difference is in unused padding at the end of the structure.
+	 */
+	if (copy_from_user(&io, uio, uio_size))
 		return -EFAULT;
 	if (io.flags)
 		return -EINVAL;
@@ -1559,6 +1564,11 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	if (is_ctrl_ioctl(cmd))
 		return nvme_handle_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
 
+	if (cmd == NVME_IOCTL_SUBMIT_IO || cmd == NVME_IOCTL_SUBMIT_IO_COMPAT) {
+		ret = nvme_submit_io(ns, argp, _IOC_SIZE(cmd));
+		goto out;
+	}
+
 	switch (cmd) {
 	case NVME_IOCTL_ID:
 		force_successful_syscall_return();
@@ -1567,9 +1577,6 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	case NVME_IOCTL_IO_CMD:
 		ret = nvme_user_cmd(ns->ctrl, ns, argp);
 		break;
-	case NVME_IOCTL_SUBMIT_IO:
-		ret = nvme_submit_io(ns, argp);
-		break;
 	case NVME_IOCTL_IO64_CMD:
 		ret = nvme_user_cmd64(ns->ctrl, ns, argp);
 		break;
@@ -1579,7 +1586,7 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		else
 			ret = -ENOTTY;
 	}
-
+out:
 	nvme_put_ns_from_disk(head, srcu_idx);
 	return ret;
 }
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index d99b5a772698..60e20f23bec9 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -9,6 +9,31 @@
 
 #include <linux/types.h>
 
+#ifdef __KERNEL__
+/*
+ * The nvme_user_io structure has excess padding at the end when __u64 has
+ * 64-bit alignment.  In the compat case with less strict alignment, there
+ * is no such padding.  The nvme_user_io_compat structure has otherwise
+ * identical layout to nvme_user_io as there is no padding between members.
+ */
+struct nvme_user_io_compat {
+	__u8	opcode;
+	__u8	flags;
+	__u16	control;
+	__u16	nblocks;
+	__u16	rsvd;
+	__u64	metadata;
+	__u64	addr;
+	__u64	slba;
+	__u32	dsmgmt;
+	__u32	reftag;
+	__u16	apptag;
+	__u16	appmask;
+} __attribute__((packed));
+
+#define NVME_IOCTL_SUBMIT_IO_COMPAT _IOW('N', 0x42, struct nvme_user_io_compat)
+#endif
+
 struct nvme_user_io {
 	__u8	opcode;
 	__u8	flags;
-- 
2.24.1

