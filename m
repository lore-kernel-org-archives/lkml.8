Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D93C18E5B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 18:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0A8206B1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 18:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="cj9KAAvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgCOSiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:38:07 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:48245 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgCOSiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 14:38:07 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48gSqK13NPzw;
        Sun, 15 Mar 2020 19:38:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584297485; bh=wwHl4ckQVVyEhjv3zlUJvCyhzJS+DJkqAAlUhZ0JEtc=;
        h=Date:From:Subject:To:Cc:From;
        b=cj9KAAvrmBshazU43V+ZM8S8apAfivsy/u8csZwZC+zil0QzrdOM0Is1uUrNLJL20
         uGQdsYQJXzqqFk2+IgbzoyvL5/78MmT8akciCiuroTd2lqWrLndMHWRQ4v0BFoPAPJ
         h8YRR43KkbF8a3jyupMw3Jze0LGHHujdn+RWv3hnJzXW5ajp0qmHn4/vsKB+VKDl2p
         RWrV3JUnScZGQqZfXM18HjzHRsIsYnlybINU74LuW7TfCWGmw+/XkgpadJgp9Obk7K
         pqSH1L786H9t7M79SWphah1VjHl3psnesVvQp059VZZHqSBNwpHs8LRII4nmisY2Nb
         NMDr8O5YgPhrQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 15 Mar 2020 19:38:04 +0100
Message-Id: <cover.1584296940.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/3] clk: at91: support configuring PCKx parent via DT
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

This series extends AT91 with clock references to PCKx and PLLA/AUDIOPLL.

First patch simplifies clock table allocation. Next two update the table
with missing clock pointers and IDs.

Michał Mirosław (3):
  clk: at91: optimize pmc data allocation
  clk: at91: allow setting PCKx parent via DT
  clk: at91: sama5d2: allow setting all PMC clock parents via DT

 drivers/clk/at91/at91sam9260.c   |  7 +++--
 drivers/clk/at91/at91sam9rl.c    |  6 +++--
 drivers/clk/at91/at91sam9x5.c    |  6 +++--
 drivers/clk/at91/pmc.c           | 44 ++++++++++++--------------------
 drivers/clk/at91/pmc.h           |  8 ++++--
 drivers/clk/at91/sama5d2.c       | 12 ++++++---
 drivers/clk/at91/sama5d4.c       |  6 +++--
 include/dt-bindings/clock/at91.h |  3 +++
 8 files changed, 52 insertions(+), 40 deletions(-)

-- 
2.20.1

