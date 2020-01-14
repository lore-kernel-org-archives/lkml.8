Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8406AC33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0EC24677
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996481;
	bh=YLLRxSU8TbjHH9MhIW8POwazjj39RFa0uNS6FY9gSTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wd5Y/IXJQUITBpOlmXYeWSQPP1qdYd0H8mzQIcm+pd4Y3Qu6zEkutoKsKMkOG0eaY
	 2uvdWckyGpP8FpIujxFKNYBJatxH9hddggDEbZwVrTqa+RIXOXRGa1k/rX4IXlMg0W
	 qV5rQbEgjyQwYnsJdGJXoh0nyalHPSxS8q2ReCxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgANKIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:08:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730158AbgANKH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:07:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D8C72467D;
        Tue, 14 Jan 2020 10:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996477;
        bh=YLLRxSU8TbjHH9MhIW8POwazjj39RFa0uNS6FY9gSTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRfUiPNN4mcp60ydDtTsuIGvOEwc4VkvyFs1gXm6/fvaZzz9JAU8G7++78MvHvjry
         zAZkGfNxz4BTIGZuOUXlXJ4qfo/AHj0QRdLZD50QGpnmfWm1MdRnJ0GAzCa0zzYsYb
         vVtAQgctFn1BHkhNgxaXTLBrKXSM9ov/8SNVl/Iw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>, Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.19 29/46] usb: musb: dma: Correct parameter passed to IRQ handler
Date:   Tue, 14 Jan 2020 11:01:46 +0100
Message-Id: <20200114094346.287485190@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
References: <20200114094339.608068818@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

commit c80d0f4426c7fdc7efd6ae8d8b021dcfc89b4254 upstream.

The IRQ handler was passed a pointer to a struct dma_controller, but the
argument was then casted to a pointer to a struct musb_dma_controller.

Fixes: 427c4f333474 ("usb: struct device - replace bus_id with dev_name(), dev_set_name()")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
Cc: stable@vger.kernel.org
Signed-off-by: Bin Liu <b-liu@ti.com>
Link: https://lore.kernel.org/r/20191216161844.772-2-b-liu@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musbhsdma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -425,7 +425,7 @@ struct dma_controller *musbhs_dma_contro
 	controller->controller.channel_abort = dma_channel_abort;
 
 	if (request_irq(irq, dma_controller_irq, 0,
-			dev_name(musb->controller), &controller->controller)) {
+			dev_name(musb->controller), controller)) {
 		dev_err(dev, "request_irq %d failed!\n", irq);
 		musb_dma_controller_destroy(&controller->controller);
 


