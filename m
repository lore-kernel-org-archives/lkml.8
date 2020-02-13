Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F52C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE1E24673
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rmDCMt8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgBMPwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:52:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45777 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbgBMPwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:52:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id g3so7274150wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 07:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qRSNHxPBZ1IexXWr4sAA9opPLPtOEFKsiR173BgPSbE=;
        b=rmDCMt8johXf39HuPfvbW10KGlsza5f82dM90WRh/o8esX8OkRNxItKTtPH80Aw7PK
         w6hwn7YXoxCrjoydoLYw8KB+l8rFn0HuY1RWsVR55UzJk4jRrYmR0OqOv9+dllAqoqYI
         IUfZtCwBYWOyibEPrFjbOgM10K11SHeVgTIQpGfnGO+gTk83bitTdzbao0Hgi3r5l3QQ
         a1WcFJOjDtt1x0Fyxqw2UUXZYfxowjJxu3tleaFrPidLlZzONnLFrhPM+kmdV1h3aYm0
         VscLAall4oZEcfJFTKX3LM8+AuGIbObycMU9LRQADS9nEzZrQVzTo3ETriJPaan58JVT
         NeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qRSNHxPBZ1IexXWr4sAA9opPLPtOEFKsiR173BgPSbE=;
        b=FmdOj/vsxNgBcvhNZmHS3KZhmVA6RC+LeE/iTMuZRz5TYXiJwfKcmfO8wODUm0UbVC
         J61ZtP/jTygVgwemDmnut+ut8Z37xYTjBdyLribjaurKdBVY3MOGnc5BgaWVlnQUygnC
         HrOEKYHTc7Z0O5KJ0Nd81trfskXuNf0G5JAFWALnj4LnP/dw6z3n4m321ydfXLTHoPz2
         YR7P2U9PU6xiOrheyox5mXAoeLxi4rFDYURmAvZyrgy5veIgq8GMJJpJoEGgmoeaiWNH
         UldMbj3oTxt/xl6/oKT4EASTDLZ/jLJdUxLHZXRXHBtmnZS45hSfE8dud3cGKzXTWC5u
         tiiQ==
X-Gm-Message-State: APjAAAVey0ww2Zn41Bn0gu4NjxutIfbCakjKo3RdQ3Xep9D2FL4vjpN6
        XRXhqfS/BX7D0w0FB6zbEQz/Pw+6RIs=
X-Google-Smtp-Source: APXvYqzaEZ72W0WraKrTyInOswcFFpztUeMtekBYMK7/Qvo39kr8aI6aa2+adZuUr6wwgRuldPDSzw==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr21617587wrm.290.1581609127423;
        Thu, 13 Feb 2020 07:52:07 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id e1sm3319814wrt.84.2020.02.13.07.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:52:06 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/9] ASoC: meson: gx: add audio output support
Date:   Thu, 13 Feb 2020 16:51:50 +0100
Message-Id: <20200213155159.3235792-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the i2s and spdif audio outputs of the
amlogic GX SoC family, such the S905, S905X/D, S912 and S805X. These SoCs
are used by a fair amount of boards actively maintained upstream.

This was tested on:
 * amlogic s912 q200
 * libretech s805x-ac (frite)
 * libretech s905x-cc (potato)
 * libretech s905d-pc (tartiflette)

This could also possibly support meson8 32bits SoCs but I have not tested
it myself and it could require some further tweaks.

The audio subsystem found on these SoCs has now been dropped in the newer
designs. All recent SoCs families (like g12a and sm1) derive from the AXG
audio architecture.

Jerome Brunet (9):
  ASoC: core: allow a dt node to provide several components
  ASoC: meson: g12a: extract codec-to-codec utils
  ASoC: meson: aiu: add audio output dt-bindings
  ASoC: meson: aiu: add i2s and spdif support
  ASoC: meson: aiu: add hdmi codec control support
  ASoC: meson: aiu: add internal dac codec control support
  ASoC: meson: axg: extract sound card utils
  ASoC: meson: gx: add sound card dt-binding documentation
  ASoC: meson: gx: add sound card support

 .../bindings/sound/amlogic,aiu.yaml           | 111 +++++
 .../bindings/sound/amlogic,gx-sound-card.yaml | 113 +++++
 include/dt-bindings/sound/meson-aiu.h         |  18 +
 sound/soc/meson/Kconfig                       |  24 ++
 sound/soc/meson/Makefile                      |  15 +
 sound/soc/meson/aiu-acodec-ctrl.c             | 205 +++++++++
 sound/soc/meson/aiu-codec-ctrl.c              | 152 +++++++
 sound/soc/meson/aiu-encoder-i2s.c             | 324 ++++++++++++++
 sound/soc/meson/aiu-encoder-spdif.c           | 209 +++++++++
 sound/soc/meson/aiu-fifo-i2s.c                | 153 +++++++
 sound/soc/meson/aiu-fifo-spdif.c              | 186 ++++++++
 sound/soc/meson/aiu-fifo.c                    | 223 ++++++++++
 sound/soc/meson/aiu-fifo.h                    |  50 +++
 sound/soc/meson/aiu.c                         | 390 +++++++++++++++++
 sound/soc/meson/aiu.h                         |  91 ++++
 sound/soc/meson/axg-card.c                    | 403 ++----------------
 sound/soc/meson/g12a-tohdmitx.c               | 219 ++--------
 sound/soc/meson/gx-card.c                     | 141 ++++++
 sound/soc/meson/meson-card-utils.c            | 385 +++++++++++++++++
 sound/soc/meson/meson-card.h                  |  55 +++
 sound/soc/meson/meson-codec-glue.c            | 149 +++++++
 sound/soc/meson/meson-codec-glue.h            |  32 ++
 sound/soc/soc-core.c                          |   8 +
 23 files changed, 3104 insertions(+), 552 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
 create mode 100644 include/dt-bindings/sound/meson-aiu.h
 create mode 100644 sound/soc/meson/aiu-acodec-ctrl.c
 create mode 100644 sound/soc/meson/aiu-codec-ctrl.c
 create mode 100644 sound/soc/meson/aiu-encoder-i2s.c
 create mode 100644 sound/soc/meson/aiu-encoder-spdif.c
 create mode 100644 sound/soc/meson/aiu-fifo-i2s.c
 create mode 100644 sound/soc/meson/aiu-fifo-spdif.c
 create mode 100644 sound/soc/meson/aiu-fifo.c
 create mode 100644 sound/soc/meson/aiu-fifo.h
 create mode 100644 sound/soc/meson/aiu.c
 create mode 100644 sound/soc/meson/aiu.h
 create mode 100644 sound/soc/meson/gx-card.c
 create mode 100644 sound/soc/meson/meson-card-utils.c
 create mode 100644 sound/soc/meson/meson-card.h
 create mode 100644 sound/soc/meson/meson-codec-glue.c
 create mode 100644 sound/soc/meson/meson-codec-glue.h

-- 
2.24.1

