Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B45EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9641208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859406;
	bh=OT71+5E1Ja8X2ipIEcrWpHYmjwcMy5GNtYtKWURAuiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LoRqh7Hktg+LCK72oZFFBtpEbAfM5ktLSQTsXgzwKIYa21n7M/LFIuOYJIHTmAAJw
	 oLEhOol7736jm2MYqbjic8/ffk1icf7+0l2Mx2z3/zRM6bzaYQnpieys5zSebbNwS9
	 QTIU7bs567wxuRjTHS7mLYzMV5IvJkc/zUSG734A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgAXJuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730321AbgAXJuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:50:02 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B6D7206D5;
        Fri, 24 Jan 2020 09:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859402;
        bh=OT71+5E1Ja8X2ipIEcrWpHYmjwcMy5GNtYtKWURAuiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PmAB9FSUqXMCaYR7fLNUsyOoNNKAtxIeMwKR5OE+pVodQ4+aVCCMOXs7UWAoXdmeB
         hzDgeJqQMmHbDtJozeGhPO1XbWC1Si5V+bWvOqgXZZDIsIqqjrh5ZoDnSDlCMl+vRe
         pfQTt0wrd5VACFNrQHSX8NWNHLGJHYkm0uEKiVGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 109/343] hwmon: (pmbus/tps53679) Fix driver info initialization in probe routine
Date:   Fri, 24 Jan 2020 10:28:47 +0100
Message-Id: <20200124092934.392432277@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Pasternak <vadimp@mellanox.com>

[ Upstream commit ff066653aeed8ee2d4dadb1e35774dd91ecbb19f ]

Fix tps53679_probe() by using dynamically allocated "pmbus_driver_info"
structure instead of static. Usage of static structures causes
overwritten of the field "vrm_version", in case the system is equipped
with several tps53679 devices with the different "vrm_version".
In such case the last probed device overwrites this field for all
others.

Fixes: 610526527a13 ("hwmon: (pmbus) Add support for Texas Instruments tps53679 device")
Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/tps53679.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/tps53679.c b/drivers/hwmon/pmbus/tps53679.c
index 85b515cd9df0e..2bc352c5357f4 100644
--- a/drivers/hwmon/pmbus/tps53679.c
+++ b/drivers/hwmon/pmbus/tps53679.c
@@ -80,7 +80,14 @@ static struct pmbus_driver_info tps53679_info = {
 static int tps53679_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
-	return pmbus_do_probe(client, id, &tps53679_info);
+	struct pmbus_driver_info *info;
+
+	info = devm_kmemdup(&client->dev, &tps53679_info, sizeof(*info),
+			    GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	return pmbus_do_probe(client, id, info);
 }
 
 static const struct i2c_device_id tps53679_id[] = {
-- 
2.20.1



