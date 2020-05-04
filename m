Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A572C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7090920707
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="a7j8WJNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgEDT6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:58:46 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:60934 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgEDT6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:58:46 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49GDFB1NJTzGl;
        Mon,  4 May 2020 21:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588622324; bh=qcQYscDQASAGGq1qfnXT5pHuuM+wfGhJkYYXvoJsvpU=;
        h=Date:From:Subject:To:Cc:From;
        b=a7j8WJNCy21YcZyhIxF0+HsMkUng70nkDXh0DalWFgLFFzLOmSPNszCOInbZBuNyt
         dLgiDXMdmHbjsdW6wL6HDFt7l5r+YNlCd9qE/yqCj0uweGcwwzYz0ZJ1j96MVi37KB
         qlLsxKE4cCC/Gj1QF+izr/RzXBn4TGzpTEGbjSo9oiH59X6lKXnhg2T8TVtLHG5/le
         7PwVGHDA305CuF7ap/KFhZ6FCTCcjH1G3/2P8iyTGPhV/Ss0OYGdoyGrg2+fkUxAz3
         AuUzNL50JoQwCJ6spZU98phxBweZVCPFo+f7G/QMZ9p1Z6mqTHOr1IpwWZ9y0RqS/p
         dzKcXzaQ6sIoA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 04 May 2020 21:58:37 +0200
Message-Id: <cover.1588622158.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v5 0/3] clk: at91: support configuring more clocks via DT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends AT91 clock support with references to PCKx and
PLLA/PLLB/AUDIOPLL. This makes the DT be able to fully specify (assign)
clock parents when needed.

First patch simplifies clock table allocation. Next two update the table
with missing clock pointers and IDs.


Michał Mirosław (3):
  clk: at91: optimize pmc data allocation
  clk: at91: allow setting PCKx parent via DT
  clk: at91: allow setting all PMC clock parents via DT

 drivers/clk/at91/at91rm9200.c    | 12 ++++++---
 drivers/clk/at91/at91sam9260.c   | 13 +++++++---
 drivers/clk/at91/at91sam9g45.c   | 10 +++++---
 drivers/clk/at91/at91sam9n12.c   | 12 ++++++---
 drivers/clk/at91/at91sam9rl.c    | 10 +++++---
 drivers/clk/at91/at91sam9x5.c    | 10 +++++---
 drivers/clk/at91/pmc.c           | 44 ++++++++++++--------------------
 drivers/clk/at91/pmc.h           |  8 ++++--
 drivers/clk/at91/sam9x60.c       | 10 +++++---
 drivers/clk/at91/sama5d2.c       | 12 ++++++---
 drivers/clk/at91/sama5d3.c       | 10 +++++---
 drivers/clk/at91/sama5d4.c       | 10 +++++---
 include/dt-bindings/clock/at91.h |  4 +++
 13 files changed, 106 insertions(+), 59 deletions(-)

-- 
2.20.1

