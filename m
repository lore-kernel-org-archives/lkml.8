Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EBEC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B42720578
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="kSWtpuY7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NWj7ObKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgFOIl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:41:26 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:38213 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728746AbgFOIlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A708058014B;
        Mon, 15 Jun 2020 04:41:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=+bVqouurUT66sh/V7qCOyewZgm
        Om4zf5CsQ/aE+/nKM=; b=kSWtpuY7oh3nIVsB84U6kHntMyzLB0ovAVGNekE7np
        4ivgzbWK5JYFKUMhlcFd3C/nHb24yGvLtD1k12L8b5mM2GGnrmX0d47Y2dtN+ziA
        eqj1Uz+jKw4jT+yakN9U9bn9cHGQEsUN41K4oYYi/97opR/WebbXQsWRr48bY+GO
        qbRIb7n6A0eT91SM/lgcEBe6lpQZzUh0tmAZrvWN7l37fcqcNaMGtANg1knYsHr5
        cVUxAShxxnsoPI6UJ+Xo3X/UOXf+eUa7vZ4pEoMUwYaxSrOtAdKS7I3EHYvyAqyj
        bk5IXU35J/10o/NuWhEboR4bN/qpSwI+rvaj30XIkm7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=+bVqouurUT66sh/V7
        qCOyewZgmOm4zf5CsQ/aE+/nKM=; b=NWj7ObKcJQBQy+eooDtaDS2Ih/HIGgCGh
        WhVqoSjo5CsmyejghNKWR83bOtfkd00RD/v72A/VRSZQhQ0zBt4wq6uhoVZiyj+z
        umLJpy+FTqiacJxT9xVIiJUMogJk+CFbLv/fg1oN3nr5PWWeeIEpBpPz/y6Ft4Di
        tpn/vodjy0/u2LQ5P+4R/dyRl5J0XmvZou+d+SZhQ3QRRSkxezQHsJkQOLy4hQP2
        7DKNx/z4yI3J6wlDClmNJQPsHwlP/weUxRz7HH5hshhp+/nI93+ZX2MGlSHte0G7
        YqO/l0/vIfjg+XA8/Ew8r5nOsuOy636BRHtGigXJaU6jkt8qwj0/A==
X-ME-Sender: <xms:MDTnXnpsfFhhR2bsMQHexTsgsblBhHRS5T-6Dfx4QAxc3Cy3DWk8TQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcu
    tfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvg
    hrnhepjeffheduvddvvdelhfegleelfffgieejvdehgfeijedtieeuteejteefueekjeeg
    necukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:MDTnXhro3Yr_tKP-qPuJLu8iXlGaa--icM2hbEkqPnVdAooS55MneA>
    <xmx:MDTnXkOHW_pxue5L2YeWi9aEaYSm7YkrvoExN0jQCGwa_3mqdKv3Jg>
    <xmx:MDTnXq41JuW2CM3AHUII2yM7SllYfSwD-zsecLhOBTanerD2FbHf_A>
    <xmx:MjTnXmwwGZSIwjsKQKUlVjD2wzRm5R9TMjedPgAemWXkWppyKlfS3w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 33FDE3280064;
        Mon, 15 Jun 2020 04:41:20 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 00/27] clk: bcm: rpi: Add support for BCM2711 firmware clocks
Date:   Mon, 15 Jun 2020 10:40:40 +0200
Message-Id: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since the whole DRM/HDMI support began to grow fairly big, I've chosen
to split away the two discussions between the firmware clocks and the
HDMI support.

Let me know what you think,
Maxime

Cc: bcm-kernel-feedback-list@broadcom.com
Cc: devicetree@vger.kernel.org
Cc: Kamal Dasu <kdasu.kdev@gmail.com>
Cc: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>

Changes from v4:
  - Rebased on 5.8-rc1
  - Added more tags
  - Fixed a typo in a variable name

Changes from v3:
  - Moved the firmware structure to the driver, and changed for u32
  - Prevented cache issues with MMIO driver
  - Removed message when discovering min and max rates
  - Added the gathered tags

Changes from v2:
  - Rebased on top of next-20200526
  - Split away from the HDMI series
  - Fixed an of_node leakage in the firmware driver
  - Fixed an of_node leakage in the firmware clocks driver
  - Added the min/max rate retrieval to all the firmware clocks
  - Added proper name for the firmware clocks
  - Removed the PLLB setup from the firmware clocks and moved it back to
    the MMIO driver

Florian Fainelli (1):
  dt-bindings: arm: bcm: Convert BCM2835 firmware binding to YAML

Maxime Ripard (26):
  dt-bindings: clock: Add a binding for the RPi Firmware clocks
  firmware: rpi: Only create clocks device if we don't have a node for it
  clk: bcm: rpi: Allow the driver to be probed by DT
  clk: bcm: rpi: Statically init clk_init_data
  clk: bcm: rpi: Use clk_hw_register for pllb_arm
  clk: bcm: rpi: Remove global pllb_arm clock pointer
  clk: bcm: rpi: Make sure pllb_arm is removed
  clk: bcm: rpi: Remove pllb_arm_lookup global pointer
  clk: bcm: rpi: Switch to clk_hw_register_clkdev
  clk: bcm: rpi: Make sure the clkdev lookup is removed
  clk: bcm: rpi: Use CCF boundaries instead of rolling our own
  clk: bcm: rpi: Create a data structure for the clocks
  clk: bcm: rpi: Add clock id to data
  clk: bcm: rpi: Pass the clocks data to the firmware function
  clk: bcm: rpi: Rename is_prepared function
  clk: bcm: rpi: Split pllb clock hooks
  clk: bcm: rpi: Make the PLLB registration function return a clk_hw
  clk: bcm: rpi: Add DT provider for the clocks
  clk: bcm: rpi: Add an enum for the firmware clocks
  clk: bcm: rpi: Discover the firmware clocks
  clk: bcm: rpi: Give firmware clocks a name
  Revert "clk: bcm2835: remove pllb"
  ARM: dts: bcm2711: Add firmware clocks node
  clk: bcm2835: Allow custom CCF flags for the PLLs
  clk: bcm2835: Don't cache the PLLB rate
  clk: bcm: rpi: Remove the quirks for the CPU clock

 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt  |  14 +---
 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml |  59 ++++++++++++++-
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts                                       |   5 +-
 drivers/clk/bcm/clk-bcm2835.c                                               |  34 ++++++--
 drivers/clk/bcm/clk-raspberrypi.c                                           | 311 +++++++++++++++++++++++++++++++++++++++++++-----------------------------
 drivers/firmware/raspberrypi.c                                              |  14 +++-
 6 files changed, 294 insertions(+), 143 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml

base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
-- 
git-series 0.9.1
