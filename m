Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C125C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1BC20855
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHMQTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:19:09 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:44835 "EHLO
        12.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMQTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:19:04 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Aug 2020 12:19:03 EDT
Received: from player696.ha.ovh.net (unknown [10.108.35.12])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 4D91428F064
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 18:19:02 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player696.ha.ovh.net (Postfix) with ESMTPSA id 6818515474814;
        Thu, 13 Aug 2020 16:18:56 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R006d263d468-f464-43ed-bd99-473694ab4806,
                    E10370F5499BCD549250CF93A1A6372B2A4BB833) smtp.auth=steve@sk2.org
From:   Stephen Kitt <steve@sk2.org>
To:     Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] drivers/hwmon/w83793.c: use simple i2c probe
Date:   Thu, 13 Aug 2020 18:18:45 +0200
Message-Id: <20200813161845.1511261-1-steve@sk2.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7491175034432343545
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrleehgdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver doesn't use the id information provided by the old i2c
probe function, so it can trivially be converted to the simple
("probe_new") form.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/hwmon/w83793.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 3f59f2a1a5e3..e7d0484eabe4 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -283,8 +283,7 @@ static void w83793_release_resources(struct kref *ref)
 
 static u8 w83793_read_value(struct i2c_client *client, u16 reg);
 static int w83793_write_value(struct i2c_client *client, u16 reg, u8 value);
-static int w83793_probe(struct i2c_client *client,
-			const struct i2c_device_id *id);
+static int w83793_probe(struct i2c_client *client);
 static int w83793_detect(struct i2c_client *client,
 			 struct i2c_board_info *info);
 static int w83793_remove(struct i2c_client *client);
@@ -303,7 +302,7 @@ static struct i2c_driver w83793_driver = {
 	.driver = {
 		   .name = "w83793",
 	},
-	.probe		= w83793_probe,
+	.probe_new	= w83793_probe,
 	.remove		= w83793_remove,
 	.id_table	= w83793_id,
 	.detect		= w83793_detect,
@@ -1646,8 +1645,7 @@ static int w83793_detect(struct i2c_client *client,
 	return 0;
 }
 
-static int w83793_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int w83793_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	static const int watchdog_minors[] = {
-- 
2.25.4

