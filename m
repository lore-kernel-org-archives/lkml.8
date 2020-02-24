Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84965C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536072072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kCBMljJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgBXO60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:58:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36420 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbgBXO6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:58:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so10748092wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 06:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7uc4ZyvgI1jMGXCbWtx41AYJ+mfMjeXR72GJNbpY18=;
        b=kCBMljJDgEXgQJtO36JYtqdY47PYaeQkiZClS+0usrj9Ixr8jvPES+3Tw1jnf6PdD6
         gwtvcqGKHWH33/s0vQLib0EDKaT5CHV/OjJIteuVTGT4KTEOqw3LM0DiJ/p2f/yGr+RQ
         VYtjCQA7tt6yi300wdDWYyCJhxRYeBtXGKfgmMn4eJoAtnMBgQnXuGyT4lXBRO6aZ7rD
         BR4ND1x2j7TL0Qx91QSTWUHXexmtfFfjwfok5+myttcA7hmC36G+3Zkuwk0JOkv4FwGf
         00bm0cc7zRkFA3kyAr2J0Xoz/XgKb8Y2ukc8jM0Z5pNSgmTJNRidIK2ixISCUYdRXfQm
         CwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7uc4ZyvgI1jMGXCbWtx41AYJ+mfMjeXR72GJNbpY18=;
        b=AVRa6TtoOPbbMi3X91CrCUacgePwT2Xya7ep8yIJ6w01dwYh/rYz4dGmQC9Np5dIRC
         EMNSwGlPZCfZ2x7hI6N/x/02AZOuDJS/Hdrsffs8sikOaFXCaYKEAj9AUQUK9ODH5xPF
         En6GCIuFQzHfY2kZKwYRTbhSB/Mgt8pZHn4VfWjB35KI2/nRT0UY1Jzy++vP2NUEXBT0
         5083ByqmXnevS/tAN/Yyrg7nqOdNADlAmfWfUwwy0VD4bE8o3YwMXuEVAK1XD9ucVTLJ
         MmSbT6bqwDtlkOCfbz1SvdAtHcgHfXTgN2a2thoMPD19vWkhsCbEwmhPQ1HEVlFfvs1I
         Gp8Q==
X-Gm-Message-State: APjAAAVAEJPNnYlA2nGwGf4Pp+rJB9AQlcsvZfBmArPRbt+RzVqswlWQ
        TJaltxPfm65qpiXhHHukw2nwWA==
X-Google-Smtp-Source: APXvYqzC5ORHBrCQFw6rGDHx95H9wgru83TXeezmJtNlw/dwPrwN5bmrRu/47VMppijs6JSo1frU1Q==
X-Received: by 2002:a5d:6a07:: with SMTP id m7mr38410390wru.332.1582556304185;
        Mon, 24 Feb 2020 06:58:24 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j12sm8035127wrt.35.2020.02.24.06.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 06:58:23 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/9] ASoC: meson: convert dt-bindings to schema
Date:   Mon, 24 Feb 2020 15:58:12 +0100
Message-Id: <20200224145821.262873-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset converts the amlogic sound devices to schema.

Jerome Brunet (9):
  ASoC: meson: gx-card: fix sound-dai dt schema
  ASoC: meson: convert axg tdm interface to schema
  ASoC: meson: convert axg tdm formatters to schema
  ASoC: meson: convert axg pdm to schema
  ASoC: meson: convert axg fifo to schema
  ASoC: meson: convert axg spdif input to schema
  ASoC: meson: convert axg spdif output to schema
  ASoC: meson: convert g12a tohdmitx control to schema
  ASoC: meson: convert axg sound card control to schema

 .../bindings/sound/amlogic,axg-fifo.txt       |  34 ----
 .../bindings/sound/amlogic,axg-fifo.yaml      | 111 +++++++++++
 .../bindings/sound/amlogic,axg-pdm.txt        |  29 ---
 .../bindings/sound/amlogic,axg-pdm.yaml       |  79 ++++++++
 .../bindings/sound/amlogic,axg-sound-card.txt | 124 ------------
 .../sound/amlogic,axg-sound-card.yaml         | 181 ++++++++++++++++++
 .../bindings/sound/amlogic,axg-spdifin.txt    |  27 ---
 .../bindings/sound/amlogic,axg-spdifin.yaml   |  84 ++++++++
 .../bindings/sound/amlogic,axg-spdifout.txt   |  25 ---
 .../bindings/sound/amlogic,axg-spdifout.yaml  |  77 ++++++++
 .../sound/amlogic,axg-tdm-formatters.txt      |  36 ----
 .../sound/amlogic,axg-tdm-formatters.yaml     |  92 +++++++++
 .../bindings/sound/amlogic,axg-tdm-iface.txt  |  22 ---
 .../bindings/sound/amlogic,axg-tdm-iface.yaml |  57 ++++++
 .../bindings/sound/amlogic,g12a-tohdmitx.txt  |  58 ------
 .../bindings/sound/amlogic,g12a-tohdmitx.yaml |  53 +++++
 .../bindings/sound/amlogic,gx-sound-card.yaml |   4 +-
 17 files changed, 736 insertions(+), 357 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.yaml

-- 
2.24.1

