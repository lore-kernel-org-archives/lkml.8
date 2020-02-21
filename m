Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3699C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 12:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A823124656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 12:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Hzswd1IE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgBUMWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 07:22:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35301 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgBUMWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 07:22:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so1833967wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 04:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/BYedZ4pOByhHvdhuJN4fjl+rXQW3qUeEEUr/kFsWVU=;
        b=Hzswd1IEpFgBP9efY9SXOGNd64ap93yVYNG4hX5JRFgq6BqQLP6NMpaXnrsS4yshJr
         d/cfs5VudtvLHi7xt1YxbKlxcbTdIfYFPDd4pbfMC10jwUIEmdupU+I/U319Ue7iQcHZ
         zTXIEVK1lyRXExDAjWQpCwqdmy+CthZHkPEpn4TuEfRuqoQKL9020Dy69beWpRhBEMDG
         8U/JBaYO045Zy7LLbkTq6YQzTkojCkI+UcobfIiQBV7lKe5KUl9fL9wvZZ7TQmI6OSzr
         iPqtJ7k1iNdxG0deDdtmqbUqZrShsZSA6X2Hra92Yigm2T2ltYn6+y7wvAEIK4FZhoRo
         QZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/BYedZ4pOByhHvdhuJN4fjl+rXQW3qUeEEUr/kFsWVU=;
        b=Hb2CyAFv/oeMDH7oaYv4Xl+kjE1H1ajs/15fn0W+4kYegpcr6Ru/6fMqY+v7A+OkiP
         i0pkac/FdpxlqHg+AmkQbsJ1SSTJ10OUeJi7inekoMibVqKnWbl6gkduHUI85cXleFzl
         5EMxx0Fi8dbLMscQxymkIzOJ8e/xwKiexgUiwQA32nHCGBMmp/L+LRKEgwH9GVSsSoV0
         +YH2yjGgxW4igu4r8Fg42IIE8/vxTDlX37cYUHfqnm37piaRTb2Hb6BUizm2UK/dNLGb
         tgE45OlWug0xsBW9F/btrOsSbcu54wtc/35Xb4C0MOyftxX2f3AmAmzQ3+jlwKEXUtb2
         EXBw==
X-Gm-Message-State: APjAAAVJhdzARjUy4mmjSV1LC20wumKaM/GqWc4/u/YGsvQQRYBPHJjj
        sulHQ5TKNB2LypkXW4wByUZhuA==
X-Google-Smtp-Source: APXvYqzmjIqVT9st1OIarukP3BJalnkRPkvKDXMRg5ZK7MmjuG/5QwKMBZb6+Mmv5heghIB9nKAzwA==
X-Received: by 2002:adf:fd8d:: with SMTP id d13mr49039936wrr.208.1582287768611;
        Fri, 21 Feb 2020 04:22:48 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p26sm3454653wmc.24.2020.02.21.04.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 04:22:47 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/3] ASoC: meson: g12a: add internal audio DAC support
Date:   Fri, 21 Feb 2020 13:22:39 +0100
Message-Id: <20200221122242.1500093-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the gxl, the Amlogic g12a and sm1 SoC families have a t9015 internal
audio DAC. On these more recent SoCs, any of the 3 TDM outputs can be
routed to the internal DAC. This routing is done by a small glue device
called 'toacodec'. This patchset adds support for it.

Jerome Brunet (3):
  ASoC: meson: g12a: add toacodec dt-binding documentation
  ASoC: meson: g12a: add internal DAC glue driver
  ASoC: meson: axg-card: add toacodec support

 .../bindings/sound/amlogic,g12a-toacodec.yaml |  51 ++++
 .../dt-bindings/sound/meson-g12a-toacodec.h   |  10 +
 sound/soc/meson/Kconfig                       |   9 +
 sound/soc/meson/Makefile                      |   2 +
 sound/soc/meson/axg-card.c                    |   3 +-
 sound/soc/meson/g12a-toacodec.c               | 240 ++++++++++++++++++
 6 files changed, 314 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
 create mode 100644 include/dt-bindings/sound/meson-g12a-toacodec.h
 create mode 100644 sound/soc/meson/g12a-toacodec.c

-- 
2.24.1

