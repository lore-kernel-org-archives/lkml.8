Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BF0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A862E20721
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521167;
	bh=ImNrQVFyGcuFtsDbQJO2dtMOMD8uOcGpMlubp2ca/Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=10dPnjbAoglAFhw8mf6T+DTvnWGOSzey/2y4X3XzRJQ05W81SQl38hGXMWZ0VkdyQ
	 xCDhUwHT7ZOSHqhbGxxAtDtuzGxK4hJWt8CLJP7IW16o4C2AjrSWG70NgKwBTAC1Si
	 9XecvymBPsh/+FPW4RSqjUeltZIqeGgx3rCTD4w4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392571AbgEZT0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391157AbgEZTGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:06:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35D0F208A7;
        Tue, 26 May 2020 19:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519978;
        bh=ImNrQVFyGcuFtsDbQJO2dtMOMD8uOcGpMlubp2ca/Mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CvlQ6wayo/+p1elzHHKmbHP2NZEVXbMZtTGmgvRFHlugwQr6Tt3UrxEbS5GspYT5U
         4ozPOSktgqAaDcznGbDsnaRCdZzt6BjaJu8O6JxnC9+piJsAqTKaE03nmIY9Cri2Dz
         yjFDUH9mGmBEj3K/QIcQb1G4AlM1/VFpbdj2Y1BA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alain Volmat <alain.volmat@st.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 011/111] i2c: fix missing pm_runtime_put_sync in i2c_device_probe
Date:   Tue, 26 May 2020 20:52:29 +0200
Message-Id: <20200526183933.620974645@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
References: <20200526183932.245016380@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <alain.volmat@st.com>

[ Upstream commit 3c3dd56f760da056e821ac177e3ad0de4209a435 ]

In case of the I2C client exposes the flag I2C_CLIENT_HOST_NOTIFY,
pm_runtime_get_sync is called in order to always keep active the
adapter. However later on, pm_runtime_put_sync is never called
within the function in case of an error. This commit add this
error handling.

Fixes: 72bfcee11cf8 ("i2c: Prevent runtime suspend of adapter when Host Notify is required")
Signed-off-by: Alain Volmat <alain.volmat@st.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 810a942eaa8e..cc193f2ba5d3 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -338,8 +338,10 @@ static int i2c_device_probe(struct device *dev)
 		} else if (ACPI_COMPANION(dev)) {
 			irq = i2c_acpi_get_irq(client);
 		}
-		if (irq == -EPROBE_DEFER)
-			return irq;
+		if (irq == -EPROBE_DEFER) {
+			status = irq;
+			goto put_sync_adapter;
+		}
 
 		if (irq < 0)
 			irq = 0;
@@ -353,15 +355,19 @@ static int i2c_device_probe(struct device *dev)
 	 */
 	if (!driver->id_table &&
 	    !i2c_acpi_match_device(dev->driver->acpi_match_table, client) &&
-	    !i2c_of_match_device(dev->driver->of_match_table, client))
-		return -ENODEV;
+	    !i2c_of_match_device(dev->driver->of_match_table, client)) {
+		status = -ENODEV;
+		goto put_sync_adapter;
+	}
 
 	if (client->flags & I2C_CLIENT_WAKE) {
 		int wakeirq;
 
 		wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
-		if (wakeirq == -EPROBE_DEFER)
-			return wakeirq;
+		if (wakeirq == -EPROBE_DEFER) {
+			status = wakeirq;
+			goto put_sync_adapter;
+		}
 
 		device_init_wakeup(&client->dev, true);
 
@@ -408,6 +414,10 @@ err_detach_pm_domain:
 err_clear_wakeup_irq:
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
+put_sync_adapter:
+	if (client->flags & I2C_CLIENT_HOST_NOTIFY)
+		pm_runtime_put_sync(&client->adapter->dev);
+
 	return status;
 }
 
-- 
2.25.1



