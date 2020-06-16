Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB1BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A5D207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732854AbgFPP42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:56:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:36618 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732037AbgFPP4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:56:24 -0400
IronPort-SDR: bf5uMDBNk4jen6J46nzFNpCj8ylFKBPNWlmshos+osf6px4+IzIiVEAMVExTRZ+gcdKDiPJVOU
 Ox0FS2ciOZFQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 08:56:24 -0700
IronPort-SDR: tr/ybh8U9PRGgKz1/fMBQlds+13oaI9vCV6Vh6bPppUS/SKenSmjUq9C5NfVXMyZsMxAYDEy89
 PJe5LEbrUzPA==
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="449888063"
Received: from pperycz-mobl.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.213.235.69])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 08:56:20 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Paul Murphy <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/7] Add initial Keem Bay SoC / Board support
Date:   Tue, 16 Jun 2020 16:56:06 +0100
Message-Id: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch-set adds initial support for a new Intel Movidius SoC code-named
Keem Bay. The SoC couples an ARM Cortex A53 CPU with an Intel Movidius VPU.

This initial patch-set enables only the minimal set of components required to
make the Keem Bay EVM board boot into initramfs.

Brief summary of the patch-set:
* Patches 1-2 add the Keem Bay SCMI Mailbox driver (needed to enable SCMI in
  Keem Bay)
* Patch 3 adds the ARCH_KEEMBAY config option
* Patches 4-7 add minimal device tree for Keem Bay SoC and Keem Bay EVM
  (together with information about the SoC maintainers)

Regards,
Daniele


Daniele Alessandrelli (5):
  arm64: Add config for Keem Bay SoC
  dt-bindings: arm: Add Keem Bay bindings
  MAINTAINERS: Add maintainers for Keem Bay SoC
  arm64: dts: keembay: Add device tree for Keem Bay SoC
  arm64: dts: keembay: Add device tree for Keem Bay EVM board

Paul Murphy (2):
  dt-bindings: mailbox: Add Keem Bay SCMI mailbox bindings
  mailbox: keembay-scmi-mailbox: Add support for Keem Bay mailbox

 .../devicetree/bindings/arm/keembay.yaml      |  19 ++
 .../mailbox/intel,keembay-scmi-mailbox.yaml   |  44 ++++
 MAINTAINERS                                   |  16 ++
 arch/arm64/Kconfig.platforms                  |   5 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 arch/arm64/boot/dts/intel/keembay-evm.dts     |  55 +++++
 arch/arm64/boot/dts/intel/keembay-soc.dtsi    | 172 +++++++++++++++
 drivers/mailbox/Kconfig                       |   9 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/keembay-scmi-mailbox.c        | 203 ++++++++++++++++++
 include/dt-bindings/clock/keembay-clocks.h    | 188 ++++++++++++++++
 include/dt-bindings/power/keembay-power.h     |  19 ++
 12 files changed, 733 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/keembay.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/intel,keembay-scmi-mailbox.yaml
 create mode 100644 arch/arm64/boot/dts/intel/keembay-evm.dts
 create mode 100644 arch/arm64/boot/dts/intel/keembay-soc.dtsi
 create mode 100644 drivers/mailbox/keembay-scmi-mailbox.c
 create mode 100644 include/dt-bindings/clock/keembay-clocks.h
 create mode 100644 include/dt-bindings/power/keembay-power.h

-- 
2.26.2

