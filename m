Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6D0C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 11:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3749A20723
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 11:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Pp9NmdZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgFGLpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 07:45:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63936 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFGLph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 07:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591530336; x=1623066336;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S7kE+3rYo4NWaQHRLUyBuskqtYeCu0An8sg/ravi1Dg=;
  b=Pp9NmdZkBhUii5hUijPsAIfWEvSVZS+iK2C2GSJmLZqJPw+H7PIKXFb0
   FlZgJ/VbYp5wHcnxmoqQnCaQne40+zd8PsYMyrF54M4G0Ojle7i/h3Vq2
   DGP6T7ocIs614LgC+BD3HcK/DFYU3SrOs6gU40+3Ctf6dPB55uP/ccugc
   Na2+jz33mf2QJEP/f0AkepumPNHyRNyuo+tLAmsIyAtK+XXBfQaiurojO
   jrRD8bI3eOpWfuvJXLrJl8CCrMtS8lImzJzUuRCWkgAr3uddcemnjpAYY
   g+mAwsnquWNKe2qXdQApoGkloz1lQyV04FHf7YElZHd+e5OhOCraVqJaJ
   A==;
IronPort-SDR: xn62ZDYQImLB3xJ7ZgFDf8F4oqb10yny9IGGjzDefQWXxVT0XqfUoBjwb43Bqrbjxvyf9GaUui
 dl3tZlbSSBzzBn0CIZhhDcr3FsPpHVJyilmmY+ZgKusGW1FD+fnRdT6MzAszobK3AAAbU0QY0O
 a4lIi3S88VX8Xz4ro0H4jLBQNxsW4HIsKQ9ON84b1sXgEnGP7dEI9RstCo8h+gr134qpgIh0em
 U0dx+k/MUlxsoftVtpqM0rhLUJ+VRfsrpghxeIHiCeMHbFmgKf9TqaUcbRk9KZg27Dj7Dmp07C
 U8A=
X-IronPort-AV: E=Sophos;i="5.73,484,1583164800"; 
   d="scan'208";a="139693615"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2020 19:45:36 +0800
IronPort-SDR: f8RV/cT1TcEwdFysI+RUwET5DQDd0s+Be04gTwDUmpKPpqjnr1/OfKgBn4Tn9sWghUozRGFXJz
 dojvgG4vvJn/4psKRII3ELvejQDMzTBkQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2020 04:35:08 -0700
IronPort-SDR: oq9KIwqGk2lsQJ2F7UpRsBjmE8rHamV0JijZJGpj0a7tWtXi9jTvsO03148VIHsma6npPFRlf4
 Oe5++k68rUnQ==
WDCIronportException: Internal
Received: from phd007118.ad.shared (HELO localhost.hgst.com) ([10.86.57.212])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2020 04:45:34 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: do not call del_gendisk() on a disk that was never added
Date:   Sun,  7 Jun 2020 13:45:20 +0200
Message-Id: <20200607114520.130756-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_add_disk() is negated by del_gendisk().
alloc_disk_node() is negated by put_disk().

In nvme_alloc_ns(), device_add_disk() is one of the last things being
called in the success case, and only void functions are being called
after this. Therefore this call should not be negated in the error path.

The superfluous call to del_gendisk() leads to the following prints:
[    7.839975] kobject: '(null)' (000000001ff73734): is not initialized, yet kobject_put() is being called.
[    7.840865] WARNING: CPU: 2 PID: 361 at lib/kobject.c:736 kobject_put+0x70/0x120

Fixes: 33cfdc2aa696 ("nvme: enforce extended LBA format for fabrics metadata")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
An alternative would be to do like nvme_ns_remove(), i.e. in the error
path; check if ns->disk->flags & GENHD_FL_UP is set, and only then call
del_gendisk(). However, that seems unnecessary, since as nvme_alloc_ns()
is currently written, we know that device_add_disk() does not need to be
negated.

 drivers/nvme/host/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0585efa47d8f..c2c5bc4fb702 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3669,7 +3669,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	ns->disk = disk;
 
 	if (__nvme_revalidate_disk(disk, id))
-		goto out_free_disk;
+		goto out_put_disk;
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		ret = nvme_nvm_register(ns, disk_name, node);
@@ -3696,8 +3696,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	/* prevent double queue cleanup */
 	ns->disk->queue = NULL;
 	put_disk(ns->disk);
- out_free_disk:
-	del_gendisk(ns->disk);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-- 
2.26.2

