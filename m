Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39542C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1701120659
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBB2oy+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgFDULM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgFDULL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:11:11 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69A8C08C5C0;
        Thu,  4 Jun 2020 13:11:11 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u13so1597458iol.10;
        Thu, 04 Jun 2020 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Pi/zBjFq7tRVG33YykVUtKHdjWOyuCQKzTlU7tlBF7U=;
        b=lBB2oy+l9vqKat9u2vnCdAL9M0TQDIpPrMh2tdRpHEtN5UkRxct6thh3HTVUB5oWNo
         81Bl4/TFBla4jrWCUtz0xisKmElWSnNBbpKe/dZQdRTdv9wT2/FZoJhYqBf365Bm8MR4
         Umev2czrKdMGVMVe+FyMaEIurlOhjPO1DCWF76EZZapzggrjoFWwHONdFU8fmbYl0HY6
         9uG5jey4zXI9w3BlUcdN4zK5jg/8VGXcqB2eir2FIpxqFQZv46ADedjjemkbiOJNenCS
         laNrSq6I6WsNST/2eBdxW7duNc9lLLStJ0W0MwXO33KysyHnQRCVPoVw6nrCDqGr99Ac
         t9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pi/zBjFq7tRVG33YykVUtKHdjWOyuCQKzTlU7tlBF7U=;
        b=ECgXhC+zluTpJolnKhUwinEYsqiszFofsTf2jFXkYzE1jjVha6Uxa7P2MGqKZzAeyn
         ZY7xguURv2HqX5p/I/XGvTpQG0bRjycy84VuCCzNAIl2aVJUUoMBb8c93vepkbH8oH0m
         Hs/YZuQVzoqa7Tsafz0p0sDsMyvL27MXDLfM44HKbHqogW4OjWbIOUgxoIBw8/y7yS2D
         QiSLKiI4+i0UidgATiBclEZXVDgmJAElxOjM2DjLyW9IhmToiqqoJLjtkTPH8VLnYRfo
         nPDGtqm6KefHlzWQOBnRbxck9fyMjRC02HAuTxC0SLiyc5mQqBGiZmRfRfyl+KbdX7SF
         G2Yg==
X-Gm-Message-State: AOAM533wtUwWRzOHxRIpeHrK+VaylbxxAItPN01mY5bxWR2pTS38qE0w
        /ofAlx1Ob7+/AtWNvvqBT8Q=
X-Google-Smtp-Source: ABdhPJyMVZut24SMKLBXsgjpmcZScbs8OJAuqugOBN1c33TeRW2hoM6Y6/wbK3+sEOAYlEPS1ykATQ==
X-Received: by 2002:a5d:860b:: with SMTP id f11mr5441744iol.104.1591301469814;
        Thu, 04 Jun 2020 13:11:09 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id w18sm1936296ili.19.2020.06.04.13.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:11:09 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu,
        mccamant@cs.umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] dmaengine: tegra210-adma: handle pm_runtime_get_sync failure cases
Date:   Thu,  4 Jun 2020 15:10:58 -0500
Message-Id: <20200604201058.86457-1-navid.emamdoost@gmail.com>
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
 drivers/dma/tegra210-adma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index c4ce5dfb149b..899eaaf9fc48 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -659,6 +659,7 @@ static int tegra_adma_alloc_chan_resources(struct dma_chan *dc)
 	ret = pm_runtime_get_sync(tdc2dev(tdc));
 	if (ret < 0) {
 		free_irq(tdc->irq, tdc);
+		pm_runtime_put(tdc2dev(tdc));
 		return ret;
 	}
 
@@ -870,7 +871,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
-		goto rpm_disable;
+		goto rpm_put;
 
 	ret = tegra_adma_init(tdma);
 	if (ret)
-- 
2.17.1

