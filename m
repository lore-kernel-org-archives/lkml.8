Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE04C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5800C20773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lz0nPDxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgGGOhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGOhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:37:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009DAC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:37:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so43526445wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5iF8ft+c50gpwNnzzALPrKJo/bbNCmFujAo6+tQfbag=;
        b=Lz0nPDxcqEOwOrN6zYyousamF2fXBBFMTdeR4LW8bSilPOhb/g/iLa84hhIJJFuDW6
         CHgzKjN/Ks6bLLbbMjwmjRdKIr/m4ToP0M3Ic+JLsug2W7O9eYaS4I+2X8batugOPe+M
         3MGJM+fcDQpTnBBWXXzUKPOcLnFG6F91I0Qd3mc54oBIMtqrjBel4wjkRq+YEjKDY0Eo
         Kk7J2QqmYxBmWkviAU1EFsDPmrOhRGzyZJVWglkYX4qqXij9fyPIwAA2YwXSQL5DQ3SR
         419aaKH6rylK9L6oSlUNULiT38rOIfwa9kWMflWB5O95h6VpS0DQQuAC098qrjCpsGfC
         +7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5iF8ft+c50gpwNnzzALPrKJo/bbNCmFujAo6+tQfbag=;
        b=gF316+4bTWZVyvGXSHMPerZ+N+G7QenGMdel9BJIUm8F+Kfakz8dbNarjgyxKP2A9K
         tb3TmJzvv48e719a9KBtA8F9X/7NJZZFs7MbvSiXm5NqrQTbGgGe14/vnhAJUxH2USnf
         fLGbJQCmEVJZJ5cW5lPaa9n3djbBmJ3CpxUQAnp839iEcQ7C9vzzClpA50BlSL0sZfJ7
         9An2lLZ824JyXl3Wzy6Q918PyUtvjaF9K3iyTFPfcXRcvnVY14oSJAM4CKtEGM5oREkH
         5HISmxGtH0m2IcAasIIAzMKYw/fXvxzlRuoI4mwrIKSyU61LHeNEsr2u2hTagJoGoEjS
         Ho/w==
X-Gm-Message-State: AOAM530oNcX+t8lubFIemfflxPwmrzjkpUvGsNuM3wlpqyjnBqWH/vX/
        72Cbu3itl1E9R3D/LKYRScmXpQ==
X-Google-Smtp-Source: ABdhPJw1xINFmSvbUCOzjkbGqZ/QUUiOXhKsCkIjO0i2XygXmAlkbXkTnXKhAMio+o2WFG4v85WpSA==
X-Received: by 2002:a1c:9e06:: with SMTP id h6mr4299319wme.45.1594132665610;
        Tue, 07 Jul 2020 07:37:45 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:37:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 00/28] Clean-up ASoC's W=1 build warnings
Date:   Tue,  7 Jul 2020 15:37:14 +0100
Message-Id: <20200707143742.2959960-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

After these patches are applied, the build system no longer
complains about any W=0 nor W=1 level warnings in sound/soc,
when building for Arm.

Hurrah!

Changelog

v1 => v2:
 - Remove whole read from patch 21
   - Suggested by Peter

