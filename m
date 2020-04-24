Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DFFC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A746220700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="f+qpgAyq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rPFihze0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgDXPg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:36:59 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:38879 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728666AbgDXPgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 1A67E144E;
        Fri, 24 Apr 2020 11:36:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=eOZSTsLwzi7X4
        6+RpMSLy3AiFh/ZbNYEXIOKGvsLCwc=; b=f+qpgAyq6I2S2BcsEeU/8sk1JRTbw
        ED45phzfojgvui30ZQ0B4is/YVxn1yOxWixq8CsbyjWEaoLR5VEgAz5XzYoRPvQN
        BO58JYNFzZ50PkFSu3ub8GzWTTeV8XiOueMCXEkx0vHToaAvDovrAFwgOPdEQr6t
        1MjiP4EXX8WEMseKCpnSx8Q9MFmFRxgxkaK49i/Ec9eNPtzrn8SlK3kAMeMvxz77
        tQJKz9vfIlhIg4B+jiUkzH9NNXssDeorjOe5EAETMR1MX7DaWYRw414BFzqSCmKE
        UrkFUnHOSsyeALN2xQ5HivShCMEOqBfqLMUNrzV1HTspcTJcGDt1AZ7cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=eOZSTsLwzi7X46+RpMSLy3AiFh/ZbNYEXIOKGvsLCwc=; b=rPFihze0
        9t64ZiA3+gvpY3r5SqzRI0VeUKiqiYxQc94Ma7Iq2+5VecdDGl6jqHA1IcIF0s66
        yxHI2xUJayCIr98I7kwduQqw3dS8saBBbs4md/mx2sWMFa+P/b7RiAEGJfy9CwVi
        ckw57UR63hN2A5VDZYj2ff379LVeQuodulfypvXEzer3siM6jdekHBFWAnrRmM6U
        lumhuLh4y6DvxX6dsi8S2z1zRu6im3jAVxDEBvMCVUqoagTpPvuKkjgRi2f//Jmu
        gQzzEUbBL0AWYftRzyX1Y3M+eBI2B8pBz3BKZabtPqz36UyshYEv2YugTUVI0uKV
        b9CG4oZy0oCPmA==
X-ME-Sender: <xms:jwejXt9_andU4Hn0rriVS44GaBaHk367yi36KziH9tOHxD1w3jCoJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeehheenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:jwejXgHMdBPzZG8QCqVN7RzeAyVUcJtZ9uQnIxpz_N642mfi5sQ15g>
    <xmx:jwejXtfokfmFy1Xl1COmGmBGcAHoZAwR_0USWmcPJgQhabwld7-dAg>
    <xmx:jwejXuqrZqevL3hvO1c7hYkH9FwRS3thJs3ZBzQxgg9vovHQpuVsmg>
    <xmx:jwejXp4vMUkr1xmiD6aewyyIwGBnm1QRXx7dHWRJRZce3hGA2eWEUQ-grHM>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 50ACC3065D97;
        Fri, 24 Apr 2020 11:36:47 -0400 (EDT)
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
Subject: [PATCH v2 61/91] drm/vc4: hdmi: Use debugfs private field
Date:   Fri, 24 Apr 2020 17:34:42 +0200
Message-Id: <f2e5aadf3203eb9152ce5b106016628b5f194f78.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're calling vc4_debugfs_add_file with our struct vc4_hdmi pointer set
in the private field, but we don't use that field and go through the
main struct vc4_dev to get it.

Let's use the private field directly, that will save us some trouble
later on.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 7e2d3ec311e3..a9e32ad7b0ab 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -182,9 +182,7 @@ static const struct debugfs_reg32 hd_regs[] = {
 static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	struct vc4_hdmi *hdmi = vc4->hdmi;
+	struct vc4_hdmi *hdmi = node->info_ent->data;
 	struct drm_printer p = drm_seq_file_printer(m);
 
 	drm_print_regset32(&p, &hdmi->hdmi_regset);
-- 
git-series 0.9.1
