Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD1DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2272D207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JpEjWJey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgFROdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:33:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54467 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgFROdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592490788; x=1624026788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e6ntQ+VP9KSu9eLc9ytqyhX70E87lTK30bl1wZkiMCM=;
  b=JpEjWJeykTXKSCxM+mN3fbN7rmwmz/5U5veUHeGeCprRVPMP/3Lh4PRS
   Hwg1ct2jI2/1QMXYXwPpL7HLyeKTf0GNkweytGgBZPgDJZGzgAH6t33fW
   QV/El85PuA1pOr88L9CRhA8VsxSI8+zl/fPiLzRp8nzz2xEWarJOPVF+Z
   Iy7ZrQ8Hh6MS7fz8UAaKnIY+h9gTFtfYG7v7LzlO6LJ7pcQcSNkqvbH6f
   OhYupZp17FLQZHUynnRQEWeHPyYq6Xsu2OPyXbyxZjrNhsTjY1wmGozIo
   HwG8uXSaNbSBYo3caIEWA3DFaBzN+T5p/Bvh+FTCs98WduD376wRr4nLq
   A==;
IronPort-SDR: jWuMIwMuc+5CsgmbaM5qu6sx1Fc55ZFdW3Dq+nX5ehxclturRNhoxCma7TjL1ONayDBJuDDbSv
 93wHGi5+56uJvCyC+Mn+DiuZIoVZH5335bw7XjXbgCmrBGHG+rnxer9IH4mPOvU6bUBhVt2vFn
 73/fzwXwQIHJcLPyWbE/2BGxeAI4IC++hoh1OsUD+B57Bb+qs8+u69pKpz3cNhL7Rn94q/MBdp
 iYFfNguHF7cGUwMTYFFhb7AocXufYgET6geyCAgOW+N0G7slZCjSzQu3UpCeEQHCVHivXl/Q8o
 inE=
X-IronPort-AV: E=Sophos;i="5.73,526,1583164800"; 
   d="scan'208";a="140581915"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 22:32:51 +0800
IronPort-SDR: mEsj++FRJrRdKT/5DFzVVY3sgK7fY0smky26OpA7ch5T6a2PK74ZtYMuEFnSte+OhXA6wz6YjE
 5Imeak7MkITpaL9zTnxQgeIQUciV79QRA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 07:22:02 -0700
IronPort-SDR: TSnT4PLHaTYn/RtOitRfQahJ7TE0OkO8lFGG/Zw/4A7GDquWTbqMuvnBrZKTkEuqyWVffTpGxx
 bI1oxQ6h0uuQ==
WDCIronportException: Internal
Received: from cnf006060.ad.shared (HELO localhost.hgst.com) ([10.86.58.135])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 07:32:48 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvmet: remove workarounds for gcc bug wrt unnamed fields in initializers
Date:   Thu, 18 Jun 2020 16:32:41 +0200
Message-Id: <20200618143241.1056800-2-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618143241.1056800-1-niklas.cassel@wdc.com>
References: <20200618143241.1056800-1-niklas.cassel@wdc.com>
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

 drivers/nvme/target/rdma.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 6731e0349480..85c6ff0b0e44 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1535,19 +1535,20 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
 		struct nvmet_rdma_queue *queue,
 		struct rdma_conn_param *p)
 {
-	struct rdma_conn_param  param = { };
-	struct nvme_rdma_cm_rep priv = { };
+	struct rdma_conn_param  param = {
+		.rnr_retry_count = 7,
+		.flow_control = 1,
+		.initiator_depth = min_t(u8, p->initiator_depth,
+			queue->dev->device->attrs.max_qp_init_rd_atom),
+		.private_data = &priv,
+		.private_data_len = sizeof(priv),
+	};
+	struct nvme_rdma_cm_rep priv = {
+		.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0),
+		.crqsize = cpu_to_le16(queue->recv_queue_size),
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

