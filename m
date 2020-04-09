Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50430C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2526820753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqmSGUUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgDIUkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:40:43 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:56001 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDIUkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:40:42 -0400
Received: by mail-pj1-f65.google.com with SMTP id a32so1773695pje.5;
        Thu, 09 Apr 2020 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YFdk+s6DAN6aaYEhySzPfFS73mspXBy0eatt12t9vpE=;
        b=mqmSGUUOx2o/pdEGWUOtz0ExRCl94+NNqTsUbvbhkwTI350tV+G3oWT1Ml7Mcxxddd
         MfA75X9sWWTGWeNwddMUCFeNsUEh5NSx3hM8rFkLfkaYYlu68cjHbN3U98/k8vApdBm2
         5K9O6yE3rklLInMQgvFdPbCDO2aJou4Xi1D5cgq0VJa3EKUeeQEtP7FbL/8JvxdZu1SB
         wOcbZDwEd4jLpC5Y5a0cmnEVk4Mn6iv4JJRWD0i0OpsxKqj7jountgI0kAJ05uPT7Uyh
         aahYTWFxCLJAKzN7gNJFlrCa4FxaZXwkhUAkZmeWTMDDg3OaFbKfHmtpbmM352Lt5pAY
         iojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YFdk+s6DAN6aaYEhySzPfFS73mspXBy0eatt12t9vpE=;
        b=gJtCBToaGCE7fIkuwrLceO3hhfOY1I/hA60uw/e8feqnAL7Jlx/KXPwV6gwcCVny6l
         ZWbaWki+Fu6Jy6p7byPBuqNmF0xCq5OcZ8r/jhTuuEDScTvFIaEvzKhcdyqce9/LqSPe
         o/ZlwHGFFkNpuY9gjh2Odo/xcgHS5rxXZBZ4DQjADRuSQ0wkyTRHC/iiN6m8l2Fc4pvB
         DMmvR4G6dqqNBVt/RSkk+yXg3AoP0IVeTgXjMpsOwiMUOY+S7zRP9BqX202LIda52O0o
         U8py+rM2eQpWehWNnWbfhx1PM/eo0yr4tvUOazw6fd/PfnFG7XDBuAqtAc5RnlvwzrLt
         u3xQ==
X-Gm-Message-State: AGi0PuZvG6q2AnQ/g0AeNam4tlwTG3red//10pPywwbmBD65YCBz/GgG
        OKJOSWOGaYEx0uyxXegRxII=
X-Google-Smtp-Source: APiQypJDY7fIgt5BH2dLASbxM7xt1HbxuX8tMAQnHRwL2JQKsbL/ySbmDvLuSgYsSMHwePJNtrvSbg==
X-Received: by 2002:a17:902:a5cc:: with SMTP id t12mr1456010plq.322.1586464840437;
        Thu, 09 Apr 2020 13:40:40 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:400::5:b9ab])
        by smtp.gmail.com with ESMTPSA id t4sm20043960pfb.156.2020.04.09.13.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 13:40:39 -0700 (PDT)
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
Subject: [PATCH v4] usb: gadget: aspeed: improve vhub port irq handling
Date:   Thu,  9 Apr 2020 13:40:30 -0700
Message-Id: <20200409204030.21330-1-rentao.bupt@gmail.com>
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
 Changes in v4:
   - use simple for() loop as it runs faster than for_each_set_bit()
     loop on aspeed BMCs.
 Changes in v3:
   - assign istat to (unsigned long) bitmap before calling
     "for_each_set_bit_from".
 Changes in v2:
   - use "for_each_set_bit" to speed up port irq handling.

 drivers/usb/gadget/udc/aspeed-vhub/core.c | 12 +++++++-----
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h | 11 ++++++-----
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index f8d35dd60c34..fb36bad2c0b7 100644
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
@@ -332,6 +332,8 @@ static int ast_vhub_probe(struct platform_device *pdev)
 
 	spin_lock_init(&vhub->lock);
 	vhub->pdev = pdev;
+	vhub->port_irq_mask = GENMASK(VHUB_IRQ_DEV1_BIT + vhub->max_ports - 1,
+				      VHUB_IRQ_DEV1_BIT);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	vhub->regs = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
index fac79ef6d669..b80e3ddff797 100644
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
@@ -70,6 +67,9 @@
 #define VHUB_IRQ_HUB_EP0_SETUP			(1 << 0)
 #define VHUB_IRQ_ACK_ALL			0x1ff
 
+/* Downstream device IRQ mask. */
+#define VHUB_DEV_IRQ(n)				(VHUB_IRQ_DEVICE1 << (n))
+
 /* SW reset reg */
 #define VHUB_SW_RESET_EP_POOL			(1 << 9)
 #define VHUB_SW_RESET_DMA_CONTROLLER		(1 << 8)
@@ -402,6 +402,7 @@ struct ast_vhub {
 	/* Per-port info */
 	struct ast_vhub_port		*ports;
 	u32				max_ports;
+	u32				port_irq_mask;
 
 	/* Generic EP data structures */
 	struct ast_vhub_ep		*epns;
-- 
2.17.1

