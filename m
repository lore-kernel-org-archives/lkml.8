Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E4CC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F392D20775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgCYKWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:22:35 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:11735 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgCYKWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:22:35 -0400
IronPort-SDR: /CHA92gX0MykXpSbXcRWQmLcUqCbCuqZwh+NUYFhQlFsJVFbK9W1p2FlX5V8mQPVnJxa9+APY9
 Da9H/y0rOoGekcZWEEetHZLJe8ha72/dmIOsK0MY/v7bUB7rH4x7qZ42mUTbmcj49hmA8U9VeV
 8BgyvCDOWAVlnng4T+UHWh039pDYLJCdRp3I+cP4aQIsXQstIO29zkkro6izREjo8oX5rIKLXe
 H8Ps+i9wNdG2HhQ2RdvLvsqAKZ4HIBF5fbHbeaoR5YK5/Zm6iL4YC7GR+RyN1UnC4zM6Uzsr4p
 4B4=
X-IronPort-AV: E=Sophos;i="5.72,304,1580799600"; 
   d="scan'208";a="73430215"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Mar 2020 03:22:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Mar 2020 03:22:33 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 25 Mar 2020 03:22:28 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <eugen.hristev@microchip.com>
Subject: [PATCH 1/2] ARM: configs: at91: sama5: enable SAMA5D2_PIOBU
Date:   Wed, 25 Mar 2020 12:22:22 +0200
Message-ID: <20200325102223.24827-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@microchip.com>

Driver is enabled as a module.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index bab7861443dc..258a18e659a5 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -128,6 +128,7 @@ CONFIG_SPI=y
 CONFIG_SPI_ATMEL=y
 CONFIG_SPI_GPIO=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_SAMA5D2_PIOBU=m
 CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_ACT8945A=y
 CONFIG_POWER_RESET=y
-- 
2.20.1

