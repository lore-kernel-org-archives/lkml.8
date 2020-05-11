Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C047AC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A726D206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgEKNZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726115AbgEKNZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:25:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8242FC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:25:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A82692A13E8
Received: by jupiter.universe (Postfix, from userid 1000)
        id D7B7D480100; Mon, 11 May 2020 15:25:45 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv3 0/5] ASoC: da7213: support for usage with simple-card
Date:   Mon, 11 May 2020 15:25:39 +0200
Message-Id: <20200511132544.82364-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This extends the da7213 driver to be used with simple-audio-card in
combination with a fixed clock. Here is a snippet of the downstream
board's DT, that is supposed to be supported by this patchset.

---------------------------------------------------------------------
/ {
	sound {
		compatible = "simple-audio-card";
		simple-audio-card,name = "audio-card";
		simple-audio-card,format = "i2s";
		simple-audio-card,bitclock-master = <&dailink_master>;
		simple-audio-card,frame-master = <&dailink_master>;

		simple-audio-card,widgets = "Speaker", "Ext Spk";
		simple-audio-card,audio-routing = "Ext Spk", "LINE";

		simple-audio-card,cpu {
			sound-dai = <&ssi1>;
		};

		dailink_master: simple-audio-card,codec {
			sound-dai = <&codec>;
		};
	};


	clk_ext_audio_codec: clock-codec {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <12288000>;
	};
};

&i2c1 {
	codec: audio-codec@1a {
		compatible = "dlg,da7212";
		reg = <0x1a>;
		#sound-dai-cells = <0>;
		VDDA-supply = <&reg_2v5_audio>;
		VDDSP-supply = <&reg_5v0_audio>;
		VDDMIC-supply = <&reg_3v3_audio>;
		VDDIO-supply = <&reg_3v3_audio>;
		clocks = <&clk_ext_audio_codec>;
		clock-names = "mclk";
	};
};
---------------------------------------------------------------------

This is mostly a resend of PATCHv2. There was quite a bit of discussion
for the last patch. As far as I can see no better solution was found and
the patch is fine as is. Sorry for the delay in sending another revision.

Changes since PATCHv2:
 * https://lore.kernel.org/alsa-devel/20191120152406.2744-1-sebastian.reichel@collabora.com/
 * dropped patch converting DA7213 into selectable Kconfig option (merged)
 * fix compatible string in patch 1 (DT binding) as pointed out by Adam Thomson
 * collected Reviewed-by from Adam Thomson for patch 2-4

Changes since PATCHv1:
 * https://lore.kernel.org/alsa-devel/20191108174843.11227-1-sebastian.reichel@collabora.com/
 * add patch adding da7212 compatible to DT bindings
 * update regulator patch, so that VDDA is enabled together with VDDIO
   while the device is enabled to avoid device reset
 * update clock patch, so that automatic PLL handling is not enabled
   when PLL is configured manually
 * update clock patch, so that automatic PLL is disabled when the device
   is suspended
 * update clock patch, so that automatic PLL is configured into bypass
   mode when possible

-- Sebastian

Sebastian Reichel (5):
  ASoC: da7213: Add da7212 DT compatible
  ASoC: da7213: Add regulator support
  ASoC: da7213: move set_sysclk to codec level
  ASoC: da7213: move set_pll to codec level
  ASoC: da7213: add default clock handling

 .../devicetree/bindings/sound/da7213.txt      |   8 +-
 sound/soc/codecs/da7213.c                     | 172 ++++++++++++++++--
 sound/soc/codecs/da7213.h                     |  11 ++
 3 files changed, 175 insertions(+), 16 deletions(-)

-- 
2.26.2

