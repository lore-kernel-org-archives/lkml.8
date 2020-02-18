Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07FEC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5762067D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hXAdbJg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgBRUJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:09:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55893 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBRUJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:09:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so4051932wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 12:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=4O8UBMcWrJ0vW2xCQ1w086ifQXzUq/0Zcfzr3vmxCmU=;
        b=hXAdbJg9t7Ac7RWs2LVmLNuhUWu7hjBhe1Z8zVbgf5MTlBwdMbUrvJRzRAOAQsDc0I
         EUM8+Gww5mrY84CsItT7dvGCd3oXCNqqoUvzcU5nXhvJvaTEvmA+kvxVEYOxAXv/gGdc
         ictOXLSgaUbnju48nPm5bLTfBSOlaU6fSu4BQuHA9qtPpiUYlr2FjaFJJxAGFqWrNmgb
         lWogUfBylpH6gHl/gxg5kggzq3YYcAbCIskV+OYW2tTWvcOGoRDbwc4nk8AIafQpWExb
         rHYi6sQSgdrP+P2gduAztJFiiVWpU0wOBi2rxLbXy04ZQ//c1jLI1VSRMmqBODLmu4bS
         KxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4O8UBMcWrJ0vW2xCQ1w086ifQXzUq/0Zcfzr3vmxCmU=;
        b=rXaxK6+GVQBJaDKkhR1EetUb0JRG7h9rdphIs6+MeMrrhnPkPDe2V3ZWpfQc37q6vi
         clM3ADVmQ6uK+iqw8obNmIKpM7EAgES7BHHgerOASZVh4JtP0I1y9y0SfzjVK9eM3cwx
         BpDcVmaxSpRX8NH7G4YzZjVmO4we8ti3n0zn6oEZJLpzCTXDi39w1nIFCupuDTHraU8a
         +hUV44uaLUdY6tOZq2WvYJW+aMI5GSkZfCJfEy6rxla5uzjIPPyA4aLhrbwM6S89Sd/Z
         bdfpvJoKt+cgBKU8ynyD/Dj05oPBjJ21/e/NWPh1khCBXyIO0K7kDQ6rr7loLBRyTebk
         rOkQ==
X-Gm-Message-State: APjAAAXkMcphlVjA2ESp85jmzjw/Wt4VmQ7ZZbeU1JWRd6HusUTrQJLs
        rLWdK2PsZBBLdQI3IqjQp6pLog==
X-Google-Smtp-Source: APXvYqyz8XCmBJQazBT3WrJL/40oe8aCs3Awx1JIxQFwy+25m3+8OEWhpJq7d8e2b6HSlTLRNYWFWA==
X-Received: by 2002:a1c:1dc7:: with SMTP id d190mr5026741wmd.48.1582056546861;
        Tue, 18 Feb 2020 12:09:06 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id c74sm5043017wmd.26.2020.02.18.12.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 12:09:06 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     lee.jones@linaro.org, tony@atomide.com
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] mfd: omap: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 20:09:01 +0000
Message-Id: <1582056541-16973-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_driver name is const char pointer, so it not useful to cast
xx_driver_name (which is already const char).

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/mfd/omap-usb-host.c | 2 +-
 drivers/mfd/omap-usb-tll.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 4798d9f3f9d5..1f4f01b02d98 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -840,7 +840,7 @@ MODULE_DEVICE_TABLE(of, usbhs_omap_dt_ids);
 
 static struct platform_driver usbhs_omap_driver = {
 	.driver = {
-		.name		= (char *)usbhs_driver_name,
+		.name		= usbhs_driver_name,
 		.pm		= &usbhsomap_dev_pm_ops,
 		.of_match_table = usbhs_omap_dt_ids,
 	},
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 265f5e350e1c..72f5a1cf867a 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -304,7 +304,7 @@ MODULE_DEVICE_TABLE(of, usbtll_omap_dt_ids);
 
 static struct platform_driver usbtll_omap_driver = {
 	.driver = {
-		.name		= (char *)usbtll_driver_name,
+		.name		= usbtll_driver_name,
 		.of_match_table = usbtll_omap_dt_ids,
 	},
 	.probe		= usbtll_omap_probe,
-- 
2.24.1

