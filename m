Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51601C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F51620737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663429;
	bh=s/0fHWJWsk3CSOvkSF0fCcWuzyXf2QbMKemiARoezHU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xvK7F73JM7M7bVJAgIORzrxooI1pbzyCOu69TLUVg6X4aqGZsIhelX7LypPoYm/ZD
	 G/VWpQaqkWFNkc3197N07ssQr+VtzCBaoWVRpcTC0y1ocPwl0JjiEn3kvgPfHdJ69p
	 AvOTUmm/D4EgRHVpfRyIr41Ql5e557ufNvH8C5TI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbgFIAns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729061AbgFHXMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:12:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EF57208C3;
        Mon,  8 Jun 2020 23:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657933;
        bh=s/0fHWJWsk3CSOvkSF0fCcWuzyXf2QbMKemiARoezHU=;
        h=From:To:Cc:Subject:Date:From;
        b=RG5LeXWbK0ZO8i+dpF7A7R+y/hq7YNvsfh9KJ37QQXHY3MKpIxMCrKVgN/DadnBAB
         NkgjHC5ObsQvn+HtcpkbH6EwH0e1huKXE3x/3pHOCxIYKMYU42g4E8EaPhzAqOMObA
         sgKi3fPMRQgS4xcUUA18tIftm1MV8azzkIJH601g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Samu Nuutamo <samu.nuutamo@vincit.fi>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 001/606] hwmon: (da9052) Synchronize access with mfd
Date:   Mon,  8 Jun 2020 19:02:06 -0400
Message-Id: <20200608231211.3363633-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samu Nuutamo <samu.nuutamo@vincit.fi>

[ Upstream commit 333e22db228f0bd0c839553015a6a8d3db4ba569 ]

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
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.25.1

