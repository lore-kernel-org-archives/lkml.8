Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61780C433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE9823B22
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgHOVc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:32:29 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:52574 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbgHOVcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:32:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 1F9E9FB09;
        Sat, 15 Aug 2020 23:16:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r8q8YHSa3Wsh; Sat, 15 Aug 2020 23:16:23 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id A05FD4576F; Sat, 15 Aug 2020 23:16:22 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] drm/panel: Add panel driver for the Mantix MLAF057WE51-X DSI panel
Date:   Sat, 15 Aug 2020 23:16:19 +0200
Message-Id: <cover.1597526107.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The panel uses a Focaltech FT8006p, the touch part is handled by the already
existing edt-ft5x06. It can be found in e.g. the Librem 5.

Changes from v1:
- Due to review comments by Sam Ravnborg, thanks!
  https://lore.kernel.org/dri-devel/20200815083917.GA993113@ravnborg.org/
  - Don't preserve newlines with '|' in description
  - Use reset-gpios and backlight from panel-common.yaml
  - Reindent example
  https://lore.kernel.org/dri-devel/20200815093226.GB993113@ravnborg.org/
  - Drop unused includes
  - Use dev_* instead of DRM_* for printing
  - Turn off regulators in reverse order from enable
  - Silence errors in mantix_{shutdown,remove}
  - Drop duplicate mipi_dsi_dcs_enter_sleep_mode()
  https://lore.kernel.org/dri-devel/20200815100230.GA1002374@ravnborg.org/
  - Use dev_err_probe()
- Add delays when turning off panel as suggested by the data sheet

This series is against next-20200814.

Guido Günther (3):
  dt-bindings: vendor-prefixes: Add mantix vendor prefix
  dt-bindings: Add Mantix MLAF057WE51-X panel bindings
  drm/panel: Add panel driver for the Mantix MLAF057WE51-X DSI panel

 .../display/panel/mantix,mlaf057we51-x.yaml   |  70 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 328 ++++++++++++++++++
 6 files changed, 419 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c

-- 
2.26.2

