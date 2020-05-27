Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1BFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7D820873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Zu2ERzNb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TGcyIT+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbgE0P5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:57:08 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58811 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390114AbgE0Ptf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:49:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 95A4F582007;
        Wed, 27 May 2020 11:49:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=9VNSPM39dPjV/
        5EKHPEmX5F0pfjtv/pW8b8YIRJwQsE=; b=Zu2ERzNbysuyjRUW9ui7IOax81fJn
        /PuKKzKalOtkCUNlbWOtj/awsnqJMz5hfCLySk4u2DdholnRmwlJOzECoclBO1Ll
        m/1vSvCub4hMOknEiRfnSx1Uh6eF5ZxWUqNbual67rDF7LZskuaOhhiBKE08GZxj
        o/EchnMpcZiD6Vr5raNkNp6lIlEnTZcLKSDvda46Jvh70ZUyKf8mSVIDxLs9QxUd
        sMsWGCe4JDnK4btlzDe97w6VWiTvv1oIPiFG3masPYVS8j0x4furil5JP/Tuq+7Y
        2Hy6lQwIQKZ4Q4z6QAW8oxJvaWnEayP1D9viwssMLIv1eY5FQ7qx7Yi0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=9VNSPM39dPjV/5EKHPEmX5F0pfjtv/pW8b8YIRJwQsE=; b=TGcyIT+6
        ZJksWnbv04zfv4ORiD9qWzVEvqr5FW9haI32kWovSBeWt0Mfm/f0Le1mXsxHpErc
        9lBSifKVS3jaGEpQDsga7l0P4MMdKoaWD94IC4ncHRtTphGXNytbPybU2NqDUd+T
        tW4kstJWIMZIJJE1Nt8a3k9BhJyzenL+KwX6IETBs1/xd9dRt0vMEaXAIjrWO3Nw
        otNmRPqgiRbdP5l8S+nK8iOQAnygZtW3U2c0SKRZiDgnQ7N5ViToy1iNYPbSyACy
        xL74QIq1sy9ZJccKLspswGfnUMGDK5ME3bKjuR94wRHeO2RYYqHCC4vV5a/wyPv/
        dTgV80+s0eD8Dg==
X-ME-Sender: <xms:DozOXghRpF60Ats_V7Pkd_YqvkD-DOcLC2keMa3KmBPbnQJ710-HKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:DozOXpDMGdhqpWrzgU4B46gDGudNCfHulI-g2mhR3I7P5YVaw2xWqg>
    <xmx:DozOXoHR5Zyv2niY-HoCGqBlEO8skX2XC9qxvxnbwu4WQC9hjqSFtw>
    <xmx:DozOXhSG440H8499WEPUXZCmFm6n9nEI-v1FHoWWk4d63jBI30TrBQ>
    <xmx:DozOXsyaz7VNj9GjcpHT0DqV2ZcxX2YHJfBhSqz-Vp3dIRiNUV5zjw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 052973062499;
        Wed, 27 May 2020 11:49:33 -0400 (EDT)
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
Subject: [PATCH v3 011/105] drm/vc4: drv: Add include guards
Date:   Wed, 27 May 2020 17:47:41 +0200
Message-Id: <68e89e315c4c35b313efc277c9642eca684e0ade.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vc4_drv.h doesn't have any include guards which prevents it from being
included twice. Let's add them.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 3b1f02efefbe..6f50a91e3933 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -2,6 +2,8 @@
 /*
  * Copyright (C) 2015 Broadcom
  */
+#ifndef _VC4_DRV_H_
+#define _VC4_DRV_H_
 
 #include <linux/delay.h>
 #include <linux/refcount.h>
@@ -897,3 +899,5 @@ int vc4_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *file_priv);
 int vc4_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
 				 struct drm_file *file_priv);
+
+#endif /* _VC4_DRV_H_ */
-- 
git-series 0.9.1
