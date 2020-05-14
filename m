Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7478FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44EEF206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483436;
	bh=SAfOCFHBexJBzEkBuz8E/9AxJgu9uGJhvz1+5p2MdQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2aBJWrdg+giVH1o3iY5krwTlo9BW9EiVp/Y6YbZ6expQ2H4HNBMWnY4vjdNLvLRH9
	 t3Tr1e035pKu0h/l5UUnd/htOJK9byClJK6YgZOml0T3lDikcRsv0YUvEmYEMjZm2i
	 KDaB/908hsYwrbrDSDUVZduO0I4TVc+nWDXLluf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgENTKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbgENSwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:52:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 356892065F;
        Thu, 14 May 2020 18:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482353;
        bh=SAfOCFHBexJBzEkBuz8E/9AxJgu9uGJhvz1+5p2MdQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dxwmraHy4rM5ddMCvR6DWzRjdn04ajGgoYCDmu66UuJjuKhfwK5GdiEzUgi+8dz7J
         XcAXBp2RPn73NTZ3TpdXE/jApzmeq1znviErXAJmjxrrP7r0+zDmLD+CuRVGLH3Oke
         0V4XJvZKWB/in3scoc5oaYvjND3cxD0URpP61LuU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 34/62] sun6i: dsi: fix gcc-4.8
Date:   Thu, 14 May 2020 14:51:19 -0400
Message-Id: <20200514185147.19716-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185147.19716-1-sashal@kernel.org>
References: <20200514185147.19716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 3a3a71f97c30983f1627c2c550d43566e9b634d2 ]

Older compilers warn about initializers with incorrect curly
braces:

drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c: In function 'sun6i_dsi_encoder_enable':
drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:720:8: error: missing braces around initializer [-Werror=missing-braces]
  union phy_configure_opts opts = { 0 };
        ^
drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:720:8: error: (near initialization for 'opts.mipi_dphy') [-Werror=missing-braces]

Use the GNU empty initializer extension to avoid this.

Fixes: bb3b6fcb6849 ("sun6i: dsi: Convert to generic phy handling")
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://patchwork.freedesktop.org/patch/msgid/20200428215105.3928459-1-arnd@arndb.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index a75fcb1131724..2b6d77ca3dfc2 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -719,7 +719,7 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
 	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
 	struct sun6i_dsi *dsi = encoder_to_sun6i_dsi(encoder);
 	struct mipi_dsi_device *device = dsi->device;
-	union phy_configure_opts opts = { 0 };
+	union phy_configure_opts opts = { };
 	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
 	u16 delay;
 
-- 
2.20.1

