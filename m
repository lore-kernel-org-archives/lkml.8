Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEA2C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1345B2072E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584891290;
	bh=UCXXOiIFzG5USxwTHZk7yE+L13xN0ZWV3Sj+DrUNxoA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=H64v2br4RBiGf54tx4t/kkDIZ66aVVjUEn5+ZAXKqB5HGoN8UpyaoqMCzLTMkiqBA
	 I6tsohRHuRPAwXheVDYZ7pJKVNkHrbOHW5YWaBRy3ZczOg6ULKECE77mWnXVKBwt36
	 e9lhyvqe90L85ePONsUzzzsmSSVpAQ3MUhdp4AfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCVPes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgCVPes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 11:34:48 -0400
Received: from DESKTOP-GFFITBK.localdomain (218-161-90-76.HINET-IP.hinet.net [218.161.90.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F5E320714;
        Sun, 22 Mar 2020 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584891288;
        bh=UCXXOiIFzG5USxwTHZk7yE+L13xN0ZWV3Sj+DrUNxoA=;
        h=From:To:Cc:Subject:Date:From;
        b=ho8dXUpFLrv7BWu3u7E2TB++p0MLIf6s67sN+3RlOwvBi+4Xr+/UVlQrTvgwQMzjs
         UQ53mbl7I9awnG7V3B2cf/38GwUdGo12q5guF1ymzPTb00RbAKYdMd+3L5SMy+dxlg
         7iES2r/rJIzvnYjkpTAEZATydgwN6iYoGlBUIxJE=
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
Subject: [PATCH 0/4] Move Mediatek HDMI PHY driver from DRM folder to PHY folder
Date:   Sun, 22 Mar 2020 23:34:20 +0800
Message-Id: <20200322153424.2447-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_hdmi_phy is currently placed inside mediatek drm driver, but it's
more suitable to place a phy driver into phy driver folder, so move
mtk_hdmi_phy driver into phy driver folder.

CK Hu (3):
  drm/mediatek: Move tz_disabled from mtk_hdmi_phy to mtk_hdmi driver
  drm/mediatek: Separate mtk_hdmi_phy to an independent module
  drm/mediatek: Move mtk_hdmi_phy driver into drivers/phy/mediatek
    folder

Chun-Kuang Hu (1):
  MAINTAINERS: add files for Mediatek DRM drivers

 MAINTAINERS                                   |  1 +
 drivers/gpu/drm/mediatek/Kconfig              |  2 +-
 drivers/gpu/drm/mediatek/Makefile             |  5 +---
 drivers/gpu/drm/mediatek/mtk_hdmi.c           | 23 +++++++++++++++----
 drivers/gpu/drm/mediatek/mtk_hdmi.h           |  1 -
 drivers/phy/mediatek/Kconfig                  |  7 ++++++
 drivers/phy/mediatek/Makefile                 |  7 ++++++
 .../mediatek/phy-mtk-hdmi-mt2701.c}           |  3 +--
 .../mediatek/phy-mtk-hdmi-mt8173.c}           |  2 +-
 .../mediatek/phy-mtk-hdmi.c}                  |  3 ++-
 .../mediatek/phy-mtk-hdmi.h}                  |  2 --
 11 files changed, 40 insertions(+), 16 deletions(-)
 rename drivers/{gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c => phy/mediatek/phy-mtk-hdmi-mt2701.c} (99%)
 rename drivers/{gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c => phy/mediatek/phy-mtk-hdmi-mt8173.c} (99%)
 rename drivers/{gpu/drm/mediatek/mtk_hdmi_phy.c => phy/mediatek/phy-mtk-hdmi.c} (98%)
 rename drivers/{gpu/drm/mediatek/mtk_hdmi_phy.h => phy/mediatek/phy-mtk-hdmi.h} (95%)

-- 
2.17.1

