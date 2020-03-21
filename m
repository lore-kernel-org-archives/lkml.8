Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925B4C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 21:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CB920714
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 21:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="hfTkc95H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgCUVSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 17:18:05 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:45580 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgCUVSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 17:18:04 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48lD565Dt6z7N;
        Sat, 21 Mar 2020 22:18:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584825483; bh=uG8aosJL5ouyUREof74CuX6hBY1SWsaHGPF4NrQsGn8=;
        h=Date:From:Subject:To:Cc:From;
        b=hfTkc95HFjrRy6kS08dw/JjI0BYN3l3wiuvOBufcE51H7NvabA8UoRjEV0O4S0bMM
         F/njOBvncUzfse+mPYkMY5Z13/nwsS95uoSiBCfk8UGYe49DA+FopbUjVMXlmMvmAN
         W+/eFa4sV87dwadqyLwE8GKVTetQvx8gLQ8un9Kn1qekmeLTCIdOYykRiLkChdJNDC
         vfSa/oIMNwqQmnBUu9u/IXGjtmJAZLp8fStKjASMk56PWPJHwmKyzHeiFalu7T5CD1
         1kwmmUMLO5KuAZDtfKriZ/MUdtzCeMFJGtplshBR3ZQp4i3wuyZ1FE5l1LlVsn5dVK
         nj1+nZUMlI7qg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sat, 21 Mar 2020 22:18:02 +0100
Message-Id: <cover.1584825247.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 0/3] clk: at91: support configuring more clock parents via DT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends AT91 with clock references to PCKx and
PLLA/AUDIOPLL (for sama5d2).

First patch simplifies clock table allocation. Next two update the table
with missing clock pointers and IDs.

---
v2: rebased against current clk/clk-at91 tree
v3: non-functional changes + rebase
---
Michał Mirosław (3):
  clk: at91: optimize pmc data allocation
  clk: at91: allow setting PCKx parent via DT
  clk: at91: sama5d2: allow setting all PMC clock parents via DT

 drivers/clk/at91/at91rm9200.c    |  6 +++--
 drivers/clk/at91/at91sam9260.c   |  7 +++--
 drivers/clk/at91/at91sam9g45.c   |  6 +++--
 drivers/clk/at91/at91sam9n12.c   |  6 +++--
 drivers/clk/at91/at91sam9rl.c    |  6 +++--
 drivers/clk/at91/at91sam9x5.c    |  6 +++--
 drivers/clk/at91/pmc.c           | 44 ++++++++++++--------------------
 drivers/clk/at91/pmc.h           |  8 ++++--
 drivers/clk/at91/sam9x60.c       |  6 +++--
 drivers/clk/at91/sama5d2.c       | 12 ++++++---
 drivers/clk/at91/sama5d3.c       |  6 +++--
 drivers/clk/at91/sama5d4.c       |  6 +++--
 include/dt-bindings/clock/at91.h |  3 +++
 13 files changed, 72 insertions(+), 50 deletions(-)

-- 
2.20.1

