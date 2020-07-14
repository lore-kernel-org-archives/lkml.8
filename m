Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFB1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A122077D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgGNQNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:13:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:13532 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNQNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:13:34 -0400
IronPort-SDR: J4p+ZZZXWRiBv7V7QBj55bjGgh7yuctCSX1tlUNbCuirlYkDEki5wdd7n0Dr3qZkW8jPPh6Jy9
 htrsGGSis+ug==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="129030322"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="129030322"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 09:13:34 -0700
IronPort-SDR: M2GV48mxrIa6KXM+r29+j72O98SxWOk9QtJxzxsDNChLb9lKIxrJPrYYiUDlNHnZesvRYHp1UQ
 /W0RncsHyw/A==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="485930490"
Received: from yagellee-mobl.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.252.20.60])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 09:13:28 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
List-Id: <soc.lore.kernel.org>
To:     linux-arm-kernel@lists.infradead.org, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v3 0/7] Add initial Keem Bay SoC / Board support
Date:   Tue, 14 Jul 2020 17:12:58 +0100
Message-Id: <20200714161305.836348-1-daniele.alessandrelli@linux.intel.com>
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

This initial patch-set enables only the minimal set of components required
to make the Keem Bay EVM board boot into initramfs.

Changes from v2 to v3:
* Split dt-bindings patch into 3 different patches (SoC/board bindings,
  clock bindings, and power domains bindings).
* Added dual license (GPL-2.0-only or BSD-3-Clause) to dt-bindings header
  files and DTS files.

Changes from v1 to v2:
* Moved keembay-scmi-mailbox driver to a separate patchset
* Removed Keem Bay SCMI mailbox and SCMI node from Keem Bay SoC device tree

Regards,
Daniele

Daniele Alessandrelli (7):
  arm64: Add config for Keem Bay SoC
  dt-bindings: arm: Add Keem Bay bindings
  dt-bindings: clock: Add Keem Bay clock IDs
  dt-bindings: power: Add Keem Bay power domains
  MAINTAINERS: Add maintainers for Keem Bay SoC
  arm64: dts: keembay: Add device tree for Keem Bay SoC
  arm64: dts: keembay: Add device tree for Keem Bay EVM board

 .../devicetree/bindings/arm/keembay.yaml      |  19 ++
 MAINTAINERS                                   |  10 +
 arch/arm64/Kconfig.platforms                  |   5 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 arch/arm64/boot/dts/intel/keembay-evm.dts     |  39 ++++
 arch/arm64/boot/dts/intel/keembay-soc.dtsi    | 125 ++++++++++++
 include/dt-bindings/clock/keembay-clocks.h    | 188 ++++++++++++++++++
 include/dt-bindings/power/keembay-power.h     |  19 ++
 8 files changed, 406 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/keembay.yaml
 create mode 100644 arch/arm64/boot/dts/intel/keembay-evm.dts
 create mode 100644 arch/arm64/boot/dts/intel/keembay-soc.dtsi
 create mode 100644 include/dt-bindings/clock/keembay-clocks.h
 create mode 100644 include/dt-bindings/power/keembay-power.h

-- 
2.26.2

