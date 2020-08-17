Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F20C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E1B20658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597680501;
	bh=E5VFAU4pKlcc7oy2AktMdjxV68dwiIrYRVznhcynNiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=027noNiR1NuTABgiMIWWpVjwy/8kp+IDF3BvhoLMX3QCiBD+tgVRlWyvsDUhLPicr
	 Mtv1QOoFKk175fbsU+po1UGOgxkwwy8cvDOgLeNNLd7fUs7UWh5uaPAkUDInBM77b0
	 0sGqc1uz1gKVb5P/LQVCzeQWOcKxu794CoQLq5wI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbgHQQIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:08:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387526AbgHQPpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:45:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E1022075B;
        Mon, 17 Aug 2020 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679145;
        bh=E5VFAU4pKlcc7oy2AktMdjxV68dwiIrYRVznhcynNiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ieckfeBLsWOR0SX7ObFmVTaZ99igcrawYJcNMZ+pgk2VTyAsvt6JyvFY4ymn2FTUG
         GP0GxGAbyXKjBQNOmbNQ3R5m+gkrsKyZldu1OiPW2NKIg5nzTvJxJgE61iZ/upRBE9
         rpT/M3fAWZWD24Ko4mPnsqokcXv8SOhgaPfC374o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasi Kumar <sasi.kumar@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 111/393] bdc: Fix bug causing crash after multiple disconnects
Date:   Mon, 17 Aug 2020 17:12:41 +0200
Message-Id: <20200817143825.000067418@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sasi Kumar <sasi.kumar@broadcom.com>

[ Upstream commit a95bdfd22076497288868c028619bc5995f5cc7f ]

Multiple connects/disconnects can cause a crash on the second
disconnect. The driver had a problem where it would try to send
endpoint commands after it was disconnected which is not allowed
by the hardware. The fix is to only allow the endpoint commands
when the endpoint is connected. This will also fix issues that
showed up when using configfs to create gadgets.

Signed-off-by: Sasi Kumar <sasi.kumar@broadcom.com>
Signed-off-by: Al Cooper <alcooperx@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c |  4 ++++
 drivers/usb/gadget/udc/bdc/bdc_ep.c   | 16 ++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 02a3a774670b1..5fde5a8b065c1 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -282,6 +282,7 @@ static void bdc_mem_init(struct bdc *bdc, bool reinit)
 	 * in that case reinit is passed as 1
 	 */
 	if (reinit) {
+		int i;
 		/* Enable interrupts */
 		temp = bdc_readl(bdc->regs, BDC_BDCSC);
 		temp |= BDC_GIE;
@@ -291,6 +292,9 @@ static void bdc_mem_init(struct bdc *bdc, bool reinit)
 		/* Initialize SRR to 0 */
 		memset(bdc->srr.sr_bds, 0,
 					NUM_SR_ENTRIES * sizeof(struct bdc_bd));
+		/* clear ep flags to avoid post disconnect stops/deconfigs */
+		for (i = 1; i < bdc->num_eps; ++i)
+			bdc->bdc_ep_array[i]->flags = 0;
 	} else {
 		/* One time initiaization only */
 		/* Enable status report function pointers */
diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.c b/drivers/usb/gadget/udc/bdc/bdc_ep.c
index d49c6dc1082dc..9ddc0b4e92c9c 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.c
@@ -615,7 +615,6 @@ int bdc_ep_enable(struct bdc_ep *ep)
 	}
 	bdc_dbg_bd_list(bdc, ep);
 	/* only for ep0: config ep is called for ep0 from connect event */
-	ep->flags |= BDC_EP_ENABLED;
 	if (ep->ep_num == 1)
 		return ret;
 
@@ -759,10 +758,13 @@ static int ep_dequeue(struct bdc_ep *ep, struct bdc_req *req)
 					__func__, ep->name, start_bdi, end_bdi);
 	dev_dbg(bdc->dev, "ep_dequeue ep=%p ep->desc=%p\n",
 						ep, (void *)ep->usb_ep.desc);
-	/* Stop the ep to see where the HW is ? */
-	ret = bdc_stop_ep(bdc, ep->ep_num);
-	/* if there is an issue with stopping ep, then no need to go further */
-	if (ret)
+	/* if still connected, stop the ep to see where the HW is ? */
+	if (!(bdc_readl(bdc->regs, BDC_USPC) & BDC_PST_MASK)) {
+		ret = bdc_stop_ep(bdc, ep->ep_num);
+		/* if there is an issue, then no need to go further */
+		if (ret)
+			return 0;
+	} else
 		return 0;
 
 	/*
@@ -1911,7 +1913,9 @@ static int bdc_gadget_ep_disable(struct usb_ep *_ep)
 		__func__, ep->name, ep->flags);
 
 	if (!(ep->flags & BDC_EP_ENABLED)) {
-		dev_warn(bdc->dev, "%s is already disabled\n", ep->name);
+		if (bdc->gadget.speed != USB_SPEED_UNKNOWN)
+			dev_warn(bdc->dev, "%s is already disabled\n",
+				 ep->name);
 		return 0;
 	}
 	spin_lock_irqsave(&bdc->lock, flags);
-- 
2.25.1



