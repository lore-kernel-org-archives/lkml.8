Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB67C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962B0208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="X2KI36Vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgBWNOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 08:14:51 -0500
Received: from vps.xff.cz ([195.181.215.36]:42634 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWNOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 08:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582463688; bh=7u5RcG9coKsFNhS7jd0YQxz5uywiYal8+aKSaymmgCs=;
        h=From:To:Cc:Subject:Date:From;
        b=X2KI36Vnmx99OdMgF7wGS1IBvl6b+VOpvnu1QvmrwBfUFfuTUlzpAEeCN7KXqK5qk
         k1jiQkZY4u6kewOrR7rOOqIMAEvyMNIzbFq3sc5sEmUQkK0Sdg1QaxeT1QAnoQya/Y
         f0pUPdzycHCQ5dgFIf8tq4fuxs0U5NY/6Kpshii8=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] Add support for charger LED for AXP813 and TBS A711 Tablet
Date:   Sun, 23 Feb 2020 14:14:31 +0100
Message-Id: <20200223131435.681620-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tablet has a charger LED exposed on the top. This LED is controlled
by AXP813 PMIC. Add support for enabling the LED and using it either
for charging indication (handled by PMIC automatically) or for other uses
via user control.

Please take a look.

thank you and regards,
  Ondrej Jirman

Ondrej Jirman (4):
  dt-bindings: leds: Add a binding for AXP813 charger led
  leds: axp20x: Support charger LED on AXP20x like PMICs
  ARM: dts: axp813: Add charger LED
  ARM: dts: sun8i-a83t-tbs-a711: Enable charging LED

 .../devicetree/bindings/leds/leds-axp20x.yaml |  24 ++
 arch/arm/boot/dts/axp81x.dtsi                 |   5 +
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts     |   4 +
 drivers/leds/Kconfig                          |   7 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-axp20x.c                    | 240 ++++++++++++++++++
 drivers/mfd/axp20x.c                          |   3 +
 7 files changed, 284 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-axp20x.yaml
 create mode 100644 drivers/leds/leds-axp20x.c

-- 
2.25.1

