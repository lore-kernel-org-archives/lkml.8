Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5810C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 00:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58362072E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 00:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgCYA5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 20:57:42 -0400
Received: from mta01.start.ca ([162.250.196.97]:43648 "EHLO mta01.start.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgCYA5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 20:57:42 -0400
Received: from mta01.start.ca (localhost [127.0.0.1])
        by mta01.start.ca (Postfix) with ESMTP id 507D9427AF;
        Tue, 24 Mar 2020 20:57:41 -0400 (EDT)
Received: from localhost (dhcp-24-53-240-163.cable.user.start.ca [24.53.240.163])
        by mta01.start.ca (Postfix) with ESMTPS id 2230E41F7F;
        Tue, 24 Mar 2020 20:57:41 -0400 (EDT)
From:   Nick Bowler <nbowler@draconx.ca>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: Fix gpio-f7188x module name in Kconfig help text.
Date:   Tue, 24 Mar 2020 20:57:07 -0400
Message-Id: <20200325005707.5891-1-nbowler@draconx.ca>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig help text for the gpio-f7188x driver says that if you
compile the driver as a module, the module will be called f7188x-gpio.
This is a lie: the module is called gpio-f7188x.

Change the help text to be consistent with reality.

Signed-off-by: Nick Bowler <nbowler@draconx.ca>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b8013cf90064..8cf91a9fbd18 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -755,7 +755,7 @@ config GPIO_F7188X
 	  chips F71869, F71869A, F71882FG, F71889F and F81866.
 
 	  To compile this driver as a module, choose M here: the module will
-	  be called f7188x-gpio.
+	  be called gpio-f7188x.
 
 config GPIO_GPIO_MM
 	tristate "Diamond Systems GPIO-MM GPIO support"
-- 
2.24.1

