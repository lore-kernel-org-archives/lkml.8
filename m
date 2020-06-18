Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D5CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E7C2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AHTByqNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgFROcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:32:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54455 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbgFROcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592490769; x=1624026769;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tKQtZA7H8abTwZOrHKywDFOuog+pGmQVcPZ/CYAS/qk=;
  b=AHTByqNbI3WDG639oUpABl4Obx1cNrmogyIfSIxNXgMQbMXKmxDocixs
   EINIk8pTvs+YlHImBZhHQe6/7ldwRd93cs7AiTzAKDj4Jn5j1PNhcfZ02
   VmOvdxRmDQzLABLOqquji12O+3ebrlEKatRDnbu3P9/l45VLcbjnjPxdg
   YoP11DFkiTkcbdGQxHkePP2zVsMZcm12+bh9m7DN77TEUEDKHG3Xbzxyj
   FMTDLcI8wST5CrE0Sowa9ZLyXxjjS61zgwE2WlVeTbwfIpD698P5ggCCe
   MamB0hTsY51Avlnd6fDKH65RmwS3Epmfj89rs++1H2uJr21ar/R5pEf4c
   g==;
IronPort-SDR: Fr5+mUigUx43Gm2TZtVxrCBhwUI6vMRhOpkdeO0V1HG3LWzf7wKKzynLGFA+5TPNj41/pTTN1U
 Zejef51Na+RQC9ANX2p6QjqaqGqrQfdbyG+WJ/ZCxtyLr6ncS+Vvk+tN/H9eN4wu5l+sq7Y6sD
 5fywXONyOXGTw4xJ1DguGadOWcwyh5W6SlCzCsqDK+/gaRg6iJgz4e1ZmO0E3V6iDfet9Bgy0F
 hji6p6pLOCoqCUGBUGbR/wQjAOEgzoLrGMXAymEjQ/bV159dmAlCR5ERlGGxnVO4h4MqY1+XFA
 6XE=
X-IronPort-AV: E=Sophos;i="5.73,526,1583164800"; 
   d="scan'208";a="140581910"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 22:32:49 +0800
IronPort-SDR: uz9LH24ZD9CAIhANw7vwuGwhe608sU+HodlFftnUOKmY8T/kmEL4QuZFmAN7S1poUfs8AfD2G4
 P7y9LJ+DxjB+hT2GLIwtJ5zmIgSc5W8so=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 07:22:00 -0700
IronPort-SDR: Uw7NVs1KDMNCtOuozNNRBU++DtokeoDkiKZuhv3DdUKYNyqLBJbvPaPzhGsHwZapR1qdz2DvOZ
 07zC/HR4atSg==
