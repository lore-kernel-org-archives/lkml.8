Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFA0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8293820734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="WQa9ttIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgHKBHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:07:48 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:11422 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgHKBHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:07:41 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQZSX0W12zQJ;
        Tue, 11 Aug 2020 03:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597108060; bh=OIdj1bieFAd1gN9WGC2r/NFX1YGGGl5RTklKLLBrmu0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=WQa9ttIcJpNZTeCfO4TQpfQVQTVyeUwFHYT/6LbshXeYq8iBAtlQdCF0SrCt9Abc4
         HFIeXEEkkvRXix0nKyfQfLUjSdS42HghuxBOAZcgE9xhbtgaiB/2WYUcnobjuh/NkV
         z1/zZlolZArRgIkW+oMwYH2/VRoWH3m3vCgj6en7J026vZXhxEnci+wUuJRsB9fVIK
         aKCGlewph/RjsTnfq3dIG/YUOqvNYXznMu0fTypnIkN3zLZWx+JaYYuZty7YsDgaE7
         r7qgMnNYpWYLR8NwfuHWRDi8SygGmm6YBf9oiugJsXV58ftDunWTV1PtzKwD9QzuRX
         pF/eBn/n1jmYQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Tue, 11 Aug 2020 03:07:39 +0200
Message-Id: <2a978483b064b810b00e072fcdb6c3d24a896bd8.1597107682.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 4/7] regulator: push allocation in
 set_consumer_device_supply() out of lock
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull regulator_list_mutex into set_consumer_device_supply() and keep
allocations outside of it. Fourth of the fs_reclaim deadlock case.

Cc: stable@vger.kernel.org
Fixes: 45389c47526d ("regulator: core: Add early supply resolution for regulators")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 44 +++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c95397798275..0408c4e1d9a8 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1445,6 +1445,22 @@ static int set_consumer_device_supply(struct regulator_dev *rdev,
 	else
 		has_dev = 0;
 
+	node = kzalloc(sizeof(struct regulator_map), GFP_KERNEL);
+	if (node == NULL)
+		return -ENOMEM;
+
+	node->regulator = rdev;
+	node->supply = supply;
+
+	if (has_dev) {
+		node->dev_name = kstrdup(consumer_dev_name, GFP_KERNEL);
+		if (node->dev_name == NULL) {
+			kfree(node);
+			return -ENOMEM;
+		}
+	}
+
+	mutex_lock(&regulator_list_mutex);
 	list_for_each_entry(node, &regulator_map_list, list) {
 		if (node->dev_name && consumer_dev_name) {
 			if (strcmp(node->dev_name, consumer_dev_name) != 0)
@@ -1462,26 +1478,19 @@ static int set_consumer_device_supply(struct regulator_dev *rdev,
 			 node->regulator->desc->name,
 			 supply,
 			 dev_name(&rdev->dev), rdev_get_name(rdev));
-		return -EBUSY;
-	}
-
-	node = kzalloc(sizeof(struct regulator_map), GFP_KERNEL);
-	if (node == NULL)
-		return -ENOMEM;
-
-	node->regulator = rdev;
-	node->supply = supply;
-
-	if (has_dev) {
-		node->dev_name = kstrdup(consumer_dev_name, GFP_KERNEL);
-		if (node->dev_name == NULL) {
-			kfree(node);
-			return -ENOMEM;
-		}
+		goto fail;
 	}
 
 	list_add(&node->list, &regulator_map_list);
+	mutex_unlock(&regulator_list_mutex);
+
 	return 0;
+
+fail:
+	mutex_unlock(&regulator_list_mutex);
+	kfree(node->dev_name);
+	kfree(node);
+	return -EBUSY;
 }
 
 static void unset_regulator_supplies(struct regulator_dev *rdev)
@@ -5239,19 +5248,16 @@ regulator_register(const struct regulator_desc *regulator_desc,
 
 	/* add consumers devices */
 	if (init_data) {
-		mutex_lock(&regulator_list_mutex);
 		for (i = 0; i < init_data->num_consumer_supplies; i++) {
 			ret = set_consumer_device_supply(rdev,
 				init_data->consumer_supplies[i].dev_name,
 				init_data->consumer_supplies[i].supply);
 			if (ret < 0) {
-				mutex_unlock(&regulator_list_mutex);
 				dev_err(dev, "Failed to set supply %s\n",
 					init_data->consumer_supplies[i].supply);
 				goto unset_supplies;
 			}
 		}
-		mutex_unlock(&regulator_list_mutex);
 	}
 
 	if (!rdev->desc->ops->get_voltage &&
-- 
2.20.1

