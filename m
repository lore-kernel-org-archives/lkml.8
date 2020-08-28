Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C5DC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6ED208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgH1OUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:20:33 -0400
Received: from foss.arm.com ([217.140.110.172]:50328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgH1OU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:20:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4400E1FB;
        Fri, 28 Aug 2020 07:20:28 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E0F33F71F;
        Fri, 28 Aug 2020 07:20:26 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Min <chanho.min@lge.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wei Xu <xuwei5@hisilicon.com>
Subject: [PATCH v2 0/6] dt-bindings: Convert SP804 to Json-schema (and fix users)
Date:   Fri, 28 Aug 2020 15:20:12 +0100
Message-Id: <20200828142018.43298-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second attempt at converting the SP804 timer binding to yaml.
Compared to v1, I forbid additional properties, and included the primecell
binding. Also the clock-names property is now listed, although without
further requirements on the names. Changelog below.

--------------
The yaml conversion is done in the first patch, the remaining five fix
some DT users.

I couldn't test any of those DT files on actual machines, but tried
to make the changes in a way that would be transparent to at least the
Linux driver. The only other SP804 DT user I could find is FreeBSD,
but they seem to use a different binding (no clocks, but a
clock-frequency property).

Cheers,
Andre

Changelog v1 .. v2:
- Add additional-properties: false
- Allow clock-names property
- Include primecell binding
- Fix subject on Broadcom patch
- Add Florian's Tested-by: on Broadcom patch
- Add Linus' Acked-by: on Arm patch

Andre Przywara (6):
  dt-bindings: timers: sp-804: Convert to json-schema
  ARM: dts: arm: Fix SP804 users
  ARM: dts: NSP: Fix SP804 compatible node
  ARM: dts: hisilicon: Fix SP804 users
  ARM: dts: nspire: Fix SP804 users
  arm64: dts: lg: Fix SP804 users

 .../devicetree/bindings/timer/arm,sp804.txt   | 29 ------
 .../devicetree/bindings/timer/arm,sp804.yaml  | 93 +++++++++++++++++++
 arch/arm/boot/dts/arm-realview-pb11mp.dts     | 16 ++--
 arch/arm/boot/dts/bcm-nsp.dtsi                |  2 +-
 arch/arm/boot/dts/hi3620.dtsi                 | 30 ++++--
 arch/arm/boot/dts/hip04.dtsi                  |  4 +-
 arch/arm/boot/dts/mps2.dtsi                   |  6 +-
 arch/arm/boot/dts/nspire.dtsi                 | 12 ++-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts        |  4 +-
 arch/arm64/boot/dts/lg/lg1312.dtsi            |  6 +-
 arch/arm64/boot/dts/lg/lg1313.dtsi            |  6 +-
 11 files changed, 144 insertions(+), 64 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.yaml

-- 
2.17.1


