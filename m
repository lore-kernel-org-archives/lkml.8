Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ECCC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 02:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E357D2084E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 02:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwg0PwY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgCECjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 21:39:20 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40099 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgCECjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 21:39:20 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so1947745plp.7;
        Wed, 04 Mar 2020 18:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YW1iAxgihWa7R1z2LZ0jq4L5SHYbV/y2Cl+4YB22Nq0=;
        b=rwg0PwY/pBMBBCdKXuCPnAOK+gKG8fWRjtLb8qoZDbY2XJir4nAN2j81+pu+Zm2ChD
         hCn10l37f12AqtrZmjlcBD/nXxilTi1O5VC6L/m9NC3V/T+XjjprVRilKGBmuIXjF1Ha
         Q+f7PNBgvDLKzBGbFa9qfE2bK1jHst3TZcW69C7NNScimVRub52WWTe497P8RrB74WRd
         bGLkqLKdi19e02DtQArGXu1Z8c2QS/J4wF3IRXj0U5poiJ/Oremq2M7A07gOQhv5yO6i
         ysJSDXEThmhWBDGfdo1hLCVBFb5PwWZ9dozA5wIqkKl6M0Cumh/IyVeNoEDEZDDr5Eqm
         vz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YW1iAxgihWa7R1z2LZ0jq4L5SHYbV/y2Cl+4YB22Nq0=;
        b=iyNfhhLxB7t5BW0kSTSa3fwdXowYH+A2vFp24JtEqdWfIFYQbSb/38/rYPhbtZ01xS
         TeaY3qG4d0+C4w2W9TpeSBHk1JYiJMKx/68oWFLjJJhTVTtAF+g1ksSqgFKSA635iyfe
         UaXOE4uuzApWUmppDoQ8QCzh/VOxfwYtfVb238nBn/DQc/vryIHZ4AA8+gW02S+xy2/R
         Lyn/OQv6XZR33O+uNUOUIPLEBDeeyQmYeuNZHA5D5TOlc7lf6t/w1D9PA+FINFFmKXOt
         vxhABup7OXiD9F0LZUIBN4Rly/q1V/Ui/heqyaTjHCn4Ltxbu1bChssWMmmHsuaa4f3J
         qW9Q==
X-Gm-Message-State: ANhLgQ2HmPiJxsZBPWKoCO8ZVtMKEztMv16cKGFcY2eGn2up8H22tc+h
        5RoB1rLEGDE4hJInOUvkvjTFlWhChcs=
X-Google-Smtp-Source: ADFU+vvNfv1O4y+T8xjWDrOY/eMq3S4rz6h3FPkm/6Mv8mQrQ0af/lXw9Wl/PKse4xev/7IwPhvWKg==
X-Received: by 2002:a17:90a:e012:: with SMTP id u18mr6415803pjy.190.1583375959117;
        Wed, 04 Mar 2020 18:39:19 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::5:7dc6])
        by smtp.gmail.com with ESMTPSA id i197sm26750447pfe.137.2020.03.04.18.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 18:39:18 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH] usb: gadget: aspeed: improve vhub port irq handling
Date:   Wed,  4 Mar 2020 18:38:59 -0800
Message-Id: <20200305023859.21057-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This patch evaluates vhub ports' irq mask before going through per-port
irq handling one by one, which helps to speed up irq handling in case
there is no port interrupt.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/core.c | 11 ++++++-----
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  8 ++++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index f8d35dd60c34..a03e4e4ea401 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -134,11 +134,11 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
 	}
 
 	/* Handle device interrupts */
-	for (i = 0; i < vhub->max_ports; i++) {
-		u32 dev_mask = VHUB_IRQ_DEVICE1 << i;
-
-		if (istat & dev_mask)
-			ast_vhub_dev_irq(&vhub->ports[i].dev);
+	if (istat & vhub->port_irq_mask) {
+		for (i = 0; i < vhub->max_ports; i++) {
+			if (istat & VHUB_DEV_IRQ(i))
+				ast_vhub_dev_irq(&vhub->ports[i].dev);
+		}
 	}
 
 	/* Handle top-level vHub EP0 interrupts */
@@ -332,6 +332,7 @@ static int ast_vhub_probe(struct platform_device *pdev)
 
 	spin_lock_init(&vhub->lock);
 	vhub->pdev = pdev;
+	vhub->port_irq_mask = GENMASK(vhub->max_ports + 8, 9);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	vhub->regs = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
index fac79ef6d669..e49924ec7e58 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
+++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
@@ -54,10 +54,6 @@
 #define VHUB_IRQ_USB_CMD_DEADLOCK		(1 << 18)
 #define VHUB_IRQ_EP_POOL_NAK			(1 << 17)
 #define VHUB_IRQ_EP_POOL_ACK_STALL		(1 << 16)
-#define VHUB_IRQ_DEVICE5			(1 << 13)
-#define VHUB_IRQ_DEVICE4			(1 << 12)
-#define VHUB_IRQ_DEVICE3			(1 << 11)
-#define VHUB_IRQ_DEVICE2			(1 << 10)
 #define VHUB_IRQ_DEVICE1			(1 << 9)
 #define VHUB_IRQ_BUS_RESUME			(1 << 8)
 #define VHUB_IRQ_BUS_SUSPEND 			(1 << 7)
@@ -70,6 +66,9 @@
 #define VHUB_IRQ_HUB_EP0_SETUP			(1 << 0)
 #define VHUB_IRQ_ACK_ALL			0x1ff
 
+/* Downstream device IRQ mask. */
+#define VHUB_DEV_IRQ(n)				(VHUB_IRQ_DEVICE1 << (n))
+
 /* SW reset reg */
 #define VHUB_SW_RESET_EP_POOL			(1 << 9)
 #define VHUB_SW_RESET_DMA_CONTROLLER		(1 << 8)
@@ -402,6 +401,7 @@ struct ast_vhub {
 	/* Per-port info */
 	struct ast_vhub_port		*ports;
 	u32				max_ports;
+	u32				port_irq_mask;
 
 	/* Generic EP data structures */
 	struct ast_vhub_ep		*epns;
-- 
2.17.1

