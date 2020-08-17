Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7D1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3011920674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693125;
	bh=Ev2MKrV3RTdHkwWtyN15qSAmclYuXz3Qy4/2nqB5rpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WL5zklxkgFPAWpzW9gVwHQn8jUjyyxR1DK/bRF96584AvflfPmviTPRb0o5uQ43il
	 OaPgy/s2zeyLknKEJ05s4TyH88Ac0uzyW5jQ007/j4gJDCH2Y2sGXH8LPYi2+299tj
	 8Q5kTV56M2r5YIIrDBopm2US00dg5qFoVXXCSf54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbgHQTin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHQP1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:27:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61F7323A85;
        Mon, 17 Aug 2020 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678024;
        bh=Ev2MKrV3RTdHkwWtyN15qSAmclYuXz3Qy4/2nqB5rpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bw9m/wWPylCfFwPHmWte3B8Gq/nGWDe4S7Kqme6rnRlF9SsHdZhch5Sq9Zo/AgSsH
         4ppPtzeLAZS2upJEoFOsRQjAU6ZTXFMB8QpNnVRk45bWOlvuKrbER4nCDqEjY1lKjI
         +8MIRDNxj/5yHOsuQLeEikStGc1AJzwQSjpvYSiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Chiras <robert.chiras@nxp.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 185/464] drm/mipi: use dcs write for mipi_dsi_dcs_set_tear_scanline
Date:   Mon, 17 Aug 2020 17:12:18 +0200
Message-Id: <20200817143842.686102592@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Velikov <emil.velikov@collabora.com>

[ Upstream commit 7a05c3b6d24b8460b3cec436cf1d33fac43c8450 ]

The helper uses the MIPI_DCS_SET_TEAR_SCANLINE, although it's currently
using the generic write. This does not look right.

Perhaps some platforms don't distinguish between the two writers?

Cc: Robert Chiras <robert.chiras@nxp.com>
Cc: Vinay Simha BN <simhavcs@gmail.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Thierry Reding <treding@nvidia.com>
Fixes: e83950816367 ("drm/dsi: Implement set tear scanline")
Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200505160329.2976059-3-emil.l.velikov@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 55531895dde6d..37b03fefbdf6f 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1082,11 +1082,11 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_pixel_format);
  */
 int mipi_dsi_dcs_set_tear_scanline(struct mipi_dsi_device *dsi, u16 scanline)
 {
-	u8 payload[3] = { MIPI_DCS_SET_TEAR_SCANLINE, scanline >> 8,
-			  scanline & 0xff };
+	u8 payload[2] = { scanline >> 8, scanline & 0xff };
 	ssize_t err;
 
-	err = mipi_dsi_generic_write(dsi, payload, sizeof(payload));
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_TEAR_SCANLINE, payload,
+				 sizeof(payload));
 	if (err < 0)
 		return err;
 
-- 
2.25.1



