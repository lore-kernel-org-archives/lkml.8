Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A2AC2BB84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955582074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="mbfzMJdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgIDLA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 07:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIDLAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:00:40 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA88DC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 04:00:39 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout1.routing.net (Postfix) with ESMTP id 1407E4026B;
        Fri,  4 Sep 2020 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1599217229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DXWunT6/1oNeLvT/FMsXBR2HIErDGDCvRZEkb2LPbhU=;
        b=mbfzMJdQ5aIC4rkeOeCzXpVZ4rxaoYZIYGpWAvoU0cVbfERXsjipPqZWVy1yY9CjS3k5yN
        0JVVKhL9gdwN9bTa5lcZK4bDOjUTUFonAdLrjEWoN8gRVSqnRNzUCJmfTHh3gpoEvxitb1
        imA54I3xXc9FhWom/zIHN2K2gttkXYI=
Received: from localhost.localdomain (fttx-pool-217.61.147.193.bambit.de [217.61.147.193])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 2B322360469;
        Fri,  4 Sep 2020 11:00:28 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v6 0/4] make hdmi work on bananapi-r2
Date:   Fri,  4 Sep 2020 12:59:58 +0200
Message-Id: <20200904110002.88966-1-linux@fw-web.de>
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

v5->v6:
 - drop parts already merged to mediatek-drm-next
 - include lima-regulator-patch
 - rebase on changes in mediatek-drm-next tree (hdmi/hdmi-phy patches)
 - fix compatible of hdmi0 because of changes in hdmi-driver
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
     which may cause also some resolutions not working on some TFT

Alex Ryabchenko (1):
  arm: dts: mt7623: add lima related regulator

Frank Wunderlich (1):
  arm: dts: mt7623: move display nodes to separate mt7623n.dtsi

Ryder Lee (1):
  arm: dts: mt7623: add display subsystem related device nodes

chunhui dai (1):
  drm/mediatek: disable tmds on mt2701

 arch/arm/boot/dts/mt7623.dtsi                 | 123 -------
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  87 ++++-
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  74 ++++-
 arch/arm/boot/dts/mt7623n.dtsi                | 306 ++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c    |   1 +
 drivers/phy/mediatek/phy-mtk-hdmi.c           |   3 +
 drivers/phy/mediatek/phy-mtk-hdmi.h           |   1 +
 7 files changed, 469 insertions(+), 126 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt7623n.dtsi

-- 
2.25.1

