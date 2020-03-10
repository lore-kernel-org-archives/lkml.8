Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A853C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EAF2467F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pascalroeleven.nl header.i=@pascalroeleven.nl header.b="q2+FGgY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCJLJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:09:19 -0400
Received: from web0081.zxcs.nl ([185.104.29.10]:43580 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgCJLJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:09:18 -0400
X-Greylist: delayed 2469 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Mar 2020 07:09:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3IKSYKtw2n6yNxpaRbwsTLkcDXqG5XqbFrwDDbF1iTo=; b=q2+FGgY0n/8I2ypRNbhdzFXmqe
        v0RSk3+nlIPz7V1WNA4b2mV2GDPyr7Zu2w2nsC6m6IDsFTa+C/EvGl5f7bD3ICTSHBttf2qA7ew/B
        xlpjY0minYaq3RrdJDEh/ik+cnx1GxwSl2Mmh/n4X+n7gKtdx6y5qTBj3lis5R43C43SG74Aj8M/K
        Umi/D9E+BWGRi7OdWzpUKecpD+kPoF42Tc6HVsAJ9D6BmYo4irlzvlUZOiY6Cn6zqP0ZnYOfpJmPc
        z2niDfCBx86K/mz0ndvyQrDg7iXNLXSfbvMUo2PvgpBgtNGsvsXWhyk50Xq/25ZVA7amTh977Ogf7
        WFyBuphg==;
Received: from ip565b1bc7.direct-adsl.nl ([86.91.27.199]:35430 helo=localhost.localdomain)
        by web0081.zxcs.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1jBc7q-0017It-Mh; Tue, 10 Mar 2020 11:28:38 +0100
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-sunxi@googlegroups.com,
        Pascal Roeleven <dev@pascalroeleven.nl>
Subject: [PATCH 1/2] drm/panel: Add Starry KR070PE2T
Date:   Tue, 10 Mar 2020 11:27:23 +0100
Message-Id: <20200310102725.14591-2-dev@pascalroeleven.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310102725.14591-1-dev@pascalroeleven.nl>
References: <20200310102725.14591-1-dev@pascalroeleven.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: dev@pascalroeleven.nl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KR070PE2T is a 7" panel with a resolution of 800x480.

KR070PE2T is the marking present on the ribbon cable. As this panel is
probably available under different brands, this marking will catch
most devices.

Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
---
 .../display/panel/starry,kr070pe2t.txt        |  7 +++++
 drivers/gpu/drm/panel/panel-simple.c          | 26 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/starry,kr070pe2t.txt

diff --git a/Documentation/devicetree/bindings/display/panel/starry,kr070pe2t.txt b/Documentation/devicetree/bindings/display/panel/starry,kr070pe2t.txt
new file mode 100644
index 000000000..699ad5eb2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/starry,kr070pe2t.txt
@@ -0,0 +1,7 @@
+Starry 7" (800x480 pixels) LCD panel
+
+Required properties:
+- compatible: should be "starry,kr070pe2t"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index e14c14ac6..027a2612b 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2842,6 +2842,29 @@ static const struct panel_desc shelly_sca07010_bfn_lnn = {
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
+static const struct drm_display_mode starry_kr070pe2t_mode = {
+	.clock = 33000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 209,
+	.hsync_end = 800 + 209 + 1,
+	.htotal = 800 + 209 + 1 + 45,
+	.vdisplay = 480,
+	.vsync_start = 480 + 22,
+	.vsync_end = 480 + 22 + 1,
+	.vtotal = 480 + 22 + 1 + 22,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc starry_kr070pe2t = {
+	.modes = &starry_kr070pe2t_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 152,
+		.height = 86,
+	},
+};
+
 static const struct drm_display_mode starry_kr122ea0sra_mode = {
 	.clock = 147000,
 	.hdisplay = 1920,
@@ -3474,6 +3497,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "shelly,sca07010-bfn-lnn",
 		.data = &shelly_sca07010_bfn_lnn,
+	}, {
+		.compatible = "starry,kr070pe2t",
+		.data = &starry_kr070pe2t,
 	}, {
 		.compatible = "starry,kr122ea0sra",
 		.data = &starry_kr122ea0sra,
-- 
2.20.1

