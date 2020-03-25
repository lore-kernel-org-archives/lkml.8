Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD60C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 00:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE13206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 00:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCYAhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 20:37:50 -0400
Received: from mta01.start.ca ([162.250.196.97]:55166 "EHLO mta01.start.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbgCYAht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 20:37:49 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Mar 2020 20:37:49 EDT
Received: from mta01.start.ca (localhost [127.0.0.1])
        by mta01.start.ca (Postfix) with ESMTP id 7F76D4266E;
        Tue, 24 Mar 2020 20:29:21 -0400 (EDT)
Received: from localhost (dhcp-24-53-240-163.cable.user.start.ca [24.53.240.163])
        by mta01.start.ca (Postfix) with ESMTPS id 5527941F7F;
        Tue, 24 Mar 2020 20:29:18 -0400 (EDT)
From:   Nick Bowler <nbowler@draconx.ca>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: Fix NVME_IOCTL_ADMIN_CMD compat address handling.
Date:   Tue, 24 Mar 2020 20:28:48 -0400
Message-Id: <20200325002847.2140-1-nbowler@draconx.ca>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a real 32-bit kernel, the upper bits of userspace addresses passed
to NVME_IOCTL_ADMIN_CMD via the nvme_passthru_cmd structure are silently
ignored by the nvme driver.

However on a 64-bit kernel running a compat task, these upper bits are
not ignored and are in fact required to be zero for the ioctl to work.

Unfortunately, this difference matters.  32-bit smartctl submits garbage
in these upper bits because it seems the pointer value it puts into the
nvme_passthru_cmd structure is sign extended.  This works fine on a real
32-bit kernel but fails on a 64-bit one because (at least on my setup)
the addresses smartctl uses are consistently above 2G.  For example:

  # smartctl -x /dev/nvme0n1p1
  smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.5.11] (local build)
  Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools.org

  Read NVMe Identify Controller failed: NVME_IOCTL_ADMIN_CMD: Bad address

Since changing 32-bit kernels to actually check all of the submitted
address bits now would break existing userspace, this patch fixes the
problem by explicitly zeroing the upper bits in the compat case.  This
enables 32-bit smartctl to work on a 64-bit kernel.

Signed-off-by: Nick Bowler <nbowler@draconx.ca>
---
 drivers/nvme/host/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a4d8c90ee7cc..afb7b76d1d8a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -6,6 +6,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
+#include <linux/compat.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/hdreg.h>
@@ -1412,6 +1413,16 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
+	if (in_compat_syscall()) {
+		/*
+		 * On real 32-bit kernels this implementation ignores the
+		 * upper bits of address fields so we must replicate that
+		 * behaviour in the compat case.
+		 */
+		cmd.addr = (compat_uptr_t)cmd.addr;
+		cmd.metadata = (compat_uptr_t)cmd.metadata;
+	}
+
 	effects = nvme_passthru_start(ctrl, ns, cmd.opcode);
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
-- 
2.24.1

