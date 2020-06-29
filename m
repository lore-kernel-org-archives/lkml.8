Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66091C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBBD22269
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593455734;
	bh=VdLNrCbuwMYCY9QDHYOlAwoBGMDQ4WJP7+Rn3wVFuD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0FHRlvSSmRCx89aYv7I5mIxnNutACGmC0sByPz7/NFCZgiZLG9FGm+1BzRP0+3QSu
	 01C2ZUFXdDZl0A/Zvr+tTgdPBHkX8iZLSR4jhICkn+QHmGItSH57mlpANf368nhR6x
	 U4hgz68nR4mH7Z1l1GGiDKMahBJaCmXzg4ZNt3l0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgF2Sfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:35:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgF2SfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 936FE2478B;
        Mon, 29 Jun 2020 15:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444096;
        bh=VdLNrCbuwMYCY9QDHYOlAwoBGMDQ4WJP7+Rn3wVFuD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vSWB0TwhwjFkK5NmiLpXHSxT4yExyjAhniJ+MF+kmXjyq1h/x488Ljg22ek08dH5w
         cwVhQg/WbQaCCJpRnDHCme1CY4A0Cq5Ts14ZuUIhSzy5sOsam8b8JmzF/Ymp1bqgMA
         PU28FRR1kjfZFZiRSk5RDDeLBr6HbtbV+Wq7EKhc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 206/265] block: update hctx map when use multiple maps
Date:   Mon, 29 Jun 2020 11:17:19 -0400
Message-Id: <20200629151818.2493727-207-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weiping Zhang <zhangweiping@didiglobal.com>

[ Upstream commit fe35ec58f0d339221643287bbb7cee15c93a5389 ]

There is an issue when tune the number for read and write queues,
if the total queue count was not changed. The hctx->type cannot
be updated, since __blk_mq_update_nr_hw_queues will return directly
if the total queue count has not been changed.

Reproduce:

dmesg | grep "default/read/poll"
[    2.607459] nvme nvme0: 48/0/0 default/read/poll queues
cat /sys/kernel/debug/block/nvme0n1/hctx*/type | sort | uniq -c
     48 default

tune the write queues to 24:
echo 24 > /sys/module/nvme/parameters/write_queues
echo 1 > /sys/block/nvme0n1/device/reset_controller

dmesg | grep "default/read/poll"
[  433.547235] nvme nvme0: 24/24/0 default/read/poll queues

cat /sys/kernel/debug/block/nvme0n1/hctx*/type | sort | uniq -c
     48 default

The driver's hardware queue mapping is not same as block layer.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 98a702761e2cc..8f580e66691b9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3328,7 +3328,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	if (set->nr_maps == 1 && nr_hw_queues > nr_cpu_ids)
 		nr_hw_queues = nr_cpu_ids;
-	if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
+	if (nr_hw_queues < 1)
+		return;
+	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
 		return;
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-- 
2.25.1

