Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0464C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC07E2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGJTOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJTOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:14:38 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB36AC08C5DC;
        Fri, 10 Jul 2020 12:14:37 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id B2C55BC07E;
        Fri, 10 Jul 2020 19:14:34 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     chenyu56@huawei.com, wangbinghui@hisilicon.com, kishon@ti.com,
        vkoul@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] phy: hi3660: Replace HTTP links with HTTPS ones
Date:   Fri, 10 Jul 2020 21:14:28 +0200
Message-Id: <20200710191428.31989-1-grandmaster@al2klimov.de>
In-Reply-To: <20200710070613.GA1176018@kroah.com>
References: <20200710070613.GA1176018@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Now better?

 drivers/phy/hisilicon/phy-hi3660-usb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/hisilicon/phy-hi3660-usb3.c b/drivers/phy/hisilicon/phy-hi3660-usb3.c
index cc0af2c044d0..575c867d13ca 100644
--- a/drivers/phy/hisilicon/phy-hi3660-usb3.c
+++ b/drivers/phy/hisilicon/phy-hi3660-usb3.c
@@ -3,7 +3,7 @@
  * Phy provider for USB 3.0 controller on HiSilicon 3660 platform
  *
  * Copyright (C) 2017-2018 Hilisicon Electronics Co., Ltd.
- *		http://www.huawei.com
+ *		https://www.huawei.com
  *
  * Authors: Yu Chen <chenyu56@huawei.com>
  */
-- 
2.27.0

