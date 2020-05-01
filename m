Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD23C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0662051A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340951;
	bh=YMHgFr6fxhlVJn3HMme0Cl0WS0IrJyx0JqUcOr2TVQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r8MkgB2gdltq3XGRWsjaIwXhQ4Hke06Eo9aeC5F3tNWnVp2/p75Omv4nfZAocCU8I
	 HAOtXvqJBLWbWKG6WDk+PKR/qjRrkHtPwYhhdxhEWMX2fRTtdKVX3h5r3Bw3UOai0E
	 R7hyxFVQPHM1pMaLKQZl7BuYJVz1oWwmCcEQJwyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbgEANtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731415AbgEANlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:41:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 809F320757;
        Fri,  1 May 2020 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340502;
        bh=YMHgFr6fxhlVJn3HMme0Cl0WS0IrJyx0JqUcOr2TVQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgC9mYvILGIpF7KOawmltmWtx4l5Cq3c6g2VZkphEnjgv/TwFrE8N3xNpuO0oTXrf
         Yj/BKOVM1JKFXnED9x7p2NbHkqGTl/tlfRv9pI5NyAqCNu+k80Kvaxpbt5GlBU7rTx
         BeLHe1wfzEUDMu4Gdl0dfzNpS7qxW1AH0kyRDQAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 5.6 008/106] usb: gadget: udc: atmel: Fix vbus disconnect handling
Date:   Fri,  1 May 2020 15:22:41 +0200
Message-Id: <20200501131544.536767439@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

commit 12b94da411f9c6d950beb067d913024fd5617a61 upstream.

A DMA transfer can be in progress while vbus is lost due to a cable
disconnect. For endpoints that use DMA, this condition can lead to
peripheral hang. The patch ensures that endpoints are disabled before
the clocks are stopped to prevent this issue.

Fixes: a64ef71ddc13 ("usb: gadget: atmel_usba_udc: condition clocks to vbus state")
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/atmel_usba_udc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1951,10 +1951,10 @@ static irqreturn_t usba_vbus_irq_thread(
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


