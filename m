Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1FAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4229A2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593458983;
	bh=wKVojw3v10HVgEldxDQ8d8OdOl9ZfBVivKKmRcFWmq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U9Xuhs+fhKALvSqEkn4CkiHUDTpgEcfjKfM3vvvq96WyeBitSU7lA+yOwknhCgLtN
	 Vfh8xf1QG/v1s5RzAfVh21bTpRMRy9d0vTZqCiDCHD7OSaTCLfPms4Qu0DhuPAufEU
	 M0rpmERfoowixK1s5T6758r81yooq7apT3Oks6u4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbgF2T3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732657AbgF2TZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4533525416;
        Mon, 29 Jun 2020 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445367;
        bh=wKVojw3v10HVgEldxDQ8d8OdOl9ZfBVivKKmRcFWmq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LKcGVSdKs2Fbqt+k2nFzqrU46+6k3ZEXv9GQfqbsOZT41QoRXJYjCrUQ4RwEPPx/Z
         TskONi364b8mb/q8NCjuGzSgTw4SfW3PvCXlcWmDt6jjDwlPlvB6irCN/0Vkr16lfI
         dNF1TNbNVg1oTS1zbAiJhKe/mltlJOvb7+qI66kk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 122/191] mtd: rawnand: xway: Fix the probe error path
Date:   Mon, 29 Jun 2020 11:38:58 -0400
Message-Id: <20200629154007.2495120-123-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
References: <20200629154007.2495120-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 34531be5e804a8e1abf314a6c3a19fe342e4a154 ]

nand_release() is supposed be called after MTD device registration.
Here, only nand_scan() happened, so use nand_cleanup() instead.

There is no real Fixes tag applying here as the use of nand_release()
in this driver predates the introduction of nand_cleanup() in
commit d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
which makes this change possible. However, pointing this commit as the
culprit for backporting purposes makes sense even if this commit is not
introducing any bug.

Fixes: d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-61-miquel.raynal@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/xway_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/xway_nand.c b/drivers/mtd/nand/xway_nand.c
index d374a0007960a..3d51b8fc5aafe 100644
--- a/drivers/mtd/nand/xway_nand.c
+++ b/drivers/mtd/nand/xway_nand.c
@@ -211,7 +211,7 @@ static int xway_nand_probe(struct platform_device *pdev)
 
 	err = mtd_device_register(mtd, NULL, 0);
 	if (err)
-		nand_release(&data->chip);
+		nand_cleanup(&data->chip);
 
 	return err;
 }
-- 
2.25.1

