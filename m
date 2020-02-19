Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E53C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97E220801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="X2e0sx2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgBSRfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:35:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34544 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgBSRfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:35:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id n10so1567103wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SKZ1ddDPfUYCjUQ7kAF3t+orQ6m6BZIYkrSaotWcAmM=;
        b=X2e0sx2O23WHDyj+CdogMOZnhLzlHGUY84Cw/1358tG4/lp0p4QzlF4gTn0S3FY5aF
         wlKpLxS0Pq7GvSWtJJZlnc1/BhuJaSmmxc957ERCeTZfWstj/7P9ynHWGySHKdNut72W
         OixpFUrGD9ADXYh9sGhd7pCeG+MDemjlpISXz9n5guTcFXHwC4ltNKQPsv1xZyo0nH/6
         oedY9idCZ394g4kRJLT2t10k1kTREfbTfiWs8hohLdnCJxCwkXRaSe0izO0rYPp5W3V3
         9d0Pm7TJCz+eu+Qnazm4qvj9KIpCTIg+eKRCDKN8gdAj8G6lYG+tTsbqRHk2AaBkxfcw
         YygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SKZ1ddDPfUYCjUQ7kAF3t+orQ6m6BZIYkrSaotWcAmM=;
        b=GC4aFKeFTnAwBYbYqGRrG8yCZ67YKl4X0OnxY4yRzOnY8vSoZua8mCJSxh07KStPUF
         uQU000uG/oW6oVbQhHz+TouHQGufq2F8QcedSvQTxwNLlGhnXFCVp44S9pTS0qHjBYe6
         R38Tvi+ZR5RKyZQpVVWXpqQN2xwZ95kDI3Up2++8zS23kiRpHF9uWNFWLYvvDNDnLBQ5
         UQE/X5j3CKKrFxjgzHexuSi/jdE8eQ+kVugRJm78wwmepnCV8k1CAa/mT5VceI9IgO2E
         EVHlsgK7fGGiBu/6hBv79aawyBSA6ufuC1txWRXyJI8Uhb5naQ9mtbXhBh3zkT0Cfg9f
         LRQQ==
X-Gm-Message-State: APjAAAXO2yAVn9Vsdix42CRPzXOTf+azK1ahKbX+exp89IWwWLeXqrdx
        rRbof3tfljxUyTAHEIgtAmVV7ByW0Vo=
X-Google-Smtp-Source: APXvYqzk6aYz8GK14PUd7/aAq+BxUqQaODL7ymtKvwWlFXfp7QfRzdYohN9IJrf2eOWE2Tw9MfdveA==
X-Received: by 2002:adf:cd0a:: with SMTP id w10mr37515585wrm.107.1582133708455;
        Wed, 19 Feb 2020 09:35:08 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id v15sm648120wrf.7.2020.02.19.09.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 09:35:07 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v3 0/2] ASoC: meson: add internal DAC support
Date:   Wed, 19 Feb 2020 18:35:01 +0100
Message-Id: <20200219173503.1112561-1-jbrunet@baylibre.com>
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

Changes since v2 [1]:
* Fix Mute kcontrol name

Changes since v1 [0]:
* Change some kcontrol names
* Move DAC sources to DAPM

[0]: https://lore.kernel.org/r/20200219133646.1035506-1-jbrunet@baylibre.com
[1]: https://lore.kernel.org/r/20200219161625.1078051-1-jbrunet@baylibre.com

Jerome Brunet (2):
  ASoC: meson: add t9015 internal codec binding documentation
  ASoC: meson: add t9015 internal DAC driver

 .../bindings/sound/amlogic,t9015.yaml         |  58 +++
 sound/soc/meson/Kconfig                       |   8 +
 sound/soc/meson/Makefile                      |   2 +
 sound/soc/meson/t9015.c                       | 333 ++++++++++++++++++
 4 files changed, 401 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
 create mode 100644 sound/soc/meson/t9015.c

-- 
2.24.1

