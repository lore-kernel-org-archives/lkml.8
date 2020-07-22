Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB86C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A561E20709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="l5K36Zwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgGVHif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:38:35 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:23373 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgGVHie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403513; x=1626939513;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=nHp8k5w3QtQPtWSzCw0VnPwsZy9y/gV958fJNTqFCcs=;
  b=l5K36Zwxa1fh/cmV64vq+ef6avel9wrRIhwoD3NUOI+W8GDiTLKYR4Wz
   BZkln4Ur+L4NQxUmcS8eNCoW7CMLPD6NCXx6uBbEZkr4tWfBGpwdL+1WD
   FCTj0wBR9lbE1EOEsllcsJOC+7FPcQ7enz1jmIyETNvTKXHOCPrGSHsQD
   qwd1hXD5fPrXS0OttpM53aXwJRwraOUftge41KRPs2ek4SuqBT3ZTrPUq
   pdO7zsixRUGwuT/8j+htKW3btDZI5lSxCS48qP/Knl/d7EZLs5lCU6j+7
   PGacf4XVP2UpCr7JwtkTiMdhKkrA/x6zg55UGojQnNrBVz23GNGLwwUxn
   w==;
IronPort-SDR: 9cOQiqpjtiIEDroJ4fvdo19X6mUJKXuYuQhh4w21Ie504igDV+aGJuj299kX+hW3Fe7U3XlOuC
 qXQlkpEepdwxQQn2dRTaL5Y0J76Q7YSMO9w5fnkYcWjajaXt0Ei+Ft0qb9rK9hPBp/tpuZ6XIi
 2HnXCfRDJVjj0edbMM/VQ0CYNUtwJZruIWBxpogyGDlp88ol8mxOqkyiV4BHJHIZYxTEQZ3XzR
 NWDTydNDlyGhIxqVqaN69a4u0YjISrFshh7Wj+pnGVDe2ljevAXPCfna1XWmy9gl415TW3xrKy
 GEQ=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="82772018"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:38:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:38:33 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:38:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 00/18] clk: at91: add sama7g5 clock support
Date:   Wed, 22 Jul 2020 10:38:08 +0300
Message-ID: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds clock support for SAMA7G5. The first patches in
series, patches 1/19-9/19, contains some fixes (let me know if
you want to send them as a separate series).

For SAMA7G5 clock support some AT91 clock drivers needed changes
because:
1/ some of generated, master and peripheral clocks could have
   changeable parents (being able to request frequency changes
   from parent)
2/ generated and programmable clocks parents needed a mux table
   as the hardware parent index doesn't correspond with software
   parent index
3/ there are 4 new master clocks, MCK1..4 (compared with previous
   AT91 architectures) which are controlled separately from MCK0
4/ some of the PLLs have 2 outputs the internal block schema being
   as follows:

   +------+            +--------+
   | FRAC |-----+----->| DIVPMC |--->
   +------+     |      +--------+
                |
                |      +--------+
                +----->|  DIVIO |--->
                       +--------+

   For this, the clk-sam9x60-pll driver has been re-factored.

Changes in v2:
- collected Reviewed-by tags
- squashed patches 4/19 and 7/19 from previous version
- fixed typos in commit description of patch 6/19 from previous version
- improve commit description on patch
  "clk: at91: sckc: register slow_rc with accuracy option"
- improve a bit commit description on patch
  "clk: at91: replace conditional operator with double logical not"
- use u64 type for fcore variable in
  "clk: at91: sam9x60-pll: check fcore against ranges"

Claudiu Beznea (18):
  clk: at91: clk-generated: continue if __clk_determine_rate() returns
    error
  clk: at91: clk-generated: check best_rate against ranges
  clk: at91: clk-sam9x60-pll: fix mul mask
  clk: at91: sam9x60-pll: use logical or for range check
  clk: at91: sam9x60-pll: check fcore against ranges
  clk: at91: sam9x60-pll: use frac when setting frequency
  clk: at91: sam9x60: fix main rc oscillator frequency
  clk: at91: sckc: register slow_rc with accuracy option
  clk: at91: replace conditional operator with double logical not
  clk: at91: clk-generated: pass the id of changeable parent at
    registration
  clk: at91: clk-generated: add mux_table option
  clk: at91: clk-master: add master clock support for SAMA7G5
  clk: at91: clk-peripheral: add support for changeable parent rate
  clk: at91: clk-programmable: add mux_table option
  clk: at91: add macro for pll ids mask
  clk: at91: clk-sam9x60-pll: re-factor to support plls with multiple
    outputs
  clk: at91: clk-utmi: add utmi support for sama7g5
  clk: at91: sama7g5: add clock support for sama7g5

 drivers/clk/at91/Makefile           |    1 +
 drivers/clk/at91/at91rm9200.c       |    3 +-
 drivers/clk/at91/at91sam9260.c      |    3 +-
 drivers/clk/at91/at91sam9g45.c      |    3 +-
 drivers/clk/at91/at91sam9n12.c      |    5 +-
 drivers/clk/at91/at91sam9rl.c       |    3 +-
 drivers/clk/at91/at91sam9x5.c       |    7 +-
 drivers/clk/at91/clk-generated.c    |   44 +-
 drivers/clk/at91/clk-main.c         |    6 +-
 drivers/clk/at91/clk-master.c       |  310 +++++++++-
 drivers/clk/at91/clk-peripheral.c   |  111 +++-
 drivers/clk/at91/clk-programmable.c |   11 +-
 drivers/clk/at91/clk-sam9x60-pll.c  |  547 ++++++++++++------
 drivers/clk/at91/clk-system.c       |    4 +-
 drivers/clk/at91/clk-utmi.c         |  103 +++-
 drivers/clk/at91/dt-compat.c        |   25 +-
 drivers/clk/at91/pmc.h              |   43 +-
 drivers/clk/at91/sam9x60.c          |   64 ++-
 drivers/clk/at91/sama5d2.c          |   41 +-
 drivers/clk/at91/sama5d3.c          |    6 +-
 drivers/clk/at91/sama5d4.c          |    7 +-
 drivers/clk/at91/sama7g5.c          | 1059 +++++++++++++++++++++++++++++++++++
 drivers/clk/at91/sckc.c             |    5 +-
 include/linux/clk/at91_pmc.h        |    4 +
 24 files changed, 2140 insertions(+), 275 deletions(-)
 create mode 100644 drivers/clk/at91/sama7g5.c

-- 
2.7.4

