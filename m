Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DCCC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EBD020786
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594429837;
	bh=obkdWl2N6bzEnN0PanxeRIISOXyw6TIbMvNwfoNiaXM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1uCzeKrQ3seuznRaZ6Q5as3uCez0UUmNHyWVlKlIIPhV4taUETYonDFL/XbOcyoHf
	 7xcvsJ0XVEVSyFTHKEMOFxnDBNtEApNZQBlFxaVjL3RLexGlQhkqnIkenov8ccFIrD
	 HY69jAEi56SdnKZtK9OACwsIkvK90jyfeeBwTqY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgGKBKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 21:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgGKBKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 21:10:36 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.194.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B3AD2076A;
        Sat, 11 Jul 2020 01:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594429835;
        bh=obkdWl2N6bzEnN0PanxeRIISOXyw6TIbMvNwfoNiaXM=;
        h=From:To:Cc:Subject:Date:From;
        b=Ua2kf3VZjIIkFbHCUgHFuh6yEuyDq5Lg1907l3oLg1B2S8kTEbM8GNOlOIsLFNru8
         HdjWhP+w9zVzIBZ+9qkky5iZIkotwCgwlSBdtUBbC5HydTgN4D7mlAhGpFhQE01Pp1
         OSl41PWKckZCFAY6zBd+K1hmuLU8d1VSM+Y5kg14=
Received: by wens.tw (Postfix, from userid 1000)
        id 3B2A85FCD1; Sat, 11 Jul 2020 09:10:31 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: sun4i: hdmi: Fix inverted HPD result
Date:   Sat, 11 Jul 2020 09:10:30 +0800
Message-Id: <20200711011030.21997-1-wens@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

When the extra HPD polling in sun4i_hdmi was removed, the result of
HPD was accidentally inverted.

Fix this by inverting the check.

Fixes: bda8eaa6dee7 ("drm: sun4i: hdmi: Remove extra HPD polling")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Sorry for the screw-up.

---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 557cbe5ab35f..2f2c9f0a1071 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -260,7 +260,7 @@ sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	unsigned long reg;
 
 	reg = readl(hdmi->base + SUN4I_HDMI_HPD_REG);
-	if (reg & SUN4I_HDMI_HPD_HIGH) {
+	if (!(reg & SUN4I_HDMI_HPD_HIGH)) {
 		cec_phys_addr_invalidate(hdmi->cec_adap);
 		return connector_status_disconnected;
 	}
-- 
2.27.0

