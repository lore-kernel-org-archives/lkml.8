Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB0DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB03120700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="DGdIlHZp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E1Yezqie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgGZCxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 22:53:40 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:41557 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727789AbgGZCxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 22:53:37 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9EEB5580428;
        Sat, 25 Jul 2020 22:53:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 25 Jul 2020 22:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=f1ggifv2qgcXmIBc8IkyaYFUQ+
        xQAPJcNHBoK/4x6GQ=; b=DGdIlHZpufK70xhAOzazoy2zcD96Q3GW5iGSyLA4mg
        NFIZl/uP6yodeDrgnVkEW8rimFZge9u856d5XIyxLvhuZh4OCkIf2SxvZykIPi/w
        31Muif3RoSMwTsILd5qnShu4Y3j2nIpDV/zKpFaQCjA5XRu/ez7JuSq84LWDJogF
        o1QhPbDIE19YC4Y1DjhsxDienwb43Ism1EpzY7Qi4SRBRfgzZOtFmKV/iinIfKAy
        1wCJhhtvCZ7leirG/38EhoECR2B75lfkjbRE2VS/VNAiQ+f4U5gGfhNcncTNTFdm
        NCGkEJjsuIJzhs4P39xc9jIwNMap5g0gaAr+QB5CZ2Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=f1ggifv2qgcXmIBc8
        IkyaYFUQ+xQAPJcNHBoK/4x6GQ=; b=E1YezqiewiNurCuxe5NhRkz14JBoQjxru
        v0E8BSeC+mJMKiJOIf8elkAs8AXRY19DUgZyOF97IvSdbaWcUgSd7fYfmJ9UkODE
        HUaWahd2PmTL94RFeh8i0uit5ZHI05MGxAkuSZ18BTmkgjL6loekrq2gq9F18Vca
        uTmy7kjRubVRoeSU2tG2fNUBqYnvaE4Ff7pNFFChcxkn/W2cWb/bNzdNUgGhix9T
        PCZ10XMysxpd1CfDISyRA8UQi7woCcYLo69fLHHUR1UkDj6WWgaZduFoU0VBnFPv
        6M5oEHDucDUOvvkAb3Ev4yK+LO5OxwyuWtUkSnozVf9wPBR+Bs0Xg==
X-ME-Sender: <xms:L_AcX1qaQZloYaNCIOK-q2UERnpBfBLjXfH0R411WxV1NSZK4NlAvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdho
    rhhg
X-ME-Proxy: <xmx:L_AcX3qwidCk6rwxszrRXQ23DURSYgn33SmLoB8rkgwiHvfRLSajXw>
    <xmx:L_AcXyMYBvMfQrVDX5rJExI_B4kvD8pvNgqveAHlLx2APOFyFv_6oQ>
    <xmx:L_AcXw4lb9LYcdvIS1AmFmRDnyTSDC0d-bYoD74ZNCXuFYfozK_EKA>
    <xmx:MPAcXzZNCLDDdndCY6f5kxqmnuepiAmrPEqRd-_-FJEKtfwyF_0eVw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D5A2D3280063;
        Sat, 25 Jul 2020 22:53:34 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 0/8] ASoC: sun50i-codec-analog: Cleanup and power management
Date:   Sat, 25 Jul 2020 21:53:26 -0500
Message-Id: <20200726025334.59931-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series performs some minor cleanup on the driver for the analog
codec in the Allwinner A64, and hooks up the existing mute switches to
DAPM widgets, in order to provide improved power management.

Changes since v1:
  - Collected Acked-by/Reviewed-by tags
  - Used SOC_MIXER_NAMED_CTL_ARRAY to avoid naming a widget "Earpiece"

Samuel Holland (8):
  ASoC: sun50i-codec-analog: Fix duplicate use of ADC enable bits
  ASoC: sun50i-codec-analog: Gate the amplifier clock during suspend
  ASoC: sun50i-codec-analog: Group and sort mixer routes
  ASoC: sun50i-codec-analog: Make headphone routes stereo
  ASoC: sun50i-codec-analog: Enable DAPM for headphone switch
  ASoC: sun50i-codec-analog: Make line out routes stereo
  ASoC: sun50i-codec-analog: Enable DAPM for line out switch
  ASoC: sun50i-codec-analog: Enable DAPM for earpiece switch

 sound/soc/sunxi/sun50i-codec-analog.c | 176 ++++++++++++++++----------
 1 file changed, 111 insertions(+), 65 deletions(-)

-- 
2.26.2

