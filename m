Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C13C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D46020575
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QQdBXwV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgD0Mew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:34:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:50435 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgD0Mew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587990891; x=1619526891;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VFhl5pd1bt6CpJr4PfxQxrl9uO26lhYUX26RETwc4cw=;
  b=QQdBXwV4R5BMi/7n+ptMQhetLGya9i9Nos0lfPglvjtRLxHoQ3jyWeRC
   muTgO4GilA+ud0jGUPZpS2XM1zY+lSD+b9o+/NTrblmQ/7CGSVS+myv9U
   hZ6UBLHnFLfFgaSgo4JR8+TK6CPLfr3jPPNuTVX5NHVVv14+Rvoxb7GRp
   HtooSHd0+OIHbx1EBybqUREjQ6bbljpcuwv7q/fy8SbrRzSvm6EIVncGM
   VACW4s0xKyU67yBSCggEIoSmY+62DAkWG+mOdTW8sHwEIHQjYifDXRbnz
   RPSfJqlDNvDlfMO9+5Ne+i000MZiOZsyp82tewp+Ie0MxpEjlpVVM0w5I
   A==;
IronPort-SDR: gC2/NWSK42K5VDDWKPpYpEhrFzq+Ddif/q4nt4Nh/2K6OpryqvgiAPMpaxKYyLnlYHwiKaUXEI
 dpriOGL3NkplAtepHQM/CJxmPxnW3GV7ieSTQD2DTxBJNDdpbc3QaCHFrjkB9ZhrF7mpJVaReR
 MagW71KlXESswJAf/KKuaXlB6Zbs6POx5Cz+GD0rGB5Urk016yz61w2XglkUulA3Lt8VK78L4M
 /28E1F5JcI/ieyjHX3CYmMwAYP0r/KPWaoZmIszdch43KFAKPkF2mlJZr3VGk5xP23fhEVk/p/
 Idc=
X-IronPort-AV: E=Sophos;i="5.73,324,1583164800"; 
   d="scan'208";a="136554768"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 20:34:51 +0800
IronPort-SDR: FXXe/R9ZlLzxEFopDun1TVfvILS8m44+3wt9LUJd2LGVKhL+0FJQmdBjAFQ9WQ8o/OmiKY8d46
 ZPKAH5oVyZyngTxvASun356SIYuoMpvr8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 05:25:32 -0700
IronPort-SDR: joVpwLHLD6k+JizYgH/iGyPlWfrkPSlUPtw35O+L9V3zdtYTZtit5oZ5/epw7Pjc43LN0IvG4Z
 Dz+PMn7H5Bzw==
WDCIronportException: Internal
Received: from th5m0yyf2.ad.shared (HELO localhost.hgst.com) ([10.86.56.126])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Apr 2020 05:34:46 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: prevent double free in nvme_alloc_ns() error handling
Date:   Mon, 27 Apr 2020 14:34:41 +0200
Message-Id: <20200427123443.520469-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When jumping to the out_put_disk label, we will call put_disk(), which will
trigger a call to disk_release(), which calls blk_put_queue().

Later in the cleanup code, we do blk_cleanup_queue(), which will also call
blk_put_queue().

Putting the queue twice is incorrect, and will generate a KASAN splat.

Set the disk->queue pointer to NULL, before calling put_disk(), so that the
first call to blk_put_queue() will not free the queue.

The second call to blk_put_queue() uses another pointer to the same queue,
so this call will still free the queue.

Fixes: 85136c010285 ("lightnvm: simplify geometry enumeration")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 91c1bd659947..f2adea96b04c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3642,6 +3642,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	return;
  out_put_disk:
+	/* prevent double queue cleanup */
+	ns->disk->queue = NULL;
 	put_disk(ns->disk);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
-- 
2.25.3

