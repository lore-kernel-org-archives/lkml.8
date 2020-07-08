Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDE2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD26206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="RW8+v/a2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DWXVhxMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGHRnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:43:17 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:44653 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726859AbgGHRnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 703632F2;
        Wed,  8 Jul 2020 13:43:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=vbjE83hg7Ongd
        MeQodU+dgrmswlM1THN0QhMEewZkvM=; b=RW8+v/a2EI3ks2LHkZUer3JGoGiCk
        ABeiOoFrl8Mai2jcM8rSjjx5sCwhg3Uw3ZThtNOw8RfMfrDLFyUY0nqP+mwsGL42
        UDyezKjInwegZutxkIDqLs8OLYvlbUSICVq97cVYteD8EaQiN5ehk5Oe9fzbXl3D
        RcipBU38ea3uVifKZBIYLY9Y1wp/fcTPljGPEy3oU/QUYPiLf9dxib4dU8x/M7Xs
        sJElmJ52OY8YdlXVWyKlg72qPwShPFZf38rqYDrBoUQHfBH9p6qkMmTVU8Td/Vwu
        UMjAvGR3Oyzk1HMNdwkc6V6x+5VXDsEds4z14bmlkCwm+HeVlypyeQd1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=vbjE83hg7OngdMeQodU+dgrmswlM1THN0QhMEewZkvM=; b=DWXVhxMB
        CsuCQo8OYJl67ZpvprUbp3z9D1Ic0v3d1vI2qryL4Y2ullV+ZgFsw4GY1koUhT7v
        6GWYzWQSmxpF5Qev0waD24CapNL9nqedhxqkQy9Jz7LKDeojTwwwScsW6uAwzDFr
        BOnep/3yWhLZh2mulPWCn8U1DeBboj7+WN/u0p7PEQWxeND3Utl/TWdjIkMUBDzM
        +zA4ya3+qyiyak0DUnLAw+6ElIbwO1bQ5+f30bG1kuBOifo2ABI2QlpOA3h1Rg+x
        hbIP3tADSFwp87+uZJGGM3NikoYIweg58paXA6ZB+Nnv0tGsBaPmJ46rn2XvlpGQ
        Y4rDME0+eYXmmw==
X-ME-Sender: <xms:sAUGX8LTQlVtDABGy0CB8T-muopUPA0f_f6xHrzpqyscGGldfeCuFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:sAUGX8KRghJRrKrhxzvMohKknj7XiJYvyp5v1A0Zw-sNiFEK3yPCog>
    <xmx:sAUGX8uzxMIfRoMKgMEsFAdDtVjLR8cFnCAPDLmyz-iltORKWVgVQA>
    <xmx:sAUGX5ZbULW5e-3VhYnDHJtx0isAlD0ndOYeEj4LpViUPuVRfbHlag>
    <xmx:sQUGX34QnHZtxO6HR_ZrfFTd0JV3ImUGnaa0ZBBraXMuXLtdof7mX2LkZ8w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B285730600B2;
        Wed,  8 Jul 2020 13:43:12 -0400 (EDT)
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
Subject: [PATCH v4 29/78] drm/vc4: crtc: Add a delay after disabling the PixelValve output
Date:   Wed,  8 Jul 2020 19:41:37 +0200
Message-Id: <a1f22aadc60a2f32022831a6348c8bbd6e1954c3.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid pixels getting stuck in the (unflushable) FIFO between
the HVS and the PV, we need to add some delay after disabling the PV output
and before disabling the HDMI controller. 20ms seems to be good enough so
let's use that.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index d0b326e1df0a..7b178d67187f 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -403,6 +403,8 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
 	WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
 
+	mdelay(20);
+
 	if (vc4_encoder->post_crtc_disable)
 		vc4_encoder->post_crtc_disable(encoder);
 
-- 
git-series 0.9.1
