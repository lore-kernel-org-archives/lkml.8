Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DBAC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16BF520736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgEKLC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725993AbgEKLCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:02:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EA9C061A0C;
        Mon, 11 May 2020 04:02:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A06152A0AF8
Received: by jupiter.universe (Postfix, from userid 1000)
        id 3FEC34800FF; Mon, 11 May 2020 13:02:21 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Samu Nuutamo <samu.nuutamo@vincit.fi>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH] hwmon: da9052: Synchronize access with mfd
Date:   Mon, 11 May 2020 13:02:19 +0200
Message-Id: <20200511110219.68188-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samu Nuutamo <samu.nuutamo@vincit.fi>

When tsi-as-adc is configured it is possible for in7[0123]_input read to
return an incorrect value if a concurrent read to in[456]_input is
performed. This is caused by a concurrent manipulation of the mux
channel without proper locking as hwmon and mfd use different locks for
synchronization.

Switch hwmon to use the same lock as mfd when accessing the TSI channel.

Fixes: 4f16cab19a3d5 ("hwmon: da9052: Add support for TSI channel")
Signed-off-by: Samu Nuutamo <samu.nuutamo@vincit.fi>
[rebase to current master, reword commit message slightly]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/hwmon/da9052-hwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
index 53b517dbe7e6..4af2fc309c28 100644
--- a/drivers/hwmon/da9052-hwmon.c
+++ b/drivers/hwmon/da9052-hwmon.c
@@ -244,9 +244,9 @@ static ssize_t da9052_tsi_show(struct device *dev,
 	int channel = to_sensor_dev_attr(devattr)->index;
 	int ret;
 
-	mutex_lock(&hwmon->hwmon_lock);
+	mutex_lock(&hwmon->da9052->auxadc_lock);
 	ret = __da9052_read_tsi(dev, channel);
-	mutex_unlock(&hwmon->hwmon_lock);
+	mutex_unlock(&hwmon->da9052->auxadc_lock);
 
 	if (ret < 0)
 		return ret;
-- 
2.26.2

