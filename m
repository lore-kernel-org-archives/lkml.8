Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C8FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D408321744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S4oUcCos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgHEIg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:36:58 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:53851 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgHEIg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596616615; x=1628152615;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=LfYO9g+FGWyDgQ8j8fkTqXUVuxUq9UB8VMpu2RT1Ofw=;
  b=S4oUcCos7NUDdLqYjYMw00oHKb5ZXLLyC+o5E9WVHrfPtkRjQZ6gJa77
   0TC/PkL2hJzegANNVp8xZRDc4rZs0+FU9OaM5Y62PcXKAhSiGmaDUuzAX
   7RNoVwzrcIcWT6IaHwAOt9ibdRYCuDeW1IyxMbroUgrHvpqU8EbVE//o3
   XMMc1w32KzDbe0XzGHy3GgdZATmRruG75hX31jqFE3Spgd9UT/l9g7ZmJ
   Lx+oHwKQJRTVfVqIA/YI6vcRkrnTDVzta68u41sSIArkWtSwvp+P/94r3
   fgywTR/8SlvLvcmxvOL+vxcBtCRd/s2nt8G4qjc6k6TAN/SuklCGVj9H6
   A==;
IronPort-SDR: BZL2Dno/Vjfcv7QsqHVjuwisQAhByW+Qyr9Ato6QtAo+OGPvvz2k5RCTjfMB+VYjQlgK6Zp9jc
 sItWqCjYHMFmw+Dh0+fdm/AdrXg/WUfR03+Qq0nfeD7l2EL7zVZ3sPFk11To/QTrpV+RKj9g/a
 a+Lw8lqDZ/JKKkaUtQOyQ1G1qHeyD912ZVkTq0pahZf3tCezJsd3kPhMIsQPPVO/sQwbsr9ST8
 r5/veCPTGZJ3i7URI1Ewp0JJZvUjpI0+G7RwSlDloUVVhlxi/uuC5UJ3kflMkpn4eHbQpNrBkv
 W2M=
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="84485775"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2020 01:36:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 5 Aug 2020 01:36:53 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 5 Aug 2020 01:36:51 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 0/3] AT91 PM improvements
Date:   Wed, 5 Aug 2020 11:36:47 +0300
Message-ID: <1596616610-15460-1-git-send-email-claudiu.beznea@microchip.com>
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

Changes in v3:
- force STANDBY and ULP0 modes for rm9200 and at91sam9 to avoid
  looping over all available modes and thus preserving booting time
- keep static in "static const int modes[] __initconst" in *_pm_init()
  functions to avoid compilation error "error: section attribute cannot
  be specified for local variables const int modes[] __initconst = {"
- remove sama5_pm() introduced in v2

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

 arch/arm/mach-at91/pm.c         | 90 ++++++++++++++++++++++++++++++++++++++---
 arch/arm/mach-at91/pm.h         |  5 ++-
 arch/arm/mach-at91/pm_suspend.S | 41 +++++++++++++++++--
 3 files changed, 125 insertions(+), 11 deletions(-)

-- 
2.7.4

