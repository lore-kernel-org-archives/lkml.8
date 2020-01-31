Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731CBC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B01214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvvSE+y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgAaWWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:22:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40481 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgAaWWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 17:22:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so3302669plp.7;
        Fri, 31 Jan 2020 14:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wSzJwkvRpdC4ZPPv+f6r9mzu5IB7aUbc0urJg/jNjl0=;
        b=OvvSE+y8ye7N5+THH0qJlSCGi+0ze3TVr0d66Lr4LxVdRTY2dX9KY49MXJGfmPM7hy
         p/AQMRMm+VODOVx7LIykMg9Lx8HultkxI+4uU5egTDebM61K3nQIgGEMATMocCS89oVD
         l+AmaqvNHtr9RA9fD6HKXKB1uf8JKrJGXkcVE/YCXfzuraxGj/8mRdTEDFVgPqYPWbdG
         RTLoBSjLblnzgthVJiaimoGdC8LKr1O06wx4snrajedYITdZmqaH0pxRFNEr1j8OKF1T
         PnEHyjz357A5h7EWqzJhYIERLoUxfBogs8J+8ucqlqky7dmV+irAU4V1r8SMxNfi7b4x
         pLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wSzJwkvRpdC4ZPPv+f6r9mzu5IB7aUbc0urJg/jNjl0=;
        b=pAWqTTfIglC7cQFaDzA128yiIt1p0LN24jn0VSYptmQQnFWi/L9VtshWW5TNoLYgIM
         T90y4Umpo9oyYKuVkUR6Jk8h3hU/SKMfssj5anpB57WUhXVVG0l1a3R9uq+C9c1Clw77
         IYVJCT+8U0SveJdN48pbCzTqGgU+/IeUekF9K1JfL8YW8oYy74NichRRKkkI/qXFeMEl
         GFQd1t9F7k++Wo7rlTgDIxdh5Utj2+/Fi1WiZ6wU80jQTwTviolc8DbHDUDC/5eS0W7w
         2Cfl+66eSjGs5fxlNqcIjFXOV+nLh3dXSw95Hd3Yq2HljoRBDY9Whj9WSW8Qwwz3xGzl
         kRYA==
X-Gm-Message-State: APjAAAWeckKqNGkBNgAXq7yKBuRTvSDwH+nNRTAVGtcJXnZ5Q/J3R5lx
        9w8rRYjGMEmCDPso87m1Vq8=
X-Google-Smtp-Source: APXvYqzBLFzKofUIpvT30N4IUyqXxoZIoYk2D6ykKzwAFsGoR/vQ9KOZZzYn8bPITHvNhpplaDsRiA==
X-Received: by 2002:a17:90a:c24c:: with SMTP id d12mr15158909pjx.113.1580509330716;
        Fri, 31 Jan 2020 14:22:10 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::1:a521])
        by smtp.gmail.com with ESMTPSA id v8sm11201515pff.151.2020.01.31.14.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:22:10 -0800 (PST)
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
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 2/3] usb: gadget: aspeed: add ast2600 vhub support
Date:   Fri, 31 Jan 2020 14:21:56 -0800
Message-Id: <20200131222157.20849-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131222157.20849-1-rentao.bupt@gmail.com>
References: <20200131222157.20849-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add AST2600 support in aspeed-vhub driver. There are 3 major differences
between AST2500 and AST2600 vhub:
  - AST2600 supports 7 downstream ports while AST2500 supports 5.
  - AST2600 supports 21 generic endpoints while AST2500 supports 15.
  - EP0 data buffer's 8-byte DMA alignment restriction is removed from
    AST2600.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/usb/gadget/udc/aspeed-vhub/Kconfig | 4 ++--
 drivers/usb/gadget/udc/aspeed-vhub/core.c  | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/Kconfig b/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
index 83ba8a2eb6af..605500b19cf3 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
+++ b/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
@@ -4,5 +4,5 @@ config USB_ASPEED_VHUB
 	depends on ARCH_ASPEED || COMPILE_TEST
 	depends on USB_LIBCOMPOSITE
 	help
-	  USB peripheral controller for the Aspeed AST2500 family
-	  SoCs supporting the "vHub" functionality and USB2.0
+	  USB peripheral controller for the Aspeed AST2400, AST2500 and
+	  AST2600 family SoCs supporting the "vHub" functionality and USB2.0
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index 94081cc04113..c827bf420278 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -42,6 +42,11 @@ static const struct ast_vhub_config ast2400_config = {
 	.max_epns = 15,
 };
 
+static const struct ast_vhub_config ast2600_config = {
+	.max_ports = 7,
+	.max_epns = 21,
+};
+
 static const struct of_device_id ast_vhub_dt_ids[] = {
 	{
 		.compatible = "aspeed,ast2400-usb-vhub",
@@ -51,6 +56,10 @@ static const struct of_device_id ast_vhub_dt_ids[] = {
 		.compatible = "aspeed,ast2500-usb-vhub",
 		.data = &ast2400_config,
 	},
+	{
+		.compatible = "aspeed,ast2600-usb-vhub",
+		.data = &ast2600_config,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ast_vhub_dt_ids);
-- 
2.17.1

