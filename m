Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE3DC33CB7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33832072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201601;
	bh=IVGWB140nrt+GHipb+qYIHmKcToavEP9uvo3bLo7vEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PDbDGm8kfiK0+Tjg0zPAEY7rPR9oxcNVKiPIjTFp4QvfW4hGomNa3vadIc1o01o+a
	 1p+cLkqPzDNROpdduA+9wDKoKZZRQ23yXlpOWB4EBqdnS3Adj7ZNgcXy9GQ8uYNmCd
	 9rIKa0iMpDNhPWBznJAV1T5bcLQ8k382h/Kwz0YU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbgAPRBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:01:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388094AbgAPRB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:01:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 454C021D56;
        Thu, 16 Jan 2020 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194086;
        bh=IVGWB140nrt+GHipb+qYIHmKcToavEP9uvo3bLo7vEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hr9M3MbiaK4mF2ZfL1i6Vhj9NbZcWtIZgsQ3UMcnHut1AwecU4Ob+XfjeoNTwe1y7
         ZjW+3sJxcSbclQZ/4vDQG53PIXj646ae2jP1td4ixpM+OGGHcetPmRMHTf7IwJx1f7
         2PYiRnzci3YTXwco36n/NOh0KUd7JaWGLc2NqIoc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vadim Pasternak <vadimp@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 190/671] hwmon: (pmbus/tps53679) Fix driver info initialization in probe routine
Date:   Thu, 16 Jan 2020 11:51:39 -0500
Message-Id: <20200116165940.10720-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 85b515cd9df0..2bc352c5357f 100644
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

