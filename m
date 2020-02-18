Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71ADC3404D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F1C2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S347hVOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgBRX4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:56:13 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54210 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgBRX4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:56:11 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so1754284pjc.3;
        Tue, 18 Feb 2020 15:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gIZmq38PDK8maDWrzZ6tzbZwLb/TzUBYIhY9CLrQkGc=;
        b=S347hVOmVw9Nc2voSueUVI1ZhoqJ6pSLRS+4GIwZL68we0JXUeXVwwxpnLZVwXvPtY
         KKAWtrggxw6FDwj89J70/2Ulcf11cxM9ZxDdBWZriDovu+P9pku6AI4WfFWmZexBMrkN
         bU8nJbVHfImE/JyRThhMbO+RqWYDVke2ENRahA7mXxt+UTR04uRzEdVNpu2GIxjYjs3y
         2E9uVPiWPyK/P3yB6nTHi+iKCvFvfWfOuqM/aMvgeoQPWo80w1LO9BcVC4t/hguNVRSc
         JKRXGSoROm/YheQVqbCftn8Jx+3seScjKAGEdK19LORWSxPkkBbs2O+M8b3Hi6PYlxsz
         JXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gIZmq38PDK8maDWrzZ6tzbZwLb/TzUBYIhY9CLrQkGc=;
        b=bfyJKhLCQlJm0Rmz4DUmLMU5Te4bPqENyiQjysVydS9pSSn2AyjZEn/yUoAI/iSw5h
         41BT6EHKhc99P9C6r270siMb3DK7oSuYfXB4jEiZi5NAoEX9o5jYD30xdycTUeyPbJwF
         jwPh4oeV2AvB42eFpXdfpBeI52N7m2ICSdewDtgLX9rQwRi6LTy0JdX1ODC7dow2GlWn
         g4wve40SAF2ri14tA/IG9bvhG+cMoAPtI0KujnZrIU7csC20l4G+bQ8ZJ4469jeYdCjR
         YH4sT21i9lx59Q0Mg6DVPw5BmzOOekaIUhWOR8b991mHEuoOhOup6swEZ/Lfi65qVYWN
         c/HA==
X-Gm-Message-State: APjAAAWM+SHf9hg0Wt+FSznRGStXQ/XizQF+tnDmSb6MHodTpSDrb1WM
        SYyjTjDzINJjzgEVa1lEA/FLQb5dm2Q=
X-Google-Smtp-Source: APXvYqzu4kvt7c3D3fRouLnWb2bYfjUGbMXHN7cCvhLj8uE6HlJhHfa9o51uKfKMk/X5+9whB0WoQQ==
X-Received: by 2002:a17:902:b611:: with SMTP id b17mr23055633pls.23.1582070170385;
        Tue, 18 Feb 2020 15:56:10 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::5:1718])
        by smtp.gmail.com with ESMTPSA id d3sm80558pjx.10.2020.02.18.15.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 15:56:09 -0800 (PST)
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
Subject: [PATCH 1/2] usb: gadget: aspeed: allow to customize vhub device IDs/strings
Date:   Tue, 18 Feb 2020 15:55:59 -0800
Message-Id: <20200218235600.6763-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200218235600.6763-1-rentao.bupt@gmail.com>
References: <20200218235600.6763-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This patch allows people to customize vendor/product/device IDs and
manufacture/product/serial strings in vhub's device descriptor through
device tree properties.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/hub.c | 73 +++++++++++++++++++-----
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 9c7e57fbd8ef..4e3ef83283a6 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -43,19 +43,23 @@
  *    - We may need to indicate TT support
  *    - We may need a device qualifier descriptor
  *	as devices can pretend to be usb1 or 2
- *    - Make vid/did overridable
  *    - make it look like usb1 if usb1 mode forced
  */
 #define KERNEL_REL	bin2bcd(((LINUX_VERSION_CODE >> 16) & 0x0ff))
 #define KERNEL_VER	bin2bcd(((LINUX_VERSION_CODE >> 8) & 0x0ff))
 
 enum {
+	AST_VHUB_STR_INDEX_MAX = 4,
 	AST_VHUB_STR_MANUF = 3,
 	AST_VHUB_STR_PRODUCT = 2,
 	AST_VHUB_STR_SERIAL = 1,
 };
 
