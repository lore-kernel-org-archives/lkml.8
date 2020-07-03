Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF20C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE6E206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgGCKdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgGCKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:33:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686F3C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 03:33:18 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jrJ0O-0000WM-Gq; Fri, 03 Jul 2020 12:33:16 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] regmap: dev_get_regmap_match(): fix string comparison
Date:   Fri,  3 Jul 2020 12:33:15 +0200
Message-Id: <20200703103315.267996-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is used by dev_get_regmap() to retrieve a regmap for the
specified device. If the device has more than one regmap, the name parameter
can be used to specify one.

The code here uses a pointer comparison to check for equal strings. This
however will probably always fail, as the regmap->name is allocated via
kstrdup_const() from the regmap's config->name.

Fix this by using strcmp() instead.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hey,

I stumbled over this by accident. AFAICS there's no-one on the kernel making
use of the "name" parameter.

regrads,
Marc

 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 06a796821e8b..795a62a04022 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1364,7 +1364,7 @@ static int dev_get_regmap_match(struct device *dev, void *res, void *data)
 
 	/* If the user didn't specify a name match any */
 	if (data)
-		return (*r)->name == data;
+		return !strcmp((*r)->name, data);
 	else
 		return 1;
 }
-- 
2.27.0

