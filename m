Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C277C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3C321739
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSTD/CiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCCGXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:23:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45349 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgCCGXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:23:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id m15so1023851pgv.12;
        Mon, 02 Mar 2020 22:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m7KmSlQ4EFgubxYp5UALnSjFoVX9ZzuBugi+uy5y+5c=;
        b=oSTD/CiWd3JoJEoXQCnzp7QTx7VMCoMmVxkK0Em7wctnUdtqZN589gJ/hIGQtP1ge4
         U0jtV4rW5T7TMNBMgKCollWju0UIoTObfcDmZG72PRSi9lHmCCZVzjQQiZ6YaXu5ljGs
         T+geD+Z9PJOZ4kzK4tdieoyhlWofYzFWIqt1EtYyWzBP2/NEzWHRiYohXMmgitPYig7G
         UUpsGHutQBJF/6fjLW2idV9sAUBbmRdg5TIS2HkUe/vbdvyp+h5XWuJpJBZYAjFYn5Lh
         YaeQcilpujkvVaDPCvSxDrXrrsGNCkzzSbnSsX64g1uUg+BJbAom2s+G6pmFUJTV7/NR
         P4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m7KmSlQ4EFgubxYp5UALnSjFoVX9ZzuBugi+uy5y+5c=;
        b=TMHPdzdG+eUNrWC12ijgnxT3cioxB/gx2DBQhUI1ukNxP3SvHwihF2iJ4P/LrTipGz
         s5K3NRDdVWbVsvYNh6swWMQcfr6xhXLFWBdGPbStJLiUPw5+VkFjLGOknM8492AMiRE8
         e72DFud8h57AVhNTpECDJJb0yE5Tq434MSqes5WexGOxf3UqqJ6Ir1om15vRxx2C69ZV
         pPPoJoU7Ot6AFgeRzqD+ofaXbY0x7HCsSR2OjDmsfgc1hdRYTtBmcNo/77m4N843CuJe
         TCqGTeXAWVbLeIAUQIW+5rR1hqxZRQX/UUEBycYV2pE9oAANe3uI4zqvIMZ4FFJTT2g6
         MyTw==
X-Gm-Message-State: ANhLgQ0SdKhoe8G0GXCMEikI5SESesL02VahWS1ul7yfj/T46pzbVKnh
        I+hpzc+gpIILaf04/heER/Q=
X-Google-Smtp-Source: ADFU+vu6wdsxZ6lNWMKXxWfoMrjDAW8c4Ni+G/I5Nv8RlncdnY4JGadd9ZmbI8iDto547rh/UIYTNg==
X-Received: by 2002:a05:6a00:cb:: with SMTP id e11mr2698405pfj.88.1583216627506;
        Mon, 02 Mar 2020 22:23:47 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id k5sm7453526pfp.66.2020.03.02.22.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 22:23:47 -0800 (PST)
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
Subject: [PATCH v7 1/7] usb: gadget: aspeed: support per-vhub usb descriptors
Date:   Mon,  2 Mar 2020 22:23:30 -0800
Message-Id: <20200303062336.7361-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303062336.7361-1-rentao.bupt@gmail.com>
References: <20200303062336.7361-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This patch store vhub's standard usb descriptors in struct "ast_vhub" so
it's more convenient to customize descriptors and potentially support
multiple vhub instances in the future.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 No change in v2/v3/v4/v5/v6/v7:
   - the patch is added to the patch series since v4.

 drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 43 ++++++++++++++++-------
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h | 15 ++++++++
 2 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 19b3517e04c0..9c3027306b15 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -93,11 +93,7 @@ static void ast_vhub_patch_dev_desc_usb1(struct usb_device_descriptor *desc)
 				 USB_DT_INTERFACE_SIZE + \
 				 USB_DT_ENDPOINT_SIZE)
 
