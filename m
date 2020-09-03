Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF39C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4775F206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ltsavqlY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YC5pnwgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgICID2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:03:28 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:42409 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728057AbgICICK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 61E0AB18;
        Thu,  3 Sep 2020 04:02:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=XYgpM2+C6Ffr8
        9VX+fzprB+BVWrGtQKRxGxoZZAckPk=; b=ltsavqlYBZvTzH1f7fVLT/KAFbm2l
        5jlNBftY1TADBTtPIqUfkS4QhZPG65P2Z/LCLyBoeJrbul3OA6FwHcm2rQwDZbN9
        uTm2hFWNPWjUJikP5DsQmsA16lrQyk2YoqIfU+BlwtEtXJ/NCaIzk1RPfEacGQIG
        SSNtGSvXzgzfHDG8KK67NKJTD/NQp0HFaxjYZ40E0w3BV0GaVsplrlRLjtb3pS9L
        QQXafeUAKZYvSz6J483sbk+tjT6bUIYgu6BMoXOyF00MlMG11KKnYjcJCyduswsv
        bzPYTB9qgvMYn5Y8TZTRVEn/kGmrM/1ttYBtakH1AT0Sfd/EEx/LKLhWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=XYgpM2+C6Ffr89VX+fzprB+BVWrGtQKRxGxoZZAckPk=; b=YC5pnwgP
        0iE77UhA/R6OMJCyk3SHcrSfWe+6tUWRTriifx3PEBvslN4agTqRf8uTpx0wpF6+
        cV22NjqH4lmXVS8RglndqAwHunSwS80btsk+f4nYOwcT85IDCTwvFh7YDSANtcsM
        WaeaSgOP1Z4/NZOw6jNvKvdzyOrXlzN3XAY0xE8y44k3At1PorbK1gdqzEgewEkj
        KXiWWGJXDs9Yx62Aa9lENhtNulEStuyTbflK0n7ATM081Hk5Uxo4Dp2x95siANMj
        x38iII10u+4Zccckr64ClxyWWvIaVBP6NJiCHsTry2ikxBSl+q/f0fjNuiA5ZTTU
        XvqRRhbAeboF5w==
X-ME-Sender: <xms:-qJQX18LRZNEQnCDVKfnBrildVnp4KA1xYVp0XR8dvGLNhWlKERTXw>
    <xme:-qJQX5tNJ-KuwnQlKG9BUv7nd15ZB5zyWmlzTMj_phmQpIGP9ghLGF1ffQY-YaIQr
    AVOEFpu6CeHxFs_N30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:-qJQXzCluYYCVZaG_J1nK7szgG-djA3KAW4pap5mMD04kml_QkwbLg>
    <xmx:-qJQX5fhl1QY_9Nqs9SfxwjtWz_Ab96ifuX4l9IncCA-lmm8QnI1mQ>
    <xmx:-qJQX6N70J6m8sjiKxuj1iDkJ-0DyyKKrYE6hqppflErFpwDDM7bBA>
    <xmx:-6JQX7nlvyUk0gZMZwgGzRLXQY95h3rLktqY7hERV4eMpflD9mBFrggMc0I>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9BF6B328005A;
        Thu,  3 Sep 2020 04:02:02 -0400 (EDT)
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
Subject: [PATCH v5 06/80] drm/vc4: plane: Create more planes
Date:   Thu,  3 Sep 2020 10:00:38 +0200
Message-Id: <b41003001541fc2bb23668c699c0369ff7983be8.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
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
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
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
