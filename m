Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D73C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379592088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="kU53pVLD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gIeMrltU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgE0PuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:50:20 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34339 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728482AbgE0PuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 08300582057;
        Wed, 27 May 2020 11:50:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=paZ0RrmilrGG7
        YJ5JlbhmJJvPjMtrxilkOsZzdPjgeQ=; b=kU53pVLDVbRXSBOmIpvll7/uZ1CuX
        xOA8EfJyzJy58Bza36fy3hQbZza45vTqS0y/bwwiVUz6xVgjxRP2OxizIXr/2cES
        lpJuaFjG9605jGUCr+PkatjuxcJ9Y1hIGO/WDd0sNGed4VstGvu9vswyKjHhH/lz
        kNUqJjMON3pK9bOuxeMS37ZhZG8HxQi0nbYJ03JgxVRcmKipHPLvZQqPgumKJaxY
        hrk+RrMI4nPH65UlIIoVVEEfLhn28kiYmCmI6eOciixe/XSzT7AvzjqR2h5VNuLp
        N/Tjqv1/ocYpMtxa66IPOw3uQBqP19I4k4M0QuUYaIMO8Ca1l63dSjSjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=paZ0RrmilrGG7YJ5JlbhmJJvPjMtrxilkOsZzdPjgeQ=; b=gIeMrltU
        Bar33w0GjeLohFIGazwEQnhrF16Ll+Jdh5tkGfrtcPFOPp8712+gpDzotnFmqPEf
        cJ1VWEbk/cB72SnN+ehbBazRyYNuNAbqaJDJDE17E7Ah4JlEBzlKcLK7jXrp3LkH
        MQ2txVqjAEQP8/y6VkfdkkxWTh8v09U7Cp39zjgVCzHY+sPnyw4FS3gbGFPK1NrT
        b5tvL3F4ReHijvw79A72nOVVhJMJdAmzj3VG1v3pKMzEcty3+/LTS+F/rFJPGxMM
        fA4FU5UohOLmpsy0s0hsYcG3MYClw783z79jLNLoxGBlrA94XW9ZudEBgMMfrcZY
        XmjUtwfTdG5/kw==
X-ME-Sender: <xms:LozOXuaQmhi5rpslCkWyB0KCzn8Riwxn8rtdpJX_fy0ox74Z85Bb4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepuddune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:LozOXhZy_KewNMpe1KRxmxWl0kwp2Rt9fa2_0sYCNQVsF5eqI95rLg>
    <xmx:LozOXo-vpIyh9-yN3lmyh6iohyy-i6epB_n7YTldEx5QJgrB40_kpw>
    <xmx:LozOXgqmkPYQPDWEeicWIkK8Baib3fLpcaR9sSS7V9UcCZ1B2jF7PQ>
    <xmx:L4zOXtKtXoQVojan8JBWtPmM7udX9k1eHXT2QZaUkb9J7SxO-wDfkg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9DD713061856;
        Wed, 27 May 2020 11:50:06 -0400 (EDT)
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
Subject: [PATCH v3 031/105] drm/vc4: crtc: Use local chan variable
Date:   Wed, 27 May 2020 17:48:01 +0200
Message-Id: <e899798e17c22cad7358178f5129d4ffef7cbb41.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vc4_crtc_handle_page_flip already has a local variable holding the
value of vc4_crtc->channel, so let's use it instead.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 14e3a962d8a7..15c72afb226f 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -813,7 +813,7 @@ static void vc4_crtc_handle_page_flip(struct vc4_crtc *vc4_crtc)
 		 * the CRTC and encoder already reconfigured, leading to
 		 * underruns. This can be seen when reconfiguring the CRTC.
 		 */
-		vc4_hvs_unmask_underrun(dev, vc4_crtc->channel);
+		vc4_hvs_unmask_underrun(dev, chan);
 	}
 	spin_unlock_irqrestore(&dev->event_lock, flags);
 }
-- 
git-series 0.9.1
