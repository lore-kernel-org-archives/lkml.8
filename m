Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28170C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9F820675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgCaJhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:37:00 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:56025 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgCaJhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:37:00 -0400
IronPort-SDR: Njc920jYRQHR0o9j4KFE/USrjF+rEFOibNA9j0svFzek/fndu2JbLBI3MyPPj8213okvy0Glrf
 6GXoN6HEF9aoANpe29+gBp1DI1/tYL29UEWh1ECegEr96NlMJB8cRTgUabI0z98+6jv31pRM05
 3f5YTXlYB/ds8NnCyiKidNAP0lO3oPb7HEUMgCLxcvo0Qv+kdoZHrtt3s1x0WaVH6pwmC+adbX
 0O8ma4YO0zcf0cgA+i8zRJw2BNbEGDlZrzNMwHkDFW1iPjM1MZ3Z75lMdEdzawp3Z0kqLJkPt5
 tcw=
X-IronPort-AV: E=Sophos;i="5.72,327,1580799600"; 
   d="scan'208";a="74183720"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2020 02:36:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 31 Mar 2020 02:36:59 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 31 Mar 2020 02:36:55 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <woojung.huh@microchip.com>, <andrew@lunn.ch>,
        <vivien.didelot@gmail.com>, <f.fainelli@gmail.com>,
        <davem@davemloft.net>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH] net: dsa: ksz: Select KSZ protocol tag
Date:   Tue, 31 Mar 2020 12:36:51 +0300
Message-ID: <20200331093651.23365-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KSZ protocol tag is needed by the KSZ DSA drivers.

Fixes: 0b9f9dfbfab4 ("dsa: Allow tag drivers to be built as modules")
Tested-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Patch was tested on a 9477-like switch, but the 8795 variant seems to be
in the same situation.
I am not very sure about the Fixes tag, but it seems to be the one since
it removes the dependency between old NET_DSA_TAG_KSZ9477 and
NET_DSA_TAG_KSZ.

 drivers/net/dsa/microchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/microchip/Kconfig b/drivers/net/dsa/microchip/Kconfig
index 1d7870c6df3c..4ec6a47b7f72 100644
--- a/drivers/net/dsa/microchip/Kconfig
+++ b/drivers/net/dsa/microchip/Kconfig
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NET_DSA_MICROCHIP_KSZ_COMMON
+	select NET_DSA_TAG_KSZ
 	tristate
 
 menuconfig NET_DSA_MICROCHIP_KSZ9477
-- 
2.20.1

