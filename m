Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8766DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6082E2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459047;
	bh=zVxml5wEXF6c7i/SNNh3TfWm82mK2HgfMq8Uwz/nyfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1M4RGTl8ngNz03osR6AGjGvDpYTdkbEZaGPiwyoolg/jKXquksgpiB2ysld6XBAI2
	 5NwaQvLp006L+5u8K9KlumXQcuof2NDd13dZjGQFAZAZH7QffP7UM8iyZOk9Ce3InT
	 7T+sppwwl9KoW7lMGldIUTPOlARuV6jHlVUa9/ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbgF2Tap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732759AbgF2TaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66AFA25224;
        Mon, 29 Jun 2020 15:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444944;
        bh=zVxml5wEXF6c7i/SNNh3TfWm82mK2HgfMq8Uwz/nyfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjqjaCrcRE4fi7kYY/ToRvI13CxDfLjxbkKfNs8DPRwOTHPa5BvUBtsasd1KcH4vF
         gjYw0uFTiXy+VXBSUe0UCvMgRrWmjLpxmKv2gWajw6t0vIZ+13nHQjEMEu7c7coZhq
         SaGlKP1c12E+gYCkHisIa7eye+5DWsvaN7+SDYyY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19 041/131] USB: ohci-sm501: Add missed iounmap() in remove
Date:   Mon, 29 Jun 2020 11:33:32 -0400
Message-Id: <20200629153502.2494656-42-sashal@kernel.org>
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

From: Chuhong Yuan <hslester96@gmail.com>

commit 07c112fb09c86c0231f6ff0061a000ffe91c8eb9 upstream.

This driver misses calling iounmap() in remove to undo the ioremap()
called in probe.
Add the missed call to fix it.

Fixes: f54aab6ebcec ("usb: ohci-sm501 driver")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20200610024844.3628408-1-hslester96@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/ohci-sm501.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ohci-sm501.c b/drivers/usb/host/ohci-sm501.c
index c9233cddf9a23..0a39dc58f3767 100644
--- a/drivers/usb/host/ohci-sm501.c
+++ b/drivers/usb/host/ohci-sm501.c
@@ -196,6 +196,7 @@ static int ohci_hcd_sm501_drv_remove(struct platform_device *pdev)
 	struct resource	*mem;
 
 	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
 	dma_release_declared_memory(&pdev->dev);
-- 
2.25.1

