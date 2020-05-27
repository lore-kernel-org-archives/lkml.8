Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4140C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A905D20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="PxbclBKz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W9XVPXnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389795AbgE0Ppf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:45:35 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:59581 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726860AbgE0Ppa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:45:30 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6717C581DB3;
        Wed, 27 May 2020 11:45:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=nXEtTH5SN5wx/wDh0BQNd6ms4U
        oDlGel5I6M1n2fXwI=; b=PxbclBKz8Er5HtpgsLeicOCTtceqszSqGWtRP6cApw
        nNZKMMzZbOXxdkiv6zDKdb4DGPvU425JMeMI6xC3Ecz/08aS4VDy3iifb5nVTWqu
        5fAYPJt9Rj9iHOUKabLnNvQXoom2VNoKnY8iepfAescYXVI8juJUZH8fBQxciWFL
        uNRDaY5MOLv50LRiVpRE17Uf2nDRoBkSfYtCLXJMFfvxGjdRTY5pSAJaZC4KDkGR
        pgPZhh7mSksn+8Z1gleGZ5o5RoKlx+r0TDE5SrF+90eWIeFVYW/RLxn0gXBQFJRm
        oyMAFqcfckc3EPKcknF7Oe65GZQ19eFGL43N+JIeiu2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=nXEtTH5SN5wx/wDh0
        BQNd6ms4UoDlGel5I6M1n2fXwI=; b=W9XVPXnUmB1MYQqrHRHK2CkyPEtGupI8W
        9usMfEOWnFkz9eq0MpsZ39U7etnBdQO4jDmz0eekqTL+pqmdwz/5db+OWu7/GpNC
        U9VFRVTYXp7s+WMgK62fdA58Ei1XxcdTPEDYabpxEDvgVee/ukui4fF/dcGuvZSr
        GuGtDooZQoquPEKsPqflr0Rf6gY4x5Dq4vSY8NmJF4oSu+hygHryxnFxgmA1C7Nv
        DxmIrIxVCzhEWNQtHql83EsjuEZygOA9JIoUIy5q7pIFaHc+HM2GBL9+5M4BDcjr
        ws5pfybztPyTCyEQUlUR4/vnkI13AKNQrFsETFbQNP4w0DGWidz6A==
X-ME-Sender: <xms:FovOXpUS4_LPJ4_XrtTtVtynt6kIauUKIB5xPc8LHTQlhXluCN8llA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcu
    tfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvg
    hrnhepjeffheduvddvvdelhfegleelfffgieejvdehgfeijedtieeuteejteefueekjeeg
    necukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:FovOXpnjsgwi0RuRDvlaMtNWUuS23P5zgkBksRtzP5_Rq3DKNJA7BQ>
    <xmx:FovOXla2EpcVKZW02NOe8-YWL01yVaqZfn0HaQi9wqMLGvKIMj9vpg>
    <xmx:FovOXsVS9BJs93bc3Ajo7ZXY7_Tsrj2BswUZ09hCd5tTa1TysRpshA>
    <xmx:GYvOXhfR68HQ3W7Tx8Ivy0GfmxXYtF6F6LOjvFKcOm8Sjis9q95fEQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5D129328005E;
        Wed, 27 May 2020 11:45:26 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org,
        Kamal Dasu <kdasu.kdev@gmail.com>, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v3 00/25] clk: bcm: rpi: Add support for BCM2711 firmware clocks
Date:   Wed, 27 May 2020 17:44:56 +0200
Message-Id: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
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

Maxime Ripard (24):
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
  clk: bcm: rpi: Remove the quirks for the CPU clock
  ARM: dts: bcm2711: Add firmware clocks node

 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt  |  14 +---
 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml |  59 ++++++++++++++-
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts                                       |   5 +-
 drivers/clk/bcm/clk-bcm2835.c                                               |  30 ++++++-
 drivers/clk/bcm/clk-raspberrypi.c                                           | 299 ++++++++++++++++++++++++++++++++++++++++++++----------------------------
 drivers/firmware/raspberrypi.c                                              |  14 +++-
 include/soc/bcm2835/raspberrypi-firmware.h                                  |   5 +-
 7 files changed, 293 insertions(+), 133 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml

base-commit: b0523c7b1c9d0edcd6c0fe6d2cb558a9ad5c60a8
-- 
git-series 0.9.1
