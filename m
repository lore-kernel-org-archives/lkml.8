Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA9AC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA00F24655
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBRXS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:18:58 -0500
Received: from silver.sucs.swan.ac.uk ([137.44.10.1]:60216 "EHLO
        silver.sucs.swan.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbgBRXS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:18:58 -0500
X-Greylist: delayed 1018 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 18:18:55 EST
Received: from [95.146.247.173] (helo=localhost.localdomain)
        by silver.sucs.swan.ac.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <edmund@sucs.org>)
        id 1j4Bs3-0007x8-MQ; Tue, 18 Feb 2020 23:01:39 +0000
From:   Edmund Merrow-Smith <edmund@sucs.org>
To:     kbusch@kernel.org
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Edmund Merrow-Smith <edmund@sucs.org>
Subject: [PATCH] drivers: NVME: host: core.c: Fixed some coding style issues.
Date:   Tue, 18 Feb 2020 23:01:31 +0000
Message-Id: <20200218230131.12135-1-edmund@sucs.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a number of style issues highlighted by scripts/checkpatch.pl.
Mostly whitespace issues, implied int warnings,
trailing semicolons and line length issues.

Signed-off-by: Edmund Merrow-Smith <edmund@sucs.org>
---
 drivers/nvme/host/core.c | 142 ++++++++++++++++++++-------------------
 1 file changed, 72 insertions(+), 70 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ada59df642d2..420d19689a62 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -92,7 +92,7 @@ static struct class *nvme_subsys_class;
 static int nvme_revalidate_disk(struct gendisk *disk);
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
-					   unsigned nsid);
+					   unsigned int nsid);
 
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
@@ -482,7 +482,7 @@ static inline void nvme_clear_nvme_request(struct request *req)
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
 {
-	unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
+	unsigned int op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
 	struct request *req;
 
 	if (qid == NVME_QID_ANY) {
@@ -571,7 +571,7 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
 		return 0;
 	}
 
-	ctrl->nr_streams = min_t(unsigned, ctrl->nssa, BLK_MAX_WRITE_HINTS - 1);
+	ctrl->nr_streams = min_t(unsigned int, ctrl->nssa, BLK_MAX_WRITE_HINTS - 1);
 	dev_info(ctrl->device, "Using %u streams\n", ctrl->nr_streams);
 	return 0;
 }
@@ -819,8 +819,8 @@ static void nvme_execute_rq_polled(struct request_queue *q,
  * if the result is positive, it's an NVM Express status code
  */
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		union nvme_result *result, void *buffer, unsigned bufflen,
-		unsigned timeout, int qid, int at_head,
+		union nvme_result *result, void *buffer, unsigned int bufflen,
+		unsigned int timeout, int qid, int at_head,
 		blk_mq_req_flags_t flags, bool poll)
 {
 	struct request *req;
@@ -855,7 +855,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 EXPORT_SYMBOL_GPL(__nvme_submit_sync_cmd);
 
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		void *buffer, unsigned bufflen)
+		void *buffer, unsigned int bufflen)
 {
 	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen, 0,
 			NVME_QID_ANY, 0, 0, false);
@@ -863,7 +863,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
 static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
-		unsigned len, u32 seed, bool write)
+		unsigned int len, u32 seed, bool write)
 {
 	struct bio_integrity_payload *bip;
 	int ret = -ENOMEM;
@@ -898,8 +898,8 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 
 static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, void __user *ubuffer,
-		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		u32 meta_seed, u64 *result, unsigned timeout)
+		unsigned int bufflen, void __user *meta_buffer, unsigned int meta_len,
+		u32 meta_seed, u64 *result, unsigned int timeout)
 {
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
@@ -924,8 +924,8 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		bio = req->bio;
 		bio->bi_disk = disk;
 		if (disk && meta_buffer && meta_len) {
-			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
-					meta_seed, write);
+			meta = nvme_add_user_metadata(bio, meta_buffer,
+					meta_len, meta_seed, write);
 			if (IS_ERR(meta)) {
 				ret = PTR_ERR(meta);
 				goto out_unmap;
@@ -983,8 +983,8 @@ static int nvme_keep_alive(struct nvme_ctrl *ctrl)
 {
 	struct request *rq;
 
-	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd, BLK_MQ_REQ_RESERVED,
-			NVME_QID_ANY);
+	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd,
+			BLK_MQ_REQ_RESERVED, NVME_QID_ANY);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
 
@@ -1055,7 +1055,7 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 	return error;
 }
 
-static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
+static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned int nsid,
 		struct nvme_ns_ids *ids)
 {
 	struct nvme_command c = { };
@@ -1127,7 +1127,8 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 	return status;
 }
 
