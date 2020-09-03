Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DA1C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400B3206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="INtr+AiP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EhBw3HaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgICIKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:10:10 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:36085 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728415AbgICICf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 39CDFC4E;
        Thu,  3 Sep 2020 04:02:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=3UuL6jDNomYcZ
        z5/kjK71QfzRXCVATkZbwYtbqg/RII=; b=INtr+AiPw3dCdN02V7en9GAUjmrkd
        MNgjuvs7//tHXCKUxindXzwewcOI0mNUCfIe1NbXEi8M+zFZwiM836r/oS9HyFAA
        XcVQ30R5TW3s0YFfoqoapFYG2tlPMmmbUivQQWL7ofx67TOU3O+VUY3Mz8xy4KAq
        qN8z0uYdftseR3slW4u0ykxXE1RgbM3evP0CWIg3c6aFuzK+QmhaFA6h/RSPeWCb
        IVor+8Uh9LZ6Xo6Javixci26AinRteUEFSMrdJ5+Y4EyCKu1oIETxK7uJDW4on+P
        b3Owq1QOx/Ue6ULgdegFV1d2biUJu57TxO/BUGuylmfRt8A3VStuOupZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=3UuL6jDNomYcZz5/kjK71QfzRXCVATkZbwYtbqg/RII=; b=EhBw3HaV
        4G2T5vYRK1dFSxdC4C5GvT8NfVxUdEjZIsNqc4wUqTJ5bhoEHdhjWtdNmWOJG4Mb
        P67NsrxU1FRgeSarLuC2SuPP/DrFzuQ/5TRtkJOVSzwzCIwDBeYmPqNqdjJ1S/YK
        IN2tEgJJy2CYOWW3+ttg91ccN22dsNj4sCGF2BC3yTYJLfY5BdGEk1b7/zj3UwtE
        ew9xCdbmgXPzzi14C6Aeg3waUM8lUL/6h+wf+4Zw5HgFD2kkHBQpdJ/F2BWltA5j
        cL5ngwmQT7hrikK2vLlCVlfaFRPgQGV4ZKLkVcrJ2/yyxGBVaQoUvPUljwmm4PRh
        HkBMUOPxSY2BqA==
X-ME-Sender: <xms:F6NQX4DVzvsiy-pZnxhzpZang57HvWLA6N1e8MHP4Bs9AU2yNvCFGA>
    <xme:F6NQX6gD2CTD6EKaVlte33_LChQxX80e20o-jDQZNiXcvjpgDkcGFtvqDmh4IA-Uu
    MXeo8TzfW5N3n6k48Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvfe
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:F6NQX7nWgskJRDDW6FxNFGvAMmjZkfy1LWp8TttTfK-dIGSKmzmATA>
    <xmx:F6NQX-wOD__2CWHXp8oC4YIYWiLM8od6Kztil2clO_cyMXxOg-oNIQ>
    <xmx:F6NQX9Qmpcb-gG2kbBuUJp0h2qUrJ150eISm_kIOHp-NHpizGk_DQw>
    <xmx:F6NQX9YA-QMeYI4COz0VCaMrhalHMgZuk3cwK_83DLqqT9nZEFOvKShSkDE>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 74E16306005E;
        Thu,  3 Sep 2020 04:02:31 -0400 (EDT)
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
Subject: [PATCH v5 27/80] drm/vc4: crtc: Move HVS channel init before the PV initialisation
Date:   Thu,  3 Sep 2020 10:00:59 +0200
Message-Id: <9d7c5a03bc1a1e6d50f7b617cc2d8a46a4bbb7bc.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid stale pixels getting stuck in an intermediate FIFO
between the HVS and the pixelvalve on BCM2711, we need to configure the HVS
channel before the pixelvalve is reset and configured.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 2c5ff45dc315..b7b0e19e2fe1 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -427,10 +427,6 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	require_hvs_enabled(dev);
 
-	vc4_crtc_config_pv(crtc);
-
-	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
-
 	/* Enable vblank irq handling before crtc is started otherwise
 	 * drm_crtc_get_vblank() fails in vc4_crtc_update_dlist().
 	 */
@@ -438,6 +434,10 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vc4_hvs_atomic_enable(crtc, old_state);
 
+	vc4_crtc_config_pv(crtc);
+
+	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
+
 	/* When feeding the transposer block the pixelvalve is unneeded and
 	 * should not be enabled.
 	 */
-- 
git-series 0.9.1
