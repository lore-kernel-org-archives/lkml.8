Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E595C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A78E2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KObRodab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgDVKK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbgDVKKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:10:18 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BF3C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:10:18 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x23so1180894lfq.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C6DnVKRB6NIRjwPWAXMLQ0NJgkEo62OoeU3KPTioqDw=;
        b=KObRodabLDVnh1RpbkhyXvi3gbBuwT9PIEfxCQHFdpvCFUN4d+kPA4VAHcRZ0RmfVZ
         4wIxqA6/QeN4pIEGPxiruC+Wizaj1UgClk2twBJwLYA2KBkeFCQVRwwAjmdMB/BoSkB6
         r0AGQiT09nh4MdZh/BYj9bHL+W2gJtzl2/Z/wSMvMN7E0k10z4EmkCrpKMeu3+5jfc98
         JQsmBEmWCQqQBBzMEAC9wIQz0e2+Tu9TzKVjO/TR1zp3LnZK8eP8DzkVpWzZzZeasvxE
         +Ex9E8rxacadZ+yRRA/FMveBBk1RwMPUPgpDv6wlQi9J/i9v18jGoBlxjLEMNJRwtqTs
         wGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C6DnVKRB6NIRjwPWAXMLQ0NJgkEo62OoeU3KPTioqDw=;
        b=UIzK7rwodqyoqdMr3nWCE3KEHUbY9NR1F3clstPO4YXhtumsWlJVKECyPCHtRtJe6O
         4ID85BfytclSgqZ0AioOud2W2u0YCt+/9MzllXbGtuD6zGlAM1+VU3O6L/Jvrip+J7P8
         Jb1BCZ3ohc7vC9XHBTTEW/0VsGNng41plI3yrH4Nr2BlIB8ktLOBNIpctPEOeo+K0Odz
         HzMtVO4mKxjwyOc/5NjHVJ3VfDKiasGrkKTLPVuNOuvvsqXGjMp2wa3yKeB0YmW9b8zu
         Jsiyif2F2XGH0bM/tjVmIaeMQJMu0Gr+VlOk6GjZgWl8/DVWc+oiApacoWdVJ4kKRJ0i
         V6Eg==
X-Gm-Message-State: AGi0PubL0MGjTMnpKFBX8y4W15nSsc8MwyveNq16HUhaG6lHz0FlJ+lP
        vGIoCLtVEdzZKiu4OQtsdfN9Yg==
X-Google-Smtp-Source: APiQypLiEWMoI272TzvgNnpPzocl0qlAVahabYTkLZn37KAuy/71WeWwggv4+DDRNoenNgGXkegsaw==
X-Received: by 2002:a19:ee11:: with SMTP id g17mr16425495lfb.42.1587550216225;
        Wed, 22 Apr 2020 03:10:16 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id s6sm4246018lfs.74.2020.04.22.03.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:10:15 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vinod Koul <vkoul@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>, stable@vger.kernel.org
Subject: [RESEND PATCH v2 2/2] amba: Initialize dma_parms for amba devices
Date:   Wed, 22 Apr 2020 12:10:13 +0200
Message-Id: <20200422101013.31267-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's currently the amba driver's responsibility to initialize the pointer,
dma_parms, for its corresponding struct device. The benefit with this
approach allows us to avoid the initialization and to not waste memory for
the struct device_dma_parameters, as this can be decided on a case by case
basis.

However, it has turned out that this approach is not very practical. Not
only does it lead to open coding, but also to real errors. In principle
callers of dma_set_max_seg_size() doesn't check the error code, but just
assumes it succeeds.

For these reasons, let's do the initialization from the common amba bus at
the device registration point. This also follows the way the PCI devices
are being managed, see pci_device_add().

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: <stable@vger.kernel.org>
Tested-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c       | 1 +
 include/linux/amba/bus.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index fe1523664816..8558b629880b 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -645,6 +645,7 @@ static void amba_device_initialize(struct amba_device *dev, const char *name)
 	dev->dev.release = amba_device_release;
 	dev->dev.bus = &amba_bustype;
 	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
+	dev->dev.dma_parms = &dev->dma_parms;
 	dev->res.name = dev_name(&dev->dev);
 }
 
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 26f0ecf401ea..0bbfd647f5c6 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -65,6 +65,7 @@ struct amba_device {
 	struct device		dev;
 	struct resource		res;
 	struct clk		*pclk;
+	struct device_dma_parameters dma_parms;
 	unsigned int		periphid;
 	unsigned int		cid;
 	struct amba_cs_uci_id	uci;
-- 
2.20.1

