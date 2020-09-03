Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32117C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB90F20767
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="T7GPIGUf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qcjBjvT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgICIJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:09:42 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:40807 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbgICICh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 577BAB66;
        Thu,  3 Sep 2020 04:02:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=B+Ge3UYvmpsgg
        4Lbed0L2g+EdxKusrcCPYtOlov8z54=; b=T7GPIGUfFDk+0v3oMBjyVtl/gcGZf
        QUq68UyWPyPlx/V3O/ZRg2TvlhtJUca8B5aTz+ycNRW7wqCpvHr9jcsoi2whjBrT
        cPyYXp1NBEizvdfxtIDsw/Kt5SBzr8VQES9b8IaoNcDSZ66dPreF6Jm2kc46X9Z0
        C8DhU819OdY8mtUEGWrC8y0MxlnL7E37yIRaeEUYv4oR6p7PHmZVTxpbXd10noeW
        9+FhLwviQiT3hLx2WDFkfttwxQBqsF9NeiUV9qerQOfUY81R44rZ8mNsyuylN0Qg
        3eyggeZ+iHVtaHWvo2xMtOvvM112HHpeRsZC0GzrVMbxAvHbEh/s4l2OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=B+Ge3UYvmpsgg4Lbed0L2g+EdxKusrcCPYtOlov8z54=; b=qcjBjvT6
        ERsoj2oGo557QY7MOd6oi5/Y5pCkIvTW4/Xm+kZBBFeDLf6bkkxSReAcKXFaP+aE
        CjtP2OFEpK/dTFaZFvSd6DNJlsAwPmXQN5/RW/677t6jDfbkc86I+p+nY6RU+olk
        DJrkjs9hzx7zBqGllPJ3UafqUUTRBDCdCFAg9LpU7jWRGpE7DvhJCwzVr8cJmog4
        Ra5w02xNVyTHGq/DVlttiiitPn1JhvnVXxz+OJ+h5f+Q91KPSL6tlNgnBbhVJ7mP
        I+2Elm+OQfV8FbOm+kjYBkoMLjATq9rau05PIwdy1bOXrp1k/HJ4bplqimMlqjCi
        nmpM7cg2PXfVKA==
X-ME-Sender: <xms:G6NQXzSEjmMGgjwctS_Ch4KwCbtYLZtgxUSRH_PCKSmhLOaVIr8fAg>
    <xme:G6NQX0weW67paHWlgn1irxYSUrL5c-UZzYBNc34ZfNgckBBvN_opM6hSPL8KmJpnT
    CN-by-gtlHpb5RAQ4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvje
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:G6NQX42GdOf8XaviViVK57c9mysbPNnxjn2Kx6Qqw1_AAgp-opnBbQ>
    <xmx:G6NQXzBkX9L8voe4gald0bXnBz5swNXztLGPz4wLyXascCadnvo8FA>
    <xmx:G6NQX8iMJH-hpCczxHKze8penxwhqVSCnSeikM1k0xzpquinX2UH9g>
    <xmx:G6NQX7qiOsVVWf4AoXZpXBc5pHZguMfqcWvNc9Q41ieU6IBJcZd8iFhlm7E>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7944B3280064;
        Thu,  3 Sep 2020 04:02:35 -0400 (EDT)
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
Subject: [PATCH v5 30/80] drm/vc4: crtc: Clear the PixelValve FIFO on disable
Date:   Thu,  3 Sep 2020 10:01:02 +0200
Message-Id: <26fe48b09d77088679ed0c8cb8cf0db2f108195e.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid a stale pixel getting stuck on mode change or a disable
/ enable cycle, we need to make sure to flush the PV FIFO on disable.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 4c23cf8aefb9..73d918706f7e 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -424,8 +424,7 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (vc4_encoder->post_crtc_disable)
 		vc4_encoder->post_crtc_disable(encoder);
 
-	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) & ~PV_CONTROL_EN);
-
+	vc4_crtc_pixelvalve_reset(crtc);
 	vc4_hvs_atomic_disable(crtc, old_state);
 
 	if (vc4_encoder->post_crtc_powerdown)
-- 
git-series 0.9.1
