Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158D2C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD80E206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="gswgacHB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UhKj7b3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgICIEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:04:38 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:38391 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728424AbgICICk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id F196AC12;
        Thu,  3 Sep 2020 04:02:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=2cnyUKVTc9vD/
        03BQF9KhDjcFGmV0tTe2xC3x8EBalQ=; b=gswgacHBfDHCYrxEieM6XVjsfcHNn
        kq8T/+FlqMhbkziWfIk0eoNEN8bMwj+itHjTrVegs92oa5lH9fmm4sychECdiEtV
        LpMk0YWNtE7jts+RY9yJi6XT8zN7zL6lJYb0cT54O+3qLql1fEkpJD6oeiAhg6OS
        ZXehpldOt2lZtGPZya9CfEtAT+xiAOr1vXqmvdZDgBpCnS3g7+d74fALknLssq/i
        4HPpKR+M+igq0oz7ZB2TI6IxSvJNjhPMOLauKB3TUCP1m2fYVKzHNS3X0EQtJmWo
        cuVcQN7qRXmB4RdPMXR+biro+zMSFk2jgbKASgM60+rObEXAYTZ6od3Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=2cnyUKVTc9vD/03BQF9KhDjcFGmV0tTe2xC3x8EBalQ=; b=UhKj7b3v
        hT/KqTBheneVi/SjN4PlD/fGNjLNBzlvmYxxbfK3ul1FEhf9Eh6uz6rLnvKN3Cvr
        Lw/GA+h+HB52vrOl0QsrC8jK/fmIq4q3JOuXSexm3m/6ncq7XytcaJduG5T4Sgrn
        1no8WOSHvG/LUzD874U3izoDbCZah1otOgvDu7kngwNwYwbpFcZaMixQj2x40X9X
        fwUzLpTJABiYdF6BIPld71ctqdmQeUVHjo8vUhVcoCigbOVw4MZC+msBOkz57aQt
        kQMs5fpg5dFlGSPjAH+kWNek70J0C2fd4BQjr+HUR97LJG51XMW0Bqdc/y12H6zR
        tPEnDNaRpPFUDA==
X-ME-Sender: <xms:HqNQX-CTFBu_5VFudCAMIckNZn8eENjjMhldqw5aevGpGuJGCn9OGA>
    <xme:HqNQX4hSFN89iH6ABzrUeNKs7SXgn5dX17Na6fTrpl3U0ErKNf8TSH0hLs1OkxNy8
    4-jAzSNeH3zCI2Mysg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvje
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:HqNQXxmsjTrIIoe3VLxIx7eI65EWjFS86cZYMcvYoR3pVr697zTDxA>
    <xmx:HqNQX8wo4NCCaE1cVLcqZZwI2ZGARAAMtIj92RJ3Hr0Y4XMzu83ieg>
    <xmx:HqNQXzRrbBRato9myjQZP0oX6LBAcBinVY6_sfpdv9SNCAuJq6os9w>
    <xmx:HqNQX7ZVkIVXfw9MtBFw5nWd10xKBVAXBOFN7KZH6cWxkmoDv61l0y4gsEo>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3B116328005E;
        Thu,  3 Sep 2020 04:02:38 -0400 (EDT)
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
Subject: [PATCH v5 32/80] drm/vc4: hvs: Make the stop_channel function public
Date:   Thu,  3 Sep 2020 10:01:04 +0200
Message-Id: <a9d5f0891c3bc1deb6b16d56ca6994ed912ec7c7.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the transition from the firmware to the KMS driver, we need to pay
particular attention to how we deal with the pixelvalves that have already
been enabled, otherwise either timeouts or stuck pixels can occur. We'll
thus need to call the function to stop an HVS channel at boot.

Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 1 +
 drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 251fcc35530c..554c2e29b23d 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -907,6 +907,7 @@ void vc4_irq_reset(struct drm_device *dev);
 
 /* vc4_hvs.c */
 extern struct platform_driver vc4_hvs_driver;
+void vc4_hvs_stop_channel(struct drm_device *dev, unsigned int output);
 int vc4_hvs_atomic_check(struct drm_crtc *crtc, struct drm_crtc_state *state);
 void vc4_hvs_atomic_enable(struct drm_crtc *crtc, struct drm_crtc_state *old_state);
 void vc4_hvs_atomic_disable(struct drm_crtc *crtc, struct drm_crtc_state *old_state);
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 0f56a7b57916..b5ee9556e821 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -248,7 +248,7 @@ static int vc4_hvs_init_channel(struct vc4_dev *vc4, struct drm_crtc *crtc,
 	return 0;
 }
 
-static void vc4_hvs_stop_channel(struct drm_device *dev, unsigned int chan)
+void vc4_hvs_stop_channel(struct drm_device *dev, unsigned int chan)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 
-- 
git-series 0.9.1
