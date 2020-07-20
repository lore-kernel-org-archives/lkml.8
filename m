Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73859C433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E80022482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260056;
	bh=AGBnPG3j5pXqrZ+XuXX8bDaVopY3JrUjvToX1odT9w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1GcFmqsy6PFjZuwscR7wdbRl5ISBpQi8CdJ1zLdlN6C2vCxxkaSug1mnX961uWOdJ
	 OK2GNUiYYda2icepq727La8ZDAe4pcdou+CkJHgqUVBdL3lhtpWA/+51FqhXSflKCx
	 LtunihN/5Q4JwaHCtLPYpQdaZfujrnKH9ifYJ7/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbgGTPrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730758AbgGTPrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:47:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E400722CB3;
        Mon, 20 Jul 2020 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260041;
        bh=AGBnPG3j5pXqrZ+XuXX8bDaVopY3JrUjvToX1odT9w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eJL+ua9k3ngJa55njMqKEF9aVhxCauZ5hPH38ZP2kntvXcrmjGEc4czq26T8EBY2b
         JQNVlDQ5A9WX7pWlmwvTjyDcu6HafmcZracL4XP2r6sc432/4hw33Ya9V80xVAwGY1
         +DDpc4TXNvY2NyxElMNGOZI0mmvopMruGrdCOvgQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 084/125] usb: gadget: udc: atmel: fix uninitialized read in debug printk
Date:   Mon, 20 Jul 2020 17:37:03 +0200
Message-Id: <20200720152807.071152976@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

[ Upstream commit 30517ffeb3bff842e1355cbc32f1959d9dbb5414 ]

Fixed commit moved the assignment of 'req', but did not update a
reference in the DBG() call. Use the argument as it was renamed.

Fixes: 5fb694f96e7c ("usb: gadget: udc: atmel: fix possible oops when unloading module")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 39676824a2c6f..8540e52c28a97 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -912,7 +912,7 @@ static int usba_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	u32 status;
 
 	DBG(DBG_GADGET | DBG_QUEUE, "ep_dequeue: %s, req %p\n",
-			ep->ep.name, req);
+			ep->ep.name, _req);
 
 	spin_lock_irqsave(&udc->lock, flags);
 
-- 
2.25.1



