Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4F6C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD30206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="G+D1jRIS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VVEljL7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBQGmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:42:54 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:33147 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbgBQGmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:42:53 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 492845227;
        Mon, 17 Feb 2020 01:42:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=zSdco/OlhEmu6V+GTJlxM8pk6k
        LCbTTBFJQJg1vPYes=; b=G+D1jRIS6vghi4BstN+rLaADjJEMTHCp6fCuh1M7v5
        xp0n7gMLHIvlbmmcK5qTkgwWnYP19W8txeHFA2/CBiMNLXqHRNLzUUQCKOusERSP
        hzL5A8tn4z9adkyhmfsxlRKOMYsNdprnvftI7JnNRVdG8emKZ8GWk3Q7vtcrhT0d
        GQM8Cuo2IO9f6TDfPIAcXQ6SxhyzEq7PpfdUrpl4gWJBIMR8tVy1u5IZZZFdVswG
        e/fZx/GCmSCpmiSv+UzMfbyAKcRlXI2A5eOEPuDcSMiJJZ8RjrCxGjb+Z+7bOutX
        8ANZ6T2xvNodWCorfSz/w877j7j+2oyxGnvKFF+qjLOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zSdco/OlhEmu6V+GT
        JlxM8pk6kLCbTTBFJQJg1vPYes=; b=VVEljL7Qttz83QjtzIb78dchsCVP+3iiq
        mrQrdn2Wp5FTnyKu7ZmcYGqs+cOB357RegatmWCZw0DMLuYpzQQZiCi6BCxIm+zg
        xzDmhCOdTKUfnV/KTpx5Tdzzadqit1aSyXCiPkKVnYoTOce7/OdMTvkkG8PKjpfq
        ddvrJbyGnqrpSKeXcrrM4CQaD4psU69ZO9FdogfLp05+xPyH168c7cavefKU8Cjr
        oJFqYtKS4U7t+zgrN8OylzK+ay2YFYJQxezgVR3ZkFPoVwoLW/omAWbZY6Mh+JSh
        Ph6TW91ZknD2WeOIHctOZPy1PrCDtdb1D0e8/nc13ZxcXHk/TVm0Q==
X-ME-Sender: <xms:6zVKXvDuwajBBXLayMP6rG3SAxrYn5LDZ13aGwqWVjxZt-hHAhK0rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtd
    drudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6zVKXrnrOMGEitV3Mp0cgd0vLlrdK1vQDr5LZu6jLvf8nNpxnMVSoA>
    <xmx:6zVKXt30GaZomQc0oEUCOr6_5sOT-7pkk5EZcCYM_ebqtvAritnx-Q>
    <xmx:6zVKXp5nbpyUWIQ3ylMO-s8t07akaXOPrMBtmktqQIqMxOdBSx5Wug>
    <xmx:7DVKXqlBRtkKwaGovPTQOFxuSvXqZjJPSGvZ4GkVyfIsBrIdDCmBUg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 70A61328005D;
        Mon, 17 Feb 2020 01:42:50 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH 00/34] sun8i-codec fixes and new features
Date:   Mon, 17 Feb 2020 00:42:16 -0600
Message-Id: <20200217064250.15516-1-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

The sun8i-codec driver, as used in the Allwinner A33 and A64, currently
only exposes a small subset of the available hardware features. In order
to use the A64 in a smartphone (the PinePhone), I've added the necessary
functionality to the driver:
  * The full set of supported DAI format options
  * Support for AIF2 and AIF3
  * Additional routing knobs
  * Additional volume controls

Unfortunately, due to preexisting issues with the driver, there are some
breaking changes, as explained further in the commit messages:
  * The LRCK inversion issue means we need a new compatible for the A64.
  * Some controls are named inaccurately, so they are renamed.
  * Likewise, the DAPM widgets used in device trees were either named
    wrong, or the device trees were using the wrong widgets in the first
    place. (Specifically, the links between the analog codec and digital
    codec happen at the ADC and DAC, not AIF1.)

