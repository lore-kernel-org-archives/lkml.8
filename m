Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A32AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A68820768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbgF3HHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:07:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:2116 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730386AbgF3HHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:07:46 -0400
IronPort-SDR: hMOBxv46gEWRiUELMFJ/DDcT67owjSTk6G5DQ20loaaBjVoak47/A3lUPAJCbaEM/qf5Gund4X
 ORm/jDbCzTKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="125796951"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="125796951"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 00:07:45 -0700
IronPort-SDR: zN0xCHYhnQTCKA6dD9R2SaSnOqW7vy7mgzTVJKR9fw9+XOH8P45kstYiWnpOjPL58W/EcoHYFt
 KioPeOKNjU5g==
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="454499042"
Received: from letingex-mobl.ger.corp.intel.com ([10.214.248.180])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 00:07:37 -0700
Message-ID: <e7068d39c8ca60159ba7d1d5f917ef209570bb86.camel@linux.intel.com>
Subject: Re: [PATCH 0/7] Add initial Keem Bay SoC / Board support
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Paul Murphy <paul.j.murphy@intel.com>,
        Will Deacon <will@kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Date:   Tue, 30 Jun 2020 08:07:28 +0100
In-Reply-To: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
References: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-16 at 16:56 +0100, Daniele Alessandrelli wrote:
> Hi,
> 
> This patch-set adds initial support for a new Intel Movidius SoC
> code-named
> Keem Bay. The SoC couples an ARM Cortex A53 CPU with an Intel
> Movidius VPU.
> 
> This initial patch-set enables only the minimal set of components
> required to
> make the Keem Bay EVM board boot into initramfs.
> 
> Brief summary of the patch-set:
> * Patches 1-2 add the Keem Bay SCMI Mailbox driver (needed to enable
> SCMI in
>   Keem Bay)
> * Patch 3 adds the ARCH_KEEMBAY config option
> * Patches 4-7 add minimal device tree for Keem Bay SoC and Keem Bay
> EVM
>   (together with information about the SoC maintainers)
> 
> Regards,
> Daniele
> 
> 
> Daniele Alessandrelli (5):
>   arm64: Add config for Keem Bay SoC
>   dt-bindings: arm: Add Keem Bay bindings
>   MAINTAINERS: Add maintainers for Keem Bay SoC
>   arm64: dts: keembay: Add device tree for Keem Bay SoC
>   arm64: dts: keembay: Add device tree for Keem Bay EVM board
> 
> Paul Murphy (2):
>   dt-bindings: mailbox: Add Keem Bay SCMI mailbox bindings
>   mailbox: keembay-scmi-mailbox: Add support for Keem Bay mailbox
> 
>  .../devicetree/bindings/arm/keembay.yaml      |  19 ++
>  .../mailbox/intel,keembay-scmi-mailbox.yaml   |  44 ++++
>  MAINTAINERS                                   |  16 ++
>  arch/arm64/Kconfig.platforms                  |   5 +
>  arch/arm64/boot/dts/intel/Makefile            |   1 +
>  arch/arm64/boot/dts/intel/keembay-evm.dts     |  55 +++++
>  arch/arm64/boot/dts/intel/keembay-soc.dtsi    | 172 +++++++++++++++
>  drivers/mailbox/Kconfig                       |   9 +
>  drivers/mailbox/Makefile                      |   2 +
>  drivers/mailbox/keembay-scmi-mailbox.c        | 203
> ++++++++++++++++++
>  include/dt-bindings/clock/keembay-clocks.h    | 188 ++++++++++++++++
>  include/dt-bindings/power/keembay-power.h     |  19 ++
>  12 files changed, 733 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/arm/keembay.yaml
>  create mode 100644
> Documentation/devicetree/bindings/mailbox/intel,keembay-scmi-
> mailbox.yaml
>  create mode 100644 arch/arm64/boot/dts/intel/keembay-evm.dts
>  create mode 100644 arch/arm64/boot/dts/intel/keembay-soc.dtsi
>  create mode 100644 drivers/mailbox/keembay-scmi-mailbox.c
>  create mode 100644 include/dt-bindings/clock/keembay-clocks.h
>  create mode 100644 include/dt-bindings/power/keembay-power.h
> 

Ping



