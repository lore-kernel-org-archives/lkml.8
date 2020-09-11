Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B143C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E649720758
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NUSrvRqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgIKKXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgIKKXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:23:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F58DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 03:23:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 5so6333303pgl.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0vYasziV4Ler0VCEn6KqQHtlj4BJcAoBCUWQkLB1w7Q=;
        b=NUSrvRqmlAloG2hxHlBBY9dwtvyS3x7PRz4DWrxcP1VxixL3oFi1tQkrc6zUtmwk3t
         Pf5tRZOqNcx1Lj6UzHx79lq3hraKZgedTohZVKjJECewlOILUAC+s7bmn+I7bp5KeIWw
         K5QNQSYGmLgaOoNg3SV36FbV/8oOg644m3kSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0vYasziV4Ler0VCEn6KqQHtlj4BJcAoBCUWQkLB1w7Q=;
        b=AcLJ7bHaGcOXsh+jMHKZh4LsqtaiW5tLm89qFI3auKxb+tn1doA8hfYn2LU++RCplL
         j9sJ8a/dUuL3x8zIpIjRVPECZ6BiMdEQxbtmurQ4eCxqPGHuKq6ELCEbFPpd87P9u1X9
         oDVCPLjH2/mPiWmgt2uFAp5dSIll4UEDX/zGF6n02ZjUQW/QI8EGZ8FG6aDLg46e2oCM
         qLWYiVhVUVUqbOwiDbaYDl1OmwtFgSNRI5IL4tZDD/vax31W8WP1KMpL2NPatdypbNWp
         oDXEGxG5Fy20qX6d9D+i/B8K73jWkGRei6r3lU9W1uE+Ae2qy8h0fLfDYfDOeTeIU4IP
         hgJQ==
X-Gm-Message-State: AOAM532AH9A/XBvR/DSyBzNrJ/cHuQxM2UpQaSDmt5+hOwJr3bY+yBqc
        UUwOygMo/WKFOtaM2MMzPDi7ZGw5sZQLGeb2
X-Google-Smtp-Source: ABdhPJyYmaJmk1RDpFXLOPsLGNOg/bKTZV0+TMJnDMZBrL1SlRoSUzLsu3q6S6akaad+bQjg/sYm1Q==
X-Received: by 2002:a63:3710:: with SMTP id e16mr1201441pga.140.1599819788638;
        Fri, 11 Sep 2020 03:23:08 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:de4a:3eff:fe7d:d39c])
        by smtp.gmail.com with ESMTPSA id u123sm1852804pfb.209.2020.09.11.03.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 03:23:07 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v9 0/3] Add documentation and machine driver for SC7180 sound card
Date:   Fri, 11 Sep 2020 18:22:56 +0800
Message-Id: <20200911102259.3667381-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note:
- The machine driver patch is made by the collaboration of
  Cheng-Yi Chiang <cychiang@chromium.org>
  Rohit kumar <rohitkr@codeaurora.org>
  Ajit Pandey <ajitp@codeaurora.org>
  But Ajit has left codeaurora.
- This patch series needs HDMI DAI name defined in sc7180-lpass.h.
  https://patchwork.kernel.org/patch/11745565/

Changes from v1 to v2:
- Ducumentation: Addressed all suggestions from Doug.
- Machine driver:
  - Fix comment style for license.
  - Sort includes.
  - Remove sc7180_snd_hw_params.
  - Remove sc7180_dai_init and use aux device instead for headset jack registration.
  - Statically define format for Primary MI2S.
  - Atomic is not a concern because there is mutex in card to make sure
    startup and shutdown happen sequentially.
  - Fix missing return -EINVAL in startup.
  - Use static sound card.
  - Use devm_kzalloc to avoid kfree.

Changes from v2 to v3:
- Ducumentation: Addressed suggestions from Srini.
- Machine driver:
  - Reuse qcom_snd_parse_of to parse properties.
  - Remove playback-only and capture-only.
  - Misc fixes to address comments.

Changes from v3 to v4:
- Ducumentation: Addressed suggestions from Rob.
 - Remove definition of dai.
 - Use 'sound-dai: true' for sound-dai schema.
 - Add reg property to pass 'make dt_binding_check' check although reg is not used in the driver.
- Machine driver:
 - Add Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

Changes from v4 to v5:
- Documentation: Addressed suggestions from Rob.
 - Add definition for "#address-cells" and "#size-cells".
 - Add additionalProperties: false
 - Add required properties.

Changes from v5 to v6:
- Documentation: Addressed suggestions from Rob.
 - Drop contains in compatible strings.
 - Only allow dai-link@[0-9]
 - Remove reg ref since it has a type definition already.

Changes from v6 to v7
- Documentation:
  - Add headset-jack and hdmi-jack to specify the codec
    responsible for jack detection.
- HDMI codec driver:
  - Use component set_jack ops instead of exporting hdmi_codec_set_jack_detect.
- Machine driver:
  - Removed aux device following Stephan's suggestion.
  - Use headset-jack and hdmi-jack to specify the codec
    responsible for jack detection.
  - Add support for HDMI(actually DP) playback.

Changes from v7 to v8
- Documentation:
  - Remove headset-jack and hdmi-jack.
- Machine driver:
  - Let machine driver decide whether there is a jack on the DAI.

Changes from v8 to v9
- hdmi-codec driver:
  - Fixed the naming.
- Machine driver:
  - Fixed unused fields.
  - Moved snd_soc_card_set_drvdata
  - Keep the naming of HDMI as dai name until v5 of lpass-hdmi patches.

Ajit Pandey (1):
  ASoC: qcom: sc7180: Add machine driver for sound card registration

Cheng-Yi Chiang (2):
  ASoC: hdmi-codec: Use set_jack ops to set jack
  ASoC: qcom: dt-bindings: Add sc7180 machine bindings

 .../bindings/sound/qcom,sc7180.yaml           | 130 +++++++++
 include/sound/hdmi-codec.h                    |   3 -
 sound/soc/codecs/hdmi-codec.c                 |  12 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650.c     |   5 +-
 .../mediatek/mt8183/mt8183-da7219-max98357.c  |   5 +-
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   |   5 +-
 sound/soc/qcom/Kconfig                        |  12 +
 sound/soc/qcom/Makefile                       |   2 +
 sound/soc/qcom/sc7180.c                       | 267 ++++++++++++++++++
 sound/soc/rockchip/rockchip_max98090.c        |   3 +-
 10 files changed, 422 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
 create mode 100644 sound/soc/qcom/sc7180.c

-- 
2.28.0.618.gf4bc123cb7-goog

