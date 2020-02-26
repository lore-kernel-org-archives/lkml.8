Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C36C4BA32
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEC124650
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpQnoEga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgBZXE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:04:28 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38271 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgBZXEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:04:05 -0500
Received: by mail-pj1-f65.google.com with SMTP id j17so292006pjz.3;
        Wed, 26 Feb 2020 15:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jgDnuoRtCC8PdOztlWCD4r8rGPjlQUap91qhqvHPalA=;
        b=HpQnoEgaUdbUSBINIl3TNPBlobLWQwts7ahXdJs0YwhuUNImVCyaWTELVkAIYpEf55
         WJ8g9lEdKIcl9MVs3c4dsN/9xvIw8SbGNLWCozpQk0hDy2sDMC4UwtJWqPw0KB82wDhQ
         4gpP25M+hNAL2c6W/d7uca684Bt/De/5NharmsyTuAodMYM13nxbN/o1yxWfLZjcjChR
         XpxzBanNi34RL+azgeDtZ+yT4WOmRi1I2gndDQJOTCT2p6j3PYOpWguRDfCi667n2mab
         +OpDl79fVrzzK6DC0huGfycAojj3TyeCCVmlNRNNEB2D0jrBdI/AKFQClHmh0KQI42Wt
         ySzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jgDnuoRtCC8PdOztlWCD4r8rGPjlQUap91qhqvHPalA=;
        b=ezacd9J3BkK3xkKMA0gFaIoiSivRJTYY+n02dShVKtL02LqXGfU8Q5ij/VocskpVtt
         xndz2rCD0IZarmYwPO/iUt/lBLfQRnUfI77eirWwnua3hSgI8F8DcRCPQiGhSHtMtL68
         H8uJA6VATledjD/YJbnfrwXzjUNh2t1NFjMN1MGH+wnthCjpP6OXu5Yx4Kec4+358m6d
         lgfBNV3vd/at2kIHptw1KyQV7vWbDNrEGppuIcu7qzkonBwa5uNjVTo0oI8MWZJcFlqU
         F8clXBtIQaYKSWq1G56gZ9SkgSWfHkXi3GQzj8lKX2AbnJXfAtqFF0j9xgZravY3d40z
         mUlg==
X-Gm-Message-State: APjAAAUBAvT9oAVVZ6228HHGeyVYMwEh1FT7GgJr3Gp3ywhU7D2fBhFZ
        BBFla4s0A2KhTf72cbQ0m1Q=
X-Google-Smtp-Source: APXvYqyBw6OzN7ggYd+RCdkET7+qpQ2sm4ow2aj/+a1nVzJ0CqdjRbQ2FZ39AX+n/2g6IIrXVA2K4Q==
X-Received: by 2002:a17:90a:e2ce:: with SMTP id fr14mr1426433pjb.99.1582758243618;
        Wed, 26 Feb 2020 15:04:03 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::7:5ebf])
        by smtp.gmail.com with ESMTPSA id 3sm3912621pjg.27.2020.02.26.15.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:04:03 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 2/7] usb: gadget: aspeed: read vhub properties from device tree
