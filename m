Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9952CC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1662468D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Irva5dhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgBSNg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:36:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37227 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgBSNg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:36:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so581063wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 05:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HwepP4vylkvrAMsKrJGWiwfWFEMFo390d/0hPnMfDnQ=;
        b=Irva5dhDO7EeC/Gq61LwcdDA8SlWmI5WtROw0M6kcYEwuY1jDLSJ+y73xIUtZPyrj+
         p3mFAKgb/uvVhkn9uCHbuA0guPmbGlioDgYymJFVf3MHc/q3A/0vEC/t9140r7ZLnUQl
         Fr0fN2VVS2grIBPMAMi0teBetl/uTUELthI98JilwqkP4Iwma6YTDSNBhDkz9hyRaPGI
         gtXMisst6zIZbntFjDhIUmkOLCM9D1xAw4ggRKOxh/IaYhkSci+8xVY+aklr6GNXDCDL
         fwNgiBHAgXgzy6SIWPRyayR9I5fmAt11PAbnTcvhohV5oGjumm6ZQN+kkM/Uas3sNgHx
         wxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HwepP4vylkvrAMsKrJGWiwfWFEMFo390d/0hPnMfDnQ=;
        b=bJHHMrzSKblFVYnk/DzkBE/VjD/6h+EsAskg1XHD66q7u1Uo3UzuwZ943Ja4unGD6g
         wHcBTFu9imFE4dkxUSMrRYRCjVGsAV2rVB73FKKdqlF82QBv8KZrYGh3FQeAEMf9B1fs
         aTtrh/4Rfh3iH2xLESBtrMGhugQ8RYn9uoyHwwMB/KDDzrf2JIWk5a7XtCexC47IBW7r
         FBOBPdCUrhUUYHhxVIqe3a9DTwlhiLTiiUyiwm1813wuXrW+ocIMgrkJ7KrJg6a+4xKz
         dY7BRNSNBu+O9cBGxN1twzU9J6LBC6XzDPi58SVh3C8U+pOWdFe1IFKCZ3l6lkpcJIjS
         5lRw==
X-Gm-Message-State: APjAAAVLhb1ErFcZdQ0p5HIafy8Mwv43a8DoKkSeq+roCaOhnn1FEeWi
        rmnxrs/TjCvGz2lPKPi49V8rmQ==
X-Google-Smtp-Source: APXvYqzFBdf+KvQ/AaFbssZg7VHUlYCElqE3Jj98G953ZIChVvbutlzYOglzkBF0ek20O6lSxHLvQA==
X-Received: by 2002:a5d:4f0f:: with SMTP id c15mr37854818wru.251.1582119415457;
        Wed, 19 Feb 2020 05:36:55 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id q124sm8856480wme.2.2020.02.19.05.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 05:36:54 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/2] ASoC: meson: add internal DAC support
Date:   Wed, 19 Feb 2020 14:36:44 +0100
Message-Id: <20200219133646.1035506-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the internal audio DAC provided on the
Amlogic gxl, g12a and sm1 SoC families. On each of these SoC families,
there is glue between this codec on the audio provider. The architecture
is similar to the one used for the synopsys hdmi codec on these SoCs

Jerome Brunet (2):
  ASoC: meson: add t9015 internal codec binding documentation
  ASoC: meson: add t9015 internal DAC driver

 .../bindings/sound/amlogic,t9015.yaml         |  58 ++++
 sound/soc/meson/Kconfig                       |   8 +
 sound/soc/meson/Makefile                      |   2 +
 sound/soc/meson/t9015.c                       | 320 ++++++++++++++++++
 4 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
 create mode 100644 sound/soc/meson/t9015.c

-- 
2.24.1

