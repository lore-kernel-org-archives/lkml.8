Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E00C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7E2246C0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196240;
	bh=OTfyqL13mP7+4AKTzIHZPyB8/MGAlw88DMRmtis+I9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tYf4bwvTNpOyMjU+EnZY51z90jLM42pBhbynjSL0uY/MjI8p6dI0Q6WIwM1iFMLbC
	 QyOCxyI/CA244OiLpA8+Buc2ehU8L3NWqlfRP/WK6j6Dm7/TZ862xr5LcMcPNtPQfR
	 B+xiKG82gdf1BP4u/q6rnX9doPGZpEMr+lL7YS6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404964AbgAPRhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:37:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405322AbgAPRhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:37:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0B21246B9;
        Thu, 16 Jan 2020 17:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196230;
        bh=OTfyqL13mP7+4AKTzIHZPyB8/MGAlw88DMRmtis+I9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvBmPZEEXOD2MfIApSAPka3dt08xR3oclZv7lK10vQ9PN26AmN8lgi6sg5HP4PRno
         QJausW8mXboMrjINklBzrlA/pEIfYpVETZoZR5IjZHVbt9LhWbMCvumhW0RGC4IqW5
         mofMLs1N/ZKjvMzaYCf46Em0NbPjmmgplbFB5v4Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 062/251] rtc: pm8xxx: fix unintended sign extension
Date:   Thu, 16 Jan 2020 12:33:31 -0500
Message-Id: <20200116173641.22137-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit e42280886018c6f77f0a90190f7cba344b0df3e0 ]

Shifting a u8 by 24 will cause the value to be promoted to an integer. If
the top bit of the u8 is set then the following conversion to an unsigned
long will sign extend the value causing the upper 32 bits to be set in
the result.

Fix this by casting the u8 value to an unsigned long before the shift.

Detected by CoverityScan, CID#1309693 ("Unintended sign extension")

Fixes: 9a9a54ad7aa2 ("drivers/rtc: add support for Qualcomm PMIC8xxx RTC")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index fac835530671..a1b4b0ed1f19 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -186,7 +186,8 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		}
 	}
 
-	secs = value[0] | (value[1] << 8) | (value[2] << 16) | (value[3] << 24);
+	secs = value[0] | (value[1] << 8) | (value[2] << 16) |
+	       ((unsigned long)value[3] << 24);
 
 	rtc_time_to_tm(secs, tm);
 
@@ -267,7 +268,8 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		return rc;
 	}
 
-	secs = value[0] | (value[1] << 8) | (value[2] << 16) | (value[3] << 24);
+	secs = value[0] | (value[1] << 8) | (value[2] << 16) |
+	       ((unsigned long)value[3] << 24);
 
 	rtc_time_to_tm(secs, &alarm->time);
 
-- 
2.20.1

