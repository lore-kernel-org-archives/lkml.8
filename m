Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B7CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55358206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462305;
	bh=g4LR6Vh9bVVWevxF9IDlTa7+J/ZEmCI5rGAagLTX8Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IO5yBPFyicyAvEx7MQAaZpVGGq4c/Z/wM0eyTv18xp0UBoBez4AkWnEmDcrDMwAWx
	 m0EG/Kl59Kj3jZK1LiS/4BfmSYvfNU0qnazTm2MbubvseTd+6rJ8Koel2tFfTc4vAm
	 GOQmSoVPZGT+v9ZBFk5l6PSrCEhisvu3Mi3ETtPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389004AbgF2UZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732543AbgF2TZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F7F125414;
        Mon, 29 Jun 2020 15:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445368;
        bh=g4LR6Vh9bVVWevxF9IDlTa7+J/ZEmCI5rGAagLTX8Fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dlZm9LTHPmY8NS16zdlozKa3f/6aKe0ifhlRMSsUQfpfGs3tFv+ROCtutUb23Ut1f
         49NTbGH/rcJhxv74E+zIL8IIGEiN+x44lRlkFBJc6hy/jmgE48Zn2BOkbJV/MzT4N3
         0A/GX63en7sLhjud/pHSXPGwt/nPxeE+kN+UU+2U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 123/191] mtd: rawnand: orion: Fix the probe error path
Date:   Mon, 29 Jun 2020 11:38:59 -0400
Message-Id: <20200629154007.2495120-124-sashal@kernel.org>
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

[ Upstream commit be238fbf78e4c7c586dac235ab967d3e565a4d1a ]

nand_release() is supposed be called after MTD device registration.
Here, only nand_scan() happened, so use nand_cleanup() instead.

There is no real Fixes tag applying here as the use of nand_release()
in this driver predates by far the introduction of nand_cleanup() in
commit d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
which makes this change possible. However, pointing this commit as the
culprit for backporting purposes makes sense even if this commit is not
introducing any bug.

Fixes: d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-34-miquel.raynal@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/orion_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index cfd53f0ba6c31..0acfc0a7d8e08 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -167,7 +167,7 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 	mtd->name = "orion_nand";
 	ret = mtd_device_register(mtd, board->parts, board->nr_parts);
 	if (ret) {
-		nand_release(nc);
+		nand_cleanup(nc);
 		goto no_dev;
 	}
 
-- 
2.25.1

