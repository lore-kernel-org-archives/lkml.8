Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1577AC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA25720719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585044929;
	bh=q19GDEoEkkCPIzJ88z7GjH586uoaCQjkusvlD75Swak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gxcO3OiO8oeaf/vJYO1hvXPwPi8NA0zvU1gbbl+JSj6Z2NTO7uEmH/W5aL3Fmy13S
	 f+jnXWi0lBi3N423k6D5jgt81PeYLALR4J5KNd0k7PCmZsnNpLinhR2JqRTcwIeB/G
	 GehffVO7rjEC4DbdWkmVHL7BXw9vSzavMh53xXfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgCXKPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgCXKPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:15:24 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF6D620775;
        Tue, 24 Mar 2020 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585044924;
        bh=q19GDEoEkkCPIzJ88z7GjH586uoaCQjkusvlD75Swak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z2Hca8dUG49VWGI8UVq5bJqTrQ3sV1uAgjxojH+xMWJjYJRaDMJhB2Sp/FZu5bSf4
         ZpUiqoN15Hfd2cLZE4wtY8UOizz6C5Cft+tr+PGw7vxl1iV29IEq4AmcCqzBRO3JPi
         genECfbZXCyEnYr+6OMN0uqaUC746Wp3qt95Ea20=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGgag-001pjJ-6z; Tue, 24 Mar 2020 11:15:22 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/8] media: dvb-usb: auto-select CYPRESS_FIRMWARE
Date:   Tue, 24 Mar 2020 11:15:14 +0100
Message-Id: <c4144f6ca86384522b8cebbe862ef9c58ca241ac.1585044374.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585044374.git.mchehab+huawei@kernel.org>
References: <cover.1585044374.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least some of the supported boards by dvb-usb
driver need to load the cypress firmware, so select
it, as otherwise missing dependencies may popup.

Also, as the cypress firmware load routines are needed
only by the dvb-usb, dvb-usb-v2 and go7007 drivers, and
those all (now) select it, there's no need to ask the
user for manually select it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/common/Kconfig      | 2 +-
 drivers/media/usb/dvb-usb/Kconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/Kconfig b/drivers/media/common/Kconfig
index 1990b7f09454..4ea03b7899a8 100644
--- a/drivers/media/common/Kconfig
+++ b/drivers/media/common/Kconfig
@@ -14,7 +14,7 @@ config VIDEO_TVEEPROM
 	depends on I2C
 
 config CYPRESS_FIRMWARE
-	tristate "Cypress firmware helper routines"
+	tristate
 	depends on USB
 
 source "drivers/media/common/videobuf2/Kconfig"
diff --git a/drivers/media/usb/dvb-usb/Kconfig b/drivers/media/usb/dvb-usb/Kconfig
index 5360dc1a2210..15d29c91662f 100644
--- a/drivers/media/usb/dvb-usb/Kconfig
+++ b/drivers/media/usb/dvb-usb/Kconfig
@@ -2,6 +2,7 @@
 config DVB_USB
 	tristate "Support for various USB DVB devices"
 	depends on DVB_CORE && USB && I2C && RC_CORE
+	select CYPRESS_FIRMWARE
 	help
 	  By enabling this you will be able to choose the various supported
 	  USB1.1 and USB2.0 DVB devices.
-- 
2.24.1

