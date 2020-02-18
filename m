Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A1FC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5C92464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vHu2+iek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgBRTdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:33:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39944 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgBRTdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so25386515wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9BZxWx02OP4buIGB38mrXrqxMYCE34rX+OIKJheO44A=;
        b=vHu2+iekn6Oz45OTWnDlijL1xIyW4xkjqGKkztYOlh+VqZjEXxOUZogmPjm0uhL3/V
         gJav+pFLI7bnwITiXHYBTJOQCt1H18pQPE3Ji7+43gVecfGmcg27f+q5JhGAiwl9bXgb
         Qxll7KGR+q+tUJ9rBM2IMx6DMbSMEDNR4z+B4NQh9q+qvRk1d3gwZ0gN43pQkfCocdWP
         kSqpMOKEQC/fKZQ3XDc7jWmKUngekWsp8nTHflds91EXP+wpw1qdJg9DedOwHzg8ttPs
         6skwhW9aMZq16dU+dI+RSXH0UUh+6C3E1q1QvVPxYFSptHKzp4O6B0vVsRRgsjuOdTXG
         2hDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9BZxWx02OP4buIGB38mrXrqxMYCE34rX+OIKJheO44A=;
        b=asFWoVfrmt3+izG6mRtmPnAXHqCDkWSJ88iGP/i7Kkj67wvpstw2PfMpR9RNjXpjS4
         RKdzhBEpUmE7JhR3tsBi9npi0snHpaAbDpZanmooHSFHuUtOSUek1ua/1QB3mYXswyBv
         lN8UzK5u5pRK4prBFVcwXc9qZnu5Xi9zTxwFYXU0lL2QJmz6kzNt6mkB/S+FfKXeA1WG
         4ZAi/5Tm+qyalIRdYRRiZWwdp8VTCQSSVEKMR3nzqm5NWYbWst0zPHVmJLKdBqO6BsST
         R3m9yx+ubag3DbWO00pNJVsX3Vz7fqZvDNe+T83Or0Jp+ugplOcYc27LDPvnyjEaMX2C
         ecwQ==
X-Gm-Message-State: APjAAAUobkxnkooXRZfQvhk4hYNNQXX+cHGBGo78m+/owJ9VHRdtSQy8
        8DpoZ/oOxzktEXXKKw9NZwf+nSNwu7I=
X-Google-Smtp-Source: APXvYqxAXsDdhHT9Ljp22hJpRE2F0hVTr7iFO7n0ITXn4kLzmd5GWP72gHNUHkKcm9jzsYtEYezbWw==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr32460635wrs.213.1582054413698;
        Tue, 18 Feb 2020 11:33:33 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:33 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 20/20] usb: musb: core: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:33:03 +0000
Message-Id: <1582054383-35760-21-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_driver name is const char pointer, so it not useful to cast
xx_driver_name (which is already const char).

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/usb/musb/musb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index f616fb489542..d590110539ab 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2945,7 +2945,7 @@ static const struct dev_pm_ops musb_dev_pm_ops = {
 
 static struct platform_driver musb_driver = {
 	.driver = {
-		.name		= (char *)musb_driver_name,
+		.name		= musb_driver_name,
 		.bus		= &platform_bus_type,
 		.pm		= MUSB_DEV_PM_OPS,
 		.dev_groups	= musb_groups,
-- 
2.24.1

