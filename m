Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B69C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF56206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDkQymds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGGKQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGKQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:16:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A228C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:16:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so44558369wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sAeTAEOISwkUGJHdFnlz0rMhMgi8r2OkvIBIQRn009g=;
        b=vDkQymdsPAJARkKXV0ZqJKJv0R9QiTZj0Qk3vE4jy2GELVQqwGwKilN1HZ/jt2D7XC
         PD93tlYBzj01lkaRr25TaMO+7n6IspO8ULnepNpzbB8qgFJCwTTQtIhJ9cDQolVufaxE
         fXLNAnPIxzkRLhmtVARWho2rc9FTACCIbEzKe+ZE/KN8NGAaqF2mtkqNUkjU+hmqauh6
         Iw5QZBpgS0oi9qURJUfGd52LTh8EpKpfstzfrCVSd8mcV9U8ELxflRSKCxhCL2dL/L+c
         RZrl2tJpTophaIrzoILWuRUPkGeF2DIkvR5O6dr9Cp8vu8XoK+GnDzEyGlhpdlKGDRQN
         8ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sAeTAEOISwkUGJHdFnlz0rMhMgi8r2OkvIBIQRn009g=;
        b=dvjGzGG6N3MRB0s6qjoIOYkMt8qMWG/Bahozg+fTlYLJwwudMNAa1uPL4cM5t51An+
         MkorLehtuJWzjOIMmOYL4gZA1FC8Gtq+9bDV+0OW4pecarxvvkFOfO341b+ZlXVmUGX+
         2wOJPhmP1BPl7px3IGf1oP1J/1wZOOQZz4DbbZNHMECLJnWCM6UdfMsI+Q7qgNMcctbk
         3oFNiBQR7NeOYRahnsHY3iuXoiS4zo6iRsuzUdbUA2EgeLhwbxQSqlEji3Kx1QTYsd1Y
         y92hp7mcp2sORxdW9boNZEj8rgIdrS5MyIqogxdBv7qo7cckPv7VcHe3yj/GfLDihM+n
         VTCg==
X-Gm-Message-State: AOAM530v97BtuTns2xcHRYKiW6RGO1gmz4B2Mq38SI/wBqNYYNdYERe2
        x/YAYLQNZBfKgqQVX95Gl6+FJw==
X-Google-Smtp-Source: ABdhPJwR1H3HDPf/6gNEou9O6u3d5rQxvQWsS1h1+DHpi1DC8lg7IU3W6xA85oGItQc5pfva+/d3NA==
X-Received: by 2002:adf:f20a:: with SMTP id p10mr56348436wro.41.1594117006963;
        Tue, 07 Jul 2020 03:16:46 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:16:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/28] Clean-up ASoC's W=1 build warnings
Date:   Tue,  7 Jul 2020 11:16:14 +0100
Message-Id: <20200707101642.1747944-1-lee.jones@linaro.org>
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
complains about any W=0 nor W=1 level warnings in sound/soc.

Hurrah!

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
 sound/soc/ti/omap-mcbsp-st.c    |  3 +--
 sound/soc/uniphier/aio-core.c   |  7 +++----
 sound/soc/ux500/ux500_msp_i2s.c |  8 +++----
 26 files changed, 89 insertions(+), 134 deletions(-)

-- 
2.25.1

