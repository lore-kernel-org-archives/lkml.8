Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421F1C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22EE72063A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mQht0u40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgGOLYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:24:36 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62426 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgGOLYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594812274; x=1626348274;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=N6DV/31sOvQExw0bvi++MBVy/1MVzuDsKT0HgUq9HoE=;
  b=mQht0u40tiOPxCoO/H0zQPXfmvLM6kKGmqS9h8zAh7iiVqfsRJgdPLwB
   gI3MBWu2tJ3GtjPZbBSqfMxB5j4OW2SHMH8TmxURVROTy2QTk24sUwDnE
   Tk1Lwy7NDrhfXVwwZDkD6HqsT5WFPYwRRbkQFODVfAQvh6CLXzFeYoXt2
   BRSiDsB1NVRCKbPRxrsRRPeDjj4moOu7KR41NiosoxPi3xmT2lf6zw/42
   4dpFk/cPkn1TADCVpz5VLMusvNa4/be7N4HK0Y/inOTlr9/bbvR0neqDH
   9LB/ghgxXl79G1NC58R90ScDeLVVmQiH8GoJSen0Njjd06vI4XZagDc3t
   g==;
IronPort-SDR: ZKHXd4/fyx4RCYvlqHOKqh2HnOppqoJljtcZg0EbsfeF2z5ThN5f/JdhTh9kAoAaXrnh5YiuSI
 pMYCxeqmBSFLZyESAZlCRrQ+DSAR9DMAQU8lI7nZPqtCRzHd8BJ99JVslqs9c6KnIvNOdtkkfO
 mUEUSMWgeewAOYgC59D6tlbnfSNUsuuSS3e3Zs+nwmwfXClEHCSsZjcjMti8f2Ntgmr8+l2Tbc
 jvZ2qpgSDkwYidyrtxWA7TwwNIm3eywe9G7MEGIO4DsJlaW8bHTcYTpF7Rnc8lKekDHIYh3hYN
 pj0=
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="83962759"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 04:24:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 04:24:02 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 15 Jul 2020 04:23:58 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 00/19] clk: at91: add sama7g5 clock support
Date:   Wed, 15 Jul 2020 14:24:08 +0300
Message-ID: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
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

Claudiu Beznea (19):
  clk: at91: clk-generated: continue if __clk_determine_rate() returns
    error
  clk: at91: clk-generated: check best_rate against ranges
  clk: at91: clk-sam9x60-pll: fix mul mask
  clk: at91: sam9x60-pll: use frac when computing pll frequency
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

