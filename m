Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55750C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24126208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="f7tEqGq1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qf6+Pq2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgICIGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:06:21 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:37351 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728057AbgICIDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:03:30 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 01D019AD;
        Thu,  3 Sep 2020 04:03:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=pOGzLVEuzsJo4
        BRxTYkWGEocNeDkEQ3wi9L6w6WK6HE=; b=f7tEqGq1Hq5wSt2YwMdI+T388vyLq
        z24TM5xAT21g6us4fUx96nLQkY9RntIwzTrE6/Yc+lAy7Km3B+9H6usdep8kGSG2
        0y7BCMZLbUzd8yBuBobcCRH+kmEyUlSazcDHCKr39tfN+W2KBpIRL3tzE0IVL4yF
        ow7qjhdSNo3BxSFVvudxrQcit297Ef/8arbF+4GoZepAX8mMYkBrumrECAG80pVc
        tTCp+VYbhCoWMrVUTNtktQisSgGw+c2hsqEEGP51NK3G8nuHRxjCX4kx5x0wXjp0
        tCb6Fh/xyQUDX5zbRX5bvZiWvoBwnP98eYnoLva7BS8eIvlYV7jBYQsDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=pOGzLVEuzsJo4BRxTYkWGEocNeDkEQ3wi9L6w6WK6HE=; b=Qf6+Pq2Y
        ipCAmNEKv1OlgrXwHNj/9Zg1Zbz6fsNvN8cGQ1cZzM/BDkpgR5g/aUZ1ffBTprBL
        H+WXTDOb0h6IO8KufQaVykhb/+YJNb6i0ZiG2qiFtwWHX77sikficBfw9F75NoY6
        godw94WQY/qJSYWDLDCaimEMijyhJo9U27XZyQuTtf8rKTcFC6V9i445FGFqr9Rd
        oR3YlfFsKpvt5/uSfT75yF2xS/7zLNPVDLhKxwsNDyhQijY8cJBUHknjuGUFI55H
        W0CmC9dAkTE71vRi8Al8W1vhFTuYpFDrGNkQMoYIic1D5sWiEEWZelw9r2XOHaFs
        ZHTTbmi5mxLGSw==
X-ME-Sender: <xms:UKNQXzRHJ1iey9kHIlUV86-Fb1n_U2Rc75bBLRIbU5TVuU159Uupnw>
    <xme:UKNQX0wlmNa-rsqyqYB6wfYOczp7kxygF9Qb1S9SHMKv05Tk-w0iLUmvmR_c_ppzE
    mG1WOQ3iwrPQ9waAwI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeeivd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:UKNQX42BulGOMH7Ii5yGwqplYhW_T4uGX8l8_2glT2n3ZJOW0ta74w>
    <xmx:UKNQXzBDrVXy2tfSyXWfxRekJDz1lT0m_f3zg5FHIU3cFsk25B9CoA>
    <xmx:UKNQX8h_pvF7hY-Yq6qCmsdjhQFdCDffF6a3ZwpLOdR7Q8xJ6_do3A>
    <xmx:UKNQX7rZbO2RLScze96ctq92w6Dbv8XdqC0rWBHpnorSbNI2RYV4VNua5-o>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 32B1E306005B;
        Thu,  3 Sep 2020 04:03:28 -0400 (EDT)
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
Subject: [PATCH v5 67/80] drm/vc4: hdmi: Set the b-frame marker to the match ALSA's default.
Date:   Thu,  3 Sep 2020 10:01:39 +0200
Message-Id: <d0b126deb228baf1244c91e02ac0a8f7c9c60dc5.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

ALSA's iec958 plugin by default sets the block start preamble
to 8, whilst this driver was programming the hardware to expect
0xF.
Amend the hardware config to match ALSA.

Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 43e59466b1d8..d8137b838326 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -754,10 +754,11 @@ static int vc4_hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 
 	vc4_hdmi_audio_set_mai_clock(vc4_hdmi);
 
+	/* The B frame identifier should match the value used by alsa-lib (8) */
 	audio_packet_config =
 		VC4_HDMI_AUDIO_PACKET_ZERO_DATA_ON_SAMPLE_FLAT |
 		VC4_HDMI_AUDIO_PACKET_ZERO_DATA_ON_INACTIVE_CHANNELS |
-		VC4_SET_FIELD(0xf, VC4_HDMI_AUDIO_PACKET_B_FRAME_IDENTIFIER);
+		VC4_SET_FIELD(0x8, VC4_HDMI_AUDIO_PACKET_B_FRAME_IDENTIFIER);
 
 	channel_mask = GENMASK(vc4_hdmi->audio.channels - 1, 0);
 	audio_packet_config |= VC4_SET_FIELD(channel_mask,
-- 
git-series 0.9.1
