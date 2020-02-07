Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE1CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 05:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E3322464
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 05:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iHfAblZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgBGF0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 00:26:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39299 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgBGF0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 00:26:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so522187plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 21:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/zB9xLJSCEmcEROv88A82DPGekOIdz0Re4N4EUvv7YQ=;
        b=iHfAblZm+66QNJpVWC8jKplx2ZNZqjZfzjQmcBKuD+0bxVGGTQ5lOzM36vtl1ggI/y
         BOf4sQDqdKsGpwT3fK2xC4db5Y6c9+OsKKLAZoyvCpfNiMc7AWpgFmE6LjIs8qtiPXfQ
         m1bMLy5a60UKdJJA50YccQmyGqBD0HQibNMpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/zB9xLJSCEmcEROv88A82DPGekOIdz0Re4N4EUvv7YQ=;
        b=hOP+mRsVB4ssesT4/F9pg/Pn3EYy7sDy/WvnlmxfZXakCp9/ftiirpbTzp+Th0G7TY
         R7/8ZtSO8C5QSkXn3d2/YqMeEXTX0lm+FauiQaPJ9NS74QF9xPkWAyUxXKndVxfKsPnY
         1e/lVGXkDnTinMjfDtWEmsjOgNPjv7Ks4QqQRx+NrUPZoTWjeT9/HZP6aLaQpeNtuG+0
         0Wq0x5Fx+xqr/mU2atv/crEYRtT6jDjQIAnFAZ4Gp17G76D3oSz90xlVnwPWsLNKVmlF
         NDZkGfWrl8Nm3JYp4SYELNqxNVSUrkM9KCxXop+GZ3HqqZ9ffIiBCMD2dXAu/VNz7+TD
         ag9Q==
X-Gm-Message-State: APjAAAVVTdhDjpyI60vCYSPSi1WcYeUQBgur9NxhJ8+OPLtcnkFrOg7u
        06cVcS9fl7tsanrV6YG7MLrjWg==
X-Google-Smtp-Source: APXvYqwDhczmXZwMAxUZru60y6Afvx+soks2DBAlo9PuHeMARGx+nULMRNQyK00qlg2Fi3ADU5IOrQ==
X-Received: by 2002:a17:90a:a48a:: with SMTP id z10mr1822467pjp.52.1581053208716;
        Thu, 06 Feb 2020 21:26:48 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id i66sm1174485pfg.85.2020.02.06.21.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 21:26:47 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        ulf.hansson@linaro.org
Subject: [PATCH v4 0/7] Add dts for mt8183 GPU (and misc panfrost patches)
Date:   Fri,  7 Feb 2020 13:26:20 +0800
Message-Id: <20200207052627.130118-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Follow-up on the v3: https://patchwork.kernel.org/cover/11331343/.

The main purpose of this series is to upstream the dts change and the
binding document, but I wanted to see how far I could probe the GPU, to
check that the binding is indeed correct. The rest of the patches are
RFC/work-in-progress, but I think some of them could already be picked up.

So this is tested on MT8183 with a chromeos-4.19 kernel, and a ton of
backports to get the latest panfrost driver (I should probably try on
linux-next at some point but this was the path of least resistance).

I tested it as a module as it's more challenging (originally probing would
work built-in, on boot, but not as a module, as I didn't have the power
domain changes, and all power domains are on by default during boot).

Probing logs looks like this, currently. They look sane.
[  501.319728] panfrost 13040000.gpu: clock rate = 511999970
[  501.320041] panfrost 13040000.gpu: Linked as a consumer to regulator.14
[  501.320102] panfrost 13040000.gpu: Linked as a consumer to regulator.31
[  501.320651] panfrost 13040000.gpu: Linked as a consumer to genpd:0:13040000.gpu
[  501.320954] panfrost 13040000.gpu: Linked as a consumer to genpd:1:13040000.gpu
[  501.321062] panfrost 13040000.gpu: Linked as a consumer to genpd:2:13040000.gpu
[  501.321734] panfrost 13040000.gpu: mali-g72 id 0x6221 major 0x0 minor 0x3 status 0x0
[  501.321741] panfrost 13040000.gpu: features: 00000000,13de77ff, issues: 00000000,00000400
[  501.321747] panfrost 13040000.gpu: Features: L2:0x07120206 Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
[  501.321752] panfrost 13040000.gpu: shader_present=0x7 l2_present=0x1
[  501.324951] [drm] Initialized panfrost 1.1.0 20180908 for 13040000.gpu on minor 2

Some more changes are still required to get devfreq working, and of course
I do not have a userspace driver to test this with.

I believe at least patches 1, 2, and 3 can be merged. 4 and 5 are mostly
useful in conjunction with 6 and 7 (which are not ready yet), so I'll let
maintainers decide.

Thanks!

Nicolas Boichat (7):
  dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
  arm64: dts: mt8183: Add node for the Mali GPU
  drm/panfrost: Improve error reporting in panfrost_gpu_power_on
  drm/panfrost: Add support for multiple regulators
  drm/panfrost: Add support for multiple power domains
  RFC: drm/panfrost: Add mt8183-mali compatible string
  RFC: drm/panfrost: devfreq: Add support for 2 regulators

 .../bindings/gpu/arm,mali-bifrost.yaml        |  25 ++++
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   7 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 105 +++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  17 +++
 drivers/gpu/drm/panfrost/panfrost_device.c    | 123 +++++++++++++++---
 drivers/gpu/drm/panfrost/panfrost_device.h    |  27 +++-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  41 ++++--
 drivers/gpu/drm/panfrost/panfrost_gpu.c       |  11 +-
 8 files changed, 326 insertions(+), 30 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog

