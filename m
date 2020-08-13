Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FC8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5256920855
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgHMQbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:31:53 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:33175 "EHLO
        3.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHMQbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:31:52 -0400
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Aug 2020 12:31:51 EDT
Received: from player688.ha.ovh.net (unknown [10.110.208.202])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id 7C94E1E2FCF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 18:25:57 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player688.ha.ovh.net (Postfix) with ESMTPSA id 1C07A1526A913;
        Thu, 13 Aug 2020 16:25:52 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-103G005a681ebc9-4fce-49de-94fb-dc3a2d2e09ad,
                    E10370F5499BCD549250CF93A1A6372B2A4BB833) smtp.auth=steve@sk2.org
From:   Stephen Kitt <steve@sk2.org>
To:     George Joseph <george.joseph@fairview5.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] drivers/hwmon/asc7621.c: use simple i2c probe
Date:   Thu, 13 Aug 2020 18:25:44 +0200
Message-Id: <20200813162544.1516647-1-steve@sk2.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7607987149653036303
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrleehgdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver doesn't use the id information provided by the old i2c
probe function, so it can trivially be converted to the simple
("probe_new") form.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/hwmon/asc7621.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
index 9e14e2829ee9..600ffc7e1900 100644
--- a/drivers/hwmon/asc7621.c
+++ b/drivers/hwmon/asc7621.c
@@ -1087,7 +1087,7 @@ static void asc7621_init_client(struct i2c_client *client)
 }
 
 static int
-asc7621_probe(struct i2c_client *client, const struct i2c_device_id *id)
+asc7621_probe(struct i2c_client *client)
 {
 	struct asc7621_data *data;
 	int i, err;
@@ -1193,7 +1193,7 @@ static struct i2c_driver asc7621_driver = {
 	.driver = {
 		.name = "asc7621",
 	},
-	.probe = asc7621_probe,
+	.probe_new = asc7621_probe,
 	.remove = asc7621_remove,
 	.id_table = asc7621_id,
 	.detect = asc7621_detect,
-- 
2.25.4

