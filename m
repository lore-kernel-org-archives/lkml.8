Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183FFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D813C206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466561;
	bh=69KAXq7nSrNne8dVE7YVsV2/lDTgQzzsUVum5KwNVZc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=E4ZQGA+1Z2rQm6ZZ+ucXByrzr99k+HgvHuxIxgvAh6rw8ir6PbhXfuCRuNEtejqSk
	 HerxEWcyOthaNRmOpdFbsexLXMg8Iv2Yiw9ZQ5717ZDeOZgrUvCA5jX2BNX5uTbOnQ
	 EDN+uciDDH1V+dsXTx3B5Lmt6KnpHxrYVsb1NYto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgF2VgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728485AbgF2Skq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:46 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.194.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 720452312E;
        Mon, 29 Jun 2020 06:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593410447;
        bh=69KAXq7nSrNne8dVE7YVsV2/lDTgQzzsUVum5KwNVZc=;
        h=From:To:Cc:Subject:Date:From;
        b=GRSZFxsRZTWvOaiuzo8KJuHhWg6fv0kcWT84LyI53REIlQNAFJBgWtSDfy0UeBZrb
         zDuzXx4213NUAaSuiH3mKzaSCcQNusd1UXAOiWVQZ6qcnUZF9DMNA9p/WftCz9AdGk
         0cjZOAuZXSdbSxPfzzuRm+wEa09MV4SsfP8A07Dk=
Received: by wens.tw (Postfix, from userid 1000)
        id 13E895FCA9; Mon, 29 Jun 2020 14:00:45 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: sun4i: hdmi: Remove extra HPD polling
Date:   Mon, 29 Jun 2020 14:00:32 +0800
Message-Id: <20200629060032.24134-1-wens@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The HPD sense mechanism in Allwinner's old HDMI encoder hardware is more
or less an input-only GPIO. Other GPIO-based HPD implementations
directly return the current state, instead of polling for a specific
state and returning the other if that times out.

Remove the I/O polling from sun4i_hdmi_connector_detect() and directly
return a known state based on the current reading. This also gets rid
of excessive CPU usage by kworker as reported on Stack Exchange [1] and
Armbian forums [2].

 [1] https://superuser.com/questions/1515001/debian-10-buster-on-cubietruck-with-bug-in-sun4i-drm-hdmi
 [2] https://forum.armbian.com/topic/14282-headless-systems-and-sun4i_drm_hdmi-a10a20/

Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index ce07ddc3e058..557cbe5ab35f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -259,9 +259,8 @@ sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
 	unsigned long reg;
 
-	if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_HPD_REG, reg,
-			       reg & SUN4I_HDMI_HPD_HIGH,
-			       0, 500000)) {
+	reg = readl(hdmi->base + SUN4I_HDMI_HPD_REG);
+	if (reg & SUN4I_HDMI_HPD_HIGH) {
 		cec_phys_addr_invalidate(hdmi->cec_adap);
 		return connector_status_disconnected;
 	}
-- 
2.27.0

