Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F6FC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 01:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31DAE206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 01:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="EVPd1CL+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rn3qR07r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGZB0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 21:26:04 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:44183 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727009AbgGZB0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 21:26:01 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7533558015E;
        Sat, 25 Jul 2020 21:26:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 25 Jul 2020 21:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=NK4oEFps6opW0I20N7a390yS2P
        HhY6R+HwWvhfjHia4=; b=EVPd1CL+Nvq+jEujkBVk9W6CBa1Or/DRYaZ2O0Qk14
        ELbFcN+mc1RmKSzXLx9GosiTAcOmttKS+QVmnReS5ipq4eNv63F+v0zooFW8+JYY
        OvvW/yMZkwBPgLeRW0fm0oKFWOUrBENjl8u1x5ZexUagHN/lngpnKcJR+THNfByV
        IMykOw3q6j3NU8S7C2f8d4yabqy2W7MCblqUCgvk01wm5N6wranLOI1QHcgblnC9
        j8U/ZIjTJxa1j7VGa8BouLLkfPvJayPyLsW5HDigZahUaXYvbtGgrqpwvy7Zk5NC
        CWr+nuaksgVQsng1+VdAgd3k833JaJ/sJRe/cp2wMPlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=NK4oEFps6opW0I20N
        7a390yS2PHhY6R+HwWvhfjHia4=; b=rn3qR07rDkxIPYalMbRKf5pTNltsWk2FO
        czJkgnOA2UUbDWiUJY72giAZpZD/CNeG4ioz5edVh5EF8Znx+drxAQRHtfIebis6
        z/DBPJ6HJg+pFEhMRWGLCHbMJvIL+WyDPimsPkU+ZUWuo+dVnljBPwFuG5ZTRo8J
        hZ4XM2aAjqSKwX/nLo9W0DZ6HUQaZjFk+XMvg3bBrZUdurJa0pu8AVnPEcO3y/2C
        sbcli5lOMnnlng0TQ1n0Mw+foWIxcnDphXpz+f+uoySjIfVlYRrGHy8YjELxkcZh
        Y5HZldCPKHL/PKFeSGrF+8BLIAvqTK1fjs/8p0r2Uuz1FoepRLhlQ==
X-ME-Sender: <xms:ptscX77KMY_lXI7gKRHSJTU8J7TVctfc0kqasdGI3ZB8PJkx1oN_0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdho
    rhhg
X-ME-Proxy: <xmx:ptscXw4jeKeCFpEqyogj7uQ5Y1I7DopCbz7qFo2mExlT8_vcRhVOuw>
    <xmx:ptscXyfZ7anLQhn3huYUE2pB64GsbBr_3jglEzMY-ZN7FaJ6RIGznA>
    <xmx:ptscX8LrNVKJTtKGbO4Uk7bv8EFlxpi1WouWliGgYI_SE5hzmgk4ag>
    <xmx:qNscXxxunWdZ6bnR5OaSin1tC4eHrEPxCpbfXS8zqsB4H8bY3dGKOg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1CA0A3060067;
        Sat, 25 Jul 2020 21:25:58 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/7] Allwinner A64 digital audio codec fixes
Date:   Sat, 25 Jul 2020 20:25:50 -0500
Message-Id: <20200726012557.38282-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a couple of issues with the digital audio codec in the
Allwinner A64 SoC:
  1) Left/right channels were swapped when playing/recording audio
  2) DAPM topology was wrong, breaking some kcontrols

This is the minimum set of changes necessary to fix these issues in a
backward-compatible way. For that reason, some DAPM widgets still have
incorrect or confusing names; those and other issues will be fixed in
later patch sets.

Samuel Holland (7):
  ASoC: dt-bindings: Add a new compatible for the A64 codec
  ASoC: sun8i-codec: Fix DAPM to match the hardware topology
  ASoC: sun8i-codec: Add missing mixer routes
  ASoC: sun8i-codec: Add a quirk for LRCK inversion
  ARM: dts: sun8i: a33: Update codec widget names
  arm64: dts: allwinner: a64: Update codec widget names
  arm64: dts: allwinner: a64: Update the audio codec compatible

 .../sound/allwinner,sun8i-a33-codec.yaml      |   6 +-
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts     |   4 +-
 arch/arm/boot/dts/sun8i-a33.dtsi              |   4 +-
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |   8 +-
 .../dts/allwinner/sun50i-a64-orangepi-win.dts |   8 +-
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |   8 +-
 .../dts/allwinner/sun50i-a64-pinebook.dts     |   8 +-
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   |   8 +-
 .../boot/dts/allwinner/sun50i-a64-pinetab.dts |   8 +-
 .../allwinner/sun50i-a64-sopine-baseboard.dts |   8 +-
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts |   8 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  11 +-
 sound/soc/sunxi/sun8i-codec.c                 | 137 ++++++++++++++----
 13 files changed, 155 insertions(+), 71 deletions(-)

-- 
2.26.2

