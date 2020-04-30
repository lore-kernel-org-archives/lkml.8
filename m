Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F90C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BB0206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255635;
	bh=IpPVEfvJLI6p3CS+kHD0JvcDAyrdouIX9eEe+XK+FGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qYJE5n3+qNPb8Rh+J8C7f6ylUHw6Oxeu5J5Q71mZ7ooT7ltF4a0Clx53hkYsOcLhk
	 J/rEVnVtcdBqGrfgWy6nLA9OZ/eFutZ+aARifbY0WFfNdi7nlDeNE6dg7Ox51phFf+
	 URP60DpdZYYG7QzxAOMJ2+7Tdbw6b8oNgYQHvX0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgD3OHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgD3Nwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:52:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2637A208D5;
        Thu, 30 Apr 2020 13:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254762;
        bh=IpPVEfvJLI6p3CS+kHD0JvcDAyrdouIX9eEe+XK+FGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ie1DZ49qjCAyYvnuAamTMawdVIo62RDX3PniJPtlugsr1OOOvwzpu4hSHDXEfIK+C
         t2p8kKxtcW1cA28p6Dk0s3NDuonnOdhlZ814YOukhCA38cKkJ8KMJ99KdRSLyzzW6E
         w7C4mBpScp/oN4DjLfIyS8Tv5rjIO2dKNdQBxhKQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 21/57] usb: gadget: udc: atmel: Fix vbus disconnect handling
Date:   Thu, 30 Apr 2020 09:51:42 -0400
Message-Id: <20200430135218.20372-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135218.20372-1-sashal@kernel.org>
References: <20200430135218.20372-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

[ Upstream commit 12b94da411f9c6d950beb067d913024fd5617a61 ]

A DMA transfer can be in progress while vbus is lost due to a cable
disconnect. For endpoints that use DMA, this condition can lead to
peripheral hang. The patch ensures that endpoints are disabled before
the clocks are stopped to prevent this issue.

Fixes: a64ef71ddc13 ("usb: gadget: atmel_usba_udc: condition clocks to vbus state")
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 1d0d8952a74bf..58e5b015d40e6 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1950,10 +1950,10 @@ static irqreturn_t usba_vbus_irq_thread(int irq, void *devid)
 			usba_start(udc);
 		} else {
 			udc->suspended = false;
-			usba_stop(udc);
-
 			if (udc->driver->disconnect)
 				udc->driver->disconnect(&udc->gadget);
+
+			usba_stop(udc);
 		}
 		udc->vbus_prev = vbus;
 	}
-- 
2.20.1

