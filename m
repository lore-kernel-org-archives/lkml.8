Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BB5C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC9220863
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="JbXxNFzR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WIOBX/YZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgBXJMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:12:38 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:56539 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728101AbgBXJKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:09 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id C85E5616;
        Mon, 24 Feb 2020 04:10:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=XOAXUK0oU5Tj1
        VxK6KFCC0Euff0pn2yyPW45oYg5juU=; b=JbXxNFzR0cX8JAduI70cg5P/TdR1V
        PmRF8u3/TIcv+RxtHgRAXCUUOs2LCGjHCU757uWuHRT6KhqgLf+dY3w69mKTfOBk
        4qZnXLqwPAMAOeMwUStqHMYuxre1coc27wLhLQlwHr19djp7gRwTYQm3iLIpu71Q
        awfS2liH3MeuJspbqe0YVa1XbbYI43uCc9iA1K2F5d4/lJ9lr2WrOfO/xImBpGRk
        Ake+IZ6TPhFM8VODoGAXJkIMfrC0w1fe5pjU6faUd6xlB+qO9AOE/rGM0yueQocX
        E18ExCe6jZlV9GWxKNW3ZwuzrojQyIXubkuSUV7JQtdRq9hcod1/YBY9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=XOAXUK0oU5Tj1VxK6KFCC0Euff0pn2yyPW45oYg5juU=; b=WIOBX/YZ
        Vn7c0V7HcJto//EEM0TLH1rTOxi3rPD62SOGukA8OLF4x50jeNYu1CQNs2R9CsDj
        EEbBLr5VHV2fKNIZWOSLyqDIm+102021Wwp80fy29Bd4PZjqITyKEKPpCy6nmaYj
        /XGleVrI+7Gh8+wke+F10632dKjfr7f+Z0QH4WKkjeP4Dj1+UEZ9VXXVjIc9PrvH
        LXzNqG3XyKRx+pib9f30m7mKxRAfuPTAOc5j81GIN1UaOuocSrw2erACe+GoET4V
        EDe8wjQif1NWTs41nP98VlM/MKmnN2x/S6PWgezatKpv/dHqp7xjdentqX7eeSd6
        nUYc5LnRg1rvTg==
X-ME-Sender: <xms:75JTXr_qJQR79_WEBZnSjQjUW7nuB0W0Oxlz4WuLcJ72yR15tBWPEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepgeeknecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:75JTXkB6y6ABDZGJwo_YCKgVvwin_QEdR22VEWjoY5Xf6MdXrPIdmQ>
    <xmx:75JTXryWd4iWDNZD-n0g_cMml5tSad8wa8mFpMZsbGrYc6WOkoOdfA>
    <xmx:75JTXpS1O2I-yVWn95pwRgzBGYY3A9jbtxdOaMZ34fVkpUDquqnybA>
    <xmx:75JTXtsJ_HgmYdXetr7K_0djWDegNUPaP8CsdPdEAv8W_efA4Dfti3zpIP4>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0BD03328005A;
        Mon, 24 Feb 2020 04:10:06 -0500 (EST)
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
Subject: [PATCH 54/89] drm/vc4: crtc: Add function to compute FIFO level bits
Date:   Mon, 24 Feb 2020 10:06:56 +0100
Message-Id: <12f981ddc23c58ef9357d2a6eda6b7a237889b0c.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
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
 drivers/gpu/drm/vc4/vc4_crtc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 129131a07edd..1dd0a9fb1c02 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -277,6 +277,14 @@ static u32 vc4_get_fifo_full_level(struct vc4_crtc *vc4_crtc, u32 format)
 	}
 }
 
+static u32 vc4_crtc_get_fifo_full_level_bits(struct vc4_crtc *vc4_crtc,
+					     u32 format)
+{
+	u32 level = vc4_get_fifo_full_level(vc4_crtc, format);
+	return VC4_SET_FIELD(level & 0x3f,
+			     PV_CONTROL_FIFO_LEVEL);
+}
+
 /*
  * Returns the encoder attached to the CRTC.
  *
@@ -377,9 +385,8 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
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
