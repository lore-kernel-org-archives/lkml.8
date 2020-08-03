Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61857C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D44720738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Fjc7HVvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgHCHZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 03:25:25 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:39719 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgHCHZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 03:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596439524; x=1627975524;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=oMWg5fmcj4i94jtAVqNu7HyEx05/B6CcovlpJXQlAQM=;
  b=Fjc7HVvoDHE8U6JvghiL78AYZwOypBi4aGWLJysMXTNwQb8xqOSEuwfA
   386fnw5xiNZgS5lOm5gIm51X9IMZrJ+A9bP/aiJO/rd88TNX1KCnaGzOa
   5UFDcbWbPsac6I7xUgSyNCylI/12uDodD14WxxVN8DXOELW7M6JZHYXAv
   LSpkL0NMkDpA+ch5NmRdsD/WFXhrzbOWTO04NnlVPtHfev2WyoiIAUGhi
   1gSPcgLwlc0tcV+B2shXMwCPWFLoZmIh5I1XaY2RJmi8XBT1FDobJFBoO
   Eh+pjUFlgJVAjgfruGVfyrFk3eziNCK6ZbSoIRT7h7JI8kcQ8HX2pRkZ5
   w==;
IronPort-SDR: HK3YbIkszbVy/V2MqxfrhoqdC8RYpFvC1yUb/psG551OXECq80wJc4OPKyy0WUFErM1L9/vF5n
 GqGIf9Y4sdvuKKVjlwmIlCOOfsrtafVXhJYFWZvytF4fyQ1zDal0v6eh+DdWfMsbuuvrFcapS/
 vTpETQuf8VK7iYYLYhOIB/RrYiyLouBtoxlM/jQGL3lxzH7nAr/6mgK+6g1NttL3F490mx/Ryx
 Xq3Ec/0MYUS3h6yz4hQqan4rfftQV3AF8kJ+Hud5s85O6l738pXPZOedV/roLhXmb7L/f3dagR
 KPA=
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="21509731"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2020 00:25:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 3 Aug 2020 00:25:22 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 3 Aug 2020 00:25:19 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] AT91 PM improvements
Date:   Mon, 3 Aug 2020 10:25:14 +0300
Message-ID: <1596439517-12993-1-git-send-email-claudiu.beznea@microchip.com>
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

Claudiu Beznea (3):
  ARM: at91: pm: add support for ulp0 fast mode
  ARM: at91: pm: add per soc validation of pm modes
  ARM: at91: pm: put node after its usage

 arch/arm/mach-at91/at91rm9200.c | 10 +++++-
 arch/arm/mach-at91/at91sam9.c   |  9 ++++-
 arch/arm/mach-at91/generic.h    | 20 +++++------
 arch/arm/mach-at91/pm.c         | 79 +++++++++++++++++++++++++++++++++++------
 arch/arm/mach-at91/pm.h         |  5 +--
 arch/arm/mach-at91/pm_suspend.S | 41 ++++++++++++++++++---
 arch/arm/mach-at91/sam9x60.c    | 11 +++++-
 arch/arm/mach-at91/sama5.c      | 21 +++++++++--
 8 files changed, 165 insertions(+), 31 deletions(-)

-- 
2.7.4

