Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6E5C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4197B214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="YQsB2ait";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="puh6hTBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgAMFS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 00:18:59 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57177 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbgAMFS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 00:18:58 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5203E5E53;
        Mon, 13 Jan 2020 00:18:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 Jan 2020 00:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=6RlrtGe1q52aL1FVbHTu04Aqfx
        pcbL40rnxbamSASaQ=; b=YQsB2aith4yB1iR4q7Qv83xSwXmzwCJPLCqu22y4D4
        WOvCJ5nJCXPYv1NwGctRu2pNiXX7Eb/bK97QCbnmxTSerI3r2BCJ1oc21tS42wH5
        /XeOpgBxGZcqjazPw9djtJ/3UjGfWju3G0/dYWSAMSbBKjtGS8y3+fIawbTmrut2
        +8ake2cs7vPMk+kP0/8L2DP3wFgdF2r1YZiqxOJ5Oa19agjPB4WgpRZOnkVz34wi
        y0WLg5ah5owKJqTV8/xqjlLGF/o6TVy9Sc/hCcDk9jNGdtUJQq5Wxts33p1uK+Ly
        B9/MN+TMltbC7doz0lgLzMMncYdWj1X+20lkC5caFe9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6RlrtGe1q52aL1FVb
        HTu04AqfxpcbL40rnxbamSASaQ=; b=puh6hTBxLgcHepAg9hBIwKzIbBlH+8SA9
        v8MZxJqQZFZnU3AIyGRg9IRPQJIamqanw6kh4nLB3sSP6pE66V2ibV+ZN+2Owgea
        nbCLTzLX4C8DOn3ERRs/XdMQX5ru2g4QT1woctQVoUXuq9rP3IANNl3iypMy2ox/
        7rCb1stKNDmu2Z+ILQX59ZaEzogQUUMv0O8rSnLN7GcTxh0S6rISA058P24zcix7
        BKXYw7TlMsU9gYSRKbiMJyck2kgePy0rBHCL8a4d8l5Oo6TyCeDL6FF61HO931I4
        WIqJyFe3quteXs2A3EFyqde27f4Xi0jgQDNoQqa1QFOr2raFPQ0dA==
X-ME-Sender: <xms:vf0bXo56cXW2l6Y1on66Ze8BLTfeYodBIAvglnEqjcAdHVbuAinP7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucffohhmrg
    hinhepkhgvrhhnvghlrdhorhhgnecukfhppeejtddrudefhedrudegkedrudehudenucfr
    rghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrghenuc
    evlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:vf0bXn0LLzwxeJtfTtss5-A73Z59R1ByuHmCkmT5Eo5c0GHajikHfA>
    <xmx:vf0bXvCvXMuf0aqxoNHxw8jHwGLHy7K5KqTmHNLEazGZNwnHFqfHBw>
    <xmx:vf0bXp10YMv7sB_lSQiegZl2J5GZvuD4JIs0lsQ-mqCx1i14pm-jHg>
    <xmx:wf0bXnydl4R1ASwqR8oeqLGwNj4wXOu9KC6-DgomT9xP51_EI6hBNg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 75AE630607B4;
        Mon, 13 Jan 2020 00:18:52 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v6 0/6] Allwinner sun6i message box support
Date:   Sun, 12 Jan 2020 23:18:46 -0600
Message-Id: <20200113051852.15996-1-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
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
clients on the A64, H5, and H6 SoCs (including specifically the arm_scpi
driver), and Ondrej Jirman has tested the driver on the A83T (using a
similar patch to arm_scpi).

The clock changes are dropped in favor of:
https://lore.kernel.org/linux-clk/20191230193127.8803-1-samuel@sholland.org/

Hopefully I've learned my lesson that adding more tangentially-related
patches doesn't increase the likelihood of getting things merged. This
patch just includes the driver and the device tree changes.

Thanks,
Samuel

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
  dt-bindings: mailbox: Add a sun6i message box binding
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
 drivers/mailbox/sun6i-msgbox.c                | 332 ++++++++++++++++++
 8 files changed, 463 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
 create mode 100644 drivers/mailbox/sun6i-msgbox.c

-- 
2.23.0

