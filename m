Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0E3C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AFE20639
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597851943;
	bh=BezFOoaDmBZMcNTvmxTbP7GmF8Yi46thyB2BlvRmFFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yJkoiFfwnnIZ/yRawPIJ/PR7GAX8jpiX93bzC5ZuRCUK+MjfDe5QLANJOK5aYx2Vm
	 COHcPd8xgjSzN1SMbAHW8+jd0kx/AZmoBESE+Buy7LGTeKTopZ3FAPb75FDToP/uhy
	 OnxY7ofuD3PotdbUEJp1iZ6tCFoqFk+rC7ZrccjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgHSPpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728706AbgHSPpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:45:12 -0400
Received: from DESKTOP-GFFITBK.localdomain (218-161-90-76.HINET-IP.hinet.net [218.161.90.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0320214F1;
        Wed, 19 Aug 2020 15:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597851912;
        bh=BezFOoaDmBZMcNTvmxTbP7GmF8Yi46thyB2BlvRmFFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnXgq60LTY1LRTG8gsVxPtAo0+iD/bpplHZHDVwl3QrBIvPstTqwpGHfRIDoJwwz/
         Y3XipOLN8FI+EKRrUGWmbl3PfuIeEzsScLJlQbt70+QePRjjwYyZ34Y+vZyctoPmOD
         W/NcFzM02Dbexw3SGo8n019/eZfInE/NiQbxBcLw=
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
Subject: [PATCH v4 4/4] MAINTAINERS: add files for Mediatek DRM drivers
Date:   Wed, 19 Aug 2020 23:44:21 +0800
Message-Id: <20200819154421.7013-5-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819154421.7013-1-chunkuang.hu@kernel.org>
References: <20200819154421.7013-1-chunkuang.hu@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mediatek HDMI phy driver is moved from drivers/gpu/drm/mediatek to
drivers/phy/mediatek, so add the new folder to the Mediatek DRM drivers'
information.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..191bacf02209 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5793,6 +5793,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Supported
 F:	Documentation/devicetree/bindings/display/mediatek/
 F:	drivers/gpu/drm/mediatek/
+F:	drivers/phy/mediatek/phy-mtk-hdmi*
 
 DRM DRIVERS FOR NVIDIA TEGRA
 M:	Thierry Reding <thierry.reding@gmail.com>
-- 
2.17.1

