Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707A0C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B1B20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="H4fPFrGr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U0f0Y/Eg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgICIKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:10:46 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:57213 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728291AbgICICV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id E3841773;
        Thu,  3 Sep 2020 04:02:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=duNhF2Nx3MRwQ
        EHgb22EplTMve51MHVBzNHoNv4llic=; b=H4fPFrGrTlG33nPaFMNzsnaAJcMie
        ifIgBa+XciGBKoQFOQtre3divkrRonhAKSwYpv1RKJC5zewEzyxwqaQeKfWT0fGi
        FtIQepMpxwHes6xPyOqf7ZGaVxzLhqCROeAl7D65udeEYGlWMDKPOaeNjFM719+M
        U26GVrwcGmdM2uVrJRA1D44A0kCfa7w3SoDwOuZxwYqyHbjcT7uP6OCdPXkPFFS3
        8nRRk+nocPzIzrCQQi11ZM/HDcPXDU8xrwhIdjS83h6XzDNnP1y9yJe0lrFy4Ft9
        MI1snQQ66IxWc8hp9UNNjveqwYPIaupBdyMPiGEMvl+RAvcMcavWhWDEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=duNhF2Nx3MRwQEHgb22EplTMve51MHVBzNHoNv4llic=; b=U0f0Y/Eg
        LdTDDDOAvNAMKUpBLIdIaoE7sspChJ2ZGrU7W0LfTrkfJOfg2cQ78I2JVpjt6iXw
        C+bNJBTL7NdAa5Ioov3Qq1GF5CYYyt+cbZEV500y6jwZsbFh9CWmJUhOa05zrzxw
        mvqXFRpdH/Jo3/wkyDl1S1/1OGPHGGQ9D6LtkshtbrtXwQUFEmVtPyoy8sNOBATG
        vu5dXXlPvoGCyuvEBNgyWINYnwd2hy/t7r7H2LAk/jhbIocI3pgyf0H64j7OlvcN
        aGavLaSHa8gwvf/8xsyqZfox4Kx33lW3P3DcZeE9xf0c6DyVB0mjHfqyltQ1GiGy
        WrT/K34kSj3BzA==
X-ME-Sender: <xms:C6NQX7iOVYFyXZ_vJ27ms03zYmJf_PUcr-VFyAK5Z2WmMxUSssTxVQ>
    <xme:C6NQX4AwPVl4qrGyqC98flk-50QLmPhsqzDOsQnow3pifgPRUPVRIvBkaNAv_NeMX
    Ut2NsZfFbgB_sgCVtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeduge
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:C6NQX7H-AKaUagpflYGUN9k6qqvo03FWjZcwxEFzdmNAsb2YEun8kQ>
    <xmx:C6NQX4TjTiG_m_Nth-woUU1IRPcMymzCBvqBeEZEGxEfN1vCzN3AVw>
    <xmx:C6NQX4w784DfSTJuAUjUibHUCu3w50k0uewfMPiBK9vxnt4no6sFGg>
    <xmx:C6NQXy5poo7TckukTDraYeQc9fyGeGwS7Y0ZbxVljIX3afyqRAWvBuQPlvU>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 40644328005D;
        Thu,  3 Sep 2020 04:02:19 -0400 (EDT)
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
Subject: [PATCH v5 18/80] drm/vc4: crtc: Add HDMI1 encoder type
Date:   Thu,  3 Sep 2020 10:00:50 +0200
Message-Id: <6ba56d2421a4ad59ce72178e8f37eacfbd72cb33.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 sports a second HDMI controller, so let's add that second HDMI
encoder type.

Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 5781773aec4b..4126506b3a69 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -427,6 +427,7 @@ to_vc4_plane_state(struct drm_plane_state *state)
 enum vc4_encoder_type {
 	VC4_ENCODER_TYPE_NONE,
 	VC4_ENCODER_TYPE_HDMI0,
+	VC4_ENCODER_TYPE_HDMI1,
 	VC4_ENCODER_TYPE_VEC,
 	VC4_ENCODER_TYPE_DSI0,
 	VC4_ENCODER_TYPE_DSI1,
-- 
git-series 0.9.1
