Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD08C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFB721569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osRYjOE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgBLV5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:57:37 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38683 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbgBLV5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:57:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id t6so1466476plj.5;
        Wed, 12 Feb 2020 13:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9R6etbCWA0Xr2BLGZcOqv2B9uQVoWrtEKoDia/3gAmc=;
        b=osRYjOE+S4T3n2NX0HckDlon9Ckir9iwsJmHpigKf1urq1gHixNS0a5L+hQfjn9x4E
         I38sDSoWvbI411/D5L2/GcxtFReZDMVHboDByJoSBq7uXGhrAobi08neBsYuinyuefT7
         U70dh3OWgaDfKIEGnYUq8W7OHi7LiTjCm0+kshx930BsyYCl0BNzzBHy/rdKsQgUU2Os
         dfg7wZWCIxvPqVyD2tQiC1C2IZ3rg3POxvn49shta10lilX9xR4IFt/JkSYnmXBqKH1L
         iGlqednqnHlw1wwYaL0EX7uStpHr6ZGyDi5VQUh60wuIEUXbkR8lVUhhjqtXM1kMVo4G
         CMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9R6etbCWA0Xr2BLGZcOqv2B9uQVoWrtEKoDia/3gAmc=;
        b=QHpWB+zgCdt4u/WuIfeT1LBvBg6tvd9/f94LxDCYl80cU5eE0OVW34Zj40D1TKYrCm
         RZTRkLjxqljoSHTwVIlxgptWgnM/EOea0MFOk0X3n7CI6uS98dCOKtUrCundLwBtwwsL
         ENZVSmdvmNiPpDf0Mh275Q9pS2bPdpmzW14qXvUNJXIh7Vs66v1xci7ENmiz4SzAyyju
         6Nw9yS7oOIhUTegwJLvvnMmmd8JJGO9zMgzugqwcBNR6NkzOg8TZTo3pNW2MCGSj60wj
         TvXiQJgmfax1E8fMrqdwA/8x+ZzOzAeIlt6QDVnYxcGOWjW/3aFUX/v0zQgDcd9JAlh6
         km6w==
X-Gm-Message-State: APjAAAW6wah8O1KLWXiOwyuyzAHFeU7bsg7g7oZ4NCvetDQC5Oh0viIY
        747tFTSrCnYGallqfyf775s=
X-Google-Smtp-Source: APXvYqzMHlXDWxZW/3jPrNt/96ahoooGu6f8sVpoYs+rHds8Honw0tY8c71S8PpAo8bLxh2IziT3yQ==
X-Received: by 2002:a17:90a:8a8d:: with SMTP id x13mr1244687pjn.97.1581544651829;
        Wed, 12 Feb 2020 13:57:31 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::3:533f])
        by smtp.gmail.com with ESMTPSA id r6sm214431pfh.91.2020.02.12.13.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:57:31 -0800 (PST)
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
Subject: [PATCH v2 4/5] usb: gadget: aspeed: add ast2600 vhub support
Date:   Wed, 12 Feb 2020 13:57:16 -0800
Message-Id: <20200212215717.9474-5-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212215717.9474-1-rentao.bupt@gmail.com>
References: <20200212215717.9474-1-rentao.bupt@gmail.com>
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
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
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
index d6f737fac4e2..166d7182e2c0 100644
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

