Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1ECC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F80A20890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UCkLZZdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbgFRUCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:02:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16855 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbgFRUCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592510567; x=1624046567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gJuYaqcKR+OMZ7sPr5EK6CTqXx7WnxJVT3V/UoaoUYA=;
  b=UCkLZZdcDTo5oXLXKzeJk1GOYlrTgqkchBcrKP2JClc9xOKkMO2iNMf8
   Bb83lyoW5P6uu62ozDd1lkyjymmCtJ+jpYXAfjGgEqIVfooEZA2ZYSC3m
   ciSJEejkjxeBCOHbj9AcgCiZH0mWPVpy+3DCuRDiRy2xRkHdAlMiAcGTO
   OQiOaLHaexSB5+viK3fLsFtfD39Bre0Wjb5+vk/ccSXAOOPksvRL2pIVP
   +N0ACGQiUfSAOtzx8mcXeJM4vGYfLCzmerj4cfSyJS9kR9TiUZc8/akYq
   lPRlDYU+Rk1Qu1gYR7KZM9/Wj5jpp+FF6qMZ4qPE22rci27fs/Vuiq5+K
   g==;
IronPort-SDR: ILU2r48T7kblUQvxAN0an4u6NfzqwC+9koRWMrqmuxM250Ep55LnMiJ/m4KP7NJD0MkFFSMBZz
 NwRhkrDGJDVBXjQAkX2Sunc5K0fdhCS3D3w4TOofS1u8MDeW10NehjxlKaEkP4GMXyrUMBJIQw
 gVddJ7i+aFKhRXHTydyYlEPTycCiHWymC15ZFYTBdDDQEWn19lkr7QhiQBDt3lKwOKPnxQdV0h
 BofBirRpeAG2WFwfgOFiUMiNvpTUfy+9Ms6faCeyTo5MyCCMyhi0QD76Q6a0tb76RTn7SJXRrK
 NWg=
X-IronPort-AV: E=Sophos;i="5.75,252,1589212800"; 
   d="scan'208";a="140608375"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 04:02:46 +0800
IronPort-SDR: LKJNZlmvBCiB+DykRE8Uz/BbBy4U6ukRmQmjmu3TW6w+xpzoU7sIVM/ybDolXLLGG7bJvqREa0
 GELjuqVgCy8PJi0mmEK7dELAE0UKgnMmk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 12:51:25 -0700
IronPort-SDR: 4x42ejM9hx1A2RKaVuLbvcjCLRTdokmVOWyuf781LTlTNCDoj7DmNk3s2yEx6lMKSh8/mr630K
 RoEuSZq6Pohw==
WDCIronportException: Internal
Received: from usa001298.ad.shared (HELO localhost.hgst.com) ([10.86.58.149])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 13:02:44 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] nvmet: remove workarounds for gcc bug wrt unnamed fields in initializers
Date:   Thu, 18 Jun 2020 22:02:34 +0200
Message-Id: <20200618200235.1104587-3-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618200235.1104587-1-niklas.cassel@wdc.com>
References: <20200618200235.1104587-1-niklas.cassel@wdc.com>
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
 drivers/nvme/target/rdma.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 6731e0349480..238bc55de561 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1535,19 +1535,20 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
 		struct nvmet_rdma_queue *queue,
 		struct rdma_conn_param *p)
 {
-	struct rdma_conn_param  param = { };
-	struct nvme_rdma_cm_rep priv = { };
+	struct nvme_rdma_cm_rep priv = {
+		.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0),
+		.crqsize = cpu_to_le16(queue->recv_queue_size),
+	};
+	struct rdma_conn_param  param = {
+		.rnr_retry_count = 7,
+		.flow_control = 1,
+		.initiator_depth = min_t(u8, p->initiator_depth,
+			queue->dev->device->attrs.max_qp_init_rd_atom),
+		.private_data = &priv,
+		.private_data_len = sizeof(priv),
+	};
 	int ret = -ENOMEM;
 
-	param.rnr_retry_count = 7;
-	param.flow_control = 1;
-	param.initiator_depth = min_t(u8, p->initiator_depth,
-		queue->dev->device->attrs.max_qp_init_rd_atom);
-	param.private_data = &priv;
-	param.private_data_len = sizeof(priv);
-	priv.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0);
-	priv.crqsize = cpu_to_le16(queue->recv_queue_size);
-
 	ret = rdma_accept(cm_id, &param);
 	if (ret)
 		pr_err("rdma_accept failed (error code = %d)\n", ret);
-- 
2.26.2

