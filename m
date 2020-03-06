Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C631C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAE820848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tW4N7r6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgCFHxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:53:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45465 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgCFHxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:53:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id v2so1116879wrp.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 23:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bjpazKmv0jUdTQ7aEdJ3GDGRh4LTryp3L8+gNIuCjDo=;
        b=tW4N7r6nmM0Fi1mTR7MymNXE7pmeFl8CHkju5MlXoHsez5/FVsalphaEbPF9SZ863/
         jKhe0DJt4MPhPILD02pM4KxZ48wUsdbPf/8ZfMpW6SuKiUHnCaaK+cW6QQAJlFNaiRdT
         36OePbBQMeZYM9wupsR9FD0WDu26mk7zJc6NY+YsRNbYslczHr6qqRGuf196f395wHfy
         e6Ix/m+jYIcs5M801H4grCOFZu4mdKpBApEt/cMBg/fxf/WnbpYMo4Ji9hs9Spo66lXD
         KrIQL0WGiyuZA72KKpAYyoaE+nnKcmGMhVTYbfMOeKhZ1PDnckgzj9yK5LcjCtavXtbO
         Bm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bjpazKmv0jUdTQ7aEdJ3GDGRh4LTryp3L8+gNIuCjDo=;
        b=BBeI1/D+VEIOJdnA7CMtJobH20HYaunEXx5BQ57y4xMmg7xunf5wPDqtbVt3i+RrXq
         tpyUga3ufqDD4bq3OMa3ujxj5UC+VOaDsP9JaG3Jk9pva/nf4rmU+RxH9WTEdeYtalc8
         wcoeHiOzEkJlBQkdNzkNdJnP/2ubwqzyIuJIP9RKYQGqaF19WCs77a18e1IEF62KctXl
         8q96p/iB+7brqGwrP2CpnfXNeV9I/onI9LsaknRHNKLwfDnbUUZ6e3Wp3gDybtyKc405
         5UGQZedZuf2NDI6soK9LLw4HRoh5u2VJ9I0Oj0oGfcejN7BovS+Jh7kVd86LU9TsLlUA
         76wg==
X-Gm-Message-State: ANhLgQ3wm+kV2jX0mVLSCMKdSXoowDT6mjqM4HfYMwZnhAXLgfXWki+z
        yGmqGF68q/vzeSxdRyrtNLPydw==
X-Google-Smtp-Source: ADFU+vscgmE3Eeo+6U2MSBWHH1RJ1vL4n1MuTTQ6/lNgFJ5dVWv5bWkowG+BpUS2D93lH+uDR0lUyQ==
X-Received: by 2002:adf:9282:: with SMTP id 2mr2740731wrn.124.1583481188862;
        Thu, 05 Mar 2020 23:53:08 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id f17sm27152245wrm.3.2020.03.05.23.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2020 23:53:08 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        rafael.j.wysocki@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/2] rtc: cmos: remove useless cast for driver_name
Date:   Fri,  6 Mar 2020 07:53:01 +0000
Message-Id: <1583481181-22972-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583481181-22972-1-git-send-email-clabbe@baylibre.com>
References: <1583481181-22972-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the pnp_driver name is "const char *", there are no need to cast
driver_name.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/rtc/rtc-cmos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index fb13993fad31..bcc96ab7793f 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -1346,7 +1346,7 @@ static const struct pnp_device_id rtc_ids[] = {
 MODULE_DEVICE_TABLE(pnp, rtc_ids);
 
 static struct pnp_driver cmos_pnp_driver = {
-	.name		= (char *) driver_name,
+	.name		= driver_name,
 	.id_table	= rtc_ids,
 	.probe		= cmos_pnp_probe,
 	.remove		= cmos_pnp_remove,
-- 
2.24.1

