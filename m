Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468A2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18DDC2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459051;
	bh=kQvr20PH6P7HMgnnOg/6cEQl1b6N7Ru9B3CPfUxmv1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T4xM583d9r1SAHO4ad2MyYuwTQUGKJRflgleVRk6oXdi/woufUvIgI95I25ZGxv3M
	 4Krn15yYuJMfoXOzm39bf+6kB1mVTRwRIrASgrRAC+e2S8P17lZ3ZARVHHCEu7TUdc
	 rx/+V3nHhk/pbo1k3SqQPM4f6jN8TaY+6Q2Vt/40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgF2Tat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732865AbgF2TaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B5E92526C;
        Mon, 29 Jun 2020 15:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444980;
        bh=kQvr20PH6P7HMgnnOg/6cEQl1b6N7Ru9B3CPfUxmv1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAqwueatsyJYvAONsz7fZp3n++lwZz8kZbPR7x9Lt3OaInz1S5L+71yq4sUqXiPVb
         0TvuYe0p8SeH/jtVzqV/cIQB0d9PQ4U9S8j5gi55jLplUeLKqMQyyoKf/uQui+k6bx
         rRgEKEleTG7GBapsqV6Pynw8warfUf5mngQIp5/E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yu kuai <yukuai3@huawei.com>, Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 079/131] ARM: imx5: add missing put_device() call in imx_suspend_alloc_ocram()
Date:   Mon, 29 Jun 2020 11:34:10 -0400
Message-Id: <20200629153502.2494656-80-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yu kuai <yukuai3@huawei.com>

[ Upstream commit 586745f1598ccf71b0a5a6df2222dee0a865954e ]

if of_find_device_by_node() succeed, imx_suspend_alloc_ocram() doesn't
have a corresponding put_device(). Thus add a jump target to fix the
exception handling for this function implementation.

Fixes: 1579c7b9fe01 ("ARM: imx53: Set DDR pins to high impedance when in suspend to RAM.")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-imx/pm-imx5.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index 868781fd460c7..14c630c899c5d 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -301,14 +301,14 @@ static int __init imx_suspend_alloc_ocram(
 	if (!ocram_pool) {
 		pr_warn("%s: ocram pool unavailable!\n", __func__);
 		ret = -ENODEV;
-		goto put_node;
+		goto put_device;
 	}
 
 	ocram_base = gen_pool_alloc(ocram_pool, size);
 	if (!ocram_base) {
 		pr_warn("%s: unable to alloc ocram!\n", __func__);
 		ret = -ENOMEM;
-		goto put_node;
+		goto put_device;
 	}
 
 	phys = gen_pool_virt_to_phys(ocram_pool, ocram_base);
@@ -318,6 +318,8 @@ static int __init imx_suspend_alloc_ocram(
 	if (virt_out)
 		*virt_out = virt;
 
+put_device:
+	put_device(&pdev->dev);
 put_node:
 	of_node_put(node);
 
-- 
2.25.1

