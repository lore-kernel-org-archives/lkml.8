Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8087C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F6722CA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgHGRuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:50:01 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:53015 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728080AbgHGRt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:49:59 -0400
X-IronPort-AV: E=Sophos;i="5.75,446,1589209200"; 
   d="scan'208";a="53937333"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Aug 2020 02:49:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id F03A74004BA6;
        Sat,  8 Aug 2020 02:49:54 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/7] r8a7742: Enable DU and LVDS
Date:   Fri,  7 Aug 2020 18:49:47 +0100
Message-Id: <20200807174954.14448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series adds support for DU and LVDS to r8a7742
SoC and enables LCD support on r8a7742-iwg21d-q7 board.

This patch series applies on top of [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/
    renesas-devel.git/log/?h=renesas-arm-dt-for-v5.10

Cheers,
Prabhakar

Lad Prabhakar (7):
  dt-bindings: display: renesas,du: Document the r8a7742 bindings
  drm: rcar-du: Add r8a7742 support
  dt-bindings: display: renesas,lvds: Document r8a7742 bindings
  drm: rcar-du: lvds: Add r8a7742 support
  ARM: dts: r8a7742: Add DU support
  ARM: dts: r8a7742: Add LVDS support
  ARM: dts: r8a7742-iwg21d-q7: Add LCD support

 .../bindings/display/bridge/renesas,lvds.txt  |  1 +
 .../bindings/display/renesas,du.txt           |  2 +
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts       | 84 +++++++++++++++++
 arch/arm/boot/dts/r8a7742.dtsi                | 89 +++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  5 +-
 drivers/gpu/drm/rcar-du/rcar_lvds.c           |  1 +
 6 files changed, 180 insertions(+), 2 deletions(-)

-- 
2.17.1

