Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10FFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DEE2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF0kMaXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgE1BMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgE1BMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:12:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0768C05BD1E;
        Wed, 27 May 2020 18:12:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so10831475plo.7;
        Wed, 27 May 2020 18:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YeymCYJxoRhG3T4Xxmf2TbPWXKoHneVDsox17Vc/EmI=;
        b=SF0kMaXBitrTfXs4ZYGL0gj3rU3facXD9Z2fTnLLHkcmaelUp4j2JlQxp0kJdzFUjc
         MFxy8X0b+8eBqTreQbnNvD1iIZjyLpLsDWTMXyrR9oFv/PhAbPXcLSGAgh0MnZ7mh5qM
         5kq+IwiSeCKTtTNiKSv6Ed1nL43SC+4g0HY3BT0kgs3Hdrssj46/+4FGcbAre1o5of1T
         bl1yOBNY0mJhv/nL+NVWjIbezYFYztnlEd18gTY/FRsl0gn4cZtTUpVHu6rZ/C3jxrzs
         rqHH1ko28u+HcZ3UNrY2cTskl/pmAlTvOCtLGF/zRlsWA9YWkdUJoHvY1SFbDlSv6Rza
         3VDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YeymCYJxoRhG3T4Xxmf2TbPWXKoHneVDsox17Vc/EmI=;
        b=lCncpQAl86hsn8qZAwpmeQ2UYhSNfMKFIeYZqtv+U+XWl81Qj7q0Gx0f7esyvV6EFz
         PDdeewY3gMmgsxjzFoTXFJ8HLMcAoXNthScWjrRiM1xNFjeXhwlZ2qAoeHenzImzj8uO
         fcAo1hggtp64sKN4lQAYKSayQWV1fOV1K5gqCxfVLpzubpZXHG2AXiYqbLZwwopkYXw+
         bVteEv4bIkJMFYb+vDGUYAtuLgEuIhvvm5NCgJIVD+9l8omtK8odCfihqGl4G3f3P9+g
         1sfNxcrPCvkRku6NeiZKsQMOs9jSyYrhNHwmqHKaK83UE6yJyFNp7JSVGgB3cifUsfKh
         cpRw==
X-Gm-Message-State: AOAM5305iFfwEB7Fchl6NM4/C377pZpmXgQH8hW0SJjoBnjdegSyVOr0
        klCz7nOyNAZqIO3WAx4rTBQ=
X-Google-Smtp-Source: ABdhPJxiQddCciww8Rxr4ZOsS/vmlkqh3e2YpWcsPfwemQowQSJHNJrEY+SgMOJGI4e8h5u4/A597g==
X-Received: by 2002:a17:90a:dd43:: with SMTP id u3mr1018695pjv.221.1590628327909;
        Wed, 27 May 2020 18:12:07 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:400::5:ccc9])
        by smtp.gmail.com with ESMTPSA id gd1sm3570640pjb.14.2020.05.27.18.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 18:12:07 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH] usb: gadget: aspeed: fixup vhub port irq handling
Date:   Wed, 27 May 2020 18:11:54 -0700
Message-Id: <20200528011154.30355-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This is a follow-on patch for commit a23be4ed8f48 ("usb: gadget: aspeed:
improve vhub port irq handling"): for_each_set_bit() is replaced with
simple for() loop because for() loop runs faster on ASPEED BMC.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/core.c | 10 +++-------
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  3 +++
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index cdf96911e4b1..be7bb64e3594 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -135,13 +135,9 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
 
 	/* Handle device interrupts */
 	if (istat & vhub->port_irq_mask) {
-		unsigned long bitmap = istat;
-		int offset = VHUB_IRQ_DEV1_BIT;
-		int size = VHUB_IRQ_DEV1_BIT + vhub->max_ports;
-
-		for_each_set_bit_from(offset, &bitmap, size) {
-			i = offset - VHUB_IRQ_DEV1_BIT;
-			ast_vhub_dev_irq(&vhub->ports[i].dev);
+		for (i = 0; i < vhub->max_ports; i++) {
+			if (istat & VHUB_DEV_IRQ(i))
+				ast_vhub_dev_irq(&vhub->ports[i].dev);
 		}
 	}
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
index 2e5a1ef14a75..87a5dea12d3c 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
+++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
@@ -67,6 +67,9 @@
 #define VHUB_IRQ_HUB_EP0_SETUP			(1 << 0)
 #define VHUB_IRQ_ACK_ALL			0x1ff
 
+/* Downstream device IRQ mask. */
+#define VHUB_DEV_IRQ(n)				(VHUB_IRQ_DEVICE1 << (n))
+
 /* SW reset reg */
 #define VHUB_SW_RESET_EP_POOL			(1 << 9)
 #define VHUB_SW_RESET_DMA_CONTROLLER		(1 << 8)
-- 
2.17.1

