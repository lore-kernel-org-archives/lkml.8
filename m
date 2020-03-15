Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14569C10F29
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 19:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD086206B1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 19:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyuiwfM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgCOTQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 15:16:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45627 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbgCOTQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 15:16:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id b22so6881097pls.12;
        Sun, 15 Mar 2020 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HxxSTtrSU1OUBJi+Btc1qI+H62ceRlYBsDcUYNsAgNo=;
        b=ZyuiwfM+wsd2yK61TSSDV+f3USkgmEfbIMsJUYYfIVC8c3KUfxDklNV+sc5xGoI92Q
         aYJwJvwcwg7CX3P3cb28svAtzHXPL2Riv93ogQLpl19sQ1YJwt2YFv+UdRsmGn7ScnAK
         fF4djxEVIjoezFqgKUev9mCl3WSKcKZqOWcCRIdwLaGdUFtj0OqTLEU+I8HNmQ3ryMTb
         L1dvly+3xZS5sl6Qd8u38FcbsYmY9eMsbc74lTj6EunNXiof4OJDrLudwGNytTHsLSEu
         Xc4yT6pzYO3qBqobjN12+P4/DS112wgehF1bvbOn3k0TR0wVhWZ4BBDc0on/dmFvY793
         dGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HxxSTtrSU1OUBJi+Btc1qI+H62ceRlYBsDcUYNsAgNo=;
        b=tyrbyDGascpwp+cNn55CtfOFIgkQNDqKEZLrVHQeaKbFBw8pSJ7pNE4mal/93nVBIP
         /Uc0sDkjMm15dKsgeEsR2tjkltwJ+/LNohnDQfdoK24QI3c24COSSlRh9xCdj1qV/Tp6
         Jef7T/jWfZRlZpmfFgcthmQ4h1BZBG3aSoViD1hN7/6nuDSge6R/1xhl/LOWtD2hrlAK
         t7j95LEFIw0qVJ4wdC0wx9ybma4eVQied6tj9Q8D1arx9YTkWcuPJdE+r4FILmIrSmd6
         KnylkqVu7O4mSNIHEnCRVx2N8ekocafZkQXtxYvP77yMjC+3rVNTZUAH/C4/+FtAqMsM
         FaOw==
X-Gm-Message-State: ANhLgQ2BdLMZE+qeD5e9dJviIbXUn8MJU8gJoQqD5J5bFBmstInUhjSx
        gqtthaxpfR0XZtno7D3BVmw=
X-Google-Smtp-Source: ADFU+vvkL4f9mQwxQwHT+G9COHjk//vx+BspxGwPvXJqnCfl+rVs7Od8EQCDULapoatPXSq7AKaI6Q==
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr7409912pjb.186.1584299806362;
        Sun, 15 Mar 2020 12:16:46 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id 13sm61431882pgo.13.2020.03.15.12.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 12:16:45 -0700 (PDT)
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
Subject: [PATCH v2 4/6] usb: gadget: aspeed: allow to set device IDs in device tree
Date:   Sun, 15 Mar 2020 12:16:30 -0700
Message-Id: <20200315191632.12536-5-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200315191632.12536-1-rentao.bupt@gmail.com>
References: <20200315191632.12536-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch overrides idVendor, idProduct and bcdDevice fields in vhub
Device Descriptor if according device tree properties are defined.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
   - update per-vhub device descriptor instance instead of the global
     default descriptor.

 drivers/usb/gadget/udc/aspeed-vhub/hub.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 421631d86a17..13fba91aad6a 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -887,6 +887,26 @@ void ast_vhub_hub_reset(struct ast_vhub *vhub)
 	writel(0, vhub->regs + AST_VHUB_EP1_STS_CHG);
 }
 
+static void ast_vhub_of_parse_dev_desc(struct ast_vhub *vhub,
+				       const struct device_node *vhub_np)
+{
+	u16 id;
+	u32 data;
+
+	if (!of_property_read_u32(vhub_np, "vhub-vendor-id", &data)) {
+		id = (u16)data;
+		vhub->vhub_dev_desc.idVendor = cpu_to_le16(id);
+	}
+	if (!of_property_read_u32(vhub_np, "vhub-product-id", &data)) {
+		id = (u16)data;
+		vhub->vhub_dev_desc.idProduct = cpu_to_le16(id);
+	}
+	if (!of_property_read_u32(vhub_np, "vhub-device-revision", &data)) {
+		id = (u16)data;
+		vhub->vhub_dev_desc.bcdDevice = cpu_to_le16(id);
+	}
+}
+
 static struct usb_gadget_string_container*
 ast_vhub_str_container_alloc(struct ast_vhub *vhub)
 {
@@ -1000,6 +1020,7 @@ static int ast_vhub_init_desc(struct ast_vhub *vhub)
 	/* Initialize vhub Device Descriptor. */
 	memcpy(&vhub->vhub_dev_desc, &ast_vhub_dev_desc,
 		sizeof(vhub->vhub_dev_desc));
+	ast_vhub_of_parse_dev_desc(vhub, vhub_np);
 
 	/* Initialize vhub Configuration Descriptor. */
 	memcpy(&vhub->vhub_conf_desc, &ast_vhub_conf_desc,
-- 
2.17.1