-static const struct ast_vhub_full_cdesc {
-	struct usb_config_descriptor	cfg;
-	struct usb_interface_descriptor intf;
-	struct usb_endpoint_descriptor	ep;
-} __attribute__ ((packed)) ast_vhub_conf_desc = {
+static const struct ast_vhub_full_cdesc ast_vhub_conf_desc = {
 	.cfg = {
 		.bLength		= USB_DT_CONFIG_SIZE,
 		.bDescriptorType	= USB_DT_CONFIG,
@@ -266,6 +262,7 @@ static int ast_vhub_rep_desc(struct ast_vhub_ep *ep,
 			     u8 desc_type, u16 len)
 {
 	size_t dsize;
+	struct ast_vhub *vhub = ep->vhub;
 
 	EPDBG(ep, "GET_DESCRIPTOR(type:%d)\n", desc_type);
 
@@ -281,20 +278,20 @@ static int ast_vhub_rep_desc(struct ast_vhub_ep *ep,
 	switch(desc_type) {
 	case USB_DT_DEVICE:
 		dsize = USB_DT_DEVICE_SIZE;
-		memcpy(ep->buf, &ast_vhub_dev_desc, dsize);
-		BUILD_BUG_ON(dsize > sizeof(ast_vhub_dev_desc));
+		memcpy(ep->buf, &vhub->vhub_dev_desc, dsize);
+		BUILD_BUG_ON(dsize > sizeof(vhub->vhub_dev_desc));
 		BUILD_BUG_ON(USB_DT_DEVICE_SIZE >= AST_VHUB_EP0_MAX_PACKET);
 		break;
 	case USB_DT_CONFIG:
 		dsize = AST_VHUB_CONF_DESC_SIZE;
-		memcpy(ep->buf, &ast_vhub_conf_desc, dsize);
-		BUILD_BUG_ON(dsize > sizeof(ast_vhub_conf_desc));
+		memcpy(ep->buf, &vhub->vhub_conf_desc, dsize);
+		BUILD_BUG_ON(dsize > sizeof(vhub->vhub_conf_desc));
 		BUILD_BUG_ON(AST_VHUB_CONF_DESC_SIZE >= AST_VHUB_EP0_MAX_PACKET);
 		break;
 	case USB_DT_HUB:
 		dsize = AST_VHUB_HUB_DESC_SIZE;
-		memcpy(ep->buf, &ast_vhub_hub_desc, dsize);
-		BUILD_BUG_ON(dsize > sizeof(ast_vhub_hub_desc));
+		memcpy(ep->buf, &vhub->vhub_hub_desc, dsize);
+		BUILD_BUG_ON(dsize > sizeof(vhub->vhub_hub_desc));
 		BUILD_BUG_ON(AST_VHUB_HUB_DESC_SIZE >= AST_VHUB_EP0_MAX_PACKET);
 		break;
 	default:
@@ -317,7 +314,8 @@ static int ast_vhub_rep_string(struct ast_vhub_ep *ep,
 			       u8 string_id, u16 lang_id,
 			       u16 len)
 {
-	int rc = usb_gadget_get_string (&ast_vhub_strings, string_id, ep->buf);
+	int rc = usb_gadget_get_string(&ep->vhub->vhub_str_desc,
+					string_id, ep->buf);
 
 	/*
 	 * This should never happen unless we put too big strings in
@@ -834,9 +832,30 @@ void ast_vhub_hub_reset(struct ast_vhub *vhub)
 	writel(0, vhub->regs + AST_VHUB_EP1_STS_CHG);
 }
 
+static void ast_vhub_init_desc(struct ast_vhub *vhub)
+{
+	/* Initialize vhub Device Descriptor. */
+	memcpy(&vhub->vhub_dev_desc, &ast_vhub_dev_desc,
+		sizeof(vhub->vhub_dev_desc));
+
+	/* Initialize vhub Configuration Descriptor. */
+	memcpy(&vhub->vhub_conf_desc, &ast_vhub_conf_desc,
+		sizeof(vhub->vhub_conf_desc));
+
+	/* Initialize vhub Hub Descriptor. */
+	memcpy(&vhub->vhub_hub_desc, &ast_vhub_hub_desc,
+		sizeof(vhub->vhub_hub_desc));
+
+	/* Initialize vhub String Descriptors. */
+	memcpy(&vhub->vhub_str_desc, &ast_vhub_strings,
+		sizeof(vhub->vhub_str_desc));
+}
+
 void ast_vhub_init_hub(struct ast_vhub *vhub)
 {
 	vhub->speed = USB_SPEED_UNKNOWN;
 	INIT_WORK(&vhub->wake_work, ast_vhub_wake_work);
+
+	ast_vhub_init_desc(vhub);
 }
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
index 761919e220d3..191f9fae7420 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
+++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
@@ -2,6 +2,9 @@
 #ifndef __ASPEED_VHUB_H
 #define __ASPEED_VHUB_H
 
+#include <linux/usb.h>
+#include <linux/usb/ch11.h>
+
 /*****************************
  *                           *
  * VHUB register definitions *
@@ -373,6 +376,12 @@ struct ast_vhub_port {
 	struct ast_vhub_dev	dev;
 };
 
+struct ast_vhub_full_cdesc {
+	struct usb_config_descriptor	cfg;
+	struct usb_interface_descriptor intf;
+	struct usb_endpoint_descriptor	ep;
+} __packed;
+
 /* Global vhub structure */
 struct ast_vhub {
 	struct platform_device		*pdev;
@@ -409,6 +418,12 @@ struct ast_vhub {
 
 	/* Upstream bus speed captured at bus reset */
 	unsigned int			speed;
+
+	/* Standard USB Descriptors of the vhub. */
+	struct usb_device_descriptor	vhub_dev_desc;
+	struct ast_vhub_full_cdesc	vhub_conf_desc;
+	struct usb_hub_descriptor	vhub_hub_desc;
+	struct usb_gadget_strings	vhub_str_desc;
 };
 
 /* Standard request handlers result codes */
-- 
2.17.1

