Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4848C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B073C207DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="KPCoRRw7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qh2pRKzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGHRsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:48:08 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:48121 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbgGHRmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:42:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 8A95B109A;
        Wed,  8 Jul 2020 13:42:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=+PSb2nWmzRXnx
        sLnQxfZbPOaVw9RdI0nFsyk/O4d7IY=; b=KPCoRRw7S1Zhtv2YxnxRTJSzYe8oL
        HvJHntQFeQ46TgVbujGnWvNRs456jNYpAn1/hFZPUY/8ZtA+UB2eic31Oj7Ay2yr
        Qa0GI92u5rz5QKyneDtKsqElOnQpI9+ooyyUoFWfWVciPi9NtiM3w5CxStk5tvWO
        tUZ/TO7sb8k6l62ngauRx0umERzyUEZSIsmwB9mQWaPS/uJ61HeU/k7MlEfB/PwK
        o29Ha7ICk1pllKvzS325UtABELCpmud/wTg0xJI3uflDxZEwTzSCiV43vD0KGaoI
        MubvdixuXyQfotU/oCbzw9exgf3Bt3Mzn+cD/l4NtG47AqzQLPV+Hp/8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+PSb2nWmzRXnxsLnQxfZbPOaVw9RdI0nFsyk/O4d7IY=; b=Qh2pRKzH
        QwoqQpB9bqAKE4ybOtuky1Bdt9oyNzWMYNRePXizp1NrwCMOMU4kHlOWq/zGOFwb
        +2Itn3gv/38ORqTF5CNJoa/Dr5hcYqHnXk7BjZ+oW5NwzrQp2Yq3yCF4DGCaz4+/
        AtsihFzOdVVaQP4+UNA0c+0VHv5aqUIs1v6+XMPHmH8OC2V6bzwffkaZ7uJ2Hdg/
        Mppn9pa3RuPVf3LjNSIYycdFWM+8FVL2XyRAUBS0N8CHzzMj1aEfTZvdpe5yxetA
        g9D5kJfU3/vIpjK63iQgAslZ3/ooamX3ceTUDcT2XuYDKwsPXQmVdfPVReDL4OhY
        lZEJnAA3gMkPQg==
X-ME-Sender: <xms:kAUGXxYbnPELnIynWuHe2oEe-bloW079kzsaCuLJb5FZRlUgc8WAAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:kAUGX4ZoC3QesaBn-94G6OZua6ze4rMIe-YXF5LNVG41FecM0eLWjQ>
    <xmx:kAUGXz89rC_pp_y-SdM1RICCCj5iSSGuKe7gf89HxIlazooTuogpwA>
    <xmx:kAUGX_oZVGhuHAxer3BLUuHUiuOM353J0RcE8WlMh9h57VCzzEzO9Q>
    <xmx:kAUGX0Ig2By8KhudPJKYLZB6IhrhvN9L11vjCg8SIZ0Aq7zXra-kie3kyBg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CA0A7328005A;
        Wed,  8 Jul 2020 13:42:39 -0400 (EDT)
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
Subject: [PATCH v4 06/78] drm/vc4: plane: Create more planes
Date:   Wed,  8 Jul 2020 19:41:14 +0200
Message-Id: <5b3ce924397939fd208af8eb2e142499a705cc21.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's now create more planes that can be affected to all the CRTCs.

vc4 has 3 CRTCs, 1 primary and 1 cursor each, and was having 24 (8
planes per CRTC) overlays.

However, vc5 has 5 CRTCs, so keeping the same logic would put us at 50
planes which is well above the 32 planes limit imposed by DRM.

Using 16 seems like a good tradeoff between staying under 32 and yet
providing enough planes.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 23916814b4e3..1e38e603f83b 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -1384,7 +1384,7 @@ int vc4_plane_create_additional_planes(struct drm_device *drm)
 	 * modest number of planes to expose, that should hopefully
 	 * still cover any sane usecase.
 	 */
-	for (i = 0; i < 8; i++) {
+	for (i = 0; i < 16; i++) {
 		struct drm_plane *plane =
 			vc4_plane_init(drm, DRM_PLANE_TYPE_OVERLAY);
 
-- 
git-series 0.9.1
