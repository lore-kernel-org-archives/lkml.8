Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF44CC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D50420838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="IQf56fS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgAJPxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:53:34 -0500
Received: from hermes.aosc.io ([199.195.250.187]:48712 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgAJPxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:53:34 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 89D1E46EF0;
        Fri, 10 Jan 2020 15:53:22 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/5] Add support for Pine64 PineTab
Date:   Fri, 10 Jan 2020 23:52:20 +0800
Message-Id: <20200110155225.1051749-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1578671613;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=arqgargl3bY9HACPJC+50BrUGIBgfwYWhQpbFvgf9g8=;
        b=IQf56fS/L+J88wDn5NITVutxMKkOSUkKA6VObrxd0nceXBTehZ53tj/U1e4PgIkZkj1bjf
        4iQVIUnkzeFOm/209cHapWzv7Yz0uEmmP3Nt0UPwdShfzRIfpjhuw3glbKy7Cf4/6bPgrU
        kC/XnMd4+vPsplC+ya6/xeUFS8zfnHA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset tries to add support for the PineTab tablet from Pine64.

As it uses a specific MIPI-DSI panel, the support of the panel should be
introduced first, with its DT binding.

Then a device tree is added. Thanks to the community's contributions
these years, we now have most of the functionalities of the tablet
available in this device tree.

Icenowy Zheng (5):
  dt-bindings: vendor-prefix: add Shenzhen Feixin Photoelectics Co., Ltd
  dt-bindings: panel: add Feixin K101 IM2BA02 MIPI-DSI panel
  drm/panel: Add Feixin K101 IM2BA02 panel
  dt-bindings: arm: sunxi: add binding for PineTab tablet
  arm64: dts: allwinner: a64: add support for PineTab

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 .../display/panel/feixin,k101-im2ba02.yaml    |  54 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../boot/dts/allwinner/sun50i-a64-pinetab.dts | 461 +++++++++++++++
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-feixin-k101-im2ba02.c | 548 ++++++++++++++++++
 9 files changed, 1087 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
 create mode 100644 drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c

-- 
2.23.0

