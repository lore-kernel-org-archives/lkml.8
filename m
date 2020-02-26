Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC7C4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900E824656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgBZSJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:09:13 -0500
Received: from foss.arm.com ([217.140.110.172]:40418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbgBZSJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:09:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A437330E;
        Wed, 26 Feb 2020 10:09:12 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C8563F881;
        Wed, 26 Feb 2020 10:09:11 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Richter <rric@kernel.org>, soc@kernel.org,
        Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 00/13] arm: calxeda: update DTS, bindings and MAINTAINERS
Date:   Wed, 26 Feb 2020 18:08:48 +0000
Message-Id: <20200226180901.89940-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series is an answer to the attempt [1] of removing the Calxeda
Highbank platform support from the kernel. Apart from the pending removal
of ARM32 host KVM support from the kernel, the lack of proper DT schema
bindings was another major reason for Rob's series.

This series addresses this. The first four patches adjust the .dts files
to pass the existing (mostly generic) DT schema binding checks. Those
changes should not affect the functionality.
The following eight patches then convert the "prose" DT binding
documentation to the json-schema format, so that the automatic checking
actually does something useful.
After those patches "make dtbs_check" comes back clean for the two .dts
files in the kernel, and "dt_validate -m" reports only those three
not-covered nodes (on Highbank, only the last one on Midway):
arm,cortex-a9-twd-timer
arm,cortex-a9-twd-wdt
calxeda,hb-sdhci
The first two are generic ARM devices, for which the binding doc just
does not have been converted yet. The SDHCI controller is actually
disabled in the DTs, and the SD slot is populated on very few special
systems only, also there has never been a driver in the kernel for
this device anyway.

The final patch then changes the MAINTAINERS file to hand over the
maintainership to me. I have a working machine under my desk and have
some interest in keeping this platform support alive.

Cheers,
Andre.

[1] https://lore.kernel.org/linux-arm-kernel/20200218171321.30990-1-robh@kernel.org/

Andre Przywara (13):
  arm: dts: calxeda: Basic DT file fixes
  arm: dts: calxeda: Provide UART clock
  arm: dts: calxeda: Fix interrupt grouping
  arm: dts: calxeda: Group port-phys and sgpio-gpio items
  dt-bindings: clock: Convert Calxeda clock bindings to json-schema
  dt-bindings: sata: Convert Calxeda SATA controller to json-schema
  dt-bindings: net: Convert Calxeda Ethernet binding to json-schema
  dt-bindings: phy: Convert Calxeda ComboPHY binding to json-schema
  dt-bindings: arm: Convert Calxeda L2 cache controller to json-schema
  dt-bindings: memory-controllers: convert Calxeda DDR to json-schema
  dt-bindings: ipmi: Convert IPMI-SMIC bindings to json-schema
  dt-bindings: arm: Add Calxeda system registers json-schema binding
  MAINTAINERS: Update Calxeda Highbank maintainership

 .../bindings/arm/calxeda/hb-sregs.yaml        | 47 +++++++++
 .../devicetree/bindings/arm/calxeda/l2ecc.txt | 15 ---
 .../bindings/arm/calxeda/l2ecc.yaml           | 36 +++++++
 .../devicetree/bindings/ata/sata_highbank.txt | 44 ---------
 .../bindings/ata/sata_highbank.yaml           | 96 +++++++++++++++++++
 .../devicetree/bindings/clock/calxeda.txt     | 17 ----
 .../devicetree/bindings/clock/calxeda.yaml    | 83 ++++++++++++++++
 .../devicetree/bindings/ipmi/ipmi-smic.txt    | 25 -----
 .../devicetree/bindings/ipmi/ipmi-smic.yaml   | 56 +++++++++++
 .../memory-controllers/calxeda-ddr-ctrlr.txt  | 16 ----
 .../memory-controllers/calxeda-ddr-ctrlr.yaml | 41 ++++++++
 .../devicetree/bindings/net/calxeda-xgmac.txt | 18 ----
 .../bindings/net/calxeda-xgmac.yaml           | 47 +++++++++
 .../bindings/phy/calxeda-combophy.txt         | 17 ----
 .../bindings/phy/calxeda-combophy.yaml        | 47 +++++++++
 MAINTAINERS                                   |  2 +-
 arch/arm/boot/dts/ecx-2000.dts                |  5 +-
 arch/arm/boot/dts/ecx-common.dtsi             | 17 ++--
 arch/arm/boot/dts/highbank.dts                | 11 +--
 19 files changed, 468 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/sata_highbank.txt
 create mode 100644 Documentation/devicetree/bindings/ata/sata_highbank.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/calxeda.txt
 create mode 100644 Documentation/devicetree/bindings/clock/calxeda.yaml
 delete mode 100644 Documentation/devicetree/bindings/ipmi/ipmi-smic.txt
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/calxeda-xgmac.txt
 create mode 100644 Documentation/devicetree/bindings/net/calxeda-xgmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/calxeda-combophy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/calxeda-combophy.yaml

-- 
2.17.1

