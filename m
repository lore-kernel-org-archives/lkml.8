Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16682C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA7D42084D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Zm9uotCH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZ98LD5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgDXPgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:36:46 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:42071 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728615AbgDXPgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 4EADC143F;
        Fri, 24 Apr 2020 11:36:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=101K38Nr8slMu
        6ytfVyPzyKeDL9fqloz3Tt6MezFYHA=; b=Zm9uotCHh7cuLsTCG1tSJl/Gk1iDE
        IhbYbeDtENabV94oBEH9mv4WlOZ1o/vRTJliOTVobZMB2k3ggpX+RH7FaoElu+U6
        Wl/RtS261KQ0piWWD+DDIBBvXemA2kZofXCjbwbmxUqZZZ2g5WiT1Q9mCyfHcB0q
        3KCDVXY73ourwPEkudXVJs2UMPLlg4BJjDhDn7+gZq4yh2gNvZnzIOTmXHmhWL/N
        fK8jpoR3gqL4TzkqbrZDwD8PoPSCMXxPkkuWu5uPaY0rTCpfwvQyVMnKbYf1CL4D
        UaNOeMTXV5m4MAP1ntDx7CUQx1EDTvuf73SyKoaaXpVeG9/qQrNe1QAnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=101K38Nr8slMu6ytfVyPzyKeDL9fqloz3Tt6MezFYHA=; b=EZ98LD5u
        0+I36rM5CXXlQyKC6rXPa5H5xDmHSIZdT4OxHMFvc9i9xPHljiHJwulqlKeQsoxs
        MmuUI4F9eYosSWn7qcaB8QCE6xt/V64q5/vFFxh7+cP754Bp6yGJyMSK9Zpbk5Tn
        7qx3UlONuRwoUdSyfPzjhEP2lCMYgNwYF5RKs0Anp5ljPgEAm3+1bTR22AcTMfho
        2f2HEGF5imXrMoavmZeqm4K45YUOgAsBYmXFCYEB2Z509OaV4mB9EiM37nPLH7F1
        p5bGbnuM9vCsmEnrSHpDNW3XfbJbN3kSI3oryH8CzjbHibxO4Ap1vBjuCKgtXEWX
        ZveCvvzZrGfR0g==
X-ME-Sender: <xms:hQejXnz_6uZ1Kcbzg9_y4vC0_CWZvgflwA_zDdBbTBZlm_7m7LfzSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeegjeenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:hQejXrGuCpEIbSJqItTZAIR1SR0NBSSbrRgr0Z94NEM5TU4fJhihyg>
    <xmx:hQejXoqViB5BX6Sr3lRqYS_uRGnK2h1BSTheBNDHLMCNFGI1yxJkgA>
    <xmx:hQejXkyLRDv_hdgUbCZ2r2dWzJ7yK_MaE0MAQfGy7VaVlRq9Obc98g>
    <xmx:hQejXkyn05wpA_bf4yPsRkark6tzynrhQ9iqb5Ha0LaaKVbqhEqnER4SAXY>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 85230328005A;
        Fri, 24 Apr 2020 11:36:37 -0400 (EDT)
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
Subject: [PATCH v2 54/91] drm/vc4: crtc: Add function to compute FIFO level bits
Date:   Fri, 24 Apr 2020 17:34:35 +0200
Message-Id: <c90c36a181a96aab9056a571f2802320791663f0.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
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

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index e9d71153c6c6..d4b490e3f2b8 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -278,6 +278,15 @@ static u32 vc4_get_fifo_full_level(struct vc4_crtc *vc4_crtc, u32 format)
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
@@ -378,9 +387,8 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
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
