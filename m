Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF196C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBCB220789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407354AbgFYVnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:43:32 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58565 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407318AbgFYVnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:43:25 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 6B93AFF805;
        Thu, 25 Jun 2020 21:43:18 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kamel.bouhara@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 0/9] clocksource/drivers/timer-atmel-tcb: add sama5d2 support
Date:   Thu, 25 Jun 2020 23:43:03 +0200
Message-Id: <20200625214312.1382063-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series mainly adds sama5d2 support where we need to avoid using
clock index 0 because that clock is never enabled by the driver.

There is also a rework of the 32khz clock handling so it is not used for
clockevents on 32 bit counter because the increased rate improves the
resolution and doesn't have any drawback with that counter width. This
replaces a patch that has been carried in the linux-rt tree for a while.

Changes in v5:
 - Rebased on top of v5.8-rc1
 - Added Rob's ack

Changes in v4:
 - Rework binding documentation

Changes in v3:
 - Moved the child node documentation to the parent documentation

Changes in v2:
 - Rebased on v5.7-rc1
 - Moved the binding documentation to its proper place
 - Added back the atmel,tcb-timer child node documentation

Alexandre Belloni (8):
  dt-bindings: atmel-tcb: convert bindings to json-schema
  dt-bindings: microchip: atmel,at91rm9200-tcb: add sama5d2 compatible
  ARM: dts: at91: sama5d2: add TCB GCLK
  clocksource/drivers/timer-atmel-tcb: rework 32khz clock selection
  clocksource/drivers/timer-atmel-tcb: fill tcb_config
  clocksource/drivers/timer-atmel-tcb: stop using the 32kHz for
    clockevents
  clocksource/drivers/timer-atmel-tcb: allow selecting first divider
  clocksource/drivers/timer-atmel-tcb: add sama5d2 support

Kamel Bouhara (1):
  ARM: at91: add atmel tcb capabilities

 .../devicetree/bindings/mfd/atmel-tcb.txt     |  56 -------
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 155 ++++++++++++++++++
 arch/arm/boot/dts/sama5d2.dtsi                |  12 +-
 drivers/clocksource/timer-atmel-tcb.c         | 101 +++++++-----
 include/soc/at91/atmel_tcb.h                  |   5 +
 5 files changed, 224 insertions(+), 105 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml

-- 
2.26.2

