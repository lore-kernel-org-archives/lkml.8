Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34017C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1037D20786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHZIxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgHZIxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:53:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248BDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 01:53:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 49EB129435B
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Cc:     narmstrong@baylibre.com, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org, a.hajda@samsung.com,
        boris.brezillon@collabora.com, laurent.pinchart@ideasonboard.com,
        sam@ravnborg.org, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [RESEND PATCH v2 0/2] Convert mtk-dpi to drm_bridge API
Date:   Wed, 26 Aug 2020 10:53:15 +0200
Message-Id: <20200826085317.681385-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The mtk-dpi driver still uses the drm_encoder API which is now somewhat
deprecated. We started to move all the Mediatek drivers to the drm_bridge API,
like we did for the mtk-dsi driver [1], this is another small step to be able to
fully convert the DRM Mediatek drivers to the drm_bridge API. A dummy
drm_encoder is maintained in the mtk-dpi driver but the end goal is move all the
dummy drm_encoder (mtk-dsi, mtk-dpi, etc) to the main mtk_drm_drv driver.

[1] https://lore.kernel.org/patchwork/project/lkml/list/?series=441559

Changes in v2:
- Maintain error message when attach to bridge fails. (Boris)

Enric Balletbo i Serra (2):
  drm/mediatek: mtk_dpi: Rename bridge to next_bridge
  drm/mediatek: mtk_dpi: Convert to bridge driver

 drivers/gpu/drm/mediatek/mtk_dpi.c | 77 +++++++++++++++++-------------
 1 file changed, 45 insertions(+), 32 deletions(-)

-- 
2.28.0

