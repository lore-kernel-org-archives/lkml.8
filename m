Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1280C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA80120873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="YeducADt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xrT8LMKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgE0Pwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:52:35 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:48913 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730675AbgE0Pvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:51:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id DB6D1581518;
        Wed, 27 May 2020 11:51:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=IIw9eaxB3Tpgt
        3X5YVSg5tPQ4IfOI1UBHNLfesXywhY=; b=YeducADtmzS5QrXvADLOpISdwenaJ
        EoptJM+OmVmn7AVsICJ/0eic01yD66D+O/n2Ss4UTHXXTeMNawxkJ5zl5vIBWO5q
        N+CD+WqXSdmHJbKYsuJC9IcWXM+TuFUUGBvydyeaA1NY5fYPAxXDTLACvWdUOccg
        9mN/dNiTN69eNXxjkb/7N0Qo3ONv78PIl7Yj7GDRsjxy+qkbHepIye1dvpJLy36z
        +no6TylzGWoqlO1U2F668Sq7v0pQgZqp9tH8vteVyMRZXuSrvRHhGcS9GjgL0Bj6
        lUPtbVMunMY95EhNhw7M1+MMCt5o5ZtpU1pFLknIuYFrsWJxeVjVRM6mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=IIw9eaxB3Tpgt3X5YVSg5tPQ4IfOI1UBHNLfesXywhY=; b=xrT8LMKp
        RYKDoiZNHP+/ZDYdRzzaRAK1ggID2FDrvpUdJKCic/FuAF76TurZO8hvnszLy1Uy
        AAc1VzWPAPmMmeOcRN9QY1Z9mKAqjSBMTkpnQrSqQit8EaLpp1NFXvykQppaNdBC
        Y0/iLsJdupTtQHTxR0z7aWNfGLvK9ga+cf3RQZ1/+nflqMeLqVeTN8bsCOWQs5Gg
        TBsN8MrySvOslkKKdOcMbZytUoEwAmoiG81G+fP8Lx7jpBYikgloKgGbBkvc9pPN
        jCOETse9Z+1c8jnY+AYhvRb80bXepQLI52crs2jOrPFusLivkmHqF4AIrV5vv/5e
        4mIBifuisryTpA==
X-ME-Sender: <xms:j4zOXgH5xrQf5RJuDrQyL2kQyk0_QIGfekdeNqCFuBftbcKAe2cvZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepjedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:j4zOXpUHUW8dTd9TjWNO-KPjtAACAhStJlwiVDiNVb36Lao4sEEQMQ>
    <xmx:j4zOXqJwDF3S4m-HgwsRN1QNINmjbJ9Gp62VSvRUjDth_FXdd0kj2A>
    <xmx:j4zOXiHtuGHoQ86_kbdZRaZURBD_bm8fvCa2qE5oen1ixNyaavbqVA>
    <xmx:j4zOXhGhjyeKpbq9OwYIhCyIhtWWluElPv0Mm5hntTzCxRc-LlCYhg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 55FCF3062551;
        Wed, 27 May 2020 11:51:43 -0400 (EDT)
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
Subject: [PATCH v3 093/105] drm/vc4: hdmi: Use reg-names to retrieve the HDMI audio registers
Date:   Wed, 27 May 2020 17:49:03 +0200
Message-Id: <e01d4d2216a382ca3842a936972b5cdb13d13066.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
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
index c069bf8e6d7c..ebe9dd25c65a 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -953,6 +953,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	struct snd_soc_card *card = &vc4_hdmi->audio.card;
 	struct device *dev = &vc4_hdmi->pdev->dev;
 	const __be32 *addr;
+	int index;
 	int ret;
 
 	if (!of_find_property(dev->of_node, "dmas", NULL)) {
@@ -973,7 +974,13 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
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
