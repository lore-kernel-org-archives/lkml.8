Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A3FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594E62074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1AKKFZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgFCSix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:38:53 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43C1C08C5C0;
        Wed,  3 Jun 2020 11:38:52 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id g3so3509386ilq.10;
        Wed, 03 Jun 2020 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HjgVWrBWVT0twpsY0vgaif1i7hN5ZprKgZvtaOQKzUs=;
        b=I1AKKFZMeK1YEzuTNKcnLA3JOHFG0tIG3R/uXzyavGnMGrvdAJX/ZbNCZmHVzBn3Yc
         K42ytLQi5NFbuolF/REyCTzvKO7MssO8BaFtsozv/Y6qFRFCqjIclg2idzbq7RB0t0JO
         wAkV1dpmdAua7PHNs7lJMUCut5zinWybHTyKlWXlj3ULsnk/rNlIY7+qjTl/EGt5/4ZY
         BHi/XuuAeynnjrvnDEz8WfhX0WPlkqKyg2UVtT6ESNlDk0kbUDn+EuVJzE9GdHChLwPq
         DduSzWtruKSAroRIieUTz9W6xlMgMGp89FnM739WTLAggOhjKadOICPNCuTIdJ/WhQDH
         alsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HjgVWrBWVT0twpsY0vgaif1i7hN5ZprKgZvtaOQKzUs=;
        b=H2ohrFU0MXL6rij8dzYO7MxQIIZmtBcV96XbHtQjd3vQBYmCWFA2j4WskXF4Q8Q3BD
         l/uOFbpwv6H1GHEsoUWrISmz/HnDhym0qwsEDZDmhnTLjrOE9Zflya77hDcGd/CZ4n69
         szJrQgZWkoevrWQUKsRrhHSmNlw/p/2jE4D2Mhkxc0Ennq0NU9wHyA1a2mg1e+3Fp1uF
         aNhM1xcxyUg/1FzUxiM2FEj8e81hb+nbGQUYF0J9H5FAG4nL/9xObO7H9fZSWqrazlO5
         VIe5cFz9mo5gjvhqIuAc8HERBBsxSGHmwxrW3fkC2mmX433iiWyL6A5fMosj8WHM0T61
         oc0A==
X-Gm-Message-State: AOAM530sjN1MB4JZ8mmIuzNVY4pbYq3c2ksJyM0DXZShLIVQCuJy/xCh
        RYX8yjw8ACfd/Loc+pOniCw=
X-Google-Smtp-Source: ABdhPJzbjE9uEtjcuStaUOU67vAfYISHKtDPYInMzSLaEeYjlxomPWnavMGCSwbGXfuwy9M18C7FcQ==
X-Received: by 2002:a92:5856:: with SMTP id m83mr887898ilb.72.1591209532255;
        Wed, 03 Jun 2020 11:38:52 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id u66sm170685ilc.61.2020.06.03.11.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 11:38:51 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] dmaengine: tegra210-adma: fix pm_runtime_get_sync failure
Date:   Wed,  3 Jun 2020 13:38:45 -0500
Message-Id: <20200603183845.91054-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/dma/tegra210-adma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index c4ce5dfb149b..87f2a1bed3aa 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -869,8 +869,10 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_sync(&pdev->dev);
 		goto rpm_disable;
+	}
 
 	ret = tegra_adma_init(tdma);
 	if (ret)
-- 
2.17.1

