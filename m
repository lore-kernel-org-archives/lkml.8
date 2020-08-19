Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92631C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649CB2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597851928;
	bh=SYJC1gKfrfOoJ3hUhVfyy/GFNr1FeV/aeAmVqjZ8Mc4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2tl48p++86DTjzMK1GR3E5VpbZofSQka6KeAszaN69FJbBu3B5DXKDplFP/xv+ZkR
	 EBt4dclxE4AyZbhndfxNePszpu6CAv1Xl9SOeR+JbaxNB9+XNBFo+XZrvd8hRm/kdr
	 hYco/n55cIDbBjRGP4JvBtlfvjlhB7gLJJciDOqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgHSPpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgHSPpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:45:03 -0400
Received: from DESKTOP-GFFITBK.localdomain (218-161-90-76.HINET-IP.hinet.net [218.161.90.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED1D220639;
        Wed, 19 Aug 2020 15:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597851902;
        bh=SYJC1gKfrfOoJ3hUhVfyy/GFNr1FeV/aeAmVqjZ8Mc4=;
        h=From:To:Cc:Subject:Date:From;
        b=i2B8F28mZfGP9HW2IbHytbUrhOdKJrpfS0PDdPffY4OJ1zjpH6fizph6kwqHdXPr6
         QVrJsnq6G+JyYZrxfiPiKfz26IoK4RrVV7agP9hmoINVq3ZlidiTFRV09suDdZnrLd
         T57d2Yp0zzp0N7UoG9iBPQSU1TiySoUyZ4dg7YEQ=
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v4 0/4] Move Mediatek HDMI PHY driver from DRM folder to PHY folder
Date:   Wed, 19 Aug 2020 23:44:17 +0800
Message-Id: <20200819154421.7013-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_hdmi_phy is currently placed inside mediatek drm driver, but it's
more suitable to place a phy driver into phy driver folder, so move
mtk_hdmi_phy driver into phy driver folder.

Changes in v4:
- Rebase onto 5.9-rc1
- Remove mtk_hdmi_conf_mt8173.

Changes in v3:
- Modify [PATCH v2 3/4] prefix.

Changes in v2:
- include module.h in mtk_hdmi.c

CK Hu (3):
  drm/mediatek: Move tz_disabled from mtk_hdmi_phy to mtk_hdmi driver
  drm/mediatek: Separate mtk_hdmi_phy to an independent module
  phy: mediatek: Move mtk_hdmi_phy driver into drivers/phy/mediatek
    folder

Chun-Kuang Hu (1):
  MAINTAINERS: add files for Mediatek DRM drivers

 MAINTAINERS                                   |  1 +
 drivers/gpu/drm/mediatek/Kconfig              |  2 +-
 drivers/gpu/drm/mediatek/Makefile             |  5 +----
 drivers/gpu/drm/mediatek/mtk_hdmi.c           | 21 +++++++++++++++----
 drivers/gpu/drm/mediatek/mtk_hdmi.h           |  1 -
 drivers/phy/mediatek/Kconfig                  |  7 +++++++
 drivers/phy/mediatek/Makefile                 |  6 ++++++
 .../mediatek/phy-mtk-hdmi-mt2701.c}           |  3 +--
 .../mediatek/phy-mtk-hdmi-mt8173.c}           |  2 +-
 .../mediatek/phy-mtk-hdmi.c}                  |  3 ++-
 .../mediatek/phy-mtk-hdmi.h}                  |  2 --
 11 files changed, 37 insertions(+), 16 deletions(-)
 rename drivers/{gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c => phy/mediatek/phy-mtk-hdmi-mt2701.c} (99%)
 rename drivers/{gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c => phy/mediatek/phy-mtk-hdmi-mt8173.c} (99%)
 rename drivers/{gpu/drm/mediatek/mtk_hdmi_phy.c => phy/mediatek/phy-mtk-hdmi.c} (98%)
 rename drivers/{gpu/drm/mediatek/mtk_hdmi_phy.h => phy/mediatek/phy-mtk-hdmi.h} (95%)

-- 
2.17.1

