Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A486D207C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGHRun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:50:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:31319 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgGHRum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:50:42 -0400
IronPort-SDR: WllNX5RC/mK+MeIPawjzjZ9DPX0WLlE395OKgm9AwNumLKy8K+6iENrTuwI2uaXGWlhdJhkgFP
 fiHAa3KbFj4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="232753512"
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; 
   d="scan'208";a="232753512"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 10:50:42 -0700
IronPort-SDR: VZ9GFeLDbkCynhnB5XBEGm94Mvjvl1gYqGh27J3Q+nnaOJKZVqiFBxTOrYUGUBjM4C+CELdZNk
 Qwm2XnLrr86w==
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; 
   d="scan'208";a="457591788"
Received: from sgyanama-mobl1.gar.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.252.5.67])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 10:50:37 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
List-Id: <soc.lore.kernel.org>
To:     linux-arm-kernel@lists.infradead.org, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Paul Murphy <paul.j.murphy@intel.com>,
        Will Deacon <will@kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: [PATCH v2 0/5] Add initial Keem Bay SoC / Board support
Date:   Wed,  8 Jul 2020 18:50:15 +0100
Message-Id: <20200708175020.194436-1-daniele.alessandrelli@linux.intel.com>
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

Changes from v1 to v2:
* Moved keembay-scmi-mailbox driver to a separate patchset
* Removed Keem Bay SCMI mailbox and SCMI node from Keem Bay SoC device tree

Regards,
Daniele


Daniele Alessandrelli (5):
  arm64: Add config for Keem Bay SoC
  dt-bindings: arm: Add Keem Bay bindings
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

