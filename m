Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC24C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85B6208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="HWbvOU3c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MIM5euon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390218AbgE0PuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:50:11 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51869 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390195AbgE0PuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8427558204A;
        Wed, 27 May 2020 11:50:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=nraSlgJbsb/0z
        SiZLIXgVenK3TQP78QMuAzCTOoxk9A=; b=HWbvOU3cV14XpZLhsgFbU4JmzTwr2
        t2eh+Uv86tDxtbq+msDaLU/AeuemAj/RCVzQmohicsA3Xoo3GMwK2CKlVxmltfj5
        k8/0MggVYg8smkSZsCVuGyVqs1tAEkiO/3k2JhOuNcQcDOibDvi8h71bd/u5evmQ
        TGpNpAVhZWkoPh7V3PP5xqMLvuM6SsC8pEWo0IiTMyyfLW0xfRMK4HkkrzjdxVTy
        qTv+ZYo9p9VTNALK5yTuCV5DtBNjnq3fGGN4wza87JBqlFtaOBe+sbpssk4ryW+l
        208vM+sCELf+jKU+AF8cWn7aLG8sGiqROztuDHbJPhP4/5iGyAzoSJung==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=nraSlgJbsb/0zSiZLIXgVenK3TQP78QMuAzCTOoxk9A=; b=MIM5euon
        lys+3BtC83CyPOPiDZT5GxDEt4v34Q2HZh7aolEnWrmvt5RQ5hu0dbjO7U3qxrtL
        Dlc14QEyzXYQlhIXMZMz6tYLz23upTzsm7COSnliSTFw5/pKLENJTgc7T7D6vCwo
        +6zkypxE9rsDsdGx+I0nd1eF4CvLA785NUtDOIZ4MeqVXB4MBzlCPKy3TyoSYqBq
        4cObxsWWqRYSCcheMyipwokN/XO6D7QpWZ+GcDloJDzSaYnVaoLOZff+UZrDlfXo
        8JLozBArBqwC+B2tA2q3We7tHU/rVdKsxd2NwQFyPPG/6WjJgHcscisCyni372gk
        0vqBo9n+0CGQEA==
X-ME-Sender: <xms:KIzOXlwxG8Ezmqa4Mc2asPTIQzHX7PUbOw3SqxBEX7zL4SBPNYYB1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepjeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:KIzOXlTIsjdPFuUhWGOfe-R61_dtzaGrUMqUuJrBvXPWv-kPhV7xmA>
    <xmx:KIzOXvUb69PUN_TTXQUTOb2e3p_1g2WMFGyWwIpnB_44nLwDAdoARA>
    <xmx:KIzOXnhx-PaHRmoshoF32hSI8LmLAq6zcqVDEg9oQaRZpqW5v4ZsZg>
    <xmx:KIzOXpAPb8LKTfCLGXBOrVOxofXNsQ8FUlWhtwIuVNgETjN7pqugMQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 240F13280064;
        Wed, 27 May 2020 11:50:00 -0400 (EDT)
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
Subject: [PATCH v3 028/105] drm/vc4: crtc: Restrict HACT_ACT setup to DSI
Date:   Wed, 27 May 2020 17:47:58 +0200
Message-Id: <7a93436f97666a2aa025686ef3ff3606de4bec67.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HACT_ACT field only needs to be written to when using a DSI display.
Let's move that setup to our DSI branch to clear a bit the common path.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 8dbf06cdb069..5e1d234f3c8e 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -344,7 +344,8 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 			   (is_dsi ? PV_VCONTROL_DSI : 0));
 	}
 
-	CRTC_WRITE(PV_HACT_ACT, mode->hdisplay * pixel_rep);
+	if (is_dsi)
+		CRTC_WRITE(PV_HACT_ACT, mode->hdisplay * pixel_rep);
 
 	CRTC_WRITE(PV_CONTROL,
 		   VC4_SET_FIELD(format, PV_CONTROL_FORMAT) |
-- 
git-series 0.9.1