-static const struct usb_device_descriptor ast_vhub_dev_desc = {
+/*
+ * Below is the default Device Descriptor of the vhub device. Some fields
+ * may be updated in "ast_vhub_fixup_dev_desc" function.
+ */
+static struct usb_device_descriptor ast_vhub_dev_desc = {
 	.bLength		= USB_DT_DEVICE_SIZE,
 	.bDescriptorType	= USB_DT_DEVICE,
 	.bcdUSB			= cpu_to_le16(0x0200),
@@ -148,10 +152,14 @@ static struct usb_hub_descriptor ast_vhub_hub_desc = {
 };
 
 /*
- * These strings converted to UTF-16 must be smaller than
- * our EP0 buffer.
+ * Below tables define the default Language ID and String Descriptors of
+ * the vhub. Language ID and strings may be overridden if according device
+ * tree properties are defined. Refer to "ast_vhub_fixup_dev_desc" function
+ * for details.
+ * Note: these strings converted to UTF-16 must be smaller than vhub EP0
+ * buffer size.
  */
-static const struct usb_string ast_vhub_str_array[] = {
+static struct usb_string ast_vhub_str_array[] = {
 	{
 		.id = AST_VHUB_STR_SERIAL,
 		.s = "00000000"
@@ -167,7 +175,7 @@ static const struct usb_string ast_vhub_str_array[] = {
 	{ }
 };
 
-static const struct usb_gadget_strings ast_vhub_strings = {
+static struct usb_gadget_strings ast_vhub_strings = {
 	.language = 0x0409,
 	.strings = (struct usb_string *)ast_vhub_str_array
 };
@@ -320,18 +328,15 @@ static int ast_vhub_rep_string(struct ast_vhub_ep *ep,
 			       u8 string_id, u16 lang_id,
 			       u16 len)
 {
-	int rc = usb_gadget_get_string (&ast_vhub_strings, string_id, ep->buf);
-
-	/*
-	 * This should never happen unless we put too big strings in
-	 * the array above
-	 */
-	BUG_ON(rc >= AST_VHUB_EP0_MAX_PACKET);
+	int rc;
+	u8 buf[256]; /* buffer size required by usb_gadget_get_string */
 
-	if (rc < 0)
+	rc = usb_gadget_get_string(&ast_vhub_strings, string_id, buf);
+	if (rc < 0 || rc >= AST_VHUB_EP0_MAX_PACKET)
 		return std_req_stall;
 
 	/* Shoot it from the EP buffer */
+	memcpy(ep->buf, buf, rc);
 	return ast_vhub_reply(ep, NULL, min_t(u16, rc, len));
 }
 
@@ -837,11 +842,51 @@ void ast_vhub_hub_reset(struct ast_vhub *vhub)
 	writel(0, vhub->regs + AST_VHUB_EP1_STS_CHG);
 }
 
+static void ast_vhub_fixup_dev_desc(struct ast_vhub *vhub)
+{
+	int i;
+	u8 id;
+	u16 of_id;
+	const char *of_str[AST_VHUB_STR_INDEX_MAX] = {NULL};
+	struct device_node *np = vhub->pdev->dev.of_node;
+
+	/*
+	 * Update IDs in device descriptor if according properties are
+	 * defined in device tree.
+	 */
+	if (!of_property_read_u16(np, "vendor-id", &of_id))
+		ast_vhub_dev_desc.idVendor = cpu_to_le16(of_id);
+	if (!of_property_read_u16(np, "product-id", &of_id))
+		ast_vhub_dev_desc.idProduct = cpu_to_le16(of_id);
+	if (!of_property_read_u16(np, "device-id", &of_id))
+		ast_vhub_dev_desc.bcdDevice = cpu_to_le16(of_id);
+
+	/*
+	 * Update string descriptors if according properties are defined
+	 * in device tree.
+	 */
+	if (!of_property_read_u16(np, "language-id", &of_id))
+		ast_vhub_strings.language = of_id;
+
+	of_str[AST_VHUB_STR_MANUF] = of_get_property(np, "manufacturer", NULL);
+	of_str[AST_VHUB_STR_PRODUCT] = of_get_property(np, "product", NULL);
+	of_str[AST_VHUB_STR_SERIAL] = of_get_property(np, "serial-number",
+						      NULL);
+
+	for (i = 0; ast_vhub_str_array[i].s != NULL; i++) {
+		id = ast_vhub_str_array[i].id;
+		if (of_str[id])
+			ast_vhub_str_array[i].s = of_str[id];
+	}
+}
+
 void ast_vhub_init_hub(struct ast_vhub *vhub)
 {
 	vhub->speed = USB_SPEED_UNKNOWN;
 	INIT_WORK(&vhub->wake_work, ast_vhub_wake_work);
 
+	ast_vhub_fixup_dev_desc(vhub);
+
 	/*
 	 * Fixup number of ports in hub descriptor.
 	 */
-- 
2.17.1

