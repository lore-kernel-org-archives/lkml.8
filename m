Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DB8C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35E92072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgAQLhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:37:03 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:14201 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgAQLhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:37:02 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: xwQShq9l4VBljm/WWgN5Nzy46/aIe3WKw2CNcekLNHivgKlF1Zj55l+jGlQdTwnJexIjf2qSx3
 y7O5KRiGC+Nj1TcZ6v6wl0CdQyJb/fKAIJkMlSht856b6SEUQASg/iIx+sL8L8UtdZp+75qUrZ
 jg64EI6V3opBvWozrDc4qvdEjOWTKRkdh479EP3KVOBTd0S7BIFN7YyLUwj3jlUmTMGOECbtEV
 yitTuNC4DopW93zt39wSgCfOAEmpIr1jxDNNbG0Z4JojU7RPJoLpJZN3/12xOMIBzo9fwAAKQA
 4+o=
X-IronPort-AV: E=Sophos;i="5.70,330,1574146800"; 
   d="scan'208";a="62954987"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2020 04:37:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 Jan 2020 04:37:02 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 17 Jan 2020 04:36:59 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/4] clock fixes for at91
Date:   Fri, 17 Jan 2020 13:36:45 +0200
Message-ID: <1579261009-4573-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series contains some fixes for at91 clocks (usb + sam9x60).

Thank you,
Claudiu Beznea

Claudiu Beznea (4):
  clk: at91: usb: continue if clk_hw_round_rate() returned zero
  clk: at91: sam9x60: fix usb clock parents
  clk: at91: usb: use proper usbs_mask
  clk: at91: usb: introduce num_parents in driver's structure

 drivers/clk/at91/clk-usb.c | 9 +++++++--
 drivers/clk/at91/sam9x60.c | 5 ++---
 2 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.7.4

