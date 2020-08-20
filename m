Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025C4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F37208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597930346;
	bh=Mlo04NAwqU0Kk+zWv/II0kvQJ5NJbELIWe+SPqU84EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b6l2HNeMInKmjPhD4xbEMxPywfia5IuHj4ERWDFbUZhSqSW6+VQXFAPEBknOQTEUJ
	 Ec0+1nGN/fsB612SPdgh5LJ6wybJ2VxhocITRDiq2Gcf/7nHpHYc4iHrp+f/oABJG+
	 w1CMPSRgD7LZVsJQ0zbhW2dih3HQjQslg4v6K6gM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgHTNcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbgHTJcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:32:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CF3121775;
        Thu, 20 Aug 2020 09:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915939;
        bh=Mlo04NAwqU0Kk+zWv/II0kvQJ5NJbELIWe+SPqU84EM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3KRChmaiW8lSFSiAtZV2Oo5UR2RACic9l18Y8Rnby25R+bHv/LOUwD8eLHqNskyk
         0+7DR9v5XpJYUdU+Ro9CzrUY+ePwD/dSFaGOzgBC+0l8nO/rur9AZj0avRqZV5pqZD
         gzikuMOy4Us2gKoIsPgCBAF8cLGc/XaUcsQKzPks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 186/232] watchdog: rti-wdt: balance pm runtime enable calls
Date:   Thu, 20 Aug 2020 11:20:37 +0200
Message-Id: <20200820091621.805011507@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

[ Upstream commit d5b29c2c5ba2bd5bbdb5b744659984185d17d079 ]

PM runtime should be disabled in the fail path of probe and when
the driver is removed.

Fixes: 2d63908bdbfb ("watchdog: Add K3 RTI watchdog support")
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20200717132958.14304-5-t-kristo@ti.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/rti_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index d456dd72d99a0..c904496fff65e 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -211,6 +211,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
 
 err_iomap:
 	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
@@ -221,6 +222,7 @@ static int rti_wdt_remove(struct platform_device *pdev)
 
 	watchdog_unregister_device(&wdt->wdd);
 	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-- 
2.25.1



