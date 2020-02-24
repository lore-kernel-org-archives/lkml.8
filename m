Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34580C11D2A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0F02080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Wl6g0hPj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cREm2nLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgBXJLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:11:04 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:54647 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728365AbgBXJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:54 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 43F0B616;
        Mon, 24 Feb 2020 04:10:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=FZIMsSvqEu67K
        Z2BsdsliCRua/N9ZIceMURgJL9sc78=; b=Wl6g0hPj02F+KFlO5VPffhNTAbt/o
        2aEcf7NCi4+xgqAJzlECkDvHa1mNYWHfYnqPTegQ4QsSV+DtO+1KbOFerakwbfZ/
        3cGwK7P+XCt/zbWoc0bBxKsu8bRgi6y/Kl9MmwRxaUl36nEEe1lqhvQA4na3Wge5
        65HKzcvhDsk5NuV1FPHoqgP6+7T6GTexhmBdw7cWAzDju4N/sM9KLg3r8qqlqDnl
        3PrwJFhExdp7+AEgY+Sbkr6N44r309p90ao9x4KZQxT258NFwSXglelIQDU2iV36
        gENIdvapg6U2iHoVkc/EoAU6AC7PuSp1HKD3sPOyVuicLRYptgaNnhMZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=FZIMsSvqEu67KZ2BsdsliCRua/N9ZIceMURgJL9sc78=; b=cREm2nLi
        hoVl2rKYolRCAC8AWNpfxns77gVg8P3ySbHXkVnGCMdHJjMSwtnAAUSmVX/jhb5P
        e8Chl+gqvdc9HTpNPUFxpgsEuhFQ27J1ZCoxIH4mxlbxA4nFA/VraAJLG4MebBAK
        GrtFsBDTrxVai05QzQkkOZyLRnK85gsSzdvc7YQUb4wtxDq1G2FDaGkBGdSUr5tU
        mqrGQqhU3P7zD/iphIxR3ld0C4zUk88AKyKCH9NLNQ0UK/xrzpnIUmGNfEPcwdCS
        TDWHcpQJH54v8syc0m942QGq4VDCr1og8QKlrGNFAVlRXv0/YMAUpGNluli2YuXa
        gSMun76sHmwd8w==
X-ME-Sender: <xms:G5NTXjkUg2B4CrGoyZVTxW9Vmwck3HO9dKi3jbkdg1krcKD9J9cpPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepvdefnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:G5NTXuEf_rWneznc-9HOuVZbPWG_PYGSw-KHfEIp522W--XfrTwTEQ>
    <xmx:G5NTXkgAxH990l8Q_C2RzbpAeNEE_iXQEYSv2HgMcytUx7KJwJutjw>
    <xmx:G5NTXrhWf1C3lX4dOPo0UJCJzHYJx5QI49kTfLou0y3KQ46tsW-aVA>
    <xmx:G5NTXs3PZxPJPPE5wSFI4XBYXOdcfzZg2xIiRhnKqv20SG_6Qs7r2zVggUY>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 860FE3060F09;
        Mon, 24 Feb 2020 04:10:51 -0500 (EST)
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
Subject: [PATCH 85/89] drm/vc4: hdmi: Rename drm_encoder pointer in mode_valid
Date:   Mon, 24 Feb 2020 10:07:27 +0100
Message-Id: <025236a9624dcebf44521e22f002597bb1feabc8.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mode_valid hook on the encoder uses a pointer to a drm_encoder called
crtc, which is pretty confusing. Let's rename it to encoder to make it
clear what it is.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 9b06352da377..2cbb950f5d5a 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -558,7 +558,7 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 }
 
 static enum drm_mode_status
-vc4_hdmi_encoder_mode_valid(struct drm_encoder *crtc,
+vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode)
 {
 	/* HSM clock must be 108% of the pixel clock.  Additionally,
-- 
git-series 0.9.1