WDCIronportException: Internal
Received: from cnf006060.ad.shared (HELO localhost.hgst.com) ([10.86.58.135])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 07:32:45 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nvme: remove workarounds for gcc bug wrt unnamed fields in initializers
Date:   Thu, 18 Jun 2020 16:32:40 +0200
Message-Id: <20200618143241.1056800-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Workarounds for gcc issues with initializers and anon unions was first
introduced in commit e44ac588cd61 ("drivers/block/nvme-core.c: fix build
with gcc-4.4.4").

The gcc bug in question has been fixed since gcc 4.6.0:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=10676

The minimum gcc version for building the kernel has been 4.6.0 since
commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6"),
and has since been updated to gcc 4.8.0 in
commit 5429ef62bcf3 ("compiler/gcc: Raise minimum GCC version for
kernel builds to 4.8").

For that reason, it should now be safe to remove these workarounds
and make the code look like it did before
commit e44ac588cd61 ("drivers/block/nvme-core.c: fix build with gcc-4.4.4")
was introduced.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
If, for some reason, we want to allow builds with gcc < 4.6.0
even though the minimum gcc version is now 4.8.0,
there is another less intrusive workaround where you add an extra pair of
curly braces, see e.g. commit 6cc65be4f6f2 ("locking/qspinlock: Fix build
for anonymous union in older GCC compilers").

 drivers/nvme/host/core.c     | 59 ++++++++++++++++++------------------
 drivers/nvme/host/lightnvm.c | 32 +++++++++----------
 drivers/nvme/host/rdma.c     | 28 ++++++++---------
 3 files changed, 59 insertions(+), 60 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9491dbcfe81a..99059340d723 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1038,13 +1038,12 @@ static bool nvme_ctrl_limited_cns(struct nvme_ctrl *ctrl)
 
 static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 {
-	struct nvme_command c = { };
+	struct nvme_command c = {
+		.identify.opcode = nvme_admin_identify,
+		.identify.cns = NVME_ID_CNS_CTRL,
+	};
 	int error;
 
-	/* gcc-4.4.4 (at least) has issues with initializers and anon unions */
-	c.identify.opcode = nvme_admin_identify;
-	c.identify.cns = NVME_ID_CNS_CTRL;
-
 	*id = kmalloc(sizeof(struct nvme_id_ctrl), GFP_KERNEL);
 	if (!*id)
 		return -ENOMEM;
@@ -1096,16 +1095,16 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 		struct nvme_ns_ids *ids)
 {
-	struct nvme_command c = { };
+	struct nvme_command c = {
+		.identify.opcode = nvme_admin_identify,
+		.identify.nsid = cpu_to_le32(nsid),
+		.identify.cns = NVME_ID_CNS_NS_DESC_LIST,
+	};
 	int status;
 	void *data;
 	int pos;
 	int len;
 
-	c.identify.opcode = nvme_admin_identify;
-	c.identify.nsid = cpu_to_le32(nsid);
-	c.identify.cns = NVME_ID_CNS_NS_DESC_LIST;
-
 	data = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -1143,11 +1142,12 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 
 static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *ns_list)
 {
-	struct nvme_command c = { };
+	struct nvme_command c = {
+		.identify.opcode = nvme_admin_identify,
+		.identify.cns = NVME_ID_CNS_NS_ACTIVE_LIST,
+		.identify.nsid = cpu_to_le32(nsid),
+	};
 
-	c.identify.opcode = nvme_admin_identify;
-	c.identify.cns = NVME_ID_CNS_NS_ACTIVE_LIST;
-	c.identify.nsid = cpu_to_le32(nsid);
 	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list,
 				    NVME_IDENTIFY_DATA_SIZE);
 }
@@ -1155,14 +1155,13 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
 static int nvme_identify_ns(struct nvme_ctrl *ctrl,
 		unsigned nsid, struct nvme_id_ns **id)
 {
-	struct nvme_command c = { };
+	struct nvme_command c = {
+		.identify.opcode = nvme_admin_identify,
+		.identify.nsid = cpu_to_le32(nsid),
+		.identify.cns = NVME_ID_CNS_NS,
+	};
 	int error;
 
-	/* gcc-4.4.4 (at least) has issues with initializers and anon unions */
-	c.identify.opcode = nvme_admin_identify;
-	c.identify.nsid = cpu_to_le32(nsid);
-	c.identify.cns = NVME_ID_CNS_NS;
-
 	*id = kmalloc(sizeof(**id), GFP_KERNEL);
 	if (!*id)
 		return -ENOMEM;
@@ -2815,17 +2814,17 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
 		void *log, size_t size, u64 offset)
 {
-	struct nvme_command c = { };
 	u32 dwlen = nvme_bytes_to_numd(size);
-
-	c.get_log_page.opcode = nvme_admin_get_log_page;
-	c.get_log_page.nsid = cpu_to_le32(nsid);
-	c.get_log_page.lid = log_page;
-	c.get_log_page.lsp = lsp;
-	c.get_log_page.numdl = cpu_to_le16(dwlen & ((1 << 16) - 1));
-	c.get_log_page.numdu = cpu_to_le16(dwlen >> 16);
-	c.get_log_page.lpol = cpu_to_le32(lower_32_bits(offset));
-	c.get_log_page.lpou = cpu_to_le32(upper_32_bits(offset));
+	struct nvme_command c = {
+		.get_log_page.opcode = nvme_admin_get_log_page,
+		.get_log_page.nsid = cpu_to_le32(nsid),
+		.get_log_page.lid = log_page,
+		.get_log_page.lsp = lsp,
+		.get_log_page.numdl = cpu_to_le16(dwlen & ((1 << 16) - 1)),
+		.get_log_page.numdu = cpu_to_le16(dwlen >> 16),
+		.get_log_page.lpol = cpu_to_le32(lower_32_bits(offset)),
+		.get_log_page.lpou = cpu_to_le32(upper_32_bits(offset)),
+	};
 
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 69608755d415..7c44eca78f0d 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -432,12 +432,12 @@ static int nvme_nvm_identity(struct nvm_dev *nvmdev)
 {
 	struct nvme_ns *ns = nvmdev->q->queuedata;
 	struct nvme_nvm_id12 *id;
-	struct nvme_nvm_command c = {};
+	struct nvme_nvm_command c = {
+		.identity.opcode = nvme_nvm_admin_identity,
+		.identity.nsid = cpu_to_le32(ns->head->ns_id),
+	};
 	int ret;
 
-	c.identity.opcode = nvme_nvm_admin_identity;
-	c.identity.nsid = cpu_to_le32(ns->head->ns_id);
-
 	id = kmalloc(sizeof(struct nvme_nvm_id12), GFP_KERNEL);
 	if (!id)
 		return -ENOMEM;
@@ -479,16 +479,16 @@ static int nvme_nvm_get_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr ppa,
 	struct nvm_geo *geo = &nvmdev->geo;
 	struct nvme_ns *ns = q->queuedata;
 	struct nvme_ctrl *ctrl = ns->ctrl;
-	struct nvme_nvm_command c = {};
+	struct nvme_nvm_command c = {
+		.get_bb.opcode = nvme_nvm_admin_get_bb_tbl,
+		.get_bb.nsid = cpu_to_le32(ns->head->ns_id),
+		.get_bb.spba = cpu_to_le64(ppa.ppa),
+	};
 	struct nvme_nvm_bb_tbl *bb_tbl;
 	int nr_blks = geo->num_chk * geo->num_pln;
 	int tblsz = sizeof(struct nvme_nvm_bb_tbl) + nr_blks;
 	int ret = 0;
 
-	c.get_bb.opcode = nvme_nvm_admin_get_bb_tbl;
-	c.get_bb.nsid = cpu_to_le32(ns->head->ns_id);
-	c.get_bb.spba = cpu_to_le64(ppa.ppa);
-
 	bb_tbl = kzalloc(tblsz, GFP_KERNEL);
 	if (!bb_tbl)
 		return -ENOMEM;
@@ -532,15 +532,15 @@ static int nvme_nvm_set_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr *ppas,
 							int nr_ppas, int type)
 {
 	struct nvme_ns *ns = nvmdev->q->queuedata;
-	struct nvme_nvm_command c = {};
+	struct nvme_nvm_command c = {
+		.set_bb.opcode = nvme_nvm_admin_set_bb_tbl,
+		.set_bb.nsid = cpu_to_le32(ns->head->ns_id),
+		.set_bb.spba = cpu_to_le64(ppas->ppa),
+		.set_bb.nlb = cpu_to_le16(nr_ppas - 1),
+		.set_bb.value = type,
+	};
 	int ret = 0;
 
-	c.set_bb.opcode = nvme_nvm_admin_set_bb_tbl;
-	c.set_bb.nsid = cpu_to_le32(ns->head->ns_id);
-	c.set_bb.spba = cpu_to_le64(ppas->ppa);
-	c.set_bb.nlb = cpu_to_le16(nr_ppas - 1);
-	c.set_bb.value = type;
-
 	ret = nvme_submit_sync_cmd(ns->ctrl->admin_q, (struct nvme_command *)&c,
 								NULL, 0);
 	if (ret)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f8f856dc0c67..08c8728b3b29 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1804,22 +1804,22 @@ static int nvme_rdma_addr_resolved(struct nvme_rdma_queue *queue)
 static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 {
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
-	struct rdma_conn_param param = { };
-	struct nvme_rdma_cm_req priv = { };
+	struct rdma_conn_param param = {
+		.qp_num = queue->qp->qp_num,
+		.flow_control = 1,
+		.responder_resources = queue->device->dev->attrs.max_qp_rd_atom,
+		/* maximum retry count */
+		.retry_count = 7,
+		.rnr_retry_count = 7,
+		.private_data = &priv,
+		.private_data_len = sizeof(priv),
+	};
+	struct nvme_rdma_cm_req priv = {
+		.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0),
+		.qid = cpu_to_le16(nvme_rdma_queue_idx(queue)),
+	};
 	int ret;
 
-	param.qp_num = queue->qp->qp_num;
-	param.flow_control = 1;
-
-	param.responder_resources = queue->device->dev->attrs.max_qp_rd_atom;
-	/* maximum retry count */
-	param.retry_count = 7;
-	param.rnr_retry_count = 7;
-	param.private_data = &priv;
-	param.private_data_len = sizeof(priv);
-
-	priv.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0);
-	priv.qid = cpu_to_le16(nvme_rdma_queue_idx(queue));
 	/*
 	 * set the admin queue depth to the minimum size
 	 * specified by the Fabrics standard.
-- 
2.26.2

