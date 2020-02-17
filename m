Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D32C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27912086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="KgZOC9om";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tZ4rjemR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgBQCSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 21:18:23 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:47911 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726703AbgBQCSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 21:18:23 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 97B6D6D65;
        Sun, 16 Feb 2020 21:18:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 16 Feb 2020 21:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=81rmcCzH+99CIb8JzKCPF7IB0i
        Cso38cvLYNenVDvQ8=; b=KgZOC9omNh/Mhbz59mykqHg/w1bH45ClosPkO/Fgoz
        MZVm8v1NXpcRoWPtlrKLqnSUQy3XJt9Qtbwk+B4Be+fx9uqNRxS6QrsdAjy1byID
        O/JYdYWsZyCRnagTztvOpA44PadmDw3sSOpvQ8olhgxD/t/XOycyMoJFMxiKhPB5
        NMzKive9HuRPjrq6dk7gU6M0SjswTEjjbNWdYJIc4SaY6iO+PP710It1TDEGQm0k
        0mzXt0E7CGx9FvrZhwNY7jMFteLPBCBswZZ2//OVAni0hTmD/YubQdLNZEfJiH3d
        dh5HkyOkweAb/f93iMMdLOYqgH5U9VMmXZ6N0YSevXGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=81rmcCzH+99CIb8Jz
        KCPF7IB0iCso38cvLYNenVDvQ8=; b=tZ4rjemRHjhvYRn8IWa88dxrN+aJ7aByz
        81isJQx4xCyoJkN1ETHReI0CHGcSnX8REs5smKf6AWPv98T8AEUQ8kmLrduG7do0
        L15QVoc1XNNomtXRu0ZCQDBtSPbHHBoEN9gXJtGcoISYE8FO76fI4deQO/OJSmW5
        pXlkS0cCeRCtWQY1teiJjRjSlWXkthdJBK6STYvVDtrEGv8ynxGX5KQKaHJH2Wj9
        iMoBjLF7MCrWKW9inTL9057KwaQXitloWMtAx5Tao9+XKX36TIgKNKgm0U2nCjxr
        +7tdT5IZr0MOPSYGV0kKAdUnRYCn2mV7OQCf1sYVlWWF973jXAV6Q==
X-ME-Sender: <xms:5vdJXg3nqOvn_wGRRoRCPDwqghJu_I90lH075V3kuV08-Z8QTSnS0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtd
    drudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:5vdJXiHPqr_iZzZGKOLSoK8hMUwQFvTT2CWrCjnhDYhfRk3Fe6LmGQ>
    <xmx:5vdJXt7kJxB7BEVbcvSeo_2a3KP_GrteIFqNl0cO1okB5I20m02Kwg>
    <xmx:5vdJXov0YxKj6xnnkjebkZWvv228FAN7ew_FqYDVxI36OBFxt8tEhQ>
    <xmx:6_dJXr0UGR0mFYcqrcV5ahNxO4ZvGbeiGrxNaoWWqto1dCWm1TSr2w>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2A1443060BE4;
        Sun, 16 Feb 2020 21:18:14 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/8] ASoC: sun50i-codec-analog: Cleanup and power management
Date:   Sun, 16 Feb 2020 20:18:05 -0600
Message-Id: <20200217021813.53266-1-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series performs some minor cleanup on the driver for the analog
codec in the Allwinner A64, and hooks up the existing mute switches to
DAPM widgets, in order to provide improved power management.

Samuel Holland (8):
  ASoC: sun50i-codec-analog: Fix duplicate use of ADC enable bits
  ASoC: sun50i-codec-analog: Gate the amplifier clock during suspend
  ASoC: sun50i-codec-analog: Group and sort mixer routes
  ASoC: sun50i-codec-analog: Make headphone routes stereo
  ASoC: sun50i-codec-analog: Enable DAPM for headphone switch
  ASoC: sun50i-codec-analog: Make line out routes stereo
  ASoC: sun50i-codec-analog: Enable DAPM for line out switch
  ASoC: sun50i-codec-analog: Enable DAPM for earpiece switch

 sound/soc/sunxi/sun50i-codec-analog.c | 174 ++++++++++++++++----------
 1 file changed, 109 insertions(+), 65 deletions(-)

-- 
2.24.1

