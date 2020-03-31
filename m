Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719E4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442D3212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585670268;
	bh=bFnnF2dZO5qJovO73F2Ej1VVG447VC5SqBeFPILlMsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SHTJViCeAeDI7HNr4+yO9G6FxkhgBMTihRBYymir+L39GjlXBLJbnbB5p5ZVOqk1R
	 nimHFO/nARHSOOle8QwztQ1+Vu3mMoWeFLbTEaCFoCBPcHNKSmDyfT1/tpZ4hUnfdf
	 9tvFuwugOiS9cBwH2fsKgV286o+jl/RNC91BGziI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbgCaP5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731202AbgCaP5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:57:44 -0400
Received: from DESKTOP-GFFITBK.localdomain (218-161-90-76.HINET-IP.hinet.net [218.161.90.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D498214D8;
        Tue, 31 Mar 2020 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585670264;
        bh=bFnnF2dZO5qJovO73F2Ej1VVG447VC5SqBeFPILlMsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LehEO92zj/jb1FWwEtS+u7BzpzT+Ii4OZysyBIwf/nqljEhon/w4RljTNgVFTWkpJ
         UcrZi0tBki2L61LDLGpeKV7i7Au2MWGLH46f+cDNEcYP1hjoHTRpBrnB6Qwv1mKh6E
         OLUklYq0W5ykLjHHGeqsXdrVC7F50KEnna6f4b70=
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
Subject: [PATCH v3 4/4] MAINTAINERS: add files for Mediatek DRM drivers
Date:   Tue, 31 Mar 2020 23:57:28 +0800
Message-Id: <20200331155728.18032-5-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200331155728.18032-1-chunkuang.hu@kernel.org>
References: <20200331155728.18032-1-chunkuang.hu@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mediatek HDMI phy driver is moved from drivers/gpu/drm/mediatek to
drivers/phy/mediatek, so add the new folder to the Mediatek DRM drivers'
information.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3f7b6f..129777037538 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5612,6 +5612,7 @@ M:	Philipp Zabel <p.zabel@pengutronix.de>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 F:	drivers/gpu/drm/mediatek/
+F:	drivers/phy/mediatek/phy-mtk-hdmi*
 F:	Documentation/devicetree/bindings/display/mediatek/
 
 DRM DRIVERS FOR NVIDIA TEGRA
-- 
2.17.1

