Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2487CC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F2F20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="mMN9+uto";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3WTBgldZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgDXPh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:37:56 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:52823 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728854AbgDXPhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:37:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 797F11459;
        Fri, 24 Apr 2020 11:37:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=8kX7U+71bNCoQ
        d0UZnXDfrbq6WXpGjWMX/ORI+DR4Lk=; b=mMN9+utoRK0bKa7rYt6Xl7X4heAcG
        I413crPbhNzZCu3ZOnurx9ZPfrEK3oQZkKYDM83EbEiiPoeOJjH363BkQIo786jY
        gSO8uxSPV4s8+Rn+/QStiOuyrWj/R8LbZGbSpKneaVmRdeXxjpk/tyx37b6HxvTc
        AS1iz/OvaR63ziyk+EnlRreE0Iy6nX6km37oNJIu1mTiL/Ilqmb/9togbEd8BfFq
        /3lOkLDO/hE7bKJiZSVVAYngIXtI+IFQTdALlFza9KDqe8ysAuCSgbvXP9XKhzZc
        n8k5MP4skUYOj9MfQT9tQ5C1uUHEjDn4EUcmxbGiE8H8aR6y9yzKcFaJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=8kX7U+71bNCoQd0UZnXDfrbq6WXpGjWMX/ORI+DR4Lk=; b=3WTBgldZ
        oR/ONGVpMsiQoe7EevnRp6Z7PlOVUouBt51R6rbT+kx4HkRk0b8002MLqoBNFTDR
        lqL1IxgpxYgAHeUa7+AaHYjshHPYlRTVqEcG88nVpoBOKQEA/4Fd5FJnkvC/Ihwl
        9VBrosACr5ab7xTYu/sUCgHg8dexRKcQCwJvp81iRo7Nlov4Rt273/uack8MSpdQ
        rcJ8V7/P/uEZLLfguZ/po/XgSJ1rBI5R99JkpH4WbOj3MyNhLwSWobrhxxsYNgxJ
        Kqb3E8N58c8uYXiIVBsiF+UN6Xal/x4DAtpKpK80B0l3wvbV4pbV11q/58eq7zGe
        kAkgKeQq0Bhj6w==
X-ME-Sender: <xms:sQejXkZBY8McKQzgyKRLnH6ETsp1R86rk4wmfPs0CCVM4MfK1701TQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeejgeenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:sQejXlriON35UToHcW2jJQ0dnJAC0ynsJrCNURuiFMAYf6h961ayJA>
    <xmx:sQejXmMDa7oSuZ9m4tHO_sUbpZHBuFcYF2nvFPxZnXt4A8ubWIh_Yw>
    <xmx:sQejXpxW39u-PKg55vO3bMdH2POD0fRX7-derF8x4NuiLtHxYZdlOw>
    <xmx:sQejXlncic9zvjRArg9ESFQIPM8JMXFGr9Tkpme87ziBobBbnmBLJIxULKw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B7AAA3065D9A;
        Fri, 24 Apr 2020 11:37:20 -0400 (EDT)
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
Subject: [PATCH v2 85/91] drm/vc4: hdmi: Use reg-names to retrieve the HDMI audio registers
Date:   Fri, 24 Apr 2020 17:35:06 +0200
Message-Id: <6c4c4a79fec5ed1ba34250d863cbc5be3034a4a6.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The register range used for audio setup in the previous generations of
SoC were always the second range in the device tree. However, now that
the BCM2711 has way more register ranges, it makes sense to retrieve it
by names for it, while preserving the id-based lookup as a fallback.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index df3973acbe88..07304d156eeb 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -955,6 +955,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	struct snd_soc_card *card = &vc4_hdmi->audio.card;
 	struct device *dev = &vc4_hdmi->pdev->dev;
 	const __be32 *addr;
+	int index;
 	int ret;
 
 	if (!of_find_property(dev->of_node, "dmas", NULL)) {
@@ -975,7 +976,13 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	 * for DMA transfers.
 	 * This VC/MMU should probably be exposed to avoid this kind of hacks.
 	 */
-	addr = of_get_address(dev->of_node, 1, NULL, NULL);
+	index = of_property_match_string(dev->of_node, "reg-names", "hd");
+	/* Before BCM2711, we don't have a named register range */
+	if (index < 0)
+		index = 1;
+
+	addr = of_get_address(dev->of_node, index, NULL, NULL);
+
 	vc4_hdmi->audio.dma_data.addr = be32_to_cpup(addr) + mai_data->offset;
 	vc4_hdmi->audio.dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	vc4_hdmi->audio.dma_data.maxburst = 2;
-- 
git-series 0.9.1
