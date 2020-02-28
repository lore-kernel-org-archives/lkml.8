Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4050BC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E24246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgB1Nvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:51:42 -0500
Received: from foss.arm.com ([217.140.110.172]:38560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgB1Nvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:51:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5D8531B;
        Fri, 28 Feb 2020 05:51:40 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F17323F7B4;
        Fri, 28 Feb 2020 05:51:38 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Robert Richter <rric@kernel.org>, Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 0/5] arm: calxeda: update DTS and MAINTAINERS
Date:   Fri, 28 Feb 2020 13:51:01 +0000
Message-Id: <20200228135106.220620-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is mostly a repost of the DT and MAINTAINERS part of the
previous v2 series, with Rob's ACKs added.
Please apply to armsoc!
Patches based on soc/for-next (c247a41835698).

------------------
This series is an answer to the attempt [1] of removing the Calxeda
Highbank platform support from the kernel. Apart from the pending removal
of ARM32 host KVM support from the kernel, the lack of proper DT schema
bindings and passing checks was another major reason for Rob's series.

This series addresses the .dts part of the problem.
The first four patches adjust the .dts files to pass the existing
(mostly generic) DT schema binding checks, also prepare for passing
later when the schemas get updated in a parallel series.
Those changes do not affect the functionality.

The final patch then changes the MAINTAINERS file to hand over the
maintainership to me. I have a working machine under my desk and have
some interest in keeping this platform support alive.

Changelog:
v2 ... v3:
- Remove schema binding conversions from this series
- Re-add #address-cells = <0> to the GIC node
- Add Rob's ACKs

v1 ... v2:
- Remove unneeded property type from clocks and sgpio-gpio
- add additionalProperties: false to bindings missing it before
- limit number in "phydev" to the hardware constraint of 5 bits
- add required: properties to l2ecc binding
- fix enumeration of compatible strings in calxeda-ddr-ctrlr

Cheers,
Andre.

[1] https://lore.kernel.org/linux-arm-kernel/20200218171321.30990-1-robh@kernel.org/

Andre Przywara (5):
  arm: dts: calxeda: Basic DT file fixes
  arm: dts: calxeda: Provide UART clock
  arm: dts: calxeda: Fix interrupt grouping
  arm: dts: calxeda: Group port-phys and sgpio-gpio items
  MAINTAINERS: Update Calxeda Highbank maintainership

 MAINTAINERS                       |  2 +-
 arch/arm/boot/dts/ecx-2000.dts    |  6 ++----
 arch/arm/boot/dts/ecx-common.dtsi | 17 +++++++++--------
 arch/arm/boot/dts/highbank.dts    | 11 ++++-------
 4 files changed, 16 insertions(+), 20 deletions(-)

-- 
2.17.1

