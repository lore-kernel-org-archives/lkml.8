Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FB9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49AD2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="uLBV4u73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgHDQ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbgHDQ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:56:17 -0400
Received: from mxwww.masterlogin.de (mxwww.masterlogin.de [IPv6:2a03:2900:1:1::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF25C061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 09:56:16 -0700 (PDT)
Received: from mxout4.routing.net (unknown [192.168.10.112])
        by forward.mxwww.masterlogin.de (Postfix) with ESMTPS id C520F9614D;
        Tue,  4 Aug 2020 16:56:08 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout4.routing.net (Postfix) with ESMTP id 898281014A6;
        Tue,  4 Aug 2020 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1596560168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vxlga8+auKVwR7Eu02+nIG8nf/8YHYDyC6kB6ZLEXCs=;
        b=uLBV4u730I7W/HQsGBK8p59T74w59J7oOrvykIk/QoRr/GNLZZf0epHYCNc3YmOvy9hAg8
        e67YJDj2kWP2ARv/fDcL/mGs1i+vYH/dFhaf9XCtVDG8PuxM97EBJq1m2MV4GxjD/h68RF
        lUEGIoLsQs6bxtZD+c3qDxln7Z1cmyg=
Received: from localhost.localdomain (fttx-pool-217.61.144.119.bambit.de [217.61.144.119])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id BA22736041E;
        Tue,  4 Aug 2020 16:56:07 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] make hdmi work on bananapi-r2
Date:   Tue,  4 Aug 2020 18:55:48 +0200
Message-Id: <20200804165555.75159-1-linux@fw-web.de>
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


Frank Wunderlich (2):
  dt-bindings: mediatek: add mt7623 display-nodes
  drm/mediatek: add ddp routing for mt7623

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
 arch/arm/boot/dts/mt7623.dtsi                 | 170 ++++++++++++++++++
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  72 ++++++++
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  72 ++++++++
 drivers/gpu/drm/mediatek/mtk_dpi.c            |   3 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   |  42 +++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |   2 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  23 +++
 drivers/gpu/drm/mediatek/mtk_dsi.c            |   3 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c       |   3 +
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h       |   1 +
 .../gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c    |   1 +
 15 files changed, 398 insertions(+), 6 deletions(-)

-- 
2.25.1

