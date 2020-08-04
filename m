Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBE6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041DD2075A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AiC5OOOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgHDLTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:19:52 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:9733 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbgHDLMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596539573; x=1628075573;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=YtPmNSzbbPBoaWL3cjrf0tY68ii9T+o40iaT31QMEek=;
  b=AiC5OOOEGksdfuFrcb+7c61f4Hax86sRM8iZET/VuvrGW6JM3ltZJhrb
   hjkWQFHjV1EPRH1eyXxGFKS0M+kgeAye337VRghmy7fcdwZaUxLEwULRF
   2sEYKufWBUvGTk0Yi+euLqBN1qkOPW686lgs5Lf6i3X+1q8LgtGlHNjBd
   2Am9NmTNMs7zslJyG4dDh+jVchUrd8g1a9xEmUd1A7zNg7Rr2gGbswbGU
   4SIi83+/bMd22v5cwuBOsoueGRvRs/Jq5eOrDjvvuuZ7otf3cccAF0T9N
   i8O6hzCQyXmEJn0J23Jq97sjLoOTRUJ/yMY9ytmPIlfqnV7VQRignD0UX
   A==;
IronPort-SDR: ACpT0KWn+jHP0gpRWqL89XvoRrasTUHibOYUfOXG/rWYHk5gGMB4Cb1hKX3mqyVRvfygXj5yuJ
 A9eothsGg+4S+2+2OIpLXZIn25c1Ah3d0e5GCCM9C2xAVz7qwohSiYBWioysUJxh4SgrRcemnM
 W2BJirjPiB6sAs9v49dnoqtsaEMO0FVfNzsg1UI76b+sIFZ+xNim7fWUZoq9q5ifvnB46GwyLj
 EQ6EVZMJd5axMycJxFOCJVE3EMHG1RY7r52XpBRo9YNjBDziOgiylPBHWywBVOxYWKyyAthfBH
 EYw=
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="90374050"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2020 04:07:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 4 Aug 2020 04:07:40 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 4 Aug 2020 04:07:38 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <wenyou.yang@atmel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/3] AT91 PM improvements
Date:   Tue, 4 Aug 2020 14:07:35 +0300
Message-ID: <1596539258-20719-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds ULP0 fast mode intended to reduce the suspend/resume
time in the detriment of power consumption (patch 1/3).
Along with this patch 2/3 adds code to avoid requesting a PM mode
not available on platforms not supporting it.
Patch 3/3 decrements a device_node refcount after its usage.

Thank you,
Claudiu Beznea

Changes in v2:
- in patch 2/3:
	- move per SoC supported mode arrays in *_pm_init() functions.
	- use 2 booleans in at91_pm_modes_validate() for modes validation
	- continue to use array of supported modes in at91rm9200_pm_init()
	  and at91sam9_pm_init() instead of forcing
	  soc_pm.data.standby_mode = AT91_PM_STANDBY and
	  soc_pm.data.suspend_mode = AT91_PM_ULP0 to breaking the user
	  configuration (it might request ulp0 as standby mode or vice versa)
	  
Claudiu Beznea (3):
  ARM: at91: pm: add support for ULP0 fast wakeup
  ARM: at91: pm: add per soc validation of pm modes
  ARM: at91: pm: of_node_put() after its usage

 arch/arm/mach-at91/pm.c         | 93 ++++++++++++++++++++++++++++++++++++++---
 arch/arm/mach-at91/pm.h         |  5 ++-
 arch/arm/mach-at91/pm_suspend.S | 41 ++++++++++++++++--
 3 files changed, 127 insertions(+), 12 deletions(-)

-- 
2.7.4

