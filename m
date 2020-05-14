Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C22C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E782065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483187;
	bh=sCPjoIJecCKKcl4sRs7D5KHmbz3FxC1giUdKL3F29A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mvOsm7KZSQrnPhhkZLfnj/uzsxmfMXFUVLqZW1iYr6y6aHbVsqFGkBoQXEz0HglBG
	 wSZpnMes6k3By4ssbf8Ig6W5lEzPUnSKvEDPkgMxsVR3wN+zwNDX/onjnYf1i3pUUI
	 nRrGgYtAJLQwyvhZpt0PKUhdKGztvbvky1lQIYSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgENTG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbgENSxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:53:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C21920767;
        Thu, 14 May 2020 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482430;
        bh=sCPjoIJecCKKcl4sRs7D5KHmbz3FxC1giUdKL3F29A0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMBU3NtQDPHgpwV1OOq3Xz7b/j9nA9d3jtwnDm26iouQYbEtDmrKebV2laNa6U+1V
         pslo46m05pwcbLIdG6omdq7Mc15XX/T4w0WKnQKPPJoy0wO9j3v63OAulcTyudEX6c
         vi2poaWusRprKQDuFU9BUAa7ktk1dYQRXrvUmizU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 31/49] sun6i: dsi: fix gcc-4.8
Date:   Thu, 14 May 2020 14:52:52 -0400
Message-Id: <20200514185311.20294-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185311.20294-1-sashal@kernel.org>
References: <20200514185311.20294-1-sashal@kernel.org>
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
index f83522717488a..4f944ace665d5 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -718,7 +718,7 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
 	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
 	struct sun6i_dsi *dsi = encoder_to_sun6i_dsi(encoder);
 	struct mipi_dsi_device *device = dsi->device;
-	union phy_configure_opts opts = { 0 };
+	union phy_configure_opts opts = { };
 	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
 	u16 delay;
 
-- 
2.20.1

