Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4292C35246
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D65206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/zhBBvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgA3ElW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 23:41:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36560 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgA3ElU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 23:41:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so2590969wma.1;
        Wed, 29 Jan 2020 20:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yfyyd1gAYNfQRVTzzie9M6MUShefAhN4x9LLDsJ6WIA=;
        b=b/zhBBvEkiqBLRnuBsQqkOSQ05OiHftspU0dRqgfqYQT0Y0urOdgkaCAiBBBNDv4Ms
         910Uv3hw+ok892zm/E9KbW89ch5kb3DQt1FQsfjOxHiUB9LfbaG2LQLOzFLE46x6G67E
         qsJbqP8GEFrf7UE8A7f6642cWadsUUap+ICqBIApxipyg2nb2gSZPNVfVCFL7mTgEkOC
         pqtmO5UQiTBKlxdVbATQW6Z64HjgIgeY8Qc/tjexDmMJGszqwT2e4qxzqEQxNgTPh6hW
         16qT7sQ6juAcZ55yLGTcv5/yMFJMqmk6m0zx32R2lU7k4UhB0x/hefRKUpCaJk1sgfXj
         +TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yfyyd1gAYNfQRVTzzie9M6MUShefAhN4x9LLDsJ6WIA=;
        b=VIH0dnNM1g0kQQC0TLYBZmVVDrnceu+kiAHP7hraCqMvbzG9Bxo8AC3Gwupn/5GGfx
         802Cre/lA/gMcZAPNvfLPGAH3bkTBmau8t1HfxHfWUZ+9D4uK6MxbEVRwiXjWtpk/6bE
         VpSF0Drz9KStifUMvKuEBwEyu8uOodzF+aZJOocnrooNxQLs2EQ3VX+oGFuNeKxbTLt3
         bPc5WoFDGV1PKq3L6G4NiM2pP/xFReYPOfOu2qIOWBedInwSEEURdTAIJamjSMIFH/hK
         6UQeBOpXi4VMgE/nUFYWja7IR/nwVIyyRoa8cuxNQv/NSIJZmes5LIGFjoX1WdImkrSm
         tv6g==
X-Gm-Message-State: APjAAAWNE8Ookpn/QdZwmSW5ZLr7B3B+/oOYzbLf0puzcEhjeSnXc4fE
        h1jcaDDnua7qmqrPg9fZ9wk=
X-Google-Smtp-Source: APXvYqxi631LSRfQwLHKRoolj2ZGsh7ydqUCGdJ1YVi2DoxjifQS+CN4On6A6yszOV8H4mEM/fWOLQ==
X-Received: by 2002:a05:600c:2406:: with SMTP id 6mr2948859wmp.30.1580359278245;
        Wed, 29 Jan 2020 20:41:18 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g128sm4494672wme.47.2020.01.29.20.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 20:41:17 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/16] dmaengine: tegra-apb: Use devm_platform_ioremap_resource
Date:   Thu, 30 Jan 2020 07:37:54 +0300
Message-Id: <20200130043804.32243-7-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130043804.32243-1-digetx@gmail.com>
References: <20200130043804.32243-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource to keep code cleaner a tad.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index aafad50d075e..f44291207928 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1402,8 +1402,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	tdma->chip_data = cdata;
 	platform_set_drvdata(pdev, tdma);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tdma->base_addr = devm_ioremap_resource(&pdev->dev, res);
+	tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tdma->base_addr))
 		return PTR_ERR(tdma->base_addr);
 
-- 
2.24.0

