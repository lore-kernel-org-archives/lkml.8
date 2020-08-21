Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF36C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7DC206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgHUQXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:23:14 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:57047 "EHLO
        4.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgHUQTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:19:55 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2020 12:19:54 EDT
Received: from player696.ha.ovh.net (unknown [10.108.57.72])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 42C3013E1EF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:02:09 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player696.ha.ovh.net (Postfix) with ESMTPSA id 6A9CF1576BCF9;
        Fri, 21 Aug 2020 16:02:03 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-105G00637181793-cf53-479e-a21c-e4e735c6a36c,
                    20EB7F6BE0168D07063FB82D5C23839419BBC220) smtp.auth=steve@sk2.org
From:   Stephen Kitt <steve@sk2.org>
To:     Riku Voipio <riku.voipio@iki.fi>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] hwmon: (f75375s) use simple i2c probe
Date:   Fri, 21 Aug 2020 18:01:59 +0200
Message-Id: <20200821160159.591293-1-steve@sk2.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17294104045806177561
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudduvddgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeliedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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
 drivers/hwmon/f75375s.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index eb847a7d6b83..3e567be60fb1 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -113,8 +113,7 @@ struct f75375_data {
 
 static int f75375_detect(struct i2c_client *client,
 			 struct i2c_board_info *info);
-static int f75375_probe(struct i2c_client *client,
-			const struct i2c_device_id *id);
+static int f75375_probe(struct i2c_client *client);
 static int f75375_remove(struct i2c_client *client);
 
 static const struct i2c_device_id f75375_id[] = {
@@ -130,7 +129,7 @@ static struct i2c_driver f75375_driver = {
 	.driver = {
 		.name = "f75375",
 	},
-	.probe = f75375_probe,
+	.probe_new = f75375_probe,
 	.remove = f75375_remove,
 	.id_table = f75375_id,
 	.detect = f75375_detect,
@@ -814,8 +813,7 @@ static void f75375_init(struct i2c_client *client, struct f75375_data *data,
 
 }
 
-static int f75375_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+static int f75375_probe(struct i2c_client *client)
 {
 	struct f75375_data *data;
 	struct f75375s_platform_data *f75375s_pdata =
@@ -832,7 +830,7 @@ static int f75375_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
-	data->kind = id->driver_data;
+	data->kind = i2c_match_id(f75375_id, client)->driver_data;
 
 	err = sysfs_create_group(&client->dev.kobj, &f75375_group);
 	if (err)
-- 
2.25.4

