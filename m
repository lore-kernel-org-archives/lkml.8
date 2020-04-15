Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA81C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A97206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393862AbgDOJFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:05:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54192 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393832AbgDOJFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:05:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id A86232A08AA
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: Kconfig: include test_drivers with MEDIA_TEST_SUPPORT
Date:   Wed, 15 Apr 2020 10:05:09 +0100
Message-Id: <20200415090509.18381-1-guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include test_drivers/Kconfig when MEDIA_TEST_SUPPORT is enabled rather
than MEDIA_PLATFORM_SUPPORT.  Test drivers should not depend on
platform drivers to be enabled.

Fixes: 4b32216adb010 ("media: split test drivers from platform directory")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 drivers/media/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index a8def1591352..d926c2603de2 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -238,10 +238,13 @@ source "drivers/media/common/Kconfig"
 
 if MEDIA_PLATFORM_SUPPORT
 source "drivers/media/platform/Kconfig"
-source "drivers/media/test_drivers/Kconfig"
 source "drivers/media/mmc/Kconfig"
 endif
 
+if MEDIA_TEST_SUPPORT
+source "drivers/media/test_drivers/Kconfig"
+endif
+
 source "drivers/media/firewire/Kconfig"
 
 endmenu
-- 
2.20.1

