Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7359C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5FBC20776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Z4QknsdJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jb4CVfTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390307AbgE0PvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:51:19 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:37681 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729521AbgE0Pun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 432135820AC;
        Wed, 27 May 2020 11:50:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=JKPJcF5P9O84B
        kfkFMzL0EEY5mowhYm7H9n+PdHiw6A=; b=Z4QknsdJy5pMWMN1FFG/YOqpjb7Cs
        qbT/ZYZxmKPExwIwzcvDt3w1Y7RiKx0PF1P94wcetSbtMCinys0cZmACWhCG2oNp
        4U/fEfYHmo163xIwEwvVjheEYEdFpsfmIb/MrC6IGDlmNxCcH+Jqt07KHr2gjUOR
        VG/w60HilcgvV9joLaw3Ef+/cs5oZsLjUC5OjDh3cM5qskyBK1JopBZUxy/8pTC0
        Qh4uFmC3lxzDF2KWG4CcKZMgKBhHKop4ESAMmhb7TmbbolQz29lumeMJYOHPJQ2h
        QtPeawn8tHtpjfxQ0D9uZ5o+9dsPxsC/bMa4hRe3z6F4QwpniX4hJ/yag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=JKPJcF5P9O84BkfkFMzL0EEY5mowhYm7H9n+PdHiw6A=; b=jb4CVfTw
        ThorRSJWcCLpBAwKeh4Q4AmJHbPTLvWtLzODo1vqeTZF5oAASgnM5arIY32Lu1VT
        680cIaFRokcBVL688xhVoj5w1niQkBdFosbR7c1CVbZrTLqa3qr7zjQA54lg3QW4
        4NrdTDkh2ggcPHfIVkxyi/jjs/tnnLW13r1gIkXr0k9fMwhmvX/JQ4YkehcFTdIa
        EzoLQhKsy77swiTxwzlujF+cQCAiMuwbqbu+A5bXopu2jo4xLuhCVoO82gGX4hNp
        LnHgOqg4KDs7Yh7pUhwmFPzybKyabyCmZH4vm/53Z1MG3xef0kRAGv0RjB2JYuem
        rgMy6z1VQja4xg==
X-ME-Sender: <xms:UozOXriWN4QIm-ASBHRux8Ahm8gb6b5YEp4a3NkJtn-nwUxRAEGAkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeefne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:UozOXoCYqgYJ9Gc3v3eQ1PCekFRP4MSw0XXTWQZsqbx1ExugxeBbAQ>
    <xmx:UozOXrFGBqlvWLmOVj9_dkARfX0jDpNsAUzVd7VGjjkKwwWBaZrZSg>
    <xmx:UozOXoSLPolXcX8kNPoWti18IZ_dtgAoaXWfffd25GSOqwjRpcqwAA>
    <xmx:UozOXrxC6xIuddkyCHyI7k07PKHPaUhkqVqkQeX7o3CUlvbqxQgRcw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D8E3930618B7;
        Wed, 27 May 2020 11:50:40 -0400 (EDT)
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
Subject: [PATCH v3 053/105] drm/vc4: crtc: Clear the PixelValve FIFO during configuration
Date:   Wed, 27 May 2020 17:48:23 +0200
Message-Id: <edcf101ddbf3f710d7e7295ffcedca831ca56a12.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though it's not really clear why we need to flush the PV FIFO during
the configuration even though we started by flushing it, experience shows
that without it we get a stale pixel stuck in the FIFO between the HVS and
the PV.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 61e0945a8697..ecb3431470dd 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -356,7 +356,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 	if (is_dsi)
 		CRTC_WRITE(PV_HACT_ACT, mode->hdisplay * pixel_rep);
 
-	CRTC_WRITE(PV_CONTROL,
+	CRTC_WRITE(PV_CONTROL, PV_CONTROL_FIFO_CLR |
 		   vc4_crtc_get_fifo_full_level_bits(vc4_crtc, format) |
 		   VC4_SET_FIELD(format, PV_CONTROL_FORMAT) |
 		   VC4_SET_FIELD(pixel_rep - 1, PV_CONTROL_PIXEL_REP) |
-- 
git-series 0.9.1