Lee Jones (28):
  ASoC: atmel: atmel-pcm-dma: Demote function header which is clearly
    not kerneldoc
  ASoC: atmel: atmel_ssc_dai: Demote function header which is clearly
    not kerneldoc
  ASoC: fsl: fsl-asoc-card: Use correct format when providing struct
    documentation
  ASoC: fsl: fsl_asrc: Demote obvious misuse of kerneldoc to standard
    comment blocks
  ASoC: fsl: fsl_ssi: Demote obvious misuse of kerneldoc to standard
    comment blocks
  ASoC: fsl: fsl_ssi_dbg: Demote obvious misuse of kerneldoc to standard
    comment blocks
  ASoC: fsl: fsl_spdif: Use correct formatting when denoting struct
    documentation
  ASoC: fsl: fsl_spdif: Update 'struct fsl_spdif_priv's descriptions
  ASoC: fsl: fsl_esai: Fix a bunch of kerneldoc issues
  ASoC: fsl: fsl_esai: Add descriptions for 'tx_mask' and 'rx_mask' to
    'fsl_esai'
  ASoC: pxa: pxa-ssp: Demote seemingly unintentional kerneldoc header
  ASoC: codecs: ak4458: Remove set but never checked variable 'ret'
  ASoC: qcom: qdsp6: q6asm: Provide documentation for WMA
    'codec_profile'
  ASoC: samsung: pcm: Demote half-documented kerneldoc header
  ASoC: samsung: spdif: Fix 3 misspelled struct properties
  ASoC: sunxi: sun4i-i2s: Demote half-documented kerneldoc header
  ASoC: uniphier: aio-core: Fix incorrectly named struct property and
    remove another
  ASoC: sunxi: sun4i-spdif: Fix misspelling of 'reg_dac_txdata'
  ASoC: ux500: ux500_msp_i2s: Remove unused variables 'reg_val_DR' and
    'reg_val_TSTDR'
  ASoC: sti: uniperif: Mark 'uni_tdm_hw' as __maybe_unused
  ASoC: ti: omap-mcbsp-st: Remove set, but unused variable 'w'
  ASoC: codecs: da7210: Fix formatting issues in da7210_set_dai_pll()
    header
  ASoC: soc-ac97: Demote seemingly unintentional kerneldoc header
  ASoC: codecs: jz4770: Remove defined but never used variable
    'mic_boost_tlv'
  ASoC: codecs: rt5631: Demote misuse of kerneldoc to standard comment
    blocks
  ASoC: codecs: rt5659: Remove many unused const variables
  ASoC: codecs: tlv320aic26: Demote seemingly unintentional kerneldoc
    header
  ASoC: codecs: wm8400: Remove a bunch of unused variables

 sound/soc/atmel/atmel-pcm-dma.c |  2 +-
 sound/soc/atmel/atmel_ssc_dai.c |  2 +-
 sound/soc/codecs/ak4458.c       |  6 +++---
 sound/soc/codecs/da7210.c       | 12 ++++++-----
 sound/soc/codecs/jz4770.c       |  1 -
 sound/soc/codecs/rt5631.c       | 12 +++++------
 sound/soc/codecs/rt5659.c       | 37 ---------------------------------
 sound/soc/codecs/tlv320aic26.c  |  2 +-
 sound/soc/codecs/wm8400.c       | 12 -----------
 sound/soc/fsl/fsl-asoc-card.c   | 16 +++++++-------
 sound/soc/fsl/fsl_asrc.c        | 28 ++++++++++++-------------
 sound/soc/fsl/fsl_esai.c        | 19 ++++++++++-------
 sound/soc/fsl/fsl_spdif.c       |  5 +++--
 sound/soc/fsl/fsl_ssi.c         | 28 ++++++++++++-------------
 sound/soc/fsl/fsl_ssi_dbg.c     |  4 ++--
 sound/soc/pxa/pxa-ssp.c         |  2 +-
 sound/soc/qcom/qdsp6/q6asm.c    |  1 +
 sound/soc/samsung/pcm.c         |  2 +-
 sound/soc/samsung/spdif.c       |  6 +++---
 sound/soc/soc-ac97.c            |  2 +-
 sound/soc/sti/uniperif.h        |  2 +-
 sound/soc/sunxi/sun4i-i2s.c     |  2 +-
 sound/soc/sunxi/sun4i-spdif.c   |  2 +-
 sound/soc/ti/omap-mcbsp-st.c    |  3 ---
 sound/soc/uniphier/aio-core.c   |  7 +++----
 sound/soc/ux500/ux500_msp_i2s.c |  8 +++----
 26 files changed, 88 insertions(+), 135 deletions(-)

-- 
2.25.1

