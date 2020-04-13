Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D72C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCEC020732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgDMJzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:55:09 -0400
Received: from mailoutvs59.siol.net ([185.57.226.250]:50672 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727793AbgDMJzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:55:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id AE7DA522D78;
        Mon, 13 Apr 2020 11:55:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id j0F5mj0SWgUP; Mon, 13 Apr 2020 11:55:05 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 665E1522D84;
        Mon, 13 Apr 2020 11:55:05 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id E25A6522CFD;
        Mon, 13 Apr 2020 11:55:03 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sun4i: hdmi ddc clk: Fix size of m divider
Date:   Mon, 13 Apr 2020 11:54:57 +0200
Message-Id: <20200413095457.1176754-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

m divider in DDC clock register is 4 bits wide. Fix that.

Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi.h         | 2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/s=
un4i_hdmi.h
index 7ad3f06c127e..00ca35f07ba5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
@@ -148,7 +148,7 @@
 #define SUN4I_HDMI_DDC_CMD_IMPLICIT_WRITE	3
=20
 #define SUN4I_HDMI_DDC_CLK_REG		0x528
-#define SUN4I_HDMI_DDC_CLK_M(m)			(((m) & 0x7) << 3)
+#define SUN4I_HDMI_DDC_CLK_M(m)			(((m) & 0xf) << 3)
 #define SUN4I_HDMI_DDC_CLK_N(n)			((n) & 0x7)
=20
 #define SUN4I_HDMI_DDC_LINE_CTRL_REG	0x540
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c b/drivers/gpu/drm=
/sun4i/sun4i_hdmi_ddc_clk.c
index 2ff780114106..12430b9d4e93 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
@@ -33,7 +33,7 @@ static unsigned long sun4i_ddc_calc_divider(unsigned lo=
ng rate,
 	unsigned long best_rate =3D 0;
 	u8 best_m =3D 0, best_n =3D 0, _m, _n;
=20
-	for (_m =3D 0; _m < 8; _m++) {
+	for (_m =3D 0; _m < 16; _m++) {
 		for (_n =3D 0; _n < 8; _n++) {
 			unsigned long tmp_rate;
=20
--=20
2.26.0

