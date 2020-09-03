Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E95EC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44177206EB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgICOWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:22:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54538 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgICOR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:17:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id F314D29ADE1
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org
Subject: [PATCH] platform/chrome: Kconfig: Remove the transitional MFD_CROS_EC config
Date:   Thu,  3 Sep 2020 16:17:46 +0200
Message-Id: <20200903141746.996974-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MFD_CROS_EC config was a transitional Kconfig option to not break
current defconfigs in the kernel. Now, this is not required anymore
because all the defconfigs have been removed this option and migrated to
enable the CrOS EC parts individually.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/Kconfig | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index a056031dee81..ccc23d8686e8 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -3,16 +3,6 @@
 # Platform support for Chrome OS hardware (Chromebooks and Chromeboxes)
 #
 
-config MFD_CROS_EC
-	tristate "Platform support for Chrome hardware (transitional)"
-	select CHROME_PLATFORMS
-	select CROS_EC
-	select MFD_CROS_EC_DEV
-	depends on X86 || ARM || ARM64 || COMPILE_TEST
-	help
-	  This is a transitional Kconfig option and will be removed after
-	  everyone enables the parts individually.
-
 menuconfig CHROME_PLATFORMS
 	bool "Platform support for Chrome hardware"
 	depends on X86 || ARM || ARM64 || COMPILE_TEST
-- 
2.28.0

