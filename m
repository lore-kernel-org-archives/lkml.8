Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A641C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D2C2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgD3VLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:11:07 -0400
Received: from foss.arm.com ([217.140.110.172]:33596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgD3VLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:11:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C29E1FB;
        Thu, 30 Apr 2020 14:11:06 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76D8F3F68F;
        Thu, 30 Apr 2020 14:11:05 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v3 0/8] dt-bindings: calxeda: Convert bindings to json-schema
Date:   Thu, 30 Apr 2020 22:10:46 +0100
Message-Id: <20200430211054.30466-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the DT schema bindings conversion part of the v2 Calxeda update
series. The .dts part was already merged, so this tackles what is left.

This series converts the "prose" DT binding documentation for various
devices used by the Calxeda platform to the json-schema format, so that
the automatic checking actually does something useful.
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

Verified by trying to break every single assumption the bindings make
(in their example section): the tooling complained correctly.

Thanks,
Andre

Changelog:
v2 ... v3:
- adjust license to name both BSD and GPL
- add missing address specifier for clock nodes' names
- properly group phandle properties in SATA bindings example
- use itemised interrupt description in l2ecc binding
- limit reg-shift in the IPMI binding
- allow device_type property in IPMI binding

v1 ... v2:
- Remove unneeded property type from clocks and sgpio-gpio
- add additionalProperties: false to bindings missing it before
- limit number in "phydev" to the hardware constraint of 5 bits
- add required: properties to l2ecc binding
- fix enumeration of compatible strings in calxeda-ddr-ctrlr

Andre Przywara (8):
  dt-bindings: clock: Convert Calxeda clock bindings to json-schema
  dt-bindings: sata: Convert Calxeda SATA controller to json-schema
  dt-bindings: net: Convert Calxeda Ethernet binding to json-schema
  dt-bindings: phy: Convert Calxeda ComboPHY binding to json-schema
  dt-bindings: arm: Convert Calxeda L2 cache controller to json-schema
  dt-bindings: memory-controllers: Convert Calxeda DDR to json-schema
  dt-bindings: ipmi: Convert IPMI-SMIC bindings to json-schema
  dt-bindings: arm: Add Calxeda system registers json-schema binding

 .../bindings/arm/calxeda/hb-sregs.yaml        | 49 ++++++++++
 .../devicetree/bindings/arm/calxeda/l2ecc.txt | 15 ---
 .../bindings/arm/calxeda/l2ecc.yaml           | 42 ++++++++
 .../devicetree/bindings/ata/sata_highbank.txt | 44 ---------
 .../bindings/ata/sata_highbank.yaml           | 95 +++++++++++++++++++
 .../devicetree/bindings/clock/calxeda.txt     | 17 ----
 .../devicetree/bindings/clock/calxeda.yaml    | 82 ++++++++++++++++
 .../devicetree/bindings/ipmi/ipmi-smic.txt    | 25 -----
 .../devicetree/bindings/ipmi/ipmi-smic.yaml   | 63 ++++++++++++
 .../memory-controllers/calxeda-ddr-ctrlr.txt  | 16 ----
 .../memory-controllers/calxeda-ddr-ctrlr.yaml | 42 ++++++++
 .../devicetree/bindings/net/calxeda-xgmac.txt | 18 ----
 .../bindings/net/calxeda-xgmac.yaml           | 49 ++++++++++
 .../bindings/phy/calxeda-combophy.txt         | 17 ----
 .../bindings/phy/calxeda-combophy.yaml        | 51 ++++++++++
 15 files changed, 473 insertions(+), 152 deletions(-)
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

