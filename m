Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F3CC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C23F207FB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgGQJEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:04:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:64962 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgGQJEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:04:36 -0400
IronPort-SDR: ReBdF2kDlJAalE31dpui2BQ7h3F9dIyoi0WpAFFWB2XkGk7Wd9nNZc6VqQKrJc37AI+jHDboxY
 PlQXi+bh9k8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="148719402"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="148719402"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 02:04:35 -0700
IronPort-SDR: F67Fa1TCehgIy0lp62zZmEZbdUhBWjDbI/UoAnbdVJ0a2AhLunr2MrXhD3sjlgdPwg6xzZgGhJ
 fw5nBjSg9pwQ==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="460785963"
Received: from enaessen-mobl1.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.251.86.9])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 02:04:31 -0700
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
        "Paul J. Murphy" <paul.j.murphy@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v4 0/5] Add initial Keem Bay SoC / Board support
Date:   Fri, 17 Jul 2020 10:04:09 +0100
Message-Id: <20200717090414.313530-1-daniele.alessandrelli@linux.intel.com>
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

Changes from v3 to v4:
* Renamed SoC dt-bindings file to intel,keembay.yaml
* Dropped clock and power domain dt-binding header files (because currently
  unused)

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

Daniele Alessandrelli (5):
  arm64: Add config for Keem Bay SoC
  dt-bindings: arm: Add Keem Bay bindings
  MAINTAINERS: Add maintainers for Keem Bay SoC
  arm64: dts: keembay: Add device tree for Keem Bay SoC
  arm64: dts: keembay: Add device tree for Keem Bay EVM board

 .../bindings/arm/intel,keembay.yaml           |  19 +++
 MAINTAINERS                                   |   8 ++
 arch/arm64/Kconfig.platforms                  |   5 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 arch/arm64/boot/dts/intel/keembay-evm.dts     |  37 ++++++
 arch/arm64/boot/dts/intel/keembay-soc.dtsi    | 123 ++++++++++++++++++
 6 files changed, 193 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/intel,keembay.yaml
 create mode 100644 arch/arm64/boot/dts/intel/keembay-evm.dts
 create mode 100644 arch/arm64/boot/dts/intel/keembay-soc.dtsi

-- 
2.26.2

