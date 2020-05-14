Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE57CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C12206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgENRX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:23:27 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46964 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgENRXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:23:16 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jZHZV-00021u-U7; Thu, 14 May 2020 11:23:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jZHZV-0001hC-1B; Thu, 14 May 2020 11:23:01 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Thu, 14 May 2020 11:22:52 -0600
Message-Id: <20200514172253.6445-9-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514172253.6445-1-logang@deltatee.com>
References: <20200514172253.6445-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com, Chaitanya.Kulkarni@wdc.com, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v13 8/9] nvmet-passthru: Add enable/disable helpers
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds helper functions which are used in the NVMeOF configfs
when the user is configuring the passthru subsystem. Here we ensure
that only one subsys is assigned to each nvme_ctrl by using an xarray
on the cntlid.

The subsystem's version number is overridden by the passed through
controller's version. However, if that version is less than 1.2.1,
then we bump the advertised version to that and print a warning
in dmesg.

Based-on-a-patch-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/configfs.c |  4 ++
 drivers/nvme/target/core.c     | 10 +++-
 drivers/nvme/target/nvmet.h    | 12 +++++
 drivers/nvme/target/passthru.c | 87 ++++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 58cabd7b6fc5..e0ce6e5feb3a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -826,6 +826,10 @@ static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
 	int major, minor, tertiary = 0;
 	int ret;
 
+	/* passthru subsystems use the underlying controller's version */
+	if (nvmet_passthru_ctrl(subsys))
+		return -EINVAL;
+
 	ret = sscanf(page, "%d.%d.%d\n", &major, &minor, &tertiary);
 	if (ret != 2 && ret != 3)
 		return -EINVAL;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 2547e0d8951c..a2cdd35ffb1d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -522,6 +522,12 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 
 	mutex_lock(&subsys->lock);
 	ret = 0;
+
+	if (nvmet_passthru_ctrl(subsys)) {
+		pr_info("cannot enable both passthru and regular namespaces for a single subsystem");
+		goto out_unlock;
+	}
+
 	if (ns->enabled)
 		goto out_unlock;
 
@@ -1421,7 +1427,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	if (!subsys)
 		return ERR_PTR(-ENOMEM);
 
-	subsys->ver = NVME_VS(1, 3, 0); /* NVMe 1.3.0 */
+	subsys->ver = NVMET_DEFAULT_VS;
 	/* generate a random serial number as our controllers are ephemeral: */
 	get_random_bytes(&subsys->serial, sizeof(subsys->serial));
 
@@ -1463,6 +1469,8 @@ static void nvmet_subsys_free(struct kref *ref)
 
 	WARN_ON_ONCE(!list_empty(&subsys->namespaces));
 
+	nvmet_passthru_subsys_free(subsys);
+
 	kfree(subsys->subsysnqn);
 	kfree_rcu(subsys->model, rcuhead);
 	kfree(subsys);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index deb996c90804..76c3a7cb9c89 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -20,6 +20,8 @@
 #include <linux/blkdev.h>
 #include <linux/radix-tree.h>
 
+#define NVMET_DEFAULT_VS		NVME_VS(1, 3, 0)
+
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
 #define NVMET_NO_ERROR_LOC		((u16)-1)
@@ -240,6 +242,7 @@ struct nvmet_subsys {
 
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 	struct nvme_ctrl	*passthru_ctrl;
+	char			*passthru_ctrl_path;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 };
 
@@ -523,6 +526,9 @@ static inline u32 nvmet_dsm_len(struct nvmet_req *req)
 }
 
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
+void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys);
+int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys);
+void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys);
 u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req);
 u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req);
 static inline struct nvme_ctrl *nvmet_passthru_ctrl(struct nvmet_subsys *subsys)
@@ -530,6 +536,12 @@ static inline struct nvme_ctrl *nvmet_passthru_ctrl(struct nvmet_subsys *subsys)
 	return subsys->passthru_ctrl;
 }
 #else /* CONFIG_NVME_TARGET_PASSTHRU */
+static inline void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
+{
+}
+static inline void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
+{
+}
 static inline u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 {
 	return 0;
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 15b23521e59f..a11c3ef34041 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -11,6 +11,11 @@
 #include "../host/nvme.h"
 #include "nvmet.h"
 
+/*
+ * xarray to maintain one passthru subsystem per nvme controller.
+ */
+static DEFINE_XARRAY(passthru_subsystems);
+
 static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, p.work);
@@ -458,3 +463,85 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 }
+
+int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
+{
+	struct nvme_ctrl *ctrl;
+	int ret = -EINVAL;
+	void *old;
+
+	mutex_lock(&subsys->lock);
+	if (!subsys->passthru_ctrl_path)
+		goto out_unlock;
+	if (subsys->passthru_ctrl)
+		goto out_unlock;
+
+	if (subsys->nr_namespaces) {
+		pr_info("cannot enable both passthru and regular namespaces for a single subsystem");
+		goto out_unlock;
+	}
+
+	ctrl = nvme_ctrl_get_by_path(subsys->passthru_ctrl_path);
+	if (IS_ERR(ctrl)) {
+		ret = PTR_ERR(ctrl);
+		pr_err("failed to open nvme controller %s\n",
+		       subsys->passthru_ctrl_path);
+
+		goto out_unlock;
+	}
+
+	old = xa_cmpxchg(&passthru_subsystems, ctrl->cntlid, NULL,
+			 subsys, GFP_KERNEL);
+	if (xa_is_err(old)) {
+		ret = xa_err(old);
+		goto out_put_ctrl;
+	}
+
+	if (old)
+		goto out_put_ctrl;
+
+	subsys->passthru_ctrl = ctrl;
+	subsys->ver = ctrl->vs;
+
+	if (subsys->ver < NVME_VS(1, 2, 1)) {
+		pr_warn("nvme controller version is too old: %d.%d.%d, advertising 1.2.1\n",
+			(int)NVME_MAJOR(subsys->ver),
+			(int)NVME_MINOR(subsys->ver),
+			(int)NVME_TERTIARY(subsys->ver));
+		subsys->ver = NVME_VS(1, 2, 1);
+	}
+
+	mutex_unlock(&subsys->lock);
+	return 0;
+
+out_put_ctrl:
+	nvme_put_ctrl(ctrl);
+out_unlock:
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+
+static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
+{
+	if (subsys->passthru_ctrl) {
+		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
+		nvme_put_ctrl(subsys->passthru_ctrl);
+	}
+	subsys->passthru_ctrl = NULL;
+	subsys->ver = NVMET_DEFAULT_VS;
+}
+
+void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
+{
+	mutex_lock(&subsys->lock);
+	__nvmet_passthru_ctrl_disable(subsys);
+	mutex_unlock(&subsys->lock);
+}
+
+void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
+{
+	mutex_lock(&subsys->lock);
+	__nvmet_passthru_ctrl_disable(subsys);
+	mutex_unlock(&subsys->lock);
+	kfree(subsys->passthru_ctrl_path);
+}
-- 
2.20.1

