Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CC5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5049120663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593457010;
	bh=tzLUPNuFjhni840cOZi9CFA58r7CpGWMWGFnbgO4BHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FqsgBAZZAcdfJ5Y8dmODmP/cFw4oj4LEMLDgjEFE8sF9B2rKMumozT1beRu77GB7Y
	 xQFoj4UQiYX6qBmTB7pgN2TDIoG672Jh9W6uUn4EGEH3oZf+fCAaRRW+8eu8/3Y5pf
	 GAz8iLt+BAS76dNfatF4AAFL+EGVeqrV1tlBW31I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgF2S4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:56:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbgF2SzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:55:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4439125560;
        Mon, 29 Jun 2020 15:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446123;
        bh=tzLUPNuFjhni840cOZi9CFA58r7CpGWMWGFnbgO4BHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLprKUfTxO7jGtTMcHMFbMJiGNU4gKoLH+klYaCER4DQ38s/Qr0aOL7gMm2vtDvRq
         yMLpF/+GYshiG0uh7efkCGpJg7uMNRDMsfdE4kVKbnQa2S41/dEWSpppYw7sqsCA3U
         TRACEzS4iPV9e0xrwDw1XU5w+JWZTEIv7Ent+Zyk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 114/135] usb: gadget: udc: Potential Oops in error handling code
Date:   Mon, 29 Jun 2020 11:52:48 -0400
Message-Id: <20200629155309.2495516-115-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit e55f3c37cb8d31c7e301f46396b2ac6a19eb3a7c ]

If this is in "transceiver" mode the the ->qwork isn't required and is
a NULL pointer.  This can lead to a NULL dereference when we call
destroy_workqueue(udc->qwork).

Fixes: 3517c31a8ece ("usb: gadget: mv_udc: use devm_xxx for probe")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/mv_udc_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index 81b6229c78054..4f480059f851c 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -2322,7 +2322,8 @@ static int mv_udc_probe(struct platform_device *pdev)
 	return 0;
 
 err_create_workqueue:
-	destroy_workqueue(udc->qwork);
+	if (udc->qwork)
+		destroy_workqueue(udc->qwork);
 err_destroy_dma:
 	dma_pool_destroy(udc->dtd_pool);
 err_free_dma:
-- 
2.25.1

