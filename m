Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B36C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 14:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88E82496B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588429625;
	bh=uXzxKB4LFm838tqYW/k6ytJ5UIKI4tBbKZrcLiff470=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kSGZENBQf/yggDCd0IiSm4vry0xx43dOeKRCtzhKkkNoj4oYaSYLGbStRC2788wLy
	 SmoNQIAbmcLl0YkG35ubLBVLlwfVis3+Y9b8v7gDpHgDnlIAAehCFKN9NHUOb2z0Qh
	 Sp/Wz74ZQDCQSDD7USww90gL5X0TdncDdIw98HGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgEBO1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 10:27:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgEBO1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 10:27:03 -0400
Received: from localhost (p5486C608.dip0.t-ipconnect.de [84.134.198.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6B3E24969;
        Sat,  2 May 2020 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588429623;
        bh=uXzxKB4LFm838tqYW/k6ytJ5UIKI4tBbKZrcLiff470=;
        h=From:To:Cc:Subject:Date:From;
        b=YVvsSK/Ugq92x9YpE5k/657DH7e9pZ1ikJK5eu5xCWHnwoa8g0waPkMipe9NmeQaD
         zWYtRMoH9ccglaTQtu3iMOhCQebi3osy7G1//tJF50RTU+Y3JFCUxkHYDFQzKySFRI
         3S0lqO5ZFGD0mBAcamj31XNsqahaCSRfzlI+rWeM=
From:   Wolfram Sang <wsa@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, Wolfram Sang <wsa@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: adt7411: update contact email
Date:   Sat,  2 May 2020 16:27:00 +0200
Message-Id: <20200502142700.19254-1-wsa@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My 'pengutronix' address is defunct for years. Merge the entries and use
the proper contact address.

Signed-off-by: Wolfram Sang <wsa@kernel.org>
---
 drivers/hwmon/adt7411.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index c7010b91bc13..5a839cc2ed1c 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -716,7 +716,6 @@ static struct i2c_driver adt7411_driver = {
 
 module_i2c_driver(adt7411_driver);
 
-MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de> and "
-	"Wolfram Sang <w.sang@pengutronix.de>");
+MODULE_AUTHOR("Sascha Hauer, Wolfram Sang <kernel@pengutronix.de>");
 MODULE_DESCRIPTION("ADT7411 driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

