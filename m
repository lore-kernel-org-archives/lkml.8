Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9F9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3250020717
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7M9+ENa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCEXr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:47:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39656 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCEXr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 18:47:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id s2so186602pgv.6;
        Thu, 05 Mar 2020 15:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=z2HXeME5Gk76DY5Zvh5p+H88p8YEhHXH5Ad0akNZ4Go=;
        b=i7M9+ENaqIDSGbdccu/70MshUdaM1GY6nsyiIOXyVdqlfp9GO06/CNeuQdJClQ1T6f
         5jbaLtuZpia8nMNur+hSQ6ow4hDRQwvgoF8qc+Bryi/Nr/upfoM54W3KzGR8ZN2FOYgk
         xnljo4UgHyDYzQCkhGO1LwezK5GZxjQFAVX3QIHKHV4wh/fHQwalTOOQ/1fAL2SanSNb
         uIr/xP/KzI6mZdLcbL0ZrG9k0V9AYHqlu8Z+DKlKQL3hl5CWc7XpM8Jr9lx4ag8HIlt4
         lg/fRzNEcVzS6qC+h49hpllj4NQJ8xACHPV3OeRjR+OQV0sG1lzyONqNqt24oNq3sVe+
         podA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z2HXeME5Gk76DY5Zvh5p+H88p8YEhHXH5Ad0akNZ4Go=;
        b=P6cvc0hOtajfrUKYGk5vTkl/G/FnCMI53gLVx+P682v0f3kjLDE88QwXCGPf25rrX7
         EpRoaQGTNJBRJojphBIZrPvCwqXVIlUK6wjMqyV0Lo/p0JkmRZZHGtxZilutYFZIlOSa
         IEyBhCL04JlaezjoTwJ/GP3UVMrSsRt4Y1Yj6m+leVlsZs3T+H/Y8RLoBAII43WgaAFb
         wbiR2F7U3GRSq5rVsn1pREvsaeRnf/XnTLyV8AA4ftA+s3tu5luVpslV2G7FZ5+Kbd3x
         8zCuRVkF6NdVYmZQaBWxaE+m2c3h17AdS9kijyj6aodBg94KT4z+co+LBTOH/o+VNFeO
         PsxQ==
X-Gm-Message-State: ANhLgQ2Qc17PCwEdegeSG87xUKQhXdyBoh0LaqKGTUsoR+6WAltQpRAs
        LgWEJ/z1F3Di0100Jue9fkY=
X-Google-Smtp-Source: ADFU+vuXtvzxvdAVnsjaChDBJL3af8XnJtk33bP+uqfR/WxN2Ya4fj+d8he6j7TKb31ahpsc05YQvw==
X-Received: by 2002:a63:8042:: with SMTP id j63mr581107pgd.224.1583452074966;
        Thu, 05 Mar 2020 15:47:54 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::5:788])
        by smtp.gmail.com with ESMTPSA id s21sm4490620pfd.99.2020.03.05.15.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 15:47:54 -0800 (PST)
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
Subject: [PATCH v2] usb: gadget: aspeed: improve vhub port irq handling
Date:   Thu,  5 Mar 2020 15:47:46 -0800
Message-Id: <20200305234746.1002-1-rentao.bupt@gmail.com>
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
 Changes in v2:
   - use "for_each_set_bit" to speed up port irq handling.

 drivers/usb/gadget/udc/aspeed-vhub/core.c | 11 ++++++++---
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  8 +++-----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index f8d35dd60c34..af2dbd405361 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -134,11 +134,14 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
 	}
 
 	/* Handle device interrupts */
-	for (i = 0; i < vhub->max_ports; i++) {
-		u32 dev_mask = VHUB_IRQ_DEVICE1 << i;
+	if (istat & vhub->port_irq_mask) {
+		int offset = VHUB_IRQ_DEV1_BIT;
+		int size = VHUB_IRQ_DEV1_BIT + vhub->max_ports;
 
-		if (istat & dev_mask)
+		for_each_set_bit_from(offset, (unsigned long *)&istat, size) {
+			i = offset - VHUB_IRQ_DEV1_BIT;
 			ast_vhub_dev_irq(&vhub->ports[i].dev);
+		}
 	}
 
 	/* Handle top-level vHub EP0 interrupts */
@@ -332,6 +335,8 @@ static int ast_vhub_probe(struct platform_device *pdev)
 
 	spin_lock_init(&vhub->lock);
 	vhub->pdev = pdev;
+	vhub->port_irq_mask = GENMASK(VHUB_IRQ_DEV1_BIT + vhub->max_ports - 1,
+				      VHUB_IRQ_DEV1_BIT);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	vhub->regs = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
index fac79ef6d669..23a1ac91f8d2 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
+++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
@@ -51,14 +51,11 @@
 #define VHUB_CTRL_UPSTREAM_CONNECT		(1 << 0)
 
 /* IER & ISR */
+#define VHUB_IRQ_DEV1_BIT			9
 #define VHUB_IRQ_USB_CMD_DEADLOCK		(1 << 18)
 #define VHUB_IRQ_EP_POOL_NAK			(1 << 17)
 #define VHUB_IRQ_EP_POOL_ACK_STALL		(1 << 16)
-#define VHUB_IRQ_DEVICE5			(1 << 13)
-#define VHUB_IRQ_DEVICE4			(1 << 12)
-#define VHUB_IRQ_DEVICE3			(1 << 11)
-#define VHUB_IRQ_DEVICE2			(1 << 10)
-#define VHUB_IRQ_DEVICE1			(1 << 9)
+#define VHUB_IRQ_DEVICE1			(1 << (VHUB_IRQ_DEV1_BIT))
 #define VHUB_IRQ_BUS_RESUME			(1 << 8)
 #define VHUB_IRQ_BUS_SUSPEND 			(1 << 7)
 #define VHUB_IRQ_BUS_RESET 			(1 << 6)
@@ -402,6 +399,7 @@ struct ast_vhub {
 	/* Per-port info */
 	struct ast_vhub_port		*ports;
 	u32				max_ports;
+	u32				port_irq_mask;
 
 	/* Generic EP data structures */
 	struct ast_vhub_ep		*epns;
-- 
2.17.1

