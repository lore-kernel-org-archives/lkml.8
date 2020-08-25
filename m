Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C98C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269FA20782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sFgnOLhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgHYG7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:59:19 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:9418 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgHYG7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598338757; x=1629874757;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=4WHglWt7OnttEOSn3/CASkkXpuDxsAGSzQEawn0TtmE=;
  b=sFgnOLhDvmJoOXcUl4DGy71J+EYYZOixyekz8jEtG2DM5T1av7CQOcMB
   FOgeyhTk3nyTbRMKvG1M8ufrBAkZjUOQIBNoVR2EhvEmEiNJtbv2EZnnV
   Q0ttBiqD5DubDI5MLuTDQ94JASQVe29QKFL1XQxYTNBQOrMp19Klvxysy
   vfHXwfPJRI8YAoa6fcV+Uy9f1g66HmrYzFrF1mvcL5iFHtqdcN8vnw5iM
   5xKEwDAiLzsqoPm2sNZi2KHCvluQIB7AdcwsXYDA5UOW09DzjV+aYyYVT
   GZYVtfvnMNRcjbYpQiEa/Q2/W3N5vnDmm0c/opoLuto7nAKgWjwKTa4cx
   A==;
IronPort-SDR: Vm4ReLPql6/fJ3mzMsP5zrtYuWkhPfkU20oOItWr7ZrpKtQddm0x/NXL7rLbQkXOTaqhtTTAYO
 PtrlFYMAinPQk/q3l9xuhuv16FtD8PhmMyL5FyY6zeYHZZHmf6vgocyAjNI85gG5gfnAKCFGXU
 dOcU7qTH5Hddx4/rCPObPzkj2wAsr/KcvO9kB4PHi1k2o84a7tNJhHRLsWUtS10fFTNwE7CRSY
 w8G11GYXs1FM1mXoP0x8vszwgPUACrohtXIooT26VXh+1rx2eB0x+uy71EFRud3x2U8Ioc7hFF
 ibg=
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="93013745"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2020 23:59:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 23:59:15 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 24 Aug 2020 23:59:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/3] fixes for at91 clocks
Date:   Tue, 25 Aug 2020 09:59:08 +0300
Message-ID: <1598338751-20607-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In this series I collected 2 patches send previously and add another that
fixes a compilation warning.

Changes in v2:
- add patches "clk: at91: remove the checking of parent_name" and
  "clk: at91: clk-main: update key before writing AT91_CKGR_MOR" in the same
  series and collect Reviewed-by tags
- in patch "clk: at91: remove the checking of parent_name" kept only
  the changes in at91_clk_register_peripheral() function as the changes in
  at91_clk_register_sam9x5_peripheral() introduced in v1 were included in
  commit b4c115c76184 ("clk: at91: clk-peripheral: add support for changeable parent rate");
  also adapt commit message for this patch;
- add "clk: at91: clk-sam9x60-pll: remove unused variable" in this series

Claudiu Beznea (3):
  clk: at91: remove the checking of parent_name
  clk: at91: clk-main: update key before writing AT91_CKGR_MOR
  clk: at91: clk-sam9x60-pll: remove unused variable

 drivers/clk/at91/clk-main.c        | 11 ++++++++---
 drivers/clk/at91/clk-peripheral.c  |  4 ++--
 drivers/clk/at91/clk-sam9x60-pll.c |  3 +--
 3 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.7.4