-static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *ns_list)
+static int nvme_identify_ns_list(struct nvme_ctrl *dev,
+		unsigned int nsid, __le32 *ns_list)
 {
 	struct nvme_command c = { };
 
@@ -1252,7 +1253,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
 	struct nvme_user_io io;
 	struct nvme_command c;
-	unsigned length, meta_len;
+	unsigned int length, meta_len;
 	void __user *metadata;
 
 	if (copy_from_user(&io, uio, sizeof(io)))
@@ -1384,7 +1385,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
-	unsigned timeout = 0;
+	unsigned int timeout = 0;
 	u32 effects;
 	u64 result;
 	int status;
@@ -1432,7 +1433,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 {
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command c;
-	unsigned timeout = 0;
+	unsigned int timeout = 0;
 	u32 effects;
 	int status;
 
@@ -1462,8 +1463,8 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	effects = nvme_passthru_start(ctrl, ns, cmd.opcode);
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
-			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata_len,
-			0, &cmd.result, timeout);
+			(void __user *)(uintptr_t)cmd.metadata,
+			cmd.metadata_len, 0, &cmd.result, timeout);
 	nvme_passthru_end(ctrl, effects);
 
 	if (status >= 0) {
@@ -1949,7 +1950,7 @@ static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 }
 
 static int nvme_pr_register(struct block_device *bdev, u64 old,
-		u64 new, unsigned flags)
+		u64 new, unsigned int flags)
 {
 	u32 cdw10;
 
@@ -1963,7 +1964,7 @@ static int nvme_pr_register(struct block_device *bdev, u64 old,
 }
 
 static int nvme_pr_reserve(struct block_device *bdev, u64 key,
-		enum pr_type type, unsigned flags)
+		enum pr_type type, unsigned int flags)
 {
 	u32 cdw10;
 
@@ -1988,7 +1989,8 @@ static int nvme_pr_clear(struct block_device *bdev, u64 key)
 	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_register);
 }
 
-static int nvme_pr_release(struct block_device *bdev, u64 key, enum pr_type type)
+static int nvme_pr_release(struct block_device *bdev, u64 key,
+		enum pr_type type)
 {
 	u32 cdw10 = nvme_pr_type(type) << 8 | (key ? 1 << 3 : 0);
 	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
@@ -2025,14 +2027,14 @@ EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
 
 static const struct block_device_operations nvme_fops = {
-	.owner		= THIS_MODULE,
-	.ioctl		= nvme_ioctl,
-	.compat_ioctl	= nvme_ioctl,
-	.open		= nvme_open,
-	.release	= nvme_release,
-	.getgeo		= nvme_getgeo,
-	.revalidate_disk= nvme_revalidate_disk,
-	.pr_ops		= &nvme_pr_ops,
+	.owner		 = THIS_MODULE,
+	.ioctl		 = nvme_ioctl,
+	.compat_ioctl	 = nvme_ioctl,
+	.open		 = nvme_open,
+	.release	 = nvme_release,
+	.getgeo		 = nvme_getgeo,
+	.revalidate_disk = nvme_revalidate_disk,
+	.pr_ops		 = &nvme_pr_ops,
 };
 
 #ifdef CONFIG_NVME_MULTIPATH
@@ -2119,7 +2121,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	 * path in the future to accomodate architectures with differing
 	 * kernel and IO page sizes.
 	 */
-	unsigned dev_page_min, page_shift = 12;
+	unsigned int dev_page_min, page_shift = 12;
 	int ret;
 
 	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
@@ -2259,7 +2261,7 @@ static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 	 * can set ps_max_latency_us to zero to turn off APST.
 	 */
 
-	unsigned apste;
+	unsigned int apste;
 	struct nvme_feat_auto_pst *table;
 	u64 max_lat_us = 0;
 	int max_ps = -1;
@@ -2448,13 +2450,13 @@ static bool quirk_matches(const struct nvme_id_ctrl *id,
 		string_matches(id->fr, q->fr, sizeof(id->fr));
 }
 
-static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ctrl,
-		struct nvme_id_ctrl *id)
+static void nvme_init_subnqn(struct nvme_subsystem *subsys,
+		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	size_t nqnlen;
 	int off;
 
-	if(!(ctrl->quirks & NVME_QUIRK_IGNORE_DEV_SUBNQN)) {
+	if (!(ctrl->quirks & NVME_QUIRK_IGNORE_DEV_SUBNQN)) {
 		nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
 		if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
 			strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
@@ -2557,7 +2559,7 @@ static ssize_t subsys_##field##_show(struct device *dev,		\
 	return sprintf(buf, "%.*s\n",					\
 		       (int)sizeof(subsys->field), subsys->field);	\
 }									\
-static SUBSYS_ATTR_RO(field, S_IRUGO, subsys_##field##_show);
+static SUBSYS_ATTR_RO(field, S_IRUGO, subsys_##field##_show)
 
 nvme_subsys_show_str_function(model);
 nvme_subsys_show_str_function(serial);
@@ -2857,8 +2859,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		 */
 		if (ctrl->cntlid != le16_to_cpu(id->cntlid)) {
 			dev_err(ctrl->device,
-				"Mismatching cntlid: Connect %u vs Identify "
-				"%u, rejecting\n",
+				"Mismatching cntlid: Connect %u vs Identify %u, rejecting\n",
 				ctrl->cntlid, le16_to_cpu(id->cntlid));
 			ret = -EINVAL;
 			goto out_free;
@@ -2891,7 +2892,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ret = nvme_configure_apst(ctrl);
 	if (ret < 0)
 		return ret;
-	
+
 	ret = nvme_configure_timestamp(ctrl);
 	if (ret < 0)
 		return ret;
@@ -3159,28 +3160,28 @@ const struct attribute_group *nvme_ns_id_attr_groups[] = {
 	NULL,
 };
 
-#define nvme_show_str_function(field)						\
-static ssize_t  field##_show(struct device *dev,				\
-			    struct device_attribute *attr, char *buf)		\
-{										\
-        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
-        return sprintf(buf, "%.*s\n",						\
-		(int)sizeof(ctrl->subsys->field), ctrl->subsys->field);		\
-}										\
-static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
+#define nvme_show_str_function(field)					\
+static ssize_t  field##_show(struct device *dev,			\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
+	return sprintf(buf, "%.*s\n",					\
+		(int)sizeof(ctrl->subsys->field), ctrl->subsys->field);	\
+}									\
+static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL)
 
 nvme_show_str_function(model);
 nvme_show_str_function(serial);
 nvme_show_str_function(firmware_rev);
 
-#define nvme_show_int_function(field)						\
-static ssize_t  field##_show(struct device *dev,				\
-			    struct device_attribute *attr, char *buf)		\
-{										\
-        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
-        return sprintf(buf, "%d\n", ctrl->field);	\
-}										\
-static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
+#define nvme_show_int_function(field)					\
+static ssize_t  field##_show(struct device *dev,			\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
+	return sprintf(buf, "%d\n", ctrl->field);			\
+}									\
+static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL)
 
 nvme_show_int_function(cntlid);
 nvme_show_int_function(numa_node);
