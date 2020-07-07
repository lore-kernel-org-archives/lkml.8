Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51B8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91150207BB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594134984;
	bh=7joXzKaGfGR+ibfYWTpBL8FkbeLIOSNRApnPwWP0LS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MO2t5i685pAaqSPwqdslhZBbPjWvz9HOkrhlopAsfHLq6RBNqOBQfSs87Cah0NjDq
	 y8eGk3m94zYnBKZsa+g5ZhYlbfqtypLLH2O8tONRZnr+127vAp6Wm4mBy8vrQR/oEI
	 nOXtXPwvsumGU8QS0dTpgS8+wOriSP8SkSWYxpnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgGGPQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbgGGPQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:16:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25E1020738;
        Tue,  7 Jul 2020 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594134979;
        bh=7joXzKaGfGR+ibfYWTpBL8FkbeLIOSNRApnPwWP0LS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRsBFzOTwgB8mUZo7E4a8UMBIjwOal1tALEk1daLi9rRbJBTklOjiw/DUa7TiMXGl
         VhazApMohWKjlYey0PVfh2Qos7O/dFJ4bTnceuG0ulC4Iu7j1L2Cg7h13F+XnYGsW/
         HQ9r/r/VXGBNsBO/tnjbEeVRhHVaza1cHpSoNNX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 16/27] drm: sun4i: hdmi: Remove extra HPD polling
Date:   Tue,  7 Jul 2020 17:15:43 +0200
Message-Id: <20200707145749.725962737@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145748.944863698@linuxfoundation.org>
References: <20200707145748.944863698@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit bda8eaa6dee7525f4dac950810a85a88bf6c2ba0 ]

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
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://patchwork.freedesktop.org/patch/msgid/20200629060032.24134-1-wens@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 298d6a8bab120..82cb939351889 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -214,9 +214,8 @@ sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
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
2.25.1



