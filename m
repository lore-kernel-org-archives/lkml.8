Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9A4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B002207DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="hnTlNuB5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="syAhqB32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgGHRoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:44:14 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:43723 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727949AbgGHRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:44:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id BA49D10A4;
        Wed,  8 Jul 2020 13:44:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=3Jc1accPTXcxo
        H547y/FvdzgQxJY2TLozI7qw6RJ/gI=; b=hnTlNuB5h29/Y0Ds9dotJTvyFiIcv
        JxvhfwuizbCurimlw02x/1N4gssTgchSn8Yn1vgCbOctM2a5L01V0C/AR/AYAv6R
        ACrE1NX7KHsIqB3T7KbcIhohe/+c/PACJDwDGe8cyigwhQLTL77AkFWJ3Zx9H7Cm
        NgGaYr+w2qGRxN6R9dpeU0JEiEUir0RgjzWanhvUakSzqnEYx+h7Kp4g0LIvMz0D
        XxVzpC6yW5l0d8aDwnA8vd9JpevneIBQfFeyt+XkeTOEBP7wvhUfzu1Ex6880SKA
        v0uq9tI+QLpfHWs9lWesnnW7htLztMmA5CKWbsrZGNco7zkychnj4x70g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=3Jc1accPTXcxoH547y/FvdzgQxJY2TLozI7qw6RJ/gI=; b=syAhqB32
        iyUCy9q/mYme6IEyiZVik3bvnkk4O9OLMauY7YWBvO42j5pBC/5X2nW3DHYWYGpq
        ZJmpyh2GNlCsmbx8V+bq0hsL3P1trOZ+vMkuRe7NrEGG3hI+oiWJ1EXb8BMgRmHE
        zMw31HWm9tB+HLXmSFLXUKbZzPa1na+6p/32Ab8+McaPwzOaix7iQrU/lKzyfKs1
        qt+Pf5pNkBJhq8c5bpy40OCUdZUx1cKJuAyBw4ik9RLB4WohB+xJgrwq39AWxzl1
        N8YK3K6BCYbxMZLA/cEprseKtk5KXbDqDJ7kHcZMgbIzfHy6cEEilLPc+0I4mwJ3
        th11bi2TtG+xIA==
X-ME-Sender: <xms:4wUGX7bXKTfGFbKaxUbWZ6ZkTNojoceB8Brn3lphDFjhNVNRGZB3Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepheekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:4wUGX6Z4XAxjNNHF4BwIgyk6uUE2E0XunDGOshtNTr_4j9jTYSGM-A>
    <xmx:4wUGX9_aLHy2icqVvV6Jt466DBp7uUBpuspzZ7sJZCVS0do9Hsk2Pw>
    <xmx:4wUGXxr3NJjDAsh-D0IWL0NcYNVZi9GqIzj8bM3tEE3-PT-oq47QUw>
    <xmx:4wUGX2J4Dbp89OhD8iNVzF_WEWzett7qlq9C0Hch9K2gdLFruAin_EQX1ps>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id F06E13280065;
        Wed,  8 Jul 2020 13:44:02 -0400 (EDT)
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
Subject: [PATCH v4 64/78] drm/vc4: hdmi: Use reg-names to retrieve the HDMI audio registers
Date:   Wed,  8 Jul 2020 19:42:12 +0200
Message-Id: <1f49af6616f1eaf28a4e9d8c409e60ebcf45041e.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
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
index d99188c90ff9..8b94b920be43 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -954,6 +954,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	struct snd_soc_card *card = &vc4_hdmi->audio.card;
 	struct device *dev = &vc4_hdmi->pdev->dev;
 	const __be32 *addr;
+	int index;
 	int ret;
 
 	if (!of_find_property(dev->of_node, "dmas", NULL)) {
@@ -974,7 +975,13 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
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
