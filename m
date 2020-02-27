Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1C7C4BA35
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C62724685
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="CXFGnn7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgB0B1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 20:27:10 -0500
Received: from vps.xff.cz ([195.181.215.36]:44692 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgB0B1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 20:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582766828; bh=u1U5biX1YBQymIrRPcMlcQ+pX+ofoeqYtiKTMcwGEkk=;
        h=From:To:Cc:Subject:Date:From;
        b=CXFGnn7LldFRSTbl8VIBS9TBOVvyh4Cdp1xET3TKP+izNCKdFiQ4JfJH3pTQN56GC
         pvcfcDrInjqUXrShZzqsPoeLG01k6zfyiUTB72i6a/dO5Z+tEK6QtEAXRYWmxiaPW7
         bLs5SWzYcsggp9am9AShglyt2TiqMF37o3u0MPYc=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add support for Pine64 PinePhone Linux Smartphone
Date:   Thu, 27 Feb 2020 02:26:47 +0100
Message-Id: <20200227012650.1179151-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds an initial support for Pine64 PinePhone.

Please take a look.

thank you and regards,
  Ondrej Jirman


Changes in v2:
- make i2c2_pins default pinctrl config for i2c2 node
- add description of the differences between 1.0 and 1.1 to the
  commit message
- added copyright header for Martijn Braam
- drop pinctrl config from i2c1 and i2c2 nodes, since it's
  now the default
- extend comments on i2c2 and uart3 nodes to be more clear
- rebased on top of linux-next and resolved conflicts
- dropped the function-enumerator from leds

Changes not made:
- I didn't drop pinctrl configs on mmc0, mmc2 and uart3
  - these are actually not default in dtsi, as was suggested
- gpio-leds kept with the new function/color binding, but I dropped
  the function-enumerator

It seems intention for the future (since about 06-2019[0]) is for LEDs to not
have a devicename in their class name, because that's determinable
from the sysfs in other ways, and to use the function and color
properties instead of label in DT.

[0] https://lore.kernel.org/lkml/20190609190803.14815-5-jacek.anaszewski@gmail.com/T/

function-enumerator is supposed to be used if function/color don't
make the LED name unique for the board. [1] So I dropped function-enumerator
from my series, as it just added a numeric suffix to the LED name
for no reason.

[1] https://lore.kernel.org/patchwork/patch/1063388/

This follow the recent new board binding additions to the kernel (in 5.6):

https://elixir.bootlin.com/linux/v5.6-rc3/source/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi#L96

Ondrej Jirman (3):
  arm64: dts: sun50i-a64: Add i2c2 pins
  dt-bindings: arm: sunxi: Add PinePhone 1.0 and 1.1 bindings
  arm64: dts: allwinner: Add initial support for Pine64 PinePhone

 .../devicetree/bindings/arm/sunxi.yaml        |  10 +
 arch/arm64/boot/dts/allwinner/Makefile        |   2 +
 .../allwinner/sun50i-a64-pinephone-1.0.dts    |  11 +
 .../allwinner/sun50i-a64-pinephone-1.1.dts    |  11 +
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 379 ++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |   8 +-
 6 files changed, 420 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi

-- 
2.25.1

