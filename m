Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2610C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DB9208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgBTUaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:30:02 -0500
Received: from ale.deltatee.com ([207.54.116.67]:44994 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgBTUaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:30:02 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1j4sSO-0005XN-Dz; Thu, 20 Feb 2020 13:30:01 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1j4sSM-0006oK-Ry; Thu, 20 Feb 2020 13:29:58 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 20 Feb 2020 13:29:53 -0700
Message-Id: <20200220202953.26139-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] nvme-multipath: Fix memory leak with ana_log_buf
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak reports a memory leak with the ana_log_buf allocated by
nvme_mpath_init():

unreferenced object 0xffff888120e94000 (size 8208):
  comm "nvme", pid 6884, jiffies 4295020435 (age 78786.312s)
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
      01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace:
      [<00000000e2360188>] kmalloc_order+0x97/0xc0
      [<0000000079b18dd4>] kmalloc_order_trace+0x24/0x100
      [<00000000f50c0406>] __kmalloc+0x24c/0x2d0
      [<00000000f31a10b9>] nvme_mpath_init+0x23c/0x2b0
      [<000000005802589e>] nvme_init_identify+0x75f/0x1600
      [<0000000058ef911b>] nvme_loop_configure_admin_queue+0x26d/0x280
      [<00000000673774b9>] nvme_loop_create_ctrl+0x2a7/0x710
      [<00000000f1c7a233>] nvmf_dev_write+0xc66/0x10b9
      [<000000004199f8d0>] __vfs_write+0x50/0xa0
      [<0000000065466fef>] vfs_write+0xf3/0x280
      [<00000000b0db9a8b>] ksys_write+0xc6/0x160
      [<0000000082156b91>] __x64_sys_write+0x43/0x50
      [<00000000c34fbb6d>] do_syscall_64+0x77/0x2f0
      [<00000000bbc574c9>] entry_SYSCALL_64_after_hwframe+0x49/0xbe

nvme_mpath_init() is called by nvme_init_identify() which is called in
multiple places (nvme_reset_work(), nvme_passthru_end(), etc). This
means nvme_mpath_init() may be called multiple times before
nvme_mpath_uninit() (which is only called on nvme_free_ctrl()).

When nvme_mpath_init() is called multiple times, it overwrites the
ana_log_buf pointer with a new allocation, thus leaking the previous
allocation.

To fix this, free ana_log_buf before allocating a new one.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/multipath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 797c18337d96..a11900cf3a36 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -715,6 +715,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	}
 
 	INIT_WORK(&ctrl->ana_work, nvme_ana_work);
+	kfree(ctrl->ana_log_buf);
 	ctrl->ana_log_buf = kmalloc(ctrl->ana_log_size, GFP_KERNEL);
 	if (!ctrl->ana_log_buf) {
 		error = -ENOMEM;

base-commit: 11a48a5a18c63fd7621bb050228cebf13566e4d8
-- 
2.20.1

