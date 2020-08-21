Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C31C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7BF92086A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHUQMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:12:06 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:43346 "EHLO
        6.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgHUQMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:12:01 -0400
Received: from player755.ha.ovh.net (unknown [10.110.115.223])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id DEFA21E379F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:02:40 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player755.ha.ovh.net (Postfix) with ESMTPSA id 4F52A157ED5B3;
        Fri, 21 Aug 2020 16:02:35 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-105G006368e313c-e325-44bd-9ae6-001aee886a17,
                    20EB7F6BE0168D07063FB82D5C23839419BBC220) smtp.auth=steve@sk2.org
From:   Stephen Kitt <steve@sk2.org>
To:     Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] hwmon: (tmp513) use simple i2c probe
Date:   Fri, 21 Aug 2020 18:02:31 +0200
Message-Id: <20200821160231.592571-1-steve@sk2.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17302829769863875927
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudduvddgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the ongoing i2c transition to the simple probe
("probe_new"), this patch uses i2c_match_id to retrieve the
driver_data for the probed device. The id parameter is thus no longer
necessary and the simple probe can be used instead.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/hwmon/tmp513.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index df66e0bc1253..9f5885b0eb74 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -709,8 +709,7 @@ static int tmp51x_configure(struct device *dev, struct tmp51x_data *data)
 	return 0;
 }
 
-static int tmp51x_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int tmp51x_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct tmp51x_data *data;
@@ -724,7 +723,7 @@ static int tmp51x_probe(struct i2c_client *client,
 	if (client->dev.of_node)
 		data->id = (enum tmp51x_ids)device_get_match_data(&client->dev);
 	else
-		data->id = id->driver_data;
+		data->id = i2c_match_id(tmp51x_id, client)->driver_data;
 
 	ret = tmp51x_configure(dev, data);
 	if (ret < 0) {
@@ -751,7 +750,7 @@ static int tmp51x_probe(struct i2c_client *client,
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);
 
-	dev_dbg(dev, "power monitor %s\n", id->name);
+	dev_dbg(dev, "power monitor %s\n", client->name);
 
 	return 0;
 }
@@ -761,7 +760,7 @@ static struct i2c_driver tmp51x_driver = {
 		.name	= "tmp51x",
 		.of_match_table = of_match_ptr(tmp51x_of_match),
 	},
-	.probe		= tmp51x_probe,
+	.probe_new	= tmp51x_probe,
 	.id_table	= tmp51x_id,
 };
 
-- 
2.25.4

