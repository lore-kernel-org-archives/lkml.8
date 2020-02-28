Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFD8C3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0D024695
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX+VZBI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbgB1CIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 21:08:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37068 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbgB1CIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 21:08:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id z12so670398pgl.4;
        Thu, 27 Feb 2020 18:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4mjPmvXysWT0DgB3PSQGnyz6HfpRACYycHeQnWkOz6Y=;
        b=ZX+VZBI9RskmB38Sd4RrA9/Aek92Spv7yQBdBSNLRoSEFNRURWgTZE11IoKdjOZ3YK
         PGTlTDyR8NTYR1vcoWariC/tTjag+7sxf8YW+rk/DcYghR05j5n+ThZTm8AjLUAWsf+g
         mFCkQAz4hd1zRFWqdRgwUUgNLsRq6ztHgVWHvB7RVUKj7e+NNLnxVuI+LXwl58RhQyMM
         C0ZuJTShk4JZqg5OsJaVIZ6xUdVXOWqff9hkmcjsftTwAYUIan8B/5r/e0oRS3ts714o
         eK39VCi2cDLhZ+epNfi/Q/heRRxkFVXJzWlDWJH5vKB02rkr5U2AVlfW2YkKlQVbssoB
         yT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4mjPmvXysWT0DgB3PSQGnyz6HfpRACYycHeQnWkOz6Y=;
        b=hLXV6rqIHS2bCRdwfB7qMjr+fA6/V7yWf09K/+ni2lHwqS0+Eq1SeaUVaw/Ye/OiLd
         EiCCW6XXa1SWp8W7uzcLwvtkqb6Yro9q44bcQd1qYHhSilq9MjyJwxmneQ9Ooy+oRNbl
         gGHYJ04j5rctFM9xgbAmbJmsqfNI/T3jTMYdrxdqJ+A1JBcsFWSg9xavh7BJx608XM6T
         3RLDatRJGi7wWXOJuL9FrHkC+wh9yrN+BCYeGEunJqnZ+V+e/6ypXGYPGyeBA85f8Omj
         mC56fSplSR6MD8TAHpE0i1T9kvf3eWTibaEprRZiV3q3RGXS/mU2DiEmFnvfW00hkODg
         zOhQ==
X-Gm-Message-State: APjAAAX0vMHmWYyVSop29cjxOZdoNJjJA8475x7dSsPhIskeB0PwuqM0
        lOUW5TaA4fa8JlNZdBZrHsY=
X-Google-Smtp-Source: APXvYqzqI7BYR2+TRO/7IrXywoRFNx++mQlKf8rK68vX1Z5bE2FjZLKQ+AuBDWczldPe6WJ5gntoLw==
X-Received: by 2002:a62:1dca:: with SMTP id d193mr2085368pfd.140.1582855692123;
        Thu, 27 Feb 2020 18:08:12 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::4:d8f5])
        by smtp.gmail.com with ESMTPSA id k24sm4931972pgm.61.2020.02.27.18.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 18:08:11 -0800 (PST)
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
Subject: [PATCH v6 3/7] usb: gadget: aspeed: add ast2600 vhub support
Date:   Thu, 27 Feb 2020 18:07:53 -0800
Message-Id: <20200228020757.10513-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228020757.10513-1-rentao.bupt@gmail.com>
References: <20200228020757.10513-1-rentao.bupt@gmail.com>
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
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 No Change in v3/v4/v5/v6.
 Changes in v2:
   - removed "ast_vhub_config" related logic.

 drivers/usb/gadget/udc/aspeed-vhub/Kconfig | 4 ++--
 drivers/usb/gadget/udc/aspeed-vhub/core.c  | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

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
index f8ab8e012f34..f8d35dd60c34 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -423,6 +423,9 @@ static const struct of_device_id ast_vhub_dt_ids[] = {
 	{
 		.compatible = "aspeed,ast2500-usb-vhub",
 	},
+	{
+		.compatible = "aspeed,ast2600-usb-vhub",
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ast_vhub_dt_ids);
-- 
2.17.1

