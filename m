Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39A4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93CC6207CB
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9iYu67I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgEPMEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726202AbgEPMEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:04:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2816DC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:04:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l19so4981196lje.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+L60iwBSEwUxW+0ap8bzV9fQdniPntyNQfnzptKZRE=;
        b=r9iYu67IfwkAgkLhOTC12he6TwetFfDiEz/B/tZcYYQm4FkweliAPliuP9TX3XZQaa
         82EJPnFBBJI5Zzdb5yGg+lzxaSrGIKm5ZUX+Jlx+7l5C9wP1BepU18xFeqd5nWPLoMdO
         D1zuvH0cewG2Dk+eyuOvlLWpDhCLjN/P49b0jhbM4/Bk7q83m4UMnpdvQh2k2vkGMFxC
         MUxuvmryo3dnnyfg3fSGAyt/BEoGsjwnUAakvukqKsBN6fyqCI8Xdh1l5u3dJTliml5r
         LtKC+hmoSZKSYineGUGlFty18NZx9T3NMEtXMRmfozgJE/pBB/eCjGp+Tkoqkin+OHwo
         +ytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+L60iwBSEwUxW+0ap8bzV9fQdniPntyNQfnzptKZRE=;
        b=OiEH6IQ4dVblHlUqPe0OOHdz8oT5Vkocf6FLkD40Zr8RZdxtLNhyAApmHkwS63xetS
         YiBGMONRdRJ34lZyegQTM2TzYp40aTxW21pNfhZKU2UaBtJcafQmsnL5tYAwpmntBWiV
         8VDelLeCKVp6Z+YzINxK3VC46rGHOhFEfDte+VFh/sWasZUURMNvHXPUeL4TjMotgH5j
         rkhXMw0WkWDWQ5FKf7Uw0uK+CA7KHidIzJtt/gjE90qt2ZB3oWOlEo61OT/tTs6z5GnM
         39zXm143hPiNG4dhv5uVaEvqKC43wAEnW9Hxqee99Y2DLYMlRJ83a5w+i8gTJh6xwL4c
         qusg==
X-Gm-Message-State: AOAM533xo3vMOoaIirkfxElngYV4eH4O8PPWNPJgvYvzm0JfmxhA/VOO
        d89rnh3mIA6Jy1E0qvnl5zg=
X-Google-Smtp-Source: ABdhPJxjbLIDtNZ2P7eetMazfyLWq+d+yggCbqto8JfqiRhWNkMcv/XlJjzkwImEO22T4FmSShGsfw==
X-Received: by 2002:a2e:7004:: with SMTP id l4mr5075710ljc.208.1589630688577;
        Sat, 16 May 2020 05:04:48 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id r20sm2581538ljj.44.2020.05.16.05.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 05:04:48 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, alcooperx@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/3] phy: phy-bcm-ns2-usbdrd: Constify phy_ops
Date:   Sat, 16 May 2020 14:04:39 +0200
Message-Id: <20200516120441.7627-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516120441.7627-1-rikard.falkeborn@gmail.com>
References: <20200516120441.7627-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phy_ops are never modified and can therefore be made const to allow the
compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
   7831    3144     128   11103    2b5f drivers/phy/broadcom/phy-bcm-ns2-usbdrd.o

After:
   text    data     bss     dec     hex filename
   7959    3016     128   11103    2b5f drivers/phy/broadcom/phy-bcm-ns2-usbdrd.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
index 7ceea5ae2704..527625912b78 100644
--- a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
+++ b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
@@ -279,7 +279,7 @@ static irqreturn_t gpio_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct phy_ops ops = {
+static const struct phy_ops ops = {
 	.init		= ns2_drd_phy_init,
 	.power_on	= ns2_drd_phy_poweron,
 	.power_off	= ns2_drd_phy_poweroff,
-- 
2.26.2

