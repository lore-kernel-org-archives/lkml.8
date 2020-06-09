Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4FFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF04B2076C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgFIBOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:14:53 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:53198 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgFIBOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 21:14:49 -0400
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id 335D5AD6BE;
        Tue,  9 Jun 2020 09:14:42 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P3328T139696397076224S1591665277471272_;
        Tue, 09 Jun 2020 09:14:39 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <9366da969142352c044371455015e4cb>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: vkoul@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        devicetree@vger.kernel.org, Andy Yan <andy.yan@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Johan Jonker <jbx6244@gmail.com>, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Carlos de Paula <me@carlosedp.com>,
        dmaengine@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2 0/13] Patches to improve transfer efficiency for Rockchip SoCs.
Date:   Tue,  9 Jun 2020 09:14:14 +0800
Message-Id: <1591665267-37713-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Changes in v2:
- fix FATAL ERROR: Unable to parse input tree

Sugar Zhang (13):
  dmaengine: pl330: Remove the burst limit for quirk 'NO-FLUSHP'
  dmaengine: pl330: Add quirk 'arm,pl330-periph-burst'
  dt-bindings: dma: pl330: Document the quirk 'arm,pl330-periph-burst'
  ARM: dts: rk3036: Add 'arm,pl330-periph-burst' for dmac
  ARM: dts: rk322x: Add 'arm,pl330-periph-burst' for dmac
  ARM: dts: rk3288: Add 'arm,pl330-periph-burst' for dmac
  ARM: dts: rk3xxx: Add 'arm,pl330-periph-burst' for dmac
  ARM: dts: rv1108: Add 'arm,pl330-periph-burst' for dmac
  arm64: dts: px30: Add 'arm,pl330-periph-burst' for dmac
  arm64: dts: rk3308: Add 'arm,pl330-periph-burst' for dmac
  arm64: dts: rk3328: Add 'arm,pl330-periph-burst' for dmac
  arm64: dts: rk3368: Add 'arm,pl330-periph-burst' for dmac
  arm64: dts: rk3399: Add 'arm,pl330-periph-burst' for dmac

 .../devicetree/bindings/dma/arm-pl330.txt          |  1 +
 arch/arm/boot/dts/rk3036.dtsi                      |  1 +
 arch/arm/boot/dts/rk322x.dtsi                      |  1 +
 arch/arm/boot/dts/rk3288.dtsi                      |  3 ++
 arch/arm/boot/dts/rk3xxx.dtsi                      |  3 ++
 arch/arm/boot/dts/rv1108.dtsi                      |  1 +
 arch/arm64/boot/dts/rockchip/px30.dtsi             |  1 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi           |  2 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  1 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  2 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  2 +
 drivers/dma/pl330.c                                | 44 +++++++++++++++-------
 12 files changed, 49 insertions(+), 13 deletions(-)

-- 
2.7.4



