Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C89BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D392206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="fY0YjHXU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CoLsHTmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGHRnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:43:21 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:42445 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgGHRnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 55BB02F3;
        Wed,  8 Jul 2020 13:43:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=ld0J1fBGkPaub
        dbqtuPwQXtIDQMOFVgRg/8rzgVDg+A=; b=fY0YjHXU3Q6UEy6FY8hscoLThbqI/
        QtOLbu7yg2GkY9JOigntbxDtk9zAkM0Gat3szkQx/9lTCQUla/Mc6jLftHnY2zCx
        axFaS96Aq/PmBT9TtbVmZLv50iV6I6HfadndN8WiFpIn2HtW3MUPFUB0xCCQlKgv
        fgdUIqp+I8UqrtYydiVJFRSNDhtXp+Gb0lkoRC5UVMvzGDh1zh9UPLHJYnCfWY7y
        o1LBABTle3QpspqQWmez/X5xA5u2MjQQHtPz30goUqUmYmrOCsM+BrMSkNxNcZX8
        6ul6kO9Tcz/D6yhTE8RdDowthtpzZluWOlWxmjVK8hGMnI4KF3u6Bk2MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ld0J1fBGkPaubdbqtuPwQXtIDQMOFVgRg/8rzgVDg+A=; b=CoLsHTmM
        8NkzaSs+YrrszLP7CznAn1KzjV16u1XyRDoDJSIGv2OdFFG3I7W/C3l5OVtu1k72
        dBYSbWMt443jayL7DycHHlhjbFv5o8PPngIKbdRdh2HO3uWSOuP6jUrliKYKD46E
        bkCtJgavxDThG5AycHqauUzlegUaFBE2CMsbvh7hYe0NgwyCeZJAs6VCC6s9qJ/q
        VvSJUyzQJV75ptZFo7lYMW2GQcO6AMJU1NuO98dfrXEXPZ6j2NK6rJTfwqu9ZIhF
        aBFhGeduOEpgrEiWzvnNpIRmTzmc/pHSNXDgZOent9W6D4Dhkt21g7F7Yv0MmFqo
        1BjtXUidgHtHmg==
X-ME-Sender: <xms:swUGX5VzqN7wXtNJNqxvRCsp7mcNRROmnTyGzdOjcsp6F7VAwLVA0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:swUGX5kw4zDBTINFg3BeM903imkSpuc0oq0Izp-Em1PJ6XsW-VlQAw>
    <xmx:swUGX1Z_0WAalfOIHbmZj0APuEA6szFVdxXxWiP7Lr7nX2uAv5fLAg>
    <xmx:swUGX8Xnxa1LVqfSIYB3sDRmndlIvpfLYrwtDxj2FGoWeKuKtEjZag>
    <xmx:swUGXxUTzocUDUqpRHao9m8IqwNrcI0VSl20XwRIQUvxeEO2ZF0pCJ3o9qc>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8E9CC30600A6;
        Wed,  8 Jul 2020 13:43:15 -0400 (EDT)
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
Subject: [PATCH v4 31/78] drm/vc4: crtc: Clear the PixelValve FIFO during configuration
Date:   Wed,  8 Jul 2020 19:41:39 +0200
Message-Id: <596dac201108233446694a1014726c51843172c5.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
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
index 13fe0e370fb3..25a77cd46b28 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -358,7 +358,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 	if (is_dsi)
 		CRTC_WRITE(PV_HACT_ACT, mode->hdisplay * pixel_rep);
 
-	CRTC_WRITE(PV_CONTROL,
+	CRTC_WRITE(PV_CONTROL, PV_CONTROL_FIFO_CLR |
 		   vc4_crtc_get_fifo_full_level_bits(vc4_crtc, format) |
 		   VC4_SET_FIELD(format, PV_CONTROL_FORMAT) |
 		   VC4_SET_FIELD(pixel_rep - 1, PV_CONTROL_PIXEL_REP) |
-- 
git-series 0.9.1
