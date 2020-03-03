Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E7DC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B568C21739
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2ev026E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgCCGXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:23:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43734 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbgCCGXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:23:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id u12so1026644pgb.10;
        Mon, 02 Mar 2020 22:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lFzezbgly821hZw00oikD/AE/FsI5IqUTxbG0Oja4KA=;
        b=Q2ev026EawsJ85PvppOvYO+mZKcxl1rYkm0COMir47W+yf7TRR2dtZsMLOvP+UMScU
         xS9L6F+BPNybR2G9IXZhRxvCLx3Q574FJN6F37LpcOsMrf9n1q9vldzDujO8n6b4oj0x
         eswTQm6axlN5xjSAnBK+K0uuF7wf2XAjklFRJlb4IXtE8fkn+rDLs74YWTMLy8nGaE/Y
         h8o5F7SqarVuydI1WYyukWahoxsqfzmu+OctGVGQp0da16nmB9uDLGHLaSvP7g1nyQ6+
         CGxPlb5753cz7g4GeFsMn2DvpkSkV+dq8AUYcz/wTU5ZvLN0vZly96dBtkTfswyyZYN4
         2XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lFzezbgly821hZw00oikD/AE/FsI5IqUTxbG0Oja4KA=;
        b=B/CzGt63khCPKT+khCHadcrRadn6Ut4vtYCBgMJ/gDU9dgf+16Tme4MMdnbE8xgyd6
         bx3AO2PDFU4CyD8lEXaxo0wl8dHYxIw12BSZdejH7DrHCYWScP0mtrH/YTc7k9wj6gyS
         ebvp0XLOtrinRjz42CVNcPfWGNk+dSgf6rIvfZ4njdtHfToZb5HIzjrJhKuQcjs9B6yF
         VSlCPQz70B0ZKWN+uVkKE5x38kRcjI5T9gkqigoWz0u7mYJobItuh47awRvJUAWA4PsA
         Oyh6nU8wjNii6XGEf80bmFCFG+fm907cRX8xvDYx5xJUEym3s6lNYrU9YtOhBeoe2bC2
         VM3A==
X-Gm-Message-State: ANhLgQ2Z8UroYYX7hq+RhBv3hDjsiCFtn4zxUx7QgaXsjvJAjjN3iJnZ
        Cit1mTW9PdODBHSkWa9PJDA=
X-Google-Smtp-Source: ADFU+vv2fSMb6IsU3yZJKIeBgC4S/mzJAkC13JfKcx/EFBGA3G4AC7izihv2YSh16vWsaLOKFpyJKg==
X-Received: by 2002:a62:1682:: with SMTP id 124mr2672356pfw.107.1583216630225;
        Mon, 02 Mar 2020 22:23:50 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id k5sm7453526pfp.66.2020.03.02.22.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 22:23:49 -0800 (PST)
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
Subject: [PATCH v7 3/7] usb: gadget: aspeed: add ast2600 vhub support
Date:   Mon,  2 Mar 2020 22:23:32 -0800
Message-Id: <20200303062336.7361-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303062336.7361-1-rentao.bupt@gmail.com>
References: <20200303062336.7361-1-rentao.bupt@gmail.com>
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
 No Change in v3/v4/v5/v6/v7.
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

