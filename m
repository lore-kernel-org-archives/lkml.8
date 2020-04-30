Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28268C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044A220873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588254699;
	bh=GSDdMgKvKAegsAAYwcuRTGDxeY5MwNfhBUBJ4xW6S8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nOIQ0NLQ8Q2+tb3BABh3b/uVpVuZkBHJlb5rCtDZFsAx5Wzgu32f3V35diTOuOhGd
	 /AGgx9kesiXvTzpN6USDiFQQ1RQdHLmQkTzRVA016w3si9HXM+xT87glJod8yu4YSu
	 MWQv88LCLm17c+15HBL+SB21Smcd8WT9haU8k0XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgD3Nvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbgD3NvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:51:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62BEC2137B;
        Thu, 30 Apr 2020 13:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254683;
        bh=GSDdMgKvKAegsAAYwcuRTGDxeY5MwNfhBUBJ4xW6S8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHHhSXW5JAqIjUOIA9pAj6G+0PRTC1pB1t140YdaMer85wTzpL2On56X3AtrChxW7
         0RizoaZMjZY4JVwUKYQw59T7d01WZ0gt2KRbxMwk053wUKkN6/l7QPwTKPYDa3NPds
         urnbScHKNETK3Al2EwGdGm9HdHR6m1dHbtg0usM0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 34/79] usb: gadget: udc: atmel: Fix vbus disconnect handling
Date:   Thu, 30 Apr 2020 09:49:58 -0400
Message-Id: <20200430135043.19851-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135043.19851-1-sashal@kernel.org>
References: <20200430135043.19851-1-sashal@kernel.org>
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
index 6e0432141c409..22200341c8ec3 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1951,10 +1951,10 @@ static irqreturn_t usba_vbus_irq_thread(int irq, void *devid)
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

