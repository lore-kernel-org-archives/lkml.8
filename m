Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949D0C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6010C2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597928040;
	bh=Mlo04NAwqU0Kk+zWv/II0kvQJ5NJbELIWe+SPqU84EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hCSLf2mhvvJKfpOJFM5ehvx4pfWGbVPywF/easyBJcgFqrZyQq1aKIHiMUCfQPYZp
	 bu5RBXTWMbpWwyWE+zIRkEAjXMqPrxD1LN4rd++LwwQLakFbesiSy+BaYggGokrfvy
	 mN0/8rTflg1/FEIpxPICcl8NyKSeHzN4nAkKRvQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgHTMx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbgHTJnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:43:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E163A20724;
        Thu, 20 Aug 2020 09:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916611;
        bh=Mlo04NAwqU0Kk+zWv/II0kvQJ5NJbELIWe+SPqU84EM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c87WqE88mGuaq6tX/rxvckxMKr3ynhdDYkD66jOhBlh6qibXpuA0NhW1BsslfjDgi
         SU3QvmuVsXr+ncRsDMTykq4GmkBngpnv8L2ktkZ2rmKVYzmUQn94e6ncFfl3sbnTGZ
         6TzKgF1m2kf9nh6QutNUnttFsKezGtZRt3Y0JWQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 159/204] watchdog: rti-wdt: balance pm runtime enable calls
Date:   Thu, 20 Aug 2020 11:20:56 +0200
Message-Id: <20200820091614.173060527@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
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



