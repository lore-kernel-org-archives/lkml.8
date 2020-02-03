Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E881C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D1A2080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gng9XmRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgBCKyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:54:31 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:42041 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbgBCKyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:54:31 -0500
Received: by mail-pg1-f180.google.com with SMTP id w21so1854468pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 02:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ADW24ulzjRxWFs8Inpi2MLUJLlYv0kpD0PDD8jb7dpI=;
        b=gng9XmRj2Jusgtv+OYAhFWAfvviQ4ANaqX3dAANJ1k+PZMrE4ERLooYqWXjiNk3lNK
         nH5zqTbV/Q52LMsnKyq/zfmgTAe0RB9n1NxSy2kAeAvwI7psST63mCuiC4vDRhHjQpz/
         9q/rXFgPt7i+vBrEhnU9H7PTU0M039FzoSKC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ADW24ulzjRxWFs8Inpi2MLUJLlYv0kpD0PDD8jb7dpI=;
        b=QeTVc5oXOurH+BFtqG7erKJbOm+sy5B2mmW7hs2/YZhup283S3TF4s6HAnyWjCBJ/D
         UP6NMovVXLc4v0rpFThrE6LDP+JmoY7mCwf+fzAVLinE0ECVwcP4IRosmz/hw9FTMXLG
         a12LCsNn1wdSIfN8E3YYoFaJxSE6GFlolDNnKNbW5WOC+4eQlJeWvDLT8kQxXwS9ML/G
         3LsilKD3xzFYjpQzFzza5+WG3Pa2i/NfwDAJO+IRnPXZKKnpMlrvMd9/401UzDCJWzc4
         LYZbN/T6awl/PBnBhbh4Upv6OKnJMBHd+jyEzncVhGn+WTptlFZuYhvQDBr/ZooQg36S
         oo4A==
X-Gm-Message-State: APjAAAU0jbUCOtzrgYkKVO+0a812FWpBYJLMKVDo2RsYhikjEDTUQHlW
        BTiyQc8bynoUc9tHXHO0csl8HA==
X-Google-Smtp-Source: APXvYqwmogyQ4tkjuKnABxnJkcUDNUWk6sjSeWh+MezxRj8XAoT7P+8oP0g/yi1wYM4Yic/x6imZaQ==
X-Received: by 2002:aa7:9796:: with SMTP id o22mr23897517pfp.101.1580727270135;
        Mon, 03 Feb 2020 02:54:30 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id 11sm20923835pfz.25.2020.02.03.02.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 02:54:29 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v5 0/3] Add mt8173 elm and hana board
Date:   Mon,  3 Feb 2020 18:53:45 +0800
Message-Id: <20200203105345.118294-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds devicetree and binding document for Acer Chromebook R13 (elm)
and Lenovo Chromebook (hana), which are using mt8173 as SoC.

Changes in v5:
- add gpio-line-names for gpio controller

Changes in v4:
- fix dtbs_check errors on cros-ec-keyboard
- add comments for second source touchscreen and trackpad

Changes in v3:
- address comments in v2, major changes include:
  * move uart aliases from mt8173-elm.dtsi to mt8173.dtsi
  * remove brightness-levels in backlight
  * add interrupt for da9211
  * move pinmux for sdio_fixed_3v3 from mmc3_pins_default
  * remove some non upstream property
  * checked on schematic, cd-gpio in mmc1 should be GPIO_ACTIVE_LOW

Changes in v2:
- fix mediatek.yaml
- fixup some nodes and remove unused nodes in dts


Hsin-Yi Wang (3):
  dt-bindings: arm64: dts: mediatek: Add mt8173 elm and hana
  arm64: dts: mt8173: add uart aliases
  arm64: dts: mediatek: add mt8173 elm and hana board

 .../devicetree/bindings/arm/mediatek.yaml     |   22 +
 arch/arm64/boot/dts/mediatek/Makefile         |    3 +
 .../dts/mediatek/mt8173-elm-hana-rev7.dts     |   27 +
 .../boot/dts/mediatek/mt8173-elm-hana.dts     |   14 +
 .../boot/dts/mediatek/mt8173-elm-hana.dtsi    |   70 +
 arch/arm64/boot/dts/mediatek/mt8173-elm.dts   |   14 +
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  | 1169 +++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |    5 +-
 8 files changed, 1323 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi

-- 
2.25.0.341.g760bfbb309-goog

