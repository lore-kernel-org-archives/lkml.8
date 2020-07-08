Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4548C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0732206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="bzzBa6oe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cRSrN+T+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgGHRpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:45:04 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:32937 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727940AbgGHRoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:44:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 533B72F3;
        Wed,  8 Jul 2020 13:44:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=+opq7dviRqqbg
        95K03jNnT1NFi4cLJAuYRa2X/OWjDw=; b=bzzBa6oeQ1s03foJvkL4KPXNH/AKF
        Hy3fAoSm4sgNEsEA5dW0TPcWoEt2SP9eMOmXlNzTsnpz3Ht/bxqNOcyE2FSyiqzE
        bu/E/BFBAUvj9Tc9a4/kUzFZGqzSNvA/kOaeKPKCm3PVeKA58jadfas/lMDWucOx
        pYfOychY3yNGsAVf2N6Be72FofA8PcRfBO4kZ1VfQCH18PLQmH5X7L4OQWk4cBEF
        1JQtj6kbrVtPKbzReExm9QR5EBD/ii8f13vzLAYf4P2xTaIo8BpAk6GDAzKyOUEu
        uE76GhEiTYJktysZpaBrie0HtO8Rjyh5GrMJyj95WazeKcPHVL6WGdkgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+opq7dviRqqbg95K03jNnT1NFi4cLJAuYRa2X/OWjDw=; b=cRSrN+T+
        6K3ZWi+FKbka+D9Krde2hL9ZYbSuSAN7bP9sM7k4gajnWGPk5S//98Tx3895Fcme
        YTGAeO+QcVaS429EcZmlZaCTvgekOnM1aUiORTJIk3kzxNgfa52hBDwH/N8XUkzn
        BWQ14tPQQV9/MCk9qSUUuGHstKBQN6a3abVovFkWTd1t6CKJBXDFDDuAlE5el7t8
        PJjVphN+l5LTSXcn6q4LVJ03GaFHmDG1huvYpSgFW5Fp1A9W5OR3fhZVgo43hq1N
        SLn7bGl7bHmg7IdHhJI8vmIyniwsi93/R2y/UOXOr3eg3yMKj2MGv72RD+RDWwa4
        +pXYH1kyN77V+w==
X-ME-Sender: <xms:4QUGX43t3C9B9_AMjhwQzDvBHKQuTIzxYw6RUrn5zOdRWjxy1I8myg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepheekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:4QUGXzHvb2q0UkhqmnpHdZbhtuI3O4lqAruvN1mtWh7R6o_FlGk7jA>
    <xmx:4QUGXw42G9lYSamrmiV6i6loS4BpRdd_JvsIlmZdz_T_A6JQvYiNeA>
    <xmx:4QUGXx0E8iCckRXN8hJQyB7aTl5K9Gc_TlAG3b8gg-Lrn-xN-icLKw>
    <xmx:4QUGX62n55rSCpBOo_aOFA3GfjPUoC6st34vKf4GkrIqh2dYwCxkyBwkYa8>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7D99130600A9;
        Wed,  8 Jul 2020 13:44:01 -0400 (EDT)
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
Subject: [PATCH v4 63/78] drm/vc4: hdmi: Use clk_set_min_rate instead
Date:   Wed,  8 Jul 2020 19:42:11 +0200
Message-Id: <a47487bc8873abe33499e79d3c10d085e341614e.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HSM clock needs to be running at 101% the pixel clock of the HDMI
controller, however it's shared between the two HDMI controllers, which
means that if the resolutions are different between the two HDMI
controllers, and the lowest resolution is on the second (in enable order)
controller, the first HDMI controller will end up with a smaller than
expected clock rate.

Since we don't really need an exact frequency there, we can simply change
the minimum rate we expect instead.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 9f30fab744f2..d99188c90ff9 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -462,7 +462,7 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 	 * pixel clock, but HSM ends up being the limiting factor.
 	 */
 	hsm_rate = max_t(unsigned long, 120000000, (pixel_rate / 100) * 101);
-	ret = clk_set_rate(vc4_hdmi->hsm_clock, hsm_rate);
+	ret = clk_set_min_rate(vc4_hdmi->hsm_clock, hsm_rate);
 	if (ret) {
 		DRM_ERROR("Failed to set HSM clock rate: %d\n", ret);
 		return;
-- 
git-series 0.9.1
