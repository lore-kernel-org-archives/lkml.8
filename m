Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6950BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4522D20885
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgHNNga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 09:36:30 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:43782 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgHNNga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:36:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 1E861FB07;
        Fri, 14 Aug 2020 15:36:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q6Zfzkg2jRDO; Fri, 14 Aug 2020 15:36:24 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id EC786457CC; Fri, 14 Aug 2020 15:36:23 +0200 (CEST)
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
Subject: [PATCH 0/3] drm/panel: Add panel driver for the Mantix MLAF057WE51-X DSI panel
Date:   Fri, 14 Aug 2020 15:36:20 +0200
Message-Id: <cover.1597412076.git.agx@sigxcpu.org>
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

This series is against next-20200814.

Guido Günther (3):
  dt-bindings: vendor-prefixes: Add mantix vendor prefix
  dt-bindings: Add Mantix MLAF057WE51-X panel bindings
  drm/panel: Add panel driver for the Mantix MLAF057WE51-X DSI panel

 .../display/panel/mantix,mlaf057we51-x.yaml   |  73 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 362 ++++++++++++++++++
 6 files changed, 456 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c

-- 
2.26.2

