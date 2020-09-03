Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD66BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2192098B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Fg3azKAE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HqgYAkot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgICIMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:12:20 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:33675 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728382AbgICICS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 5198FC36;
        Thu,  3 Sep 2020 04:02:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=xK2MetNErdPQO
        5rSYXalb4u/ihHJbpifMF7P6V5hHg4=; b=Fg3azKAE+TJP9DhWrr9oQGMxGLNDG
        T/TPEE6oMIM2POCo4etF6z4y34prkss0elX0lT8V3jEROhGtRlgonygmaR6IVFUF
        J+/BcVfpfPsnasZidcC5tPHw2b2IiOPjktq+jr9aqT5j4cSPtAvyO1oh/hjF2qxx
        IzTy2DbgUpWpj2sBznwFTnWnhvFmgrsPtQ9S/r1MVvUr3PfCKWrf2XDDUyiDor4Z
        Dex0Id2BdoltI7llByQREOcbsC/7fzWAI4053Pyi9kk/AiZBkdOKTA2M6tEfIZJ+
        gbfeEv6Pwxxt9nwYU0jluLwHL2ysSGMKpWMgOhUaHZRP7PvJuXA7sQn0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=xK2MetNErdPQO5rSYXalb4u/ihHJbpifMF7P6V5hHg4=; b=HqgYAkot
        rGiw/kAr6bwPpSj0aZEHud1vdT1lCPqLhE81GmEZn8RoFM5ID2kM7KH5jTJp8FLx
        5BZ5KW4dcWrfGU3hScJuo2ye8s3KNjyN6zzSAdtPvQWPPvBJGnx+p0ahZDmPfTeu
        vIH4ejQUjLC4Ukew4Itx4Aqdk8TBbp2osp2WyV02W83gBnFyk+K5RKk8+S04yhC2
        46GvKcvkswsNrG2m6gGx2tCsVDZHuTNH3ytp015hyAi2TW7iNSFtDeELK/6oxR6M
        82htXSf4Lo8s6btC7pB48l0/0K02FkL8hoS/k/y/81gEJWgDbMtjfzQ+KnGHKgro
        uD0LNszSsCjuqQ==
X-ME-Sender: <xms:CKNQX_pMH8aOkRTpsq0LlAR_i3bvl1cjljGSi0RGC-E6pDmwpNAQow>
    <xme:CKNQX5p-6oT59HbxA9zwpo82yCqSpQWEiyV-mdJ5aef0UYbeRfIw38_EYvBz_93lI
    pcu8Q--KyFqm6Xm6_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeduge
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:CKNQX8Ob7n4QoPeMTkvuP8p4VQ3qKCCqqEBLNi1V_wvXYSQkoR-6jQ>
    <xmx:CKNQXy7wMGJIVzGBYIg5LBigY4d42Ea6YrSoIeWeiOpftvMRMQ21Hg>
    <xmx:CKNQX-5bS1HdGRueBUOAYsL9qFK_qJ63pQgwnpdbblG7GWxA0Br8XA>
    <xmx:CKNQX2ghAQnaKhUFKjcwevh0SrLTzBASSZsSgYG3SKS97kLkJtTQ4dIlV_g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 89C24328005A;
        Thu,  3 Sep 2020 04:02:16 -0400 (EDT)
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
Subject: [PATCH v5 16/80] drm/vc4: crtc: Add function to compute FIFO level bits
Date:   Thu,  3 Sep 2020 10:00:48 +0200
Message-Id: <e46a3823128af50c1c833de8fa9b95e9b86c2f66.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The longer FIFOs in vc5 pixelvalves means that the FIFO full level
doesn't fit in the original register field and that we also have a
secondary field. In order to prepare for this, let's move the registers
fill part to a helper function.

Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 2c64efd2d3d9..1d9e3658ae59 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -234,6 +234,15 @@ static u32 vc4_get_fifo_full_level(struct vc4_crtc *vc4_crtc, u32 format)
 	}
 }
 
+static u32 vc4_crtc_get_fifo_full_level_bits(struct vc4_crtc *vc4_crtc,
+					     u32 format)
+{
+	u32 level = vc4_get_fifo_full_level(vc4_crtc, format);
+
+	return VC4_SET_FIELD(level & 0x3f,
+			     PV_CONTROL_FIFO_LEVEL);
+}
+
 /*
  * Returns the encoder attached to the CRTC.
  *
@@ -336,9 +345,8 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 		CRTC_WRITE(PV_HACT_ACT, mode->hdisplay * pixel_rep);
 
 	CRTC_WRITE(PV_CONTROL,
+		   vc4_crtc_get_fifo_full_level_bits(vc4_crtc, format) |
 		   VC4_SET_FIELD(format, PV_CONTROL_FORMAT) |
-		   VC4_SET_FIELD(vc4_get_fifo_full_level(vc4_crtc, format),
-				 PV_CONTROL_FIFO_LEVEL) |
 		   VC4_SET_FIELD(pixel_rep - 1, PV_CONTROL_PIXEL_REP) |
 		   PV_CONTROL_CLR_AT_START |
 		   PV_CONTROL_TRIGGER_UNDERFLOW |
-- 
git-series 0.9.1
