Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56DDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C46206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="AyZIbfuc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JNbj9NEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgGHRmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:42:43 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:50503 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgGHRmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:42:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id B0315102D;
        Wed,  8 Jul 2020 13:42:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=1gB4ajIYx2zSo
        kwd0xMtjgpaC1At6DM1TzEccvP1aW8=; b=AyZIbfuca5VNRNlAwrtAgwg5Gcfdp
        kDJNhcdxXyv4+UWdWA6qwofsickKePL3C8DejIqesFqrloU2f63dLbWqEJ1B1hjM
        rZvgOuuJc8TOhhyRwXouPFtD19P1cUyBIVWrWoK+gb4fM3zcHqQl0kuh2NMIoqpO
        WgeGV33/3E4XlNZFy9vKNRqfty3Fb424TbmugasYpCS7P8hcZXhDmpfAqCQAraVG
        g6w+n3l8OWqP4MHmJu9a7SMJjSogYs/8j+mc36pYlavXJlD1pwmjq33U5z4V/qfn
        rjBtxt/RxYpDAR5Slzu6Ks3w2tNFYSLB8vuDm4OKhVXmp6YDZbZvJIzcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=1gB4ajIYx2zSokwd0xMtjgpaC1At6DM1TzEccvP1aW8=; b=JNbj9NEq
        PFiEPA6H9zp6sDf7E6MuRpxgyxhmp5J5MGGhU3YihcDfKvd7qRSK1Y0mX5JXT1jv
        3Tw14QrNQcvHWmCpNkIcGmxUk9qdolRFZuGjrleFZmSmThdsLxz2z0ZD7aULLuSQ
        QX+q0eQ3RHAfNWbaOcd86rEza3s73a+FoJy3wfK7z7vdVkOXb2BgrKTxJJ3Y6knz
        obKEu6NToR0ocpVEq4e5+SdZMZJiA5PJIq1bbJeE2Wm+TxrlF7fu8Eed1Urovk/V
        TFaD8t1iw4gkLryNbyZUcTbc/dqGQvkAD+tQvO8OEndcbUViJG0cyfqmZhNz8Mz+
        S5ULgv4s1JdAdg==
X-ME-Sender: <xms:jQUGX7amSmGsv-FM3opsgWoGe7Gltr1jTw8NyBaDT33OtDUHHx146g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:jQUGX6abTkp8czSBNqtv10mQ6SBLbndlyGD0ExCmVtpzNzOabUg8xQ>
    <xmx:jQUGX9_Bt6vwh170bDr3tCUvp-CVm3JM4LiaP466UI8HG9l5BKON1A>
    <xmx:jQUGXxpS45UF3W4Cc3Vdrf43Aq5AtBdXAJoWC8-apAOEWKLnQNT9nQ>
    <xmx:jQUGX2JbzjRh0vdM_lBXFP--TZ-Ztk3j1gQjU4VRyqO_X5UI_IKZ60wkn38>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id EC4103280059;
        Wed,  8 Jul 2020 13:42:36 -0400 (EDT)
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
Subject: [PATCH v4 04/78] drm/vc4: plane: Change LBM alignment constraint on LBM
Date:   Wed,  8 Jul 2020 19:41:12 +0200
Message-Id: <c6e54f61c09bc417cc37f8df7f97070a8a8e4634.1594230107.git-series.maxime@cerno.tech>
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

The HVS5 needs an alignment of 64bytes for its LBM memory, so let's reflect
it.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 20c949b57827..d0771ebd5f75 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -578,7 +578,9 @@ static int vc4_plane_allocate_lbm(struct drm_plane_state *state)
 		spin_lock_irqsave(&vc4->hvs->mm_lock, irqflags);
 		ret = drm_mm_insert_node_generic(&vc4->hvs->lbm_mm,
 						 &vc4_state->lbm,
-						 lbm_size, 32, 0, 0);
+						 lbm_size,
+						 vc4->hvs->hvs5 ? 64 : 32,
+						 0, 0);
 		spin_unlock_irqrestore(&vc4->hvs->mm_lock, irqflags);
 
 		if (ret)
-- 
git-series 0.9.1
