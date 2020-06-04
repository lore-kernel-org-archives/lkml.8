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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9FFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB6D2067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvglNati"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgFDUbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgFDUbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:31:10 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA48C08C5C0;
        Thu,  4 Jun 2020 13:31:10 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y18so7888645iow.3;
        Thu, 04 Jun 2020 13:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1y9+v8Zse1/fm+EdYKqvmDNnlC2PLMsLjmR6tfks32E=;
        b=JvglNatiArVj99EcpKmtASWLGtM+OjNzl4S+TMj/HAfWFzIWWUxPM6HWzBdWK16jPN
         FetsAWyxhZ5wxWRZ+VwdN7zpZBJ64QJE87y/qbKe9cMvM4OrWpZBbBJuoMhhUmTrNvwE
         eWWndF2SIaHnYIy4R5Gn4mQZOWC7RCGow4hhMUZKZ7qBafGrtNC8D/P6iL7AcQnxh3WV
         r3DdRqdLPkihEYKSsPwFn6W3HDgAjLWmt/Ci4HQJ65O0tKnZOY0x2HiDribQ/n4Wq/Oe
         4WL/1RczuV8hAKqdl3Bwre8BV9omXsQL8FtuNzyy6H3TjpdZlEiBpVLMHROblT8qE4Uv
         WDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1y9+v8Zse1/fm+EdYKqvmDNnlC2PLMsLjmR6tfks32E=;
        b=jdwWJIJWwKEU8Y+fYxcFZcbE2L7PLAwaACe7PT72WD0hE6lvdiNIapOn1tiIOpcuYA
         EJFNcSfkUsWFgLT8sldakszLl3uIvCIaQXw0mflJbobGxZwbDm9RA6DWiZaHwERsYbC0
         GQzaZP9FoZ6aPDdYPSd/P9Db+Uv2/u7NAm+BCZA6FBveEAQ2Y/nI4An6Hj8XXAUMkc/i
         uFXlk43a5FkZ0PoUFqS1RY6yt4WTt365X0cB0iLTGP+laa5Uk41ht2FaYjsy347Zv9KU
         NuAV8JvUJkOHaTcqdWcBPgOXyTGNgJrTw31orr15E6r1wlLO8iGIYn+5jA4a9cCFnx08
         3OuA==
X-Gm-Message-State: AOAM533grJbOjj4DV1Puoh5hgeEOotlCpBIPm8CMNRtJ/Qvihntj6EVM
        e54764U74h2oGkGwiPbUvu8=
X-Google-Smtp-Source: ABdhPJz7WsTouSbk2KulrP4/FiAhwzQwzcmUqS4m+OkWqaj9p3tCPnSF/XMJCyNphhzd3Zv7HZIvHA==
X-Received: by 2002:a02:b88e:: with SMTP id p14mr5745455jam.36.1591302669452;
        Thu, 04 Jun 2020 13:31:09 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id d11sm314373iod.11.2020.06.04.13.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:31:08 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu,
        mccamant@cs.umn.edu
Subject: [PATCH] dmaengine: sh: usb-dmac: handle pm_runtime_get_sync failure
Date:   Thu,  4 Jun 2020 15:30:57 -0500
Message-Id: <20200604203059.964-1-navid.emamdoost@gmail.com>
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
 drivers/dma/sh/usb-dmac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index b218a013c260..43511434c90c 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -797,7 +797,7 @@ static int usb_dmac_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "runtime PM get sync failed (%d)\n", ret);
-		goto error_pm;
+		goto error_pm_get;
 	}
 
 	ret = usb_dmac_init(dmac);
@@ -853,6 +853,7 @@ static int usb_dmac_probe(struct platform_device *pdev)
 
 error:
 	of_dma_controller_free(pdev->dev.of_node);
+error_pm_get:
 	pm_runtime_put(&pdev->dev);
 error_pm:
 	pm_runtime_disable(&pdev->dev);
-- 
2.17.1

