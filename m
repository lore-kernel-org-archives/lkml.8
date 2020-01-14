Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A30C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7119B24679
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996819;
	bh=29EAfTlO4t8QQNt+hW7N9V5LimNoR/Gf/b7qOb4ufOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eAzznM/zDD9fCilo5wkPCj4N1F1rITUziGCpOAP4TqS1Z+ErqJzTDOV3sneoPhbZh
	 hVL6IOYJK7Z1liy1hjgfYFZ6dAWcqzl6fj5P6/FKa3Hc/nEOfmFqTCIlLvkMBr959I
	 vdnp3d1+d9LCFSZpfWGCOOJ7g0PzqH9XKg45rgNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733229AbgANKNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:13:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733209AbgANKNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:13:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FA7524676;
        Tue, 14 Jan 2020 10:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996815;
        bh=29EAfTlO4t8QQNt+hW7N9V5LimNoR/Gf/b7qOb4ufOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0lYxZB3HoxLW1UoNVrrR/Lma+4k3yl4zTppjTCQtwk8succdtrfx6HHahiVcZ6XDH
         Xz1EccHYMX+IGBxCu00wYF7vOvXknGKMx+0qzqo8Q0pGlFiblDhkmm9Q6fEVgQjpBu
         WdEp5uZ/8ZKBJtJRsX2nd9dS7wVmPa+pDLFpKnmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>, Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.4 18/28] usb: musb: dma: Correct parameter passed to IRQ handler
Date:   Tue, 14 Jan 2020 11:02:20 +0100
Message-Id: <20200114094343.196492267@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094336.845958665@linuxfoundation.org>
References: <20200114094336.845958665@linuxfoundation.org>
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
@@ -398,7 +398,7 @@ struct dma_controller *musbhs_dma_contro
 	controller->controller.channel_abort = dma_channel_abort;
 
 	if (request_irq(irq, dma_controller_irq, 0,
-			dev_name(musb->controller), &controller->controller)) {
+			dev_name(musb->controller), controller)) {
 		dev_err(dev, "request_irq %d failed!\n", irq);
 		musb_dma_controller_destroy(&controller->controller);
 


