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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45481C4BA2D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1285524650
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pb8ZqOOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBZXEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:04:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35827 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZXEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:04:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id i19so555049pfa.2;
        Wed, 26 Feb 2020 15:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WTqePqPwt8jEUO6CFFTs58F4aXbYeL8ROe2MQeR3p1U=;
        b=pb8ZqOOVmILB9ovfMFUFFvWBcu/3a+3xoBd2FQzd0PSweNr/ryWv2+/u+47tzTKKxA
         qhPuIf7hXpMnO8HfTaAiEUxbMh4bpLKOWw2wKJJH1/+Mz7JFCtkmbRx0GK6JOQKENPYt
         PmTN4/G+6u8lxri0jXX7Nt3P0kXvwfLsA9sU2erFFnemsrKgB8Hz+uEc0QL39aKtU58t
         rpRhZjxazQM+CVJ79VkUT5y3i1Kg1ipQwUIVB53CXs7W/w0hfHq4d9H9oNISRaVU6giU
         iBYM+MPUfnO4+Pif9+j9ajbDVicygZCNEl6oF6VE4kK0IKedlqSlxxh8T14mHoiC51kP
         0tqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WTqePqPwt8jEUO6CFFTs58F4aXbYeL8ROe2MQeR3p1U=;
        b=XYBzNU51/AGR6gQ3KEff8qr1gcc3U9fjVexwzT7qA6RCVXaECTfBJ1DhLNiyoPVRwt
         VtpSXLpoaxEyaVDN65X7dLZ0Ia2y1PCkV5NZ7Fk3AES1Bk5ctvn1he4Dvw4wODaoxOEJ
         4jBvGrb8Y5ThuA2syimhzkDErpLcT4mHcPsgdfWKzy9LwYA71ASVMhgcJqF4vR9ktxuo
         6WmVzOeIxZ187DZc3cuY9xTG72c+pSdRuQfcjE6QDg2i2+pOKWCyMXJ+Xz86RC2vZ9kG
         lErc9e1RVkt878d2cy+WX2kSQUjx9l4GdSscLmB9bMqTZuKRLoJvVkcUkya9yijCivEW
         OiFw==
X-Gm-Message-State: APjAAAXq3sjv2mCFt3OOCdk2ufvVTdEvVGQfspftBEy+7wq4TsTiKNfr
        +cW5a+a9ciqNTzluNRXbFYA=
X-Google-Smtp-Source: APXvYqwxa6Z4LuwxaQt9Hg/qRsWn/81tKYb4scIZh/9/EnxSgz+05WRbycdlrAVV5YgVt3g4EeO0mw==
X-Received: by 2002:aa7:94a4:: with SMTP id a4mr1021266pfl.178.1582758241855;
        Wed, 26 Feb 2020 15:04:01 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::7:5ebf])
        by smtp.gmail.com with ESMTPSA id 3sm3912621pjg.27.2020.02.26.15.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:04:01 -0800 (PST)
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
Subject: [PATCH v4 1/7] usb: gadget: aspeed: support per-vhub usb descriptors
Date:   Wed, 26 Feb 2020 15:03:40 -0800
Message-Id: <20200226230346.672-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226230346.672-1-rentao.bupt@gmail.com>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This patch store vhub's standard usb descriptors in struct "ast_vhub" so
it's more convenient to customize descriptors and potentially support
multiple vhub instances in the future.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 No change in v2/v3/v4:
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

