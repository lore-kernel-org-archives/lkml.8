Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CCCC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4424720882
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgATMKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:10:15 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:4271 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgATMKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:10:15 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: XEy717sxOr71dn09PLikfej5708fGKlOQUL4mTn2B5K88s3962nMAUIWEZSTEpshtT/PAp/Fdj
 pziXUOmrO/lKSGbPkGv9lTAP+rJtmx2z57XH+1aLpgxloj4d4r/gZ7k5Z9P89/aIBhxEeEw/3j
 NiQvTci7gCsm4tfhhWzEx5onLERQFlv8P+ak5Fvpk3iU0nwQ6A4/E/vuTztuWxVTBT0oHooamO
 3AFG+OX2X4UQ88HLrAAEkC6quoyC11TivTefNwgmnCG9vQOVieGqOvFA+dWanrjXja2ebJMgSZ
 tN0=
X-IronPort-AV: E=Sophos;i="5.70,341,1574146800"; 
   d="scan'208";a="63869209"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2020 05:10:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Jan 2020 05:10:12 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Mon, 20 Jan 2020 05:10:10 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/8] PM fixes and improvements for SAM9X60
Date:   Mon, 20 Jan 2020 14:10:00 +0200
Message-ID: <1579522208-19523-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds fixes and improvements for SAM9X60 as follows:
- fix master clock register offset in pm_suspend.S
- add support for disable/enable PLL for SAM9X60
- minor fix in pm_suspend.S: s/sfr/sfrbu
- move SAM9X60's macros for PLL in include/linux/clk/at91_pmc.h

Thank you,
Claudiu Beznea

Claudiu Beznea (8):
  ARM: at91: pm: use proper master clock register offset
  Revert "ARM: at91: pm: do not disable/enable PLLA for ULP modes"
  ARM: at91: pm: add macros for plla disable/enable
  ARM: at91: pm: add pmc_version member to at91_pm_data
  ARM: at91: pm: s/sfr/sfrbu in pm_suspend.S
  clk: at91: move sam9x60's PLL register offsets to PMC header
  ARM: at91: pm: add plla disable/enable support for sam9x60
  ARM: at91: pm: add quirk for sam9x60's ulp1

 arch/arm/mach-at91/pm.c              |  35 ++++++-
 arch/arm/mach-at91/pm.h              |   2 +
 arch/arm/mach-at91/pm_data-offsets.c |   4 +
 arch/arm/mach-at91/pm_suspend.S      | 189 ++++++++++++++++++++++++++++++++---
 drivers/clk/at91/clk-sam9x60-pll.c   |  91 +++++++----------
 include/linux/clk/at91_pmc.h         |  23 +++++
 6 files changed, 270 insertions(+), 74 deletions(-)

-- 
2.7.4

