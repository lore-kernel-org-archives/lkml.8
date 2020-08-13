Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43568C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2089220658
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHMQ0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:26:14 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:39152 "EHLO
        17.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHMQ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:26:13 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Aug 2020 12:26:13 EDT
Received: from player737.ha.ovh.net (unknown [10.108.35.124])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7575E28EB84
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 18:20:36 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player737.ha.ovh.net (Postfix) with ESMTPSA id 21D02BC5348D;
        Thu, 13 Aug 2020 16:20:31 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R006f1c74461-ce2b-407c-839a-3d80edbb9b02,
                    E10370F5499BCD549250CF93A1A6372B2A4BB833) smtp.auth=steve@sk2.org
From:   Stephen Kitt <steve@sk2.org>
To:     Marc Hulsman <m.hulsman@tudelft.nl>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] drivers/hwmon/w83791d.c: use simple i2c probe
Date:   Thu, 13 Aug 2020 18:20:26 +0200
Message-Id: <20200813162026.1512242-1-steve@sk2.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7517633679366245843
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrleehgdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver doesn't use the id information provided by the old i2c
probe function, so it can trivially be converted to the simple
("probe_new") form.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/hwmon/w83791d.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index aad8d4da5802..37b25a1474c4 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -315,8 +315,7 @@ struct w83791d_data {
 	u8 vrm;			/* hwmon-vid */
 };
 
-static int w83791d_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id);
+static int w83791d_probe(struct i2c_client *client);
 static int w83791d_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static int w83791d_remove(struct i2c_client *client);
@@ -342,7 +341,7 @@ static struct i2c_driver w83791d_driver = {
 	.driver = {
 		.name = "w83791d",
 	},
-	.probe		= w83791d_probe,
+	.probe_new	= w83791d_probe,
 	.remove		= w83791d_remove,
 	.id_table	= w83791d_id,
 	.detect		= w83791d_detect,
@@ -1346,8 +1345,7 @@ static int w83791d_detect(struct i2c_client *client,
 	return 0;
 }
 
-static int w83791d_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int w83791d_probe(struct i2c_client *client)
 {
 	struct w83791d_data *data;
 	struct device *dev = &client->dev;
-- 
2.25.4

