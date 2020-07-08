Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E718C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C47D206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="aS4y7iq6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+oxwllK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgGHRpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:45:39 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:40109 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbgGHRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id E6EED333;
        Wed,  8 Jul 2020 13:43:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=iO0RfWSJe4Ub5
        U+tSuHduMTBjdaErGopyTWtE6B786c=; b=aS4y7iq6bdZ7OfHn7ifP2kHsduZOB
        pWKD03vj3X7lTC4KftzYo+MufALAm5EfcIWtcieRCRE22wOQRxGGf2bmHQD6VpK3
        PleGao/Op/56Jb+t6nNLJR3UPvIX/1eFUGj0oT7LNEsdzGoe0gdklrsewO2HaoOu
        adzoPQEsh9ruQvh9XueQ1ROhVYbR76MdxmUbf63MhDq8zNKtNMmTfcJtIKPqInjH
        3KbiN0qmhUt3G0biDY3FcGtTs3nsoRPS5XTNTDPDZBAHmzlkAfzNBNkhpUb8QyLk
        hXow6Kpk8MjPyvl3cb6QrxoVN96xhVkqooc/0fFWwckcGn7R2s7V9acEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=iO0RfWSJe4Ub5U+tSuHduMTBjdaErGopyTWtE6B786c=; b=G+oxwllK
        gtrGUobJtf9oZB3ey4qnw5hIO5Popiv4okYzAUVEl4uaftzubTYCUn63mTrzr33D
        yTmKp5wYdzGj2LJL0pDFbTPtufxHOO6686b4+soHlYFqvMGW8TdSluyzj/00bOEx
        zI8KsYFurBRehL0c30LpgqK7P/qh2n/hTHLHAGZDppxfw4LcffDkIJA/H/Rz+2yi
        ydxuIb6n6MNx7MDiGRLQzPklanBMA9BNXNpeI5MHTK3LlD5UxdsZxlVftHwjxzu1
        7dxQcItvkkEs0SjVLOVYVUDKC0c5GmPHXhPvx/O5+amvOySchfp5IfMJDh3XUqaJ
        FWrlLBg68vn82w==
X-ME-Sender: <xms:xgUGX0J4I8uTk5hLThRqcgL9S9baJBq6BrExwcfHrD5iTjfV8eo5LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeelne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:xgUGX0Kc87yYZPo6pHrvUzLLycAkc1kGtuLBUMKvYf-AE9Ye_8i7bw>
    <xmx:xgUGX0ssVZLScovioGrYxgeS-Nv4o07H0DlHb4pCBLhYIhRv3DKD2g>
    <xmx:xgUGXxaqFvijauLbHyKS3D57ZLoYJyc3y3IaFpkdM1Wt_wBGlW8QzQ>
    <xmx:xgUGX_66ZGG6zy25g5wOpSxq-1j3y30YXjK_-5Ww_avVHgHqyE8Kp4WMf-A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3CEAC3280059;
        Wed,  8 Jul 2020 13:43:34 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 44/78] drm/vc4: hdmi: Use local vc4_hdmi directly
Date:   Wed,  8 Jul 2020 19:41:52 +0200
Message-Id: <af20b590c3dcbd5d893ddb7e924252ac5440eec3.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
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
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 8955b0cf76ed..a3fb93322ebb 100644
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
