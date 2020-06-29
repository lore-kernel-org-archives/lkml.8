Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB2CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74F9206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462752;
	bh=1BjEz1tNYoNIeAeDoXRNi9H/EWV7Ubqa6oY+NfFIwu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BuIdTteVdOvGN7I31bQMH9ETVJD9CDrrq6dTJD20YHw3+s1J0uGbTgU/oPKeO2nbW
	 vrrfdJLT0PJ9VMUIzChmapNHgSY2miZE2wQLwgL1LFuR1cr3XCQGqh4wc2QfBunQKf
	 tKM4F5zv8UZf1nRI+NzuoZWztXov3BBVMA622G34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388843AbgF2Uca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732445AbgF2TZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D87F25415;
        Mon, 29 Jun 2020 15:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445366;
        bh=1BjEz1tNYoNIeAeDoXRNi9H/EWV7Ubqa6oY+NfFIwu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtsNII7/jzuADAaqSnxxtFqwDkbSAIhzVPfK0+QISE91JNAlYFIZ5Vj7tieyqH7OU
         XuY735oCBS1amdEk16KTzuYPeWNYZ2zyyrTJWlHetjHPZmYare+3kuchFUA+A6XBU1
         g37Te8eSFkDbjMlixaAzDreNaci1pw9VnhsCL/bM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 121/191] mtd: rawnand: sharpsl: Fix the probe error path
Date:   Mon, 29 Jun 2020 11:38:57 -0400
Message-Id: <20200629154007.2495120-122-sashal@kernel.org>
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

[ Upstream commit 0f44b3275b3798ccb97a2f51ac85871c30d6fbbc ]

nand_release() is supposed be called after MTD device registration.
Here, only nand_scan() happened, so use nand_cleanup() instead.

There is no Fixes tag applying here as the use of nand_release()
in this driver predates by far the introduction of nand_cleanup() in
commit d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
which makes this change possible. However, pointing this commit as the
culprit for backporting purposes makes sense.

Fixes: d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-49-miquel.raynal@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/sharpsl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sharpsl.c b/drivers/mtd/nand/sharpsl.c
index 70e28bfeb840f..661b4928e0fcf 100644
--- a/drivers/mtd/nand/sharpsl.c
+++ b/drivers/mtd/nand/sharpsl.c
@@ -192,7 +192,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	return 0;
 
 err_add:
-	nand_release(this);
+	nand_cleanup(this);
 
 err_scan:
 	iounmap(sharpsl->io);
-- 
2.25.1

