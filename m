Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18953C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAAC20838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bUN6TfTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBJGgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 01:36:22 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:36948 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgBJGgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 01:36:21 -0500
Received: by mail-pf1-f174.google.com with SMTP id p14so3209307pfn.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 22:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lo17ppS/z0H1lSs1uTt0PZLLJNNtFvUKsUcqWlfn7Dc=;
        b=bUN6TfTE7usvEbrf47ULqCV7Q1Wmo6/Vzyto8zU5n07Oijvw4PAsNQlaYy5fRB+Own
         LBZXlJr3KquKZ+JciXDyIRgUHtAVe27qImHD4CtpQCOp6qC9h4wib31fnJ40b+jIxn/S
         6ytT9ejZ497xQAfK5M11UhTtxBHR5HpdXQsBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lo17ppS/z0H1lSs1uTt0PZLLJNNtFvUKsUcqWlfn7Dc=;
        b=oNCinGpJOisUS5rqlRxjEOsuwM0uv3HYmng0c5tne9lz61MwaPAqBs7lyXwpeLblqm
         VcnYNs++L/zfvhVqIeNHYYZlabRsk1WhU8PzsX1abDM3JUDbhIDyy1WfKJ6sDw1c52kV
         KfoZS+fD7mg91lnxDNqrHrjdlhGS8a3tUgJEs6bzJkrC1cK4Dr9SLHwUEUP/GhXa8apf
         ePTcKhnagEyimLnqNQXlY1KxgFXUE4C3xawVmUPwzZps4qk6GnGyPTDxBa1312DqKvGf
         VA/FYRMjv9S8ShWur/BXHgNz3ijm/ePV0TrhcI/B1x3Y8DBIuBzRG256xllI+ll+vAs9
         8RIg==
X-Gm-Message-State: APjAAAXQ1RxLVZavx85CqFRvgTQtwh58ZJoZ2tl2kI2mwe3rLkLx/IGw
        KpY67O92mbRB31gjcEtruibBoA==
X-Google-Smtp-Source: APXvYqyV5uXjYlcd6ghIM6ap/HEp0sTQIJM1ZhrD03kxdqxEcvdfBDVhE8hzFps31kS5WDBa6r922Q==
X-Received: by 2002:a62:6342:: with SMTP id x63mr11616369pfb.103.1581316580334;
        Sun, 09 Feb 2020 22:36:20 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id f15sm11070041pgj.30.2020.02.09.22.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 22:36:19 -0800 (PST)
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
Subject: [PATCH v7 0/5] Add mt8173 elm and hana board
Date:   Mon, 10 Feb 2020 14:35:19 +0800
Message-Id: <20200210063523.133333-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds devicetree and binding document for Acer Chromebook R13 (elm)
and Lenovo Chromebook (hana), which are using mt8173 as SoC.

Changes in v7:
- add pull-up for da9211 to fix spurious interrupts

Changes in v6:
- fix several unit name warnings in mt8173.dtsi and mt8173-elm.dtsi

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

Hsin-Yi Wang (5):
  dt-bindings: arm64: dts: mediatek: Add mt8173 elm and hana
  arm64: dts: mt8173: add uart aliases
  arm64: dts: mt8173: fix unit name warnings
  arm64: dts: mediatek: add mt8173 elm and hana board
  media: mtk-mdp: Use correct aliases name

 .../devicetree/bindings/arm/mediatek.yaml     |   22 +
 arch/arm64/boot/dts/mediatek/Makefile         |    3 +
 .../dts/mediatek/mt8173-elm-hana-rev7.dts     |   27 +
 .../boot/dts/mediatek/mt8173-elm-hana.dts     |   14 +
 .../boot/dts/mediatek/mt8173-elm-hana.dtsi    |   70 +
 arch/arm64/boot/dts/mediatek/mt8173-elm.dts   |   14 +
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  | 1173 +++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |   43 +-
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c |    8 +-
 9 files changed, 1350 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi

-- 
2.25.0.225.g125e21ebc7-goog