I tended to take the philosophy of "while I'm breaking things, I might
as well do them right", so I've probably made a few more changes than
absolutely necessary. I'm not sure about where all of the policy
boundaries are, about how far I should go to maintain compatibility. For
example, for the DT widget usage, I could:
  * Rename everything and update the DTS files (which is what I did)
  * Keep the old (misleading/wrong) name for the widgets, but repurpose
    them to work correctly
      (i.e. "ADC Left" would be named "AIF1 Slot 0 Left ADC", but it
       would work just like "ADC Left" does in this patchset)
  * Keep the old widgets around as a compatibility layer, but add new
    widgets and update the in-tree DTS files to use them
      (i.e. "ADC Left" would have a path from "AIF1 Slot 0 Left ADC",
       but "AIF1 Slot 0 Left ADC" would be a no-op widget)
  * Something else entirely

There are several trivial fixes in here, and there are several commits
that just add new features without changing any existing behavior, but
there is enough changing that I thought it would be best to send the
whole thing as an RFC. I'm more than happy to reorganize this into one
or several patchsets in future revisions. It doesn't have to all go in
at once.

This has all been tested on the PinePhone. For example, I've
successfully routed a voice call between the modem at AIF2 and a
Bluetooth headset at AIF3, merged with an audio file played from AIF1.
Unfortunately, the PinePhone does not have a DTS upstream yet (partially
due to the audio driver situation), so I don't have an example DTS in
this patchset.

Thanks for any feedback,
Samuel

Samuel Holland (34):
  ASoC: dt-bindings: Add a separate compatible for the A64 codec
  ASoC: sun8i-codec: LRCK is not inverted on A64
  arm64: dts: allwinner: a64: Fix the audio codec compatible
  ASoC: sun8i-codec: Remove unused dev from codec struct
  ASoC: sun8i-codec: Remove incorrect SND_SOC_DAIFMT_DSP_B
  ASoC: sun8i-codec: Fix setting DAI data format
  ASoC: sun8i-codec: Remove extraneous widgets
  ASoC: sun8i-codec: Fix direction of AIF1 outputs
  ASoC: sun8i-codec: Fix broken DAPM routing
  ASoC: sun8i-codec: Advertise only hardware-supported rates
  ASoC: sun8i-codec: Enforce parameter symmetry
  ASoC: sun8i-codec: Fix AIF1 MODCLK widget name
  ASoC: sun8i-codec: Fix AIF1_ADCDAT_CTRL field names
  ASoC: sun8i-codec: Fix AIF1_MXR_SRC field names
  ASoC: sun8i-codec: Fix ADC_DIG_CTRL field name
  ASoC: sun8i-codec: Fix field bit number indentation
  ASoC: sun8i-codec: Sort masks in a consistent order
  ASoC: sun8i-codec: Allow all clock inversion permutations
  ASoC: sun8i-codec: Support mono DAI configurations
  ASoC: sun8i-codec: Support 8/20/24-bit word sizes
  ASoC: sun8i-codec: Clean up module/clock hierarchy
  ASoC: sun8i-codec: Clean up AIF1 Slot 0 widgets
  ASoC: sun8i-codec: Clean up DAC widgets
  ASoC: sun8i-codec: Prepare to support multiple AIFs
  ASoC: sun8i-codec: Add support for AIF2
  ASoC: sun8i-codec: Add support for AIF3
  ASoC: sun8i-codec: Add AIF mono/stereo controls
  ASoC: sun8i-codec: Add AIF loopback controls
  ASoC: sun8i-codec: Add AIF, ADC, and DAC volume controls
  ASoC: dt-bindings: Bump sound-dai-cells on sun8i-codec
  ARM: dts: sun8i-a33: Allow using multiple codec DAIs
  arm64: dts: allwinner: a64: Allow using multiple codec DAIs
  arm64: dts: allwinner: a64: Allow multiple DAI links
  arm64: dts: allwinner: a64: Add pinmux for AIF2/AIF3

 .../sound/allwinner,sun8i-a33-codec.yaml      |    6 +-
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts     |    6 +-
 arch/arm/boot/dts/sun8i-a33.dtsi              |   10 +-
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |    8 +-
 .../dts/allwinner/sun50i-a64-orangepi-win.dts |    8 +-
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |    8 +-
 .../dts/allwinner/sun50i-a64-pinebook.dts     |    8 +-
 .../boot/dts/allwinner/sun50i-a64-pinetab.dts |   14 +-
 .../allwinner/sun50i-a64-sopine-baseboard.dts |    8 +-
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts |    8 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |   47 +-
 sound/soc/sunxi/sun8i-codec.c                 | 1056 +++++++++++++----
 12 files changed, 890 insertions(+), 297 deletions(-)

-- 
2.24.1