@@ -3223,7 +3224,7 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 		[NVME_CTRL_DEAD]	= "dead",
 	};
 
-	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
+	if ((unsigned int)ctrl->state < ARRAY_SIZE(state_name) &&
 	    state_name[ctrl->state])
 		return sprintf(buf, "%s\n", state_name[ctrl->state]);
 
@@ -3295,7 +3296,7 @@ static const struct attribute_group *nvme_dev_attr_groups[] = {
 };
 
 static struct nvme_ns_head *__nvme_find_ns_head(struct nvme_subsystem *subsys,
-		unsigned nsid)
+		unsigned int nsid)
 {
 	struct nvme_ns_head *h;
 
@@ -3327,7 +3328,7 @@ static int __nvme_check_ids(struct nvme_subsystem *subsys,
 }
 
 static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
-		unsigned nsid, struct nvme_id_ns *id)
+		unsigned int nsid, struct nvme_id_ns *id)
 {
 	struct nvme_ns_head *head;
 	size_t size = sizeof(*head);
@@ -3384,7 +3385,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	return ERR_PTR(ret);
 }
 
-static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
+static int nvme_init_ns_head(struct nvme_ns *ns, unsigned int nsid,
 		struct nvme_id_ns *id)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
@@ -3435,7 +3436,8 @@ static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 	return nsa->head->ns_id - nsb->head->ns_id;
 }
 
-static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl,
+		unsigned int nsid)
 {
 	struct nvme_ns *ns, *ret = NULL;
 
@@ -3613,7 +3615,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	nvme_put_ns(ns);
 }
 
-static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned int nsid)
 {
 	struct nvme_ns *ns;
 
@@ -3627,7 +3629,7 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 }
 
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
-					unsigned nsid)
+					unsigned int nsid)
 {
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(rm_list);
@@ -3644,12 +3646,12 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 
 }
 
-static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
+static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned int nn)
 {
 	struct nvme_ns *ns;
 	__le32 *ns_list;
-	unsigned i, j, nsid, prev = 0;
-	unsigned num_lists = DIV_ROUND_UP_ULL((u64)nn, 1024);
+	unsigned int i, j, nsid, prev = 0;
+	unsigned int num_lists = DIV_ROUND_UP_ULL((u64)nn, 1024);
 	int ret = 0;
 
 	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
@@ -3685,9 +3687,9 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 	return ret;
 }
 
-static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl, unsigned nn)
+static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl, unsigned int nn)
 {
-	unsigned i;
+	unsigned int i;
 
 	for (i = 1; i <= nn; i++)
 		nvme_validate_ns(ctrl, i);
@@ -3725,7 +3727,7 @@ static void nvme_scan_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, scan_work);
 	struct nvme_id_ctrl *id;
-	unsigned nn;
+	unsigned int nn;
 
 	/* No tagset on a live ctrl means IO queues could not created */
 	if (ctrl->state != NVME_CTRL_LIVE || !ctrl->tagset)
-- 
2.20.1

