Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0756FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCAD208E4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meZHio9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgGDLjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgGDLjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:39:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58145C061794;
        Sat,  4 Jul 2020 04:39:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so35448202wrn.3;
        Sat, 04 Jul 2020 04:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=huTZWc4WX2Vk6rlBo+W/npzq0ocSqctPFM6mvDyKzhI=;
        b=meZHio9kKgmPtzv7j7dRdrQkTdsN+PUWTJgQrVGZfSrAh8bO7SmdtsxUZjgewfgm+t
         KQwupF83sh/tOwBQV2oDQvmEfzbCBdFbhiUvgFkafu1hc5+9tgW7oPWeKLcGMlf0xwYg
         S2JDTsTmYO3/pqZqdM/qTRYEVSI36OaSmC5Ong+8WOPeDVX9ZMkGa4DKmN21UFyjZThT
         z1Ufia2+HHra4ZoTt2B6k5q8aIFfPVb1u5oySe6l7B16SF3ZGJ1EV0X+UGaGHshmlZNL
         qOyl/wjerLE2dV4cjbW8EykX/AWIQolAs6de3MRZaDBSi0bHrWY0IY6DD2Bidzdc6jho
         8fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=huTZWc4WX2Vk6rlBo+W/npzq0ocSqctPFM6mvDyKzhI=;
        b=oJVrBnhMGcTcSPPkgy+E+oVNHdPVwNcrFjnoMzgmqqoQN9Jovh9YOomc0vdB4w/t9e
         aM2u1NZUsp8bks0T5iJBOvjj9n34OqZZGkX/8mxdLz2lIgIi0m9ToaNchXEF0XUw3/eM
         A6ycgrSDXUukAS3U8jB8sDitHug4zAzaXo1fU74Jv+u+k7vBxcepX1/qLiJzsIzFothV
         btWblu7oZyQKiEW1+ey5hCok2Zo0A+BCobY28FAD+qD1ZuzEMNDxRQMtkec0ZnrTPFJY
         74tqUKvALLyUUf+TsPemeclq0yFmBZCFAvYFBDBJOsrW3L0mwrFDid01n2PqkPf95fES
         kwXw==
X-Gm-Message-State: AOAM533AF+P1/Yy5Uu4GmGM0HQcb2PAAKPkvHn6MD+tzH5Vf+Nw2pS4E
        gXdtwhtZ8lY2/TzD1g1znG4=
X-Google-Smtp-Source: ABdhPJxCjhh8TckSSIgRr6CJvS63LYfsRrgWAUQSGAQuTFPXEG/R05nSp234vtwv/LzOsRt4HrNb7Q==
X-Received: by 2002:adf:fc90:: with SMTP id g16mr40188744wrr.42.1593862745973;
        Sat, 04 Jul 2020 04:39:05 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 04:39:05 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 00/16] Add Allwinner H3/H5/H6/A64 HDMI audio
Date:   Sat,  4 Jul 2020 13:38:46 +0200
Message-Id: <20200704113902.336911-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This a merge of serie:
- Add Add H6 I2S support https://patchwork.kernel.org/cover/11497007/
- Add Allwinner H3/H5/A64 HDMI audio https://patchwork.kernel.org/cover/11510511/

I merge both serie because there is a similar issue regarding the I2S polarity.
This need to be investigated under a scope and see if the comment is still true
for Allwinner H6 and previous SoC.
LibreElec team found that we have to introduce the
"simple-audio-card,frame-inversion" property with recent mainline change.
In order to make HDMI audio work.
Maybe the I2S polarity is good or maybe the silicium has an issue but not present
for HDMI I2S or not present in TDM mode...
I cannot do it myself, so if someone want to to do it please feel free.

Regarding the discussion we had here: https://patchwork.kernel.org/patch/11510521/
I didn't switch to generic hdmi card-name and used name like:
sun8i-h3-hdmi, sun50i-h6-hdmi, etc....

Despite this wrong comment the rest of the serie introduce some fix that should
be merged even if it's without the H6 support.

Regards
Clement

Change since v1:
- drop allwinner,playback-channels property
- use coherent hdmi,card-name 
- indentation fix
- collect tags

Clément Péron (2):
  ASoC: sun4i-i2s: Fix sun8i volatile regs
  arm64: dts: allwinner: h6: Enable HDMI sound for Beelink GS1

Jernej Skrabec (3):
  ASoC: sun4i-i2s: Add support for H6 I2S
  dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
  arm64: dts: allwinner: h6: Add HDMI audio node

Marcus Cooper (11):
  ASoC: sun4i-i2s: Adjust LRCLK width
  ASoC: sun4i-i2s: Set sign extend sample
  ASoc: sun4i-i2s: Add 20 and 24 bit support
  ASoC: sun4i-i2s: Adjust regmap settings
  arm: dts: sunxi: h3/h5: Add DAI node for HDMI
  arm: dts: sunxi: h3/h5: Add HDMI audio
  arm64: dts: allwinner: a64: Add DAI node for HDMI
  arm64: dts: allwinner: a64: Add HDMI audio
  arm: sun8i: h3: Add HDMI audio to Orange Pi 2
  arm: sun8i: h3: Add HDMI audio to Beelink X2
  arm64: dts: allwinner: a64: Add HDMI audio to Pine64

 .../sound/allwinner,sun4i-a10-i2s.yaml        |   2 +
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts     |   8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts     |   8 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  33 ++
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |   8 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  35 +++
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   8 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  33 ++
 sound/soc/sunxi/sun4i-i2s.c                   | 281 +++++++++++++++++-
 9 files changed, 410 insertions(+), 6 deletions(-)

-- 
2.25.1