Date:   Wed, 26 Feb 2020 15:03:41 -0800
Message-Id: <20200226230346.672-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226230346.672-1-rentao.bupt@gmail.com>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch introduces 2 DT properties ("aspeed,vhub-downstream-ports" and
"aspeed,vhub-generic-endpoints") which replaces hardcoded port/endpoint
number. It is to make it more convenient to add support for newer vhub
revisions with different number of ports and endpoints.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 Changes in v4:
   - use NUM_PORTS/NUM_GEN_EPs defined in vhub.h instead of introducing
     new constants (in v3).
 Changes in v3:
   - fall back to "default" number of ports and endpoints to avoid
     breaking existing ast2400/ast2500 platforms when according device
     tree properties are not defined.
 Changes in v2:
   - removed ast_vhub_config structure and moved vhub port/endpoint
     number into device tree.

 drivers/usb/gadget/udc/aspeed-vhub/core.c | 68 ++++++++++++++---------
 drivers/usb/gadget/udc/aspeed-vhub/dev.c  | 30 +++++++---
 drivers/usb/gadget/udc/aspeed-vhub/epn.c  |  4 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 15 ++---
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h | 28 +++++-----
 5 files changed, 88 insertions(+), 57 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index 90b134d5dca9..f8ab8e012f34 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -99,7 +99,7 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
 {
 	struct ast_vhub *vhub = data;
 	irqreturn_t iret = IRQ_NONE;
-	u32 istat;
+	u32 i, istat;
 
 	/* Stale interrupt while tearing down */
 	if (!vhub->ep0_bufs)
@@ -121,10 +121,10 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
 
 	/* Handle generic EPs first */
 	if (istat & VHUB_IRQ_EP_POOL_ACK_STALL) {
-		u32 i, ep_acks = readl(vhub->regs + AST_VHUB_EP_ACK_ISR);
+		u32 ep_acks = readl(vhub->regs + AST_VHUB_EP_ACK_ISR);
 		writel(ep_acks, vhub->regs + AST_VHUB_EP_ACK_ISR);
 
-		for (i = 0; ep_acks && i < AST_VHUB_NUM_GEN_EPs; i++) {
+		for (i = 0; ep_acks && i < vhub->max_epns; i++) {
 			u32 mask = VHUB_EP_IRQ(i);
 			if (ep_acks & mask) {
 				ast_vhub_epn_ack_irq(&vhub->epns[i]);
@@ -134,21 +134,11 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
 	}
 
 	/* Handle device interrupts */
-	if (istat & (VHUB_IRQ_DEVICE1 |
-		     VHUB_IRQ_DEVICE2 |
-		     VHUB_IRQ_DEVICE3 |
-		     VHUB_IRQ_DEVICE4 |
-		     VHUB_IRQ_DEVICE5)) {
-		if (istat & VHUB_IRQ_DEVICE1)
-			ast_vhub_dev_irq(&vhub->ports[0].dev);
-		if (istat & VHUB_IRQ_DEVICE2)
-			ast_vhub_dev_irq(&vhub->ports[1].dev);
-		if (istat & VHUB_IRQ_DEVICE3)
-			ast_vhub_dev_irq(&vhub->ports[2].dev);
-		if (istat & VHUB_IRQ_DEVICE4)
-			ast_vhub_dev_irq(&vhub->ports[3].dev);
-		if (istat & VHUB_IRQ_DEVICE5)
-			ast_vhub_dev_irq(&vhub->ports[4].dev);
+	for (i = 0; i < vhub->max_ports; i++) {
+		u32 dev_mask = VHUB_IRQ_DEVICE1 << i;
+
+		if (istat & dev_mask)
+			ast_vhub_dev_irq(&vhub->ports[i].dev);
 	}
 
 	/* Handle top-level vHub EP0 interrupts */
@@ -182,7 +172,7 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
 
 void ast_vhub_init_hw(struct ast_vhub *vhub)
 {
-	u32 ctrl;
+	u32 ctrl, port_mask, epn_mask;
 
 	UDCDBG(vhub,"(Re)Starting HW ...\n");
 
@@ -222,15 +212,20 @@ void ast_vhub_init_hw(struct ast_vhub *vhub)
 	}
 
 	/* Reset all devices */
-	writel(VHUB_SW_RESET_ALL, vhub->regs + AST_VHUB_SW_RESET);
+	port_mask = GENMASK(vhub->max_ports, 1);
+	writel(VHUB_SW_RESET_ROOT_HUB |
+	       VHUB_SW_RESET_DMA_CONTROLLER |
+	       VHUB_SW_RESET_EP_POOL |
+	       port_mask, vhub->regs + AST_VHUB_SW_RESET);
 	udelay(1);
 	writel(0, vhub->regs + AST_VHUB_SW_RESET);
 
 	/* Disable and cleanup EP ACK/NACK interrupts */
+	epn_mask = GENMASK(vhub->max_epns - 1, 0);
 	writel(0, vhub->regs + AST_VHUB_EP_ACK_IER);
 	writel(0, vhub->regs + AST_VHUB_EP_NACK_IER);
-	writel(VHUB_EP_IRQ_ALL, vhub->regs + AST_VHUB_EP_ACK_ISR);
-	writel(VHUB_EP_IRQ_ALL, vhub->regs + AST_VHUB_EP_NACK_ISR);
+	writel(epn_mask, vhub->regs + AST_VHUB_EP_ACK_ISR);
+	writel(epn_mask, vhub->regs + AST_VHUB_EP_NACK_ISR);
 
 	/* Default settings for EP0, enable HW hub EP1 */
 	writel(0, vhub->regs + AST_VHUB_EP0_CTRL);
@@ -273,7 +268,7 @@ static int ast_vhub_remove(struct platform_device *pdev)
 		return 0;
 
 	/* Remove devices */
-	for (i = 0; i < AST_VHUB_NUM_PORTS; i++)
+	for (i = 0; i < vhub->max_ports; i++)
 		ast_vhub_del_dev(&vhub->ports[i].dev);
 
 	spin_lock_irqsave(&vhub->lock, flags);
@@ -295,7 +290,7 @@ static int ast_vhub_remove(struct platform_device *pdev)
 	if (vhub->ep0_bufs)
 		dma_free_coherent(&pdev->dev,
 				  AST_VHUB_EP0_MAX_PACKET *
-				  (AST_VHUB_NUM_PORTS + 1),
+				  (vhub->max_ports + 1),
 				  vhub->ep0_bufs,
 				  vhub->ep0_bufs_dma);
 	vhub->ep0_bufs = NULL;
@@ -309,11 +304,32 @@ static int ast_vhub_probe(struct platform_device *pdev)
 	struct ast_vhub *vhub;
 	struct resource *res;
 	int i, rc = 0;
+	const struct device_node *np = pdev->dev.of_node;
 
 	vhub = devm_kzalloc(&pdev->dev, sizeof(*vhub), GFP_KERNEL);
 	if (!vhub)
 		return -ENOMEM;
 
+	rc = of_property_read_u32(np, "aspeed,vhub-downstream-ports",
+				  &vhub->max_ports);
+	if (rc < 0)
+		vhub->max_ports = AST_VHUB_NUM_PORTS;
+
+	vhub->ports = devm_kcalloc(&pdev->dev, vhub->max_ports,
+				   sizeof(*vhub->ports), GFP_KERNEL);
+	if (!vhub->ports)
+		return -ENOMEM;
+
+	rc = of_property_read_u32(np, "aspeed,vhub-generic-endpoints",
+				  &vhub->max_epns);
+	if (rc < 0)
+		vhub->max_epns = AST_VHUB_NUM_GEN_EPs;
+
+	vhub->epns = devm_kcalloc(&pdev->dev, vhub->max_epns,
+				  sizeof(*vhub->epns), GFP_KERNEL);
+	if (!vhub->epns)
+		return -ENOMEM;
+
 	spin_lock_init(&vhub->lock);
 	vhub->pdev = pdev;
 
@@ -366,7 +382,7 @@ static int ast_vhub_probe(struct platform_device *pdev)
 	 */
 	vhub->ep0_bufs = dma_alloc_coherent(&pdev->dev,
 					    AST_VHUB_EP0_MAX_PACKET *
-					    (AST_VHUB_NUM_PORTS + 1),
+					    (vhub->max_ports + 1),
 					    &vhub->ep0_bufs_dma, GFP_KERNEL);
 	if (!vhub->ep0_bufs) {
 		dev_err(&pdev->dev, "Failed to allocate EP0 DMA buffers\n");
@@ -380,7 +396,7 @@ static int ast_vhub_probe(struct platform_device *pdev)
 	ast_vhub_init_ep0(vhub, &vhub->ep0, NULL);
 
 	/* Init devices */
-	for (i = 0; i < AST_VHUB_NUM_PORTS && rc == 0; i++)
+	for (i = 0; i < vhub->max_ports && rc == 0; i++)
 		rc = ast_vhub_init_dev(vhub, i);
 	if (rc)
 		goto err;
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 4008e7a51188..d268306a7bfe 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -77,7 +77,7 @@ static void ast_vhub_dev_enable(struct ast_vhub_dev *d)
 	writel(d->ep0.buf_dma, d->regs + AST_VHUB_DEV_EP0_DATA);
 
 	/* Clear stall on all EPs */
-	for (i = 0; i < AST_VHUB_NUM_GEN_EPs; i++) {
+	for (i = 0; i < d->max_epns; i++) {
 		struct ast_vhub_ep *ep = d->epns[i];
 
 		if (ep && (ep->epn.stalled || ep->epn.wedged)) {
@@ -137,7 +137,7 @@ static int ast_vhub_ep_feature(struct ast_vhub_dev *d,
 	     is_set ? "SET" : "CLEAR", ep_num, wValue);
 	if (ep_num == 0)
 		return std_req_complete;
-	if (ep_num >= AST_VHUB_NUM_GEN_EPs || !d->epns[ep_num - 1])
+	if (ep_num >= d->max_epns || !d->epns[ep_num - 1])
 		return std_req_stall;
 	if (wValue != USB_ENDPOINT_HALT)
 		return std_req_driver;
@@ -181,7 +181,7 @@ static int ast_vhub_ep_status(struct ast_vhub_dev *d,
 
 	DDBG(d, "GET_STATUS(ep%d)\n", ep_num);
 
-	if (ep_num >= AST_VHUB_NUM_GEN_EPs)
+	if (ep_num >= d->max_epns)
 		return std_req_stall;
 	if (ep_num != 0) {
 		ep = d->epns[ep_num - 1];
@@ -299,7 +299,7 @@ static void ast_vhub_dev_nuke(struct ast_vhub_dev *d)
 {
 	unsigned int i;
 
-	for (i = 0; i < AST_VHUB_NUM_GEN_EPs; i++) {
+	for (i = 0; i < d->max_epns; i++) {
 		if (!d->epns[i])
 			continue;
 		ast_vhub_nuke(d->epns[i], -ESHUTDOWN);
@@ -416,10 +416,10 @@ static struct usb_ep *ast_vhub_udc_match_ep(struct usb_gadget *gadget,
 	 * that will allow the generic code to use our
 	 * assigned address.
 	 */
-	for (i = 0; i < AST_VHUB_NUM_GEN_EPs; i++)
+	for (i = 0; i < d->max_epns; i++)
 		if (d->epns[i] == NULL)
 			break;
-	if (i >= AST_VHUB_NUM_GEN_EPs)
+	if (i >= d->max_epns)
 		return NULL;
 	addr = i + 1;
 
@@ -526,6 +526,7 @@ void ast_vhub_del_dev(struct ast_vhub_dev *d)
 
 	usb_del_gadget_udc(&d->gadget);
 	device_unregister(d->port_dev);
+	kfree(d->epns);
 }
 
 static void ast_vhub_dev_release(struct device *dev)
@@ -546,14 +547,25 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 
 	ast_vhub_init_ep0(vhub, &d->ep0, d);
 
+	/*
+	 * A USB device can have up to 30 endpoints besides control
+	 * endpoint 0.
+	 */
+	d->max_epns = min_t(u32, vhub->max_epns, 30);
+	d->epns = kcalloc(d->max_epns, sizeof(*d->epns), GFP_KERNEL);
+	if (!d->epns)
+		return -ENOMEM;
+
 	/*
 	 * The UDC core really needs us to have separate and uniquely
 	 * named "parent" devices for each port so we create a sub device
 	 * here for that purpose
 	 */
 	d->port_dev = kzalloc(sizeof(struct device), GFP_KERNEL);
-	if (!d->port_dev)
-		return -ENOMEM;
+	if (!d->port_dev) {
+		rc = -ENOMEM;
+		goto fail_alloc;
+	}
 	device_initialize(d->port_dev);
 	d->port_dev->release = ast_vhub_dev_release;
 	d->port_dev->parent = parent;
@@ -584,6 +596,8 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 	device_del(d->port_dev);
  fail_add:
 	put_device(d->port_dev);
+ fail_alloc:
+	kfree(d->epns);
 
 	return rc;
 }
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
index 7475c74aa5c5..0bd6b20435b8 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
@@ -800,10 +800,10 @@ struct ast_vhub_ep *ast_vhub_alloc_epn(struct ast_vhub_dev *d, u8 addr)
 
 	/* Find a free one (no device) */
 	spin_lock_irqsave(&vhub->lock, flags);
-	for (i = 0; i < AST_VHUB_NUM_GEN_EPs; i++)
+	for (i = 0; i < vhub->max_epns; i++)
 		if (vhub->epns[i].dev == NULL)
 			break;
-	if (i >= AST_VHUB_NUM_GEN_EPs) {
+	if (i >= vhub->max_epns) {
 		spin_unlock_irqrestore(&vhub->lock, flags);
 		return NULL;
 	}
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 9c3027306b15..6e565c3dbb5b 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -502,7 +502,7 @@ static void ast_vhub_wake_work(struct work_struct *work)
 	 * we let the normal host wake path deal with it later.
 	 */
 	spin_lock_irqsave(&vhub->lock, flags);
-	for (i = 0; i < AST_VHUB_NUM_PORTS; i++) {
+	for (i = 0; i < vhub->max_ports; i++) {
 		struct ast_vhub_port *p = &vhub->ports[i];
 
 		if (!(p->status & USB_PORT_STAT_SUSPEND))
@@ -585,7 +585,7 @@ static enum std_req_rc ast_vhub_set_port_feature(struct ast_vhub_ep *ep,
 	struct ast_vhub *vhub = ep->vhub;
 	struct ast_vhub_port *p;
 
-	if (port == 0 || port > AST_VHUB_NUM_PORTS)
+	if (port == 0 || port > vhub->max_ports)
 		return std_req_stall;
 	port--;
 	p = &vhub->ports[port];
@@ -628,7 +628,7 @@ static enum std_req_rc ast_vhub_clr_port_feature(struct ast_vhub_ep *ep,
 	struct ast_vhub *vhub = ep->vhub;
 	struct ast_vhub_port *p;
 
-	if (port == 0 || port > AST_VHUB_NUM_PORTS)
+	if (port == 0 || port > vhub->max_ports)
 		return std_req_stall;
 	port--;
 	p = &vhub->ports[port];
@@ -674,7 +674,7 @@ static enum std_req_rc ast_vhub_get_port_stat(struct ast_vhub_ep *ep,
 	struct ast_vhub *vhub = ep->vhub;
 	u16 stat, chg;
 
-	if (port == 0 || port > AST_VHUB_NUM_PORTS)
+	if (port == 0 || port > vhub->max_ports)
 		return std_req_stall;
 	port--;
 
@@ -755,7 +755,7 @@ void ast_vhub_hub_suspend(struct ast_vhub *vhub)
 	 * Forward to unsuspended ports without changing
 	 * their connection status.
 	 */
-	for (i = 0; i < AST_VHUB_NUM_PORTS; i++) {
+	for (i = 0; i < vhub->max_ports; i++) {
 		struct ast_vhub_port *p = &vhub->ports[i];
 
 		if (!(p->status & USB_PORT_STAT_SUSPEND))
@@ -778,7 +778,7 @@ void ast_vhub_hub_resume(struct ast_vhub *vhub)
 	 * Forward to unsuspended ports without changing
 	 * their connection status.
 	 */
-	for (i = 0; i < AST_VHUB_NUM_PORTS; i++) {
+	for (i = 0; i < vhub->max_ports; i++) {
 		struct ast_vhub_port *p = &vhub->ports[i];
 
 		if (!(p->status & USB_PORT_STAT_SUSPEND))
@@ -812,7 +812,7 @@ void ast_vhub_hub_reset(struct ast_vhub *vhub)
 	 * Clear all port status, disable gadgets and "suspend"
 	 * them. They will be woken up by a port reset.
 	 */
-	for (i = 0; i < AST_VHUB_NUM_PORTS; i++) {
+	for (i = 0; i < vhub->max_ports; i++) {
 		struct ast_vhub_port *p = &vhub->ports[i];
 
 		/* Only keep the connected flag */
@@ -845,6 +845,7 @@ static void ast_vhub_init_desc(struct ast_vhub *vhub)
 	/* Initialize vhub Hub Descriptor. */
 	memcpy(&vhub->vhub_hub_desc, &ast_vhub_hub_desc,
 		sizeof(vhub->vhub_hub_desc));
+	vhub->vhub_hub_desc.bNbrPorts = vhub->max_ports;
 
 	/* Initialize vhub String Descriptors. */
 	memcpy(&vhub->vhub_str_desc, &ast_vhub_strings,
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
index 191f9fae7420..fac79ef6d669 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
+++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
@@ -79,17 +79,9 @@
 #define VHUB_SW_RESET_DEVICE2			(1 << 2)
 #define VHUB_SW_RESET_DEVICE1			(1 << 1)
 #define VHUB_SW_RESET_ROOT_HUB			(1 << 0)
-#define VHUB_SW_RESET_ALL			(VHUB_SW_RESET_EP_POOL | \
-						 VHUB_SW_RESET_DMA_CONTROLLER | \
-						 VHUB_SW_RESET_DEVICE5 | \
-						 VHUB_SW_RESET_DEVICE4 | \
-						 VHUB_SW_RESET_DEVICE3 | \
-						 VHUB_SW_RESET_DEVICE2 | \
-						 VHUB_SW_RESET_DEVICE1 | \
-						 VHUB_SW_RESET_ROOT_HUB)
+
 /* EP ACK/NACK IRQ masks */
 #define VHUB_EP_IRQ(n)				(1 << (n))
-#define VHUB_EP_IRQ_ALL				0x7fff	/* 15 EPs */
 
 /* USB status reg */
 #define VHUB_USBSTS_HISPEED			(1 << 27)
@@ -213,6 +205,11 @@
  *                                      *
  ****************************************/
 
+/*
+ * AST_VHUB_NUM_GEN_EPs and AST_VHUB_NUM_PORTS are kept to avoid breaking
+ * existing AST2400/AST2500 platforms. AST2600 and future vhub revisions
+ * should define number of downstream ports and endpoints in device tree.
+ */
 #define AST_VHUB_NUM_GEN_EPs	15	/* Generic non-0 EPs */
 #define AST_VHUB_NUM_PORTS	5	/* vHub ports */
 #define AST_VHUB_EP0_MAX_PACKET	64	/* EP0's max packet size */
@@ -315,7 +312,7 @@ struct ast_vhub_ep {
 			/* Registers */
 			void __iomem   		*regs;
 
-			/* Index in global pool (0..14) */
+			/* Index in global pool (zero-based) */
 			unsigned int		g_idx;
 
 			/* DMA Descriptors */
@@ -345,7 +342,7 @@ struct ast_vhub_dev {
 	struct ast_vhub			*vhub;
 	void __iomem			*regs;
 
-	/* Device index (0...4) and name string */
+	/* Device index (zero-based) and name string */
 	unsigned int			index;
 	const char			*name;
 
@@ -361,7 +358,8 @@ struct ast_vhub_dev {
 
 	/* Endpoint structures */
 	struct ast_vhub_ep		ep0;
-	struct ast_vhub_ep		*epns[AST_VHUB_NUM_GEN_EPs];
+	struct ast_vhub_ep		**epns;
+	u32				max_epns;
 
 };
 #define to_ast_dev(__g) container_of(__g, struct ast_vhub_dev, gadget)
@@ -402,10 +400,12 @@ struct ast_vhub {
 	bool				ep1_stalled : 1;
 
 	/* Per-port info */
-	struct ast_vhub_port		ports[AST_VHUB_NUM_PORTS];
+	struct ast_vhub_port		*ports;
+	u32				max_ports;
 
 	/* Generic EP data structures */
-	struct ast_vhub_ep		epns[AST_VHUB_NUM_GEN_EPs];
+	struct ast_vhub_ep		*epns;
+	u32				max_epns;
 
 	/* Upstream bus is suspended ? */
 	bool				suspended : 1;
-- 
2.17.1

