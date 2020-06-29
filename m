Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D20C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E967206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459675;
	bh=suxS3uWxS2tL0+jBGETGD3bqF3me5u0sGxXU3krztR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YIEDpZNQnTQV4ZYdMU4fXHJDjeLbt+gsGlOMLCm/a6fsThB7ejjsdo1nOlAu3RSgH
	 OTcMFiybou0Edd69R2cVr6Gv8GMs9C0SGKoAL4NGdhmAhgtP+SQd0swCeIftbCiBjx
	 iJYx2A950fZfJRtiv7e/rENQsUML4bIBcBs5rzwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgF2Tk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387773AbgF2Tkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7DC32485A;
        Mon, 29 Jun 2020 15:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444358;
        bh=suxS3uWxS2tL0+jBGETGD3bqF3me5u0sGxXU3krztR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b6fjR43taMS2rKdbcoo6AIsHxmpJ8P9M4+tziiCI8gjpXTy2qy9b3naxDucx1arGy
         xWbsszIbZc7iaZet01RA5jiAzgr4mNrpMhKjv2UjB/WkFvGgQSidJfCsLjxjS6fgWQ
         gl1gzuIOaM29/RWvLPF0SzstM4XcIMtlHCfrWONU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4 034/178] USB: ohci-sm501: Add missed iounmap() in remove
Date:   Mon, 29 Jun 2020 11:22:59 -0400
Message-Id: <20200629152523.2494198-35-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
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
index cff9652403270..b91d50da6127f 100644
--- a/drivers/usb/host/ohci-sm501.c
+++ b/drivers/usb/host/ohci-sm501.c
@@ -191,6 +191,7 @@ static int ohci_hcd_sm501_drv_remove(struct platform_device *pdev)
 	struct resource	*mem;
 
 	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-- 
2.25.1

