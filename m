Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194ACC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A7222CF8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHGRuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:50:14 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:4654 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728155AbgHGRuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:50:10 -0400
X-IronPort-AV: E=Sophos;i="5.75,446,1589209200"; 
   d="scan'208";a="53937348"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Aug 2020 02:50:09 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C873A40061B5;
        Sat,  8 Aug 2020 02:50:06 +0900 (JST)
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
Subject: [PATCH 4/7] drm: rcar-du: lvds: Add r8a7742 support
Date:   Fri,  7 Aug 2020 18:49:51 +0100
Message-Id: <20200807174954.14448-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200807174954.14448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200807174954.14448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LVDS encoders on RZ/G1H SoC is identical to the R-Car Gen2 family. Add
support for RZ/G1H (R8A7742) SoC to the LVDS encoder driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index ab0d49618cf9..34b833cc05be 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -982,6 +982,7 @@ static const struct rcar_lvds_device_info rcar_lvds_r8a77995_info = {
 };
 
 static const struct of_device_id rcar_lvds_of_table[] = {
+	{ .compatible = "renesas,r8a7742-lvds", .data = &rcar_lvds_gen2_info },
 	{ .compatible = "renesas,r8a7743-lvds", .data = &rcar_lvds_gen2_info },
 	{ .compatible = "renesas,r8a7744-lvds", .data = &rcar_lvds_gen2_info },
 	{ .compatible = "renesas,r8a774a1-lvds", .data = &rcar_lvds_gen3_info },
-- 
2.17.1

