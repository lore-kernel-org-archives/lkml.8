Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56606C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 14:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211B22083E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 14:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgDKO6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 10:58:50 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:38999 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgDKO6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 10:58:49 -0400
Received: from localhost.localdomain ([90.126.162.40])
        by mwinf5d41 with ME
        id RSyl2200a0scBcy03SymvJ; Sat, 11 Apr 2020 16:58:48 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Apr 2020 16:58:48 +0200
X-ME-IP: 90.126.162.40
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, andy.shevchenko@gmail.com,
        Jonathan.Cameron@huawei.com
Cc:     gwendal@chromium.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] platform/chrome: cros_ec_sensorhub: Add missing '\n' in log messages
Date:   Sat, 11 Apr 2020 16:58:44 +0200
Message-Id: <20200411145844.29542-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.

Fixes: 145d59baff59 ("platform/chrome: cros_ec_sensorhub: Add FIFO support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 230e6cf3da2f..c51af569708f 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -820,7 +820,7 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
 	if (fifo_info->count > sensorhub->fifo_size ||
 	    fifo_info->size != sensorhub->fifo_size) {
 		dev_warn(sensorhub->dev,
-			 "Mismatch EC data: count %d, size %d - expected %d",
+			 "Mismatch EC data: count %d, size %d - expected %d\n",
 			 fifo_info->count, fifo_info->size,
 			 sensorhub->fifo_size);
 		goto error;
@@ -851,14 +851,14 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
 		}
 		if (number_data > fifo_info->count - i) {
 			dev_warn(sensorhub->dev,
-				 "Invalid EC data: too many entry received: %d, expected %d",
+				 "Invalid EC data: too many entry received: %d, expected %d\n",
 				 number_data, fifo_info->count - i);
 			break;
 		}
 		if (out + number_data >
 		    sensorhub->ring + fifo_info->count) {
 			dev_warn(sensorhub->dev,
-				 "Too many samples: %d (%zd data) to %d entries for expected %d entries",
+				 "Too many samples: %d (%zd data) to %d entries for expected %d entries\n",
 				 i, out - sensorhub->ring, i + number_data,
 				 fifo_info->count);
 			break;
-- 
2.20.1

