Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093DBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D462220715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824840;
	bh=SAfOCFHBexJBzEkBuz8E/9AxJgu9uGJhvz1+5p2MdQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i72lFBtmQlqfwkaYeLVpwEeaQBLIqB+LHfAMWMpLxxK25uFz8skVGDlxmVOH6Fqp7
	 JId6oVmsUfyuDV7X952bQ7yIcAq3+CsJ1A+qqKn6m6f6untTbHMcO6AG+2Fp8QJfzu
	 gf9VXMnhVkM+psMfNT5lTPrnm0y3uve6ja0BaflQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbgERSAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732244AbgERSAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:00:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD900207F5;
        Mon, 18 May 2020 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824834;
        bh=SAfOCFHBexJBzEkBuz8E/9AxJgu9uGJhvz1+5p2MdQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqzJPjJH3vxr5kGAo3k0uT2FdW17dRWCOXeGlWvU5TKzzu6leTOMuVtDIZA3QuqvQ
         rIrvE8KFXd57Ze1uEKwD7wfLFrdLfOE10THWI+RhGOBgrz/Pe9gVxQ6P5fM1MNdaGN
         T19uxAE6HhggUoY5ltxelJij0A9vvYD+4lSswUgA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 022/194] sun6i: dsi: fix gcc-4.8
Date:   Mon, 18 May 2020 19:35:12 +0200
Message-Id: <20200518173533.369441916@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



