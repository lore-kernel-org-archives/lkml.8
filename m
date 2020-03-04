Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5A2C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69E420870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge3+vVzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbgCDLi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:38:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36845 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbgCDLi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:38:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id 195so1634679ljf.3;
        Wed, 04 Mar 2020 03:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ij3G+PRAMng8mle7qC0u8RzdsZ5G5T3N3JUhXF+5wl4=;
        b=ge3+vVzZWvDrEQHuickCzS5ORp8m2VFeSOEtEEvTs1iiMh7xjG+cBwtp3l+ZOZWxDL
         hPhmAz4XCny2+7gcauv6XpWUBmCT4Q0tsy/pzJOHXYocZT9TKc6eVkZGr577ZOFkuDkr
         d6IS6TCstSbBhqa0gc1+e27XoEJDOA/dJ/34DnmYXXxUTgOqxl84p3qYhelfIL3jdUIh
         iGyMdqrKo0fRTOA+7S0Q+Ck37jIiiJggl1cPv97dUyVoOU9oGFTGdHOlqzjbkJt7sXxi
         s+BWWwigtFAxN1NoJAhEcbINlVg4myTuf101aiO18K+HFgUODiq0hrQvT8klcBdUWFf+
         OaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ij3G+PRAMng8mle7qC0u8RzdsZ5G5T3N3JUhXF+5wl4=;
        b=t3cXk8K5q8Uvmyin9p7uKPd6PhcAgOxaW23fSHQJZM5Gw0tiGbcJfSKGG8yBMAqGP5
         ChHQmT/3Wi240hOD0E7B0sb9i+weAucI6AXOb5uhpc2itKdDjotIvtR51+jQmg0L0M0a
         c8BDOgV2RssegmTFHW3W3r07u50hr6cPiTBMpyRDha3T5+YC64/NTL32pUVuEmp7j7S3
         JUE/i21+RqjmkBkoTeMvgdpW2eVztLNtagvgDUXR3Dqvc+XvbMJBhf+e1amTgBNAP/wX
         hxLb+EWsZ50g17Ng64SqmQC9qxWwfRIka57Mj69amVOw9QmlY1dUjJcGW2yjn/PCqjg9
         lAMg==
X-Gm-Message-State: ANhLgQ05ccCeN8lPIi00uF1ToMxGluF1QdLy3euh/czF7wZ+7M0EZtto
        NbSpRo452MGPDn91wO1vKfSAdS+B
X-Google-Smtp-Source: ADFU+vt2XesDLF/GQc9LX68YPiLvq2bNdKvpYr50PkZkQOGXsCSCQKFrD/Mjp/3ikj1m7kzdeYWbxw==
X-Received: by 2002:a2e:9a93:: with SMTP id p19mr1742719lji.177.1583321904924;
        Wed, 04 Mar 2020 03:38:24 -0800 (PST)
Received: from localhost.localdomain (ip-195-182-193-216.opensvit.ua. [195.182.193.216])
        by smtp.googlemail.com with ESMTPSA id t7sm13833552ljo.7.2020.03.04.03.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 03:38:23 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     corentin.chary@gmail.com, dvhart@infradead.org, andy@infradead.org,
        yurii.pavlovskyi@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH] platform/x86: asus_wmi: Fix return value of fan_boost_mode_store
Date:   Wed,  4 Mar 2020 13:38:11 +0200
Message-Id: <20200304113811.31988-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function fan_boost_mode_store returns 0 if store is successful,
this leads to infinite loop after any write to it's sysfs entry:

# echo 0 >/sys/devices/platform/asus-nb-wmi/fan_boost_mode

This command never ends, one CPU core is at 100% utilization.
This patch fixes this by returning size of written data.

Fixes: b096f626a682 ("platform/x86: asus-wmi: Switch fan boost mode")
Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 612ef5526226..e5d35987c048 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1719,7 +1719,7 @@ static ssize_t fan_boost_mode_store(struct device *dev,
 	asus->fan_boost_mode = new_mode;
 	fan_boost_mode_write(asus);
 
-	return result;
+	return count;
 }
 
 // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
-- 
2.25.1

