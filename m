Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFA4C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C522077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389684AbgDBTbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:31:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:36936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389108AbgDBTbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:31:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A8C07AEC2;
        Thu,  2 Apr 2020 19:31:13 +0000 (UTC)
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: add revalidation support to bdev and file backed namespaces
Date:   Thu,  2 Apr 2020 21:30:52 +0200
Message-Id: <20200402193052.19935-1-ailiop@suse.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for detecting capacity changes on nvmet blockdev and file
backed namespaces. This allows for emulating and testing online resizing
of nvme devices and filesystems on top.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 drivers/nvme/target/admin-cmd.c   |  5 +++++
 drivers/nvme/target/io-cmd-bdev.c | 10 ++++++++++
 drivers/nvme/target/io-cmd-file.c | 14 ++++++++++++++
 drivers/nvme/target/nvmet.h       |  2 ++
 4 files changed, 31 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 9d6f75cfa77c..4c79aa804887 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -486,6 +486,11 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	if (!ns)
 		goto done;
 
+	if (ns->bdev)
+		nvmet_bdev_ns_revalidate(ns);
+	else
+		nvmet_file_ns_revalidate(ns);
+
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
 	 * that out from the underlying device.
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index ea0e596be15d..1f8c00d68aa9 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -75,6 +75,16 @@ void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 	}
 }
 
+void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
+{
+	loff_t size;
+
+	size = i_size_read(ns->bdev->bd_inode);
+
+	if (ns->size != size)
+		ns->size = size;
+}
+
 static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 {
 	u16 status = NVME_SC_SUCCESS;
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index cd5670b83118..c102437db72a 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -80,6 +80,20 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	return ret;
 }
 
+void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
+{
+	struct kstat stat;
+
+	if (!ns->file)
+		return;
+
+	if (vfs_getattr(&ns->file->f_path,
+			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC))
+		return;
+
+	ns->size = stat.size;
+}
+
 static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
 {
 	bv->bv_page = sg_page(sg);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 421dff3ea143..8b479d932a7b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -498,6 +498,8 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns);
 u16 nvmet_bdev_flush(struct nvmet_req *req);
 u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
+void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
+void nvmet_file_ns_revalidate(struct nvmet_ns *ns);
 
 static inline u32 nvmet_rw_len(struct nvmet_req *req)
 {
-- 
2.26.0

