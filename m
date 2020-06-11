Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BADC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85B7206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="I87kwz69";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PuzL4vF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgFKNsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:48:30 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:36867 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbgFKNs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:48:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8062E5801A2;
        Thu, 11 Jun 2020 09:38:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 09:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=jQjsWeIlhqPm1oZNMXNmNsjlPz
        ih/RDA2oOywNwUB50=; b=I87kwz69l9LvgHZdmVA+cDiJ9T9yrQX9kGu1qjvJiX
        LlG8iA49WMbkddT4lbo6z2ptt32ZhNcSKpTJns/HIsFWLSDt6OV03QLudgv/G5mC
        nnaz/AUdBPkmzPaMAfrgg/AmPurXxhdteD2LqasHZv6h99gyQfdLjvR7Zs82WWjV
        OSVsG4ViowKy5pqm3DygekU/rlm2qjQEYZUUV0PSsVT0oQ85NZC/v3JfmtvhKuu6
        he6Afya9/QAZ9LXD5gEVE4eiZ6ApAc+8KdcfDGU6p3sBmOazQ3lCVlmCcn3peLXO
        YTK9NBchDnjmah2lSh2Q0UXwwoZi1C8l0hIkZN8ZCf9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=jQjsWeIlhqPm1oZNM
        XNmNsjlPzih/RDA2oOywNwUB50=; b=PuzL4vF6Dju4Xctz5wQb0mqpZKmzZEQan
        aLEyfReB4xgLdcjXl6pP/FW87U+gCqhQ8E2BLRft+UFfFhkmtbl3PuzxzQLrg8uV
        xApbyVVjR9Ji/dA4qe2dSWFoRMOY2gBAo5yymv3vo7U/EZKHTdVdOEw1Cq81Seck
        lvt4eJUe4L/cefvhiNZNIV2ZJGAIyR24fUkwhRUZdIaTZi7VDJDmj+SOartaueZl
        f0O+mvl8Ls0lliHdtj9VKxKBp7MC9bu3iP4j1uakXzln5ZLpxMvHJnmwY0gRsRVk
        ywSkO/9RG2YfApuUQN8rrRu+kCzi/Ny7WP2dAA05ZJwI1gcSs1aLg==
X-ME-Sender: <xms:2jPiXktuOVskVoY5KmhamXjS_PrrZeCxGJUmr4HNEvzFgssPTz10NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehledggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcu
    tfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvg
    hrnhepjeffheduvddvvdelhfegleelfffgieejvdehgfeijedtieeuteejteefueekjeeg
    necukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:2jPiXhd0pW_81VlCfqAD34FL9WOAf2j2VtEfJJR0uvOzet2_sVr2EQ>
    <xmx:2jPiXvxvUx66V9nBHhR0qIKP5or9l_sPJdDy_xBbloRRMQK4lpZjFw>
    <xmx:2jPiXnOCVumnEv76bVK98Bn4bEmaxVEnH5LPFD_PzVhpWt8oNrGH6A>
    <xmx:2zPiXhMywNAl4iF7Rt_C0NB88zfGr4tmimA_b5hR7qfebbJM5SQiZA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 71E1F3066656;
        Thu, 11 Jun 2020 09:36:59 -0400 (EDT)
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
Subject: [PATCH v4 0/9] drm/vc4: Turn the TXP into a CRTC
Date:   Thu, 11 Jun 2020 15:36:45 +0200
Message-Id: <cover.c33f5fd8b1b2703081f25398eb879937c9f7ce0b.1591882579.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is another part of the rpi4 HDMI series that got promoted to a
series of its own to try to reduce the main one.

This rework is needed since the bcm2711 used in the rpi4 has a more
complex routing in the HVS that doesn't allow to use a fairly simple
mapping like what was used before.

Since that mapping affects both the pixelvalves and the TXP, turning the
TXP into a CRTC just like pixelvalves are allows to deal with the
mapping in the CRTC states, which turns out to be pretty convenient.

Let me know what you think,
Maxime

Changes from v3:
  - Stripped the patches out of the main HDMI series
  - Change the bind order of the HVS to avoid a compatible check
  - Added Eric's tags
  - Rebased on top of drm-misc-next

Maxime Ripard (9):
  drm/vc4: Reorder the bind order of the devices
  drm/vc4: crtc: Move HVS setup code to the HVS driver
  drm/vc4: crtc: Make state functions public
  drm/vc4: crtc: Split CRTC data in two
  drm/vc4: crtc: Only access the PixelValve registers if we have to
  drm/vc4: crtc: Move the CRTC initialisation to a separate function
  drm/vc4: crtc: Move the txp_armed function to the TXP
  drm/vc4: txp: Turn the TXP into a CRTC of its own
  drm/vc4: crtc: Remove the feed_txp tests

 drivers/gpu/drm/vc4/vc4_crtc.c | 427 ++++++----------------------------
 drivers/gpu/drm/vc4/vc4_drv.c  |   2 +-
 drivers/gpu/drm/vc4/vc4_drv.h  |  38 ++-
 drivers/gpu/drm/vc4/vc4_hvs.c  | 291 +++++++++++++++++++++++-
 drivers/gpu/drm/vc4/vc4_txp.c  | 109 ++++++++-
 5 files changed, 522 insertions(+), 345 deletions(-)

base-commit: ebd11f706c9d9756edad5b5f3f3310d77d77f60c
-- 
git-series 0.9.1
