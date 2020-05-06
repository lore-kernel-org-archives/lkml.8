Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA82BC47258
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CACB7206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgEFIGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:06:04 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51591 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgEFIGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:06:04 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B644B20004;
        Wed,  6 May 2020 08:06:00 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kamel.bouhara@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 0/9] clocksource/drivers/timer-atmel-tcb: add sama5d2 support
Date:   Wed,  6 May 2020 10:05:45 +0200
Message-Id: <20200506080554.283177-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series mainly adds sama5d2 support where we need to avoid using
clock index 0 because that clock is never enabled by the driver.

There is also a rework of the 32khz clock handling so it is not used for
clockevents on 32 bit counter because the increased rate improves the
resolution and doesn't have any drawback with that counter width. This
replaces a patch that has been carried in the linux-rt tree for a while.

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
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 150 ++++++++++++++++++
 arch/arm/boot/dts/sama5d2.dtsi                |  12 +-
 drivers/clocksource/timer-atmel-tcb.c         | 101 +++++++-----
 include/soc/at91/atmel_tcb.h                  |   5 +
 5 files changed, 219 insertions(+), 105 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml

-- 
2.26.2

