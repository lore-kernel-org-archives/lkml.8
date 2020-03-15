Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC26FC10F29
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 19:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F777206B1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 19:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdX3ezZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgCOTQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 15:16:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36456 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgCOTQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 15:16:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id z4so2581051pgu.3;
        Sun, 15 Mar 2020 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3ftgzhaTcHumF1wl+zxzORyRVylT4QiROgG963NJrxE=;
        b=hdX3ezZpi2YDHwnAS48I6J3zhHF57KyVQEBULjcqbwkHFINN8RzdAuYHF+cUFowEes
         mdKXHoyh+/52Pe0RTFxqWSExz0pu/J1uqEIGvu19LZNHKRFNhFNrAjO0vGFl7ju3D8N8
         77cefLPQeOOi6MRIAHATQ6Av1T4CfP7YABlRNQ3VuqYtLcHIensCUFskH3AjIFmx2/No
         fGKi2qeuqm79wR+0YyTzJx+aLGCbK/llUxsSLHGJ1DP2USQs7vPJ4jdTOmPbFlxHNCgo
         jKyeGjUFj/HvPHvWh6CeAiC2JdKCGtyNRN6JWKOVXQOdGlv8azQgRm7fvYfyDcK+L3sy
         iEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3ftgzhaTcHumF1wl+zxzORyRVylT4QiROgG963NJrxE=;
        b=lh/K1iXLKs+NVkCLpiHeD5cvogUHUo73rJW0997Zbv7u81Pwauj3MTRyzqM7nEYCAJ
         oh+LAck3zYNyfEyAOp1mSOfIf8Pk6+zM3W0LHkG5oGBCAfgFSVEaeBY+k74mzey7vfGb
         7AWQtOJR4/iXvuInLoOhWVhQbYjw5Co8xcW2A9qgA5y00ulrMO2itvsuC6JvXunsi0Pi
         Y10qZgxCK6fvo6ELUyR0lu/7SuLXKkQBIbjllx+rKWqKJ3WyS3UbNxIUCCUtpCc/rP3b
         bos67ncEDLjp2F09+HRObc3lv6fUQMEkN191d4aaYwqFoFw5QlScOpIZ/Xmw0hiyOjni
         05XA==
X-Gm-Message-State: ANhLgQ2HFn4p7JZo8Wka6toUKxrmSL6yEB9vCt/ZuJ3tDZIshCZeleyE
        NTGGJxwYC46IT31pojXCSoA=
X-Google-Smtp-Source: ADFU+vsIuGJ6NC3/lmhKrZurUH9P1d3lFbOZv5wVLK0E+vEjIvVQ8KXp+19oTFLLGwyXkL+Y/LD/kg==
X-Received: by 2002:a63:3d45:: with SMTP id k66mr23203589pga.56.1584299808334;
        Sun, 15 Mar 2020 12:16:48 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id 13sm61431882pgo.13.2020.03.15.12.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 12:16:47 -0700 (PDT)
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
Subject: [PATCH v2 5/6] usb: gadget: aspeed: fixup usb1 device descriptor at init time
Date:   Sun, 15 Mar 2020 12:16:31 -0700
Message-Id: <20200315191632.12536-6-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200315191632.12536-1-rentao.bupt@gmail.com>
References: <20200315191632.12536-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This patch moves patch-usb1-dev-desc logic from get-descriptor handler
to "ast_vhub_fixup_usb1_dev_desc" function so the code is executed only
once (at vhub initial time).

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
   - update per-vhub device descriptor instance instead of the global
     default descriptor.

 drivers/usb/gadget/udc/aspeed-vhub/hub.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 13fba91aad6a..6497185ec4e7 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -73,13 +73,6 @@ static const struct usb_device_descriptor ast_vhub_dev_desc = {
 	.bNumConfigurations	= 1,
 };
 
-/* Patches to the above when forcing USB1 mode */
-static void ast_vhub_patch_dev_desc_usb1(struct usb_device_descriptor *desc)
-{
-	desc->bcdUSB = cpu_to_le16(0x0100);
-	desc->bDeviceProtocol = 0;
-}
-
 /*
  * Configuration descriptor: same comments as above
  * regarding handling USB1 mode.
@@ -303,10 +296,6 @@ static int ast_vhub_rep_desc(struct ast_vhub_ep *ep,
 	if (len > dsize)
 		len = dsize;
 
-	/* Patch it if forcing USB1 */
-	if (desc_type == USB_DT_DEVICE && ep->vhub->force_usb1)
-		ast_vhub_patch_dev_desc_usb1(ep->buf);
-
 	/* Shoot it from the EP buffer */
 	return ast_vhub_reply(ep, NULL, len);
 }
@@ -907,6 +896,12 @@ static void ast_vhub_of_parse_dev_desc(struct ast_vhub *vhub,
 	}
 }
 
+static void ast_vhub_fixup_usb1_dev_desc(struct ast_vhub *vhub)
+{
+	vhub->vhub_dev_desc.bcdUSB = cpu_to_le16(0x0100);
+	vhub->vhub_dev_desc.bDeviceProtocol = 0;
+}
+
 static struct usb_gadget_string_container*
 ast_vhub_str_container_alloc(struct ast_vhub *vhub)
 {
@@ -1021,6 +1016,8 @@ static int ast_vhub_init_desc(struct ast_vhub *vhub)
 	memcpy(&vhub->vhub_dev_desc, &ast_vhub_dev_desc,
 		sizeof(vhub->vhub_dev_desc));
 	ast_vhub_of_parse_dev_desc(vhub, vhub_np);
+	if (vhub->force_usb1)
+		ast_vhub_fixup_usb1_dev_desc(vhub);
 
 	/* Initialize vhub Configuration Descriptor. */
 	memcpy(&vhub->vhub_conf_desc, &ast_vhub_conf_desc,
-- 
2.17.1

