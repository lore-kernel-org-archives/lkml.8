Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49585C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F9C206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="oxxpck8P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SXPtn60L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgBWEI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 23:08:57 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:35767 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbgBWEI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 23:08:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id B1EC65F00;
        Sat, 22 Feb 2020 23:08:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 22 Feb 2020 23:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=q4Ot3OeJR3RSzSA1Bg9G4BvjjT
        WwbYiknLcd/Pnw3hY=; b=oxxpck8PRbftTSecbIJZKvtQAp3/63KVp8GEO6InhT
        yyX7TLVAQLSqAzvVmhgiWFhGtgFSX3ogu0InMV25csi15GK7SF1JYtY+jHVPsWvE
        7G352uk0MMh7hiUmeVv7zSPUCD1zjxMbKDPSDTfkbOiN9dn+2uzJTp/VIgStN+GN
        oW+HWVWxDzsoHYXtZxFbbSxNoIVsfU2KtN0QFacOMik0DCqQ4T9MDGIDxcqwSPeL
        8eSDu+iEvqwKfM2+iuCR3vSWYD1yQu9tubDRx3AzbQLtKVbAPFLTS78gxGiSzu1A
        VEWBXVPlDHWVPdGsXDuGXGhrUT4ajvtw4LT0o44RfmtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=q4Ot3OeJR3RSzSA1B
        g9G4BvjjTWwbYiknLcd/Pnw3hY=; b=SXPtn60L+C5blGwK36ygthuZnv82hw8Pq
        TsYnaEYe9rdUAIKTzS+UUCbadTNpExorwKbMBRvT+y8KPeiyI5zp+UXRpdHIO0Vt
        GOv0UjVJsUqV1wRD6WztNMKDMwN5vF31R+xNvHm5ZNKgaKVYLgloyJeoKQKXJZVm
        2xlWQsmFhRVMOcfB2M3a0BPyr7v96A3yHLoJpIKiaW/ECnWua4kwv7xHDeiLVWX3
        V+lq4jDvkOyLB66k9HxkVykLvc0ItbulhFehTbSj6uza19kFYFflFyjEBEUwmfuW
        2rCSu97wTmmrYxcehhVbgU7wewROVd4xMKE38eWqqRxeSrc/gHaWA==
X-ME-Sender: <xms:1vpRXgUY7eRF4M6nH0c28YrLTJPsT3EG-FYZqPI9jxZIuTYa9K2URw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkeejgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtd
    drudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:1vpRXkc3Bhic1H0udd1jzMF34-yyhTWiKKmQsCeS9MxiAXc_6lZWzw>
    <xmx:1vpRXhtam65ZIHFvz1C9rp59zXEGH0C_CbGT2dBKe53J3JWXZt930A>
    <xmx:1vpRXrhWrk0080BXohQ6CacYUiZ87kCizWfPSv-ReW0pLeLYehqJQg>
    <xmx:1_pRXs9GeGkNps2mHiVMg2TzJN4DWd0yYpw4Byw9kfjOW-qT0VfKAg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 10F313280060;
        Sat, 22 Feb 2020 23:08:54 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v7 0/6] Allwinner sun6i message box support
Date:   Sat, 22 Feb 2020 22:08:47 -0600
Message-Id: <20200223040853.2658-1-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the "hardware message box" in sun8i, sun9i,
and sun50i SoCs, used for communication with the ARISC management
processor (the platform's equivalent of the ARM SCP). The end goal is to
use the arm_scpi driver as a client, communicating with firmware running
on the ARISC CPU.

I have tested this driver with various firmware programs and mailbox
clients on the A64, H5, and H6 SoCs (including specifically a patched
version of the arm_scpi driver), and Ondrej Jirman has tested the driver
on the A83T (using a similar patch to arm_scpi).

This patch series includes just the driver and the device tree changes.

Thanks,
Samuel

Changes from v6:
  - Rebased on tag v5.6-rc2
  - Collected Acked-by/Reviewed-by tags
  - Dropped "FIFO full" check in sun6i_msgbox_send_data()

Changes from v5:
  - Rebased on tag sunxi-dt-for-5.5-2
  - Dropped unnecessary/unrelated patches
  - Addressed Maxime's dt-binding comments
  - Used devm_reset_control_get_exclusive

Changes from v4:
  - Rebased on sunxi-next
  - Dropped AR100 clock patch, as it was controversial and unnecessary
  - Renamed sunxi-msgbox to sun6i-msgbox and sun6i-a31-msgbox
  - Added comments about not asserting the reset line
  - Dropped A80 DTS changes as they were untested
  - Added Ondrej's Tested-by for A83T
  - Dropped the demo; replaced with a real arm_scpi fix

Changes from v3:
  - Rebased on sunxi-next
  - Added Rob's Reviewed-by for patch 3
  - Fixed a crash when receiving a message on a disabled channel
  - Cleaned up some comments/formatting in the driver
  - Fixed #mbox-cells in sunxi-h3-h5.dtsi (patch 7)
  - Removed the irqchip example (no longer relevant to the fw design)
  - Added a demo/example client that uses the driver and a toy firmware

Changes from v2:
  - Merge patches 1-3
  - Add a comment in the code explaining the CLK_IS_CRITICAL usage
  - Add a patch to mark the AR100 clocks as critical
  - Use YAML for the device tree binding
  - Include a not-for-merge example usage of the mailbox

Changes from v1:
  - Marked message box clocks as critical instead of hacks in the driver
  - 8 unidirectional channels instead of 4 bidirectional pairs
  - Use per-SoC compatible strings and an A31 fallback compatible
  - Dropped the mailbox framework patch
  - Include DT patches for SoCs that document the message box

Samuel Holland (6):
  dt-bindings: mailbox: Add a binding for the sun6i msgbox
  mailbox: sun6i-msgbox: Add a new mailbox driver
  ARM: dts: sunxi: a83t: Add msgbox node
  ARM: dts: sunxi: h3/h5: Add msgbox node
  arm64: dts: allwinner: a64: Add msgbox node
  arm64: dts: allwinner: h6: Add msgbox node

 .../mailbox/allwinner,sun6i-a31-msgbox.yaml   |  80 +++++
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  10 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  10 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  10 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  10 +
 drivers/mailbox/Kconfig                       |   9 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/sun6i-msgbox.c                | 326 ++++++++++++++++++
 8 files changed, 457 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
 create mode 100644 drivers/mailbox/sun6i-msgbox.c

-- 
2.24.1

