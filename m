Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C68C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A24520714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hpK3Umhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgGWQZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:25:21 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:50440 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgGWQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595521519; x=1627057519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zHen7frI1NyzHCq/SsDVhF8PjNZaPlhUG3M1JdHxd60=;
  b=hpK3UmhdeJTHyPLSGQTjfbyrFhtMu0A7Xj7ypwnlqt5+AH7t/+GK4xZP
   5UErekA20R3pWJ5v8qgf8UtOx91jt27RbJBUvscbosL8A3XekTZ5ZNgYw
   qyVM2gmPTMR36p+AdA+DcoWRbM+htdfBiKauY2RBYhN+1WAO1rq3xijti
   B5I9JLy6iFYFqVPSfxeM9UXb4tk7oGl2J0oZeRmR6E9MtJqxQxndBc5a0
   pO92/1gDoo2nly5EGK05S9dnrhcAuNaODitHnu9wuu427+9p/dk6sJcDK
   Ejg1g4EGqZDUS75NvDwVANgA3dP/O9uE0bIJxko9V+Wx5UEKE7eJ8Dbrm
   w==;
IronPort-SDR: dKvzLny7P9FO9AursgRqvTwIH8d4UqnE4Q7nTWxKpIToCBFLM1jkJrbIs9jGr3CyAQjgO+0ZSA
 HSgwJOFywNlnd9RTu+JUow5fmyKGm/FfkLBWS8CshOtIQVMvFVxhlri5QlNZknDYLlt+N0zt6o
 kbpZmi/MEEMQ3Gru6/zcSQ/mainmIz4TOhQ9NQnLTz74w78f+hz97FXCrMQ2Ax8AJkWYrl17Jn
 kRqgPBM1D8IY0l5Guq1zJa2PHv+RozsGWK9gObMLPFHncU2lenwRv74stffE7KldhbQqGZ/TVW
 5MI=
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="83016692"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jul 2020 09:25:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 09:25:19 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 23 Jul 2020 09:25:16 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <cristian.birsan@microchip.com>,
        <nicolas.ferre@microchip.com>, <arnd@arndb.de>,
        <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 3/3] ARM: configs: at91: sama5: enable CAN PLATFORM driver
Date:   Thu, 23 Jul 2020 19:24:34 +0300
Message-ID: <20200723162434.1983643-3-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723162434.1983643-1-codrin.ciubotariu@microchip.com>
References: <20200723162434.1983643-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

CAN_M_CAN_PLATFORM is needed to probe the driver on sama5 platforms
after the driver was split into multiple files.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index f4d71ffcb6e9..7b7e333157fe 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -56,6 +56,7 @@ CONFIG_VLAN_8021Q=m
 CONFIG_CAN=y
 CONFIG_CAN_AT91=y
 CONFIG_CAN_M_CAN=y
+CONFIG_CAN_M_CAN_PLATFORM=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MAC80211_LEDS=y
-- 
2.25.1

