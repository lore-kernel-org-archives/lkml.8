Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D221C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74EE22CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MiXYRT5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgHFAIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:08:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60009 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgHFAIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596672486; x=1628208486;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=irrlTT1tShYqK45JMoHx2k1l0ZG3LkU/v6cuAOx3NI4=;
  b=MiXYRT5+Acg+xBDDIL7gLGZpIm9yIcuRqxfzvMuNm9dE0FTdorMGXhbt
   KVJXb6cry2sqbr199poMihg36o8Bh6pOMaoiWdHBxVakQP0ftVLCy+L4X
   d7Ns8NeBs4MOZAmZ1gd++L1jakg4fM3gC+fZyCbw0b2N19Nk35+5As5iQ
   qWVQSK4/68djUSyJ90/W4WoH5wm8w53qa3wGJ2T8PtIRbobOVRO4EvitL
   L5UgFr3RmpPw+VPEgTZyihz8tOOABpzqYKoypWnOl77Yq5Vw9xsHL2ToB
   UlcVAFjUnIL7GqXvg3ofXewCopTDwlgo8UdDxo504cff4QsIl1cjPwnt5
   A==;
IronPort-SDR: 2pS1PpoNnz3av/NR3jbJxqhFqUCjr6hWrPnlIq4zaYisZBpqSbiuU+2S7FPG2H86CouiRoS8BB
 7jcl334wXvUwKKtcTgGb8tpKGuo0zVxdGe6Z5UArnv7QrQJEc/dM/lwkF01gOSJEfsTcXpg2lL
 qgrCr4f2SSlKw8uHKQGesEL6I3//ZKcLCrE7dFRsNS7dVqlpNxIIUWpZ7d93t4rgpBx8cGsHKr
 +5m7kiW6EPcQXQu6BfCVjMRzGCC8XdN4iGiYOAQvIoRr32kalPQkj9fkmSTDZSutcbKxG6tp3m
 MKo=
X-IronPort-AV: E=Sophos;i="5.75,439,1589212800"; 
   d="scan'208";a="148563506"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2020 08:08:06 +0800
IronPort-SDR: myOKtsHncB8/84yI+KTT5p2DGi/qwJjltf270bZi6UTtM3Mj9QZiprd5ZnTpK9XmQDFseE8LEm
 HMTiDvjZ7anw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 16:55:24 -0700
IronPort-SDR: nUYJmY3g69kIaMDdvEBIrAraXtLHo/3wK4/RX23X6L9uOe9tXb1pwO46qPwR74QFvRi76OnSug
 6ih9gd2Bb9zg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Aug 2020 17:08:06 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     hch@lst.de, sagi@grimberg.me,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] nvmet: fix opps in nvmet_execute_passthru_cmd()
Date:   Wed,  5 Aug 2020 17:08:04 -0700
Message-Id: <20200806000804.6345-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a check in nvmet_execute_passthru_cmd() to prevent the
following oops :-

[ 1457.346861] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 1457.347838] #PF: supervisor read access in kernel mode
[ 1457.348464] #PF: error_code(0x0000) - not-present page
[ 1457.349085] PGD 0 P4D 0
[ 1457.349402] Oops: 0000 [#1] SMP NOPTI
[ 1457.349851] CPU: 18 PID: 10782 Comm: kworker/18:2 Tainted: G           OE     5.8.0-rc4nvme-5.9+ #35
[ 1457.350951] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e3214
[ 1457.352347] Workqueue: events nvme_loop_execute_work [nvme_loop]
[ 1457.353062] RIP: 0010:blk_mq_free_request+0xe/0x110
[ 1457.353651] Code: 3f ff ff ff 83 f8 01 75 0d 4c 89 e7 e8 1b db ff ff e9 2d ff ff ff 0f 0b eb ef 66 8
[ 1457.355975] RSP: 0018:ffffc900035b7de0 EFLAGS: 00010282
[ 1457.356636] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
[ 1457.357526] RDX: ffffffffa060bd05 RSI: 0000000000000000 RDI: 0000000000000000
[ 1457.358416] RBP: 0000000000000037 R08: 0000000000000000 R09: 0000000000000000
[ 1457.359317] R10: 0000000000000000 R11: 000000000000006d R12: 0000000000000000
[ 1457.360424] R13: ffff8887ffa68600 R14: 0000000000000000 R15: ffff8888150564c8
[ 1457.361322] FS:  0000000000000000(0000) GS:ffff888814600000(0000) knlGS:0000000000000000
[ 1457.362337] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1457.363058] CR2: 0000000000000000 CR3: 000000081c0ac000 CR4: 00000000003406e0
[ 1457.363973] Call Trace:
[ 1457.364296]  nvmet_passthru_execute_cmd+0x150/0x2c0 [nvmet]
[ 1457.364990]  process_one_work+0x24e/0x5a0
[ 1457.365493]  ? __schedule+0x353/0x840
[ 1457.365957]  worker_thread+0x3c/0x380
[ 1457.366426]  ? process_one_work+0x5a0/0x5a0
[ 1457.366948]  kthread+0x135/0x150
[ 1457.367362]  ? kthread_create_on_node+0x60/0x60
[ 1457.367934]  ret_from_fork+0x22/0x30
[ 1457.368388] Modules linked in: nvme_loop(OE) nvmet(OE) nvme_fabrics(OE) null_blk nvme(OE) nvme_corer
[ 1457.368414]  ata_piix crc32c_intel virtio_pci libata virtio_ring serio_raw t10_pi virtio floppy dm_]
[ 1457.380849] CR2: 0000000000000000
[ 1457.381288] ---[ end trace c6cab61bfd1f68fd ]---
[ 1457.381861] RIP: 0010:blk_mq_free_request+0xe/0x110
[ 1457.382469] Code: 3f ff ff ff 83 f8 01 75 0d 4c 89 e7 e8 1b db ff ff e9 2d ff ff ff 0f 0b eb ef 66 8
[ 1457.384749] RSP: 0018:ffffc900035b7de0 EFLAGS: 00010282
[ 1457.385393] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
[ 1457.386264] RDX: ffffffffa060bd05 RSI: 0000000000000000 RDI: 0000000000000000
[ 1457.387142] RBP: 0000000000000037 R08: 0000000000000000 R09: 0000000000000000
[ 1457.388029] R10: 0000000000000000 R11: 000000000000006d R12: 0000000000000000
[ 1457.388914] R13: ffff8887ffa68600 R14: 0000000000000000 R15: ffff8888150564c8
[ 1457.389798] FS:  0000000000000000(0000) GS:ffff888814600000(0000) knlGS:0000000000000000
[ 1457.390796] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1457.391508] CR2: 0000000000000000 CR3: 000000081c0ac000 CR4: 00000000003406e0
[ 1457.392525] Kernel panic - not syncing: Fatal exception
[ 1457.394138] Kernel Offset: disabled
[ 1457.394677] ---[ end Kernel panic - not syncing: Fatal exception ]---

Fixes: 06b7164dfdc0 ("nvmet: add passthru code to process commands")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 89d91dc999a6..b56292c9a76c 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -278,7 +278,8 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	if (ns)
 		nvme_put_ns(ns);
 	nvmet_req_complete(req, status);
-	blk_put_request(rq);
+	if (rq)
+		blk_put_request(rq);
 }
 
 /*
-- 
2.22.1

