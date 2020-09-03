Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219ACC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4306206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="IAl537fi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fxy2HNy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgICIFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:05:23 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:36085 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728434AbgICIDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:03:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 8782CB18;
        Thu,  3 Sep 2020 04:02:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=jPW8byBiZlXLz
        XpjXbh19uEq1DnCG0fPDC7gp1FjiJk=; b=IAl537fihA+iAtNpRNL1ugEDMjAHO
        329lW7SJjIebK6R9QCIQ8NAM3xzWRzZ0tuEXafCEr6qqwFrGg+TxxrjzP8mB6H4e
        BcblaYk6Gb8Ozum2dAyC5w42cuPdaM6mDl9RIfey7x4z+qKuiQV/APrq0Y745We9
        NYiWAc9RRkRmH93eMmfG/XDtBOxW7E1bQm8eYFxmffcHc9PHzdAPDJQuJWKF7xwS
        M8Alo+0nw++olw+gbQJu6VNE86KLZYw8YUuQ9ujgHb3j4cr2xVNFHPQnIly+kLNI
        Ma9TGgDh3vpndhhu+2pToZnpJmclfvVGjnpxKA57NAJv02qaU1a5gp1tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=jPW8byBiZlXLzXpjXbh19uEq1DnCG0fPDC7gp1FjiJk=; b=fxy2HNy6
        MVjmwgEcCjG4xOng/EpPkpqEpLsJdYLlLWTDjZ/PeYNP9BA+wQM6J/NJx3F78oc+
        Yqv5OXSCFEu9rQUIhDDNq3lY/S8LxDa0lTN8WRlB66H4PCU0oUhWRxrXvWRTn07/
        UgttdOz/DTfFjZCeniFcrnJ9W4BmasdZi8cULrVZbtBodHpuDtmeL9RTD/9BW5NG
        w5pluCIORHwnFeXHMPA5hGNR1+Lm8jDcHCBlWIQdyMiKXRUEKGDFuZ5VO2M9nPHS
        7zGT1hfT1BQ1ovb6/+yEQvedgBqpuUcCGhj97F4n0yJiogMLJt0ehlju7FfpJCgH
        JOkZERR9eFYa2w==
X-ME-Sender: <xms:L6NQX4GfibrmRr8d4lsQj3xCS-EOp5t7WjW-i1AQa40yNBVGUxrW7g>
    <xme:L6NQXxXsyEK7jiGfKSh2YZHjGKK2ubtpIKHMY5-u4tQ3DF79ISeeOf587WSgbxHFK
    cQT7ZW-DluUuia_AFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeegtd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:L6NQXyK7Y8RbWOO5eAnKnMyM2WG5IER7mFmJ1Gic9vfwiKBvx1snlQ>
    <xmx:L6NQX6Gl0nzt5qb9oLso2JTm2BUSeFEp3tIuf74jo166Q8qNR3Yjgw>
    <xmx:L6NQX-XvLvEhsQkdWKwldORsW6DetgHOKZBIlsxbz_zj9tUPLMLI2w>
    <xmx:L6NQX1PsVZ8zVTtm83dcBP-ctXaPzG8U_UPWEvPBMcKscxBctTBSQwm2Low>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C8A583280065;
        Thu,  3 Sep 2020 04:02:54 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v5 44/80] drm/vc4: hdmi: Use local vc4_hdmi directly
Date:   Thu,  3 Sep 2020 10:01:16 +0200
Message-Id: <ef92c5582d3b2894128b2272a8ada7cbc20be3d9.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function vc4_hdmi_connector_detect access its vc4_hdmi struct by
dereferencing the pointer in the structure vc4_dev. This will cause some
issues when we will have multiple HDMI controllers, so let's just use the
local variable for now instead of dereferencing that pointer all the time,
and we'll fix the local variable later.

Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 81c0f67cd0eb..93865327a8d4 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -125,20 +125,20 @@ vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
 
-	if (vc4->hdmi->hpd_gpio) {
-		if (gpio_get_value_cansleep(vc4->hdmi->hpd_gpio) ^
-		    vc4->hdmi->hpd_active_low)
+	if (vc4_hdmi->hpd_gpio) {
+		if (gpio_get_value_cansleep(vc4_hdmi->hpd_gpio) ^
+		    vc4_hdmi->hpd_active_low)
 			return connector_status_connected;
-		cec_phys_addr_invalidate(vc4->hdmi->cec_adap);
+		cec_phys_addr_invalidate(vc4_hdmi->cec_adap);
 		return connector_status_disconnected;
 	}
 
-	if (drm_probe_ddc(vc4->hdmi->ddc))
+	if (drm_probe_ddc(vc4_hdmi->ddc))
 		return connector_status_connected;
 
 	if (HDMI_READ(VC4_HDMI_HOTPLUG) & VC4_HDMI_HOTPLUG_CONNECTED)
 		return connector_status_connected;
-	cec_phys_addr_invalidate(vc4->hdmi->cec_adap);
+	cec_phys_addr_invalidate(vc4_hdmi->cec_adap);
 	return connector_status_disconnected;
 }
 
-- 
git-series 0.9.1
