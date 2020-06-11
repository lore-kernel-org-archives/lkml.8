Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7F1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D972207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vg9yinuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgFKTIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFKTIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:08:21 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1756C08C5C1;
        Thu, 11 Jun 2020 12:08:20 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id r16so3149959qvm.6;
        Thu, 11 Jun 2020 12:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G/T0L3vtmfhfUZJlcR7h60nF+XO/Ie4LghE2fvgkbZM=;
        b=vg9yinuUP/HhgCq8yfP7FEWTkmybKE2b+XeVxLwefQjCm6y3CB4EmMHl4RuVNNAxLd
         XYFhJxnArnLZs0XWQDp+mICxNvkFi9O0ux1vcYVBAB/iPYsSpOJOgL6FNAL/TKTq1bh6
         pRTUx/aFMlryBwKz6+cIiuiDoJ0hK3KGf3aDwd8G7ouGUrBE9shN/MqSVTbhhBbT++PI
         IRpk7ME4+J4Ssuq5QH1wcuC4kR4lyQLXrjMaD26jNrLSnLQ8vKhTcGXVcEiiIFvjMPbL
         IK81BOeiBVH49ySOJLvBQfmidQfrrLYYZpqbqSSNcbnaplezFEvD8XcaesdY9FCi03tz
         AeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G/T0L3vtmfhfUZJlcR7h60nF+XO/Ie4LghE2fvgkbZM=;
        b=ZtmrWk2qFZv8io8Z0P5xLBnE3VtLq1T/s2CAaSAguvzWVLhWm3V9fN0wOCPnvEMWjt
         FXJpypteQcozyZvccvKD1onuw1vsJfE9OEbiPfaT+CNAFnSEUb+iokadTU+IZT/Fet4C
         UXhIvECIJoZSY4CUD5VCfYrAZ10C023Cazqq9t/hc1nwn3bEjrH+t09DvuEsSFLbNa/Y
         JTMyDkUjZ7ZGbP1hZe38tpNM9SY/L8qTaZWpzJTPpVowS6a4oB1a9QYPiKIub9bgnJsQ
         pG90O6XeOlcv8AJChISrVny1ZKKCZGhVQBiUVCK/GNRLKwYlsR/b/rg+1/WDbm079/po
         dpFw==
X-Gm-Message-State: AOAM533Pk8YTToPYtHo3BO9M0toym7N+6IwXKVqtsV9bc1CO5FM4dl66
        qowWmnbE1olOak7bNtJl6g==
X-Google-Smtp-Source: ABdhPJzuUKhQ868DWJe9bQUBbkJhKQua1fhg9xG/Y5OVYD0wDtB0q0ro05v/YHhsdN5HykXGB7MRCQ==
X-Received: by 2002:a05:6214:852:: with SMTP id dg18mr8874834qvb.97.1591902499025;
        Thu, 11 Jun 2020 12:08:19 -0700 (PDT)
Received: from localhost.localdomain ([142.118.26.59])
        by smtp.googlemail.com with ESMTPSA id r138sm2783743qka.56.2020.06.11.12.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 12:08:18 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keyur Patel <iamkeyur96@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memory: tegra: Avoid double error messaging when IRQ absent
Date:   Thu, 11 Jun 2020 15:07:54 -0400
Message-Id: <20200611190758.172605-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 7723f4c ("driver core: platform: Add an error message
to platform_get_irq*()") platform_get_irq() started issuing an error message.
Thus, there is no need to have the same in the driver.

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 drivers/memory/tegra/mc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index ec8403557ed4..f519c0987485 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -659,10 +659,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	}
 
 	mc->irq = platform_get_irq(pdev, 0);
-	if (mc->irq < 0) {
-		dev_err(&pdev->dev, "interrupt not specified\n");
+	if (mc->irq < 0)
 		return mc->irq;
-	}
 
 	WARN(!mc->soc->client_id_mask, "missing client ID mask for this SoC\n");
 
-- 
2.26.2

