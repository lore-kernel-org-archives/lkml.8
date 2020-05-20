Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E014EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C0B20829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgETOLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:11:44 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:14684 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETOLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:11:43 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75ec53a8cfaa-6b731; Wed, 20 May 2020 22:11:24 +0800 (CST)
X-RM-TRANSID: 2ee75ec53a8cfaa-6b731
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.3.208.33])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25ec53a89ff6-60b9b;
        Wed, 20 May 2020 22:11:24 +0800 (CST)
X-RM-TRANSID: 2ee25ec53a89ff6-60b9b
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] driver core: platform: Fix spelling errors in platform.c
Date:   Wed, 20 May 2020 22:12:02 +0800
Message-Id: <20200520141202.19568-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a word spelling mistake of 'Unegisters', thus
it should be fixed.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/base/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 7fa654f12..15ae9428a 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -967,7 +967,7 @@ EXPORT_SYMBOL_GPL(__platform_register_drivers);
  * @drivers: an array of drivers to unregister
  * @count: the number of drivers to unregister
  *
- * Unegisters platform drivers specified by an array. This is typically used
+ * Unregisters platform drivers specified by an array. This is typically used
  * to complement an earlier call to platform_register_drivers(). Drivers are
  * unregistered in the reverse order in which they were registered.
  */
-- 
2.20.1.windows.1



