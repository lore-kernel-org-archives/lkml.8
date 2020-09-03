Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80789C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4455620767
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="DCNm4la4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dtbX2TkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgICIJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:09:02 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:45787 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728444AbgICIDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:03:02 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id EC3F9BC0;
        Thu,  3 Sep 2020 04:03:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=0V0JoVHrStkuf
        0hsv9CTL50/mL64CgSe0XNcEtSYLkQ=; b=DCNm4la448mtDnDIXASof2emuiJWE
        DgZIhJ9zeNYfqTrQ4ph2ikm+BX1VcJlAvL7SWUAKZNZYDFdpVcps4G9mVTJAWViU
        Hy9W0UKWYUmLmeyxAiCB+XjaFG3nMlQv7ZP1clhs8db3Uw3r9ZfwAxvBg8SGxk/f
        OKigd2ykHU+xKale8ZRtNybLDneUPi6pEGfnI9dBJRESle3WeOLg0eYJZU2TtJMw
        0IKYY8p0MbthY22bQERYjKnViQoXnblQCPcVmZ7AhYJp1BQZDU3VVv1OxI10uZCq
        TfMEr+Z+G0mys5Yc/07a8RsfzCrIDafJYokNa4LPSbjh6l5OD9JjwwCCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=0V0JoVHrStkuf0hsv9CTL50/mL64CgSe0XNcEtSYLkQ=; b=dtbX2TkP
        P9FVWdaacfgIcSWWrGjiWQL3E7dt0ZLNK87iw4Z3D05w2id0gbdIipUGTZXAyw1t
        lnxgtEXhX6I/DlL5wg1P0Sq9STPzhxzrXguQcTL6NtS/pa/DkHvAeWIWqpigXRnv
        wf8FcR615iDromE6GEap/v9ws9CHrSE99t89MqIkPZw5STj1r/1QVnNC+tJ9zDFI
        QiT/JoUlV+/CT/p6RIH42uPV+HR/F13Lwn13BgCDh6zOmCIu+sKHl3qKjFqv40h4
        H3oWOs9E8dmWethACS222Y4b/K3IFKg67NNM4+FG/K1ulhKmUYW8p0YpUanF3C9p
        RHwQ0mYKPicBwg==
X-ME-Sender: <xms:NKNQXw6M8JTVHUPdBh3PxkiIp6kZYv6ByaKaPoHJuA9miJQkkC2tTw>
    <xme:NKNQXx5SHhEN-BI5AOP9ydkyLI-ZgTN4iwiXMWpUyusW2STVOaj6Sya5vBZ2dXhxt
    z3JIkeftIwwP6dxk6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeegfe
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:NKNQX_dCuDZ2y0ldQia_57fuLIK7XFVKQgbKptxCZxY5p2Kjd9-zCg>
    <xmx:NKNQX1LZNQsrMai2uViQCUbP49PY7-F0srDm21OyG0WfjNfXqwO-7g>
    <xmx:NKNQX0L4CNdJT8rrFjOToom3Z6shouACV3ae3PiHy7qw4nAa14cn-w>
    <xmx:NKNQXyyiQfVW_kwqmcWivgJ6Ch6tKIgYDAo2jT5u1f0hiHpXGP3Pan8I8Ec>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 300D6328005A;
        Thu,  3 Sep 2020 04:03:00 -0400 (EDT)
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
Subject: [PATCH v5 48/80] drm/vc4: hdmi: Remove vc4_dev hdmi pointer
Date:   Thu,  3 Sep 2020 10:01:20 +0200
Message-Id: <d7ebf50319bbd902e4b7b7c39ae1612c3b38e6b2.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we don't have any users anymore, we can kill that pointer.

Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.h  | 1 -
 drivers/gpu/drm/vc4/vc4_hdmi.c | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 1a97545b9244..501a48a714d3 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -73,7 +73,6 @@ struct vc4_perfmon {
 struct vc4_dev {
 	struct drm_device *dev;
 
-	struct vc4_hdmi *hdmi;
 	struct vc4_hvs *hvs;
 	struct vc4_v3d *v3d;
 	struct vc4_dpi *dpi;
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index e0dc823c622a..912560d58448 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1188,7 +1188,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 #endif
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = dev_get_drvdata(master);
-	struct vc4_dev *vc4 = drm->dev_private;
 	struct vc4_hdmi *vc4_hdmi;
 	struct drm_encoder *encoder;
 	struct device_node *ddc_node;
@@ -1279,8 +1278,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 		vc4_hdmi->hpd_active_low = hpd_gpio_flags & OF_GPIO_ACTIVE_LOW;
 	}
 
-	vc4->hdmi = vc4_hdmi;
-
 	/* HDMI core must be enabled. */
 	if (!(HD_READ(VC4_HD_M_CTL) & VC4_HD_M_ENABLE)) {
 		HD_WRITE(VC4_HD_M_CTL, VC4_HD_M_SW_RST);
@@ -1360,8 +1357,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 static void vc4_hdmi_unbind(struct device *dev, struct device *master,
 			    void *data)
 {
-	struct drm_device *drm = dev_get_drvdata(master);
-	struct vc4_dev *vc4 = drm->dev_private;
 	struct vc4_hdmi *vc4_hdmi;
 
 	/*
@@ -1393,8 +1388,6 @@ static void vc4_hdmi_unbind(struct device *dev, struct device *master,
 	pm_runtime_disable(dev);
 
 	put_device(&vc4_hdmi->ddc->dev);
-
-	vc4->hdmi = NULL;
 }
 
 static const struct component_ops vc4_hdmi_ops = {
-- 
git-series 0.9.1
