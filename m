Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547D6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0AD20738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="hZeHVyHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHSISG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSISD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:18:03 -0400
X-Greylist: delayed 148804 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Aug 2020 01:18:02 PDT
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9799DC061389
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:18:02 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id 2E6FE3FD3D;
        Wed, 19 Aug 2020 08:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1597825079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FiBKRQX0Yu/oUfxbfaNVaqDxRl64gER3PIg7jU21vW4=;
        b=hZeHVyHF2XrQ/a58hJfkW4rkNI7zUHPiGly8MkwO/TUBgNGu0YQ5rEIrPPwL5MqCYICJIP
        0E0rFzS+RS8MOHHgeSqX66Ocsb8Lq8XDCiT4buZ0mFishA4OHmPDDJhooTQ/x6VgZQ6L8r
        vqdRqbO/TWkphgOvqTCW/Cv/nVKYyT0=
Received: from localhost.localdomain (fttx-pool-185.76.97.101.bambit.de [185.76.97.101])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 4F837100539;
        Wed, 19 Aug 2020 08:17:58 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/7] make hdmi work on bananapi-r2
Date:   Wed, 19 Aug 2020 10:17:45 +0200
Message-Id: <20200819081752.4805-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This Patch-Series adds missing Patches/Bugfixes to get hdmi working
on BPI-R2

v4->v5:
 - rebased on 5.9-rc1
 - move existing display-related dts nodes to new mt7623n.dtsi
   because mt7623a does not have gpu
 - add new display nodes to this new dtsi
v3->v4:
 - fix removed const in "add ddp routing for mt7623"
 - change subjects to "drm/mediatek:..."
 - add documentation for mt7623-* compatibles
 - dropped redundant display_components node (mmsys compatible)
 - add reviewd-by collected in v3
v2->v3:
 - use own mmsys-routing for mt7623 instead of code getting different
   routing from dts
 - remove ddp routing bls -> dpi from bpir2/rfb dts
 - updated some commit-Messages as suggested by CK Hu
v1->v2:
 - using get_possible_crtc API instead of hardcoded
 - drop unused dts-nodes
 - refine commit-messages as far as i can :)
   "config component output by device node port" is needed to fix a WARN_ON()
   "fix boot up for 720 and 480 but 1080" fixes flickering, 
     which may cause also some resolutions not working on some TFT (had some pr>

Frank Wunderlich (3):
  dt-bindings: mediatek: add mt7623 display-nodes
  drm/mediatek: add ddp routing for mt7623
  arm: dts: mt7623: move display nodes to separate mt7623n.dtsi

Jitao Shi (1):
  drm/mediatek: dpi/dsi: change the getting possible_crtc way

Ryder Lee (1):
  arm: dts: mt7623: add display subsystem related device nodes

Stu Hsieh (1):
  drm/mediatek: Add get_possible_crtc API for dpi, dsi

chunhui dai (1):
  drm/mediatek: disable tmds on mt2701

 .../display/mediatek/mediatek,disp.txt        |   2 +-
 .../display/mediatek/mediatek,dpi.txt         |   2 +-
 .../display/mediatek/mediatek,dsi.txt         |   4 +-
 .../display/mediatek/mediatek,hdmi.txt        |   4 +
 arch/arm/boot/dts/mt7623.dtsi                 | 123 -------
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  74 ++++-
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  74 ++++-
 arch/arm/boot/dts/mt7623n.dtsi                | 305 ++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dpi.c            |   3 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   |  42 +++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |   2 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  23 ++
 drivers/gpu/drm/mediatek/mtk_dsi.c            |   3 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c       |   3 +
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h       |   1 +
 .../gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c    |   1 +
 16 files changed, 535 insertions(+), 131 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt7623n.dtsi

-- 
2.25.1

