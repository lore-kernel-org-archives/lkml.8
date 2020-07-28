Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C44C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB6D2065E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XFVxZUvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgG1LSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:18:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:34321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728934AbgG1LSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595935104;
        bh=pm4hEMlP1SzMjKQ+uHyoY76koqrhvWkeRDQON2vGLX0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XFVxZUvse2zObR6M+0xBOiKlRSLE0+v2VIYCl0YJ3kC2tf49GCXNPhqSmqusKTBYF
         5/nJhprONs3KnUNv0mp0IJFP8DUXWTRH3BuUm0w4Fp9WhaC1+7kj0kpyfJyhjdPOgA
         KWyDgQ0DJxON7KsfDPirj6/F3kd+B3ImB9v3f89A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([80.208.215.239]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MWRVb-1kGiTE44Mt-00Xw1i; Tue, 28 Jul 2020 13:18:24 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v2 3/5] drm: Add get_possible_crtc API for dpi, dsi
Date:   Tue, 28 Jul 2020 13:17:58 +0200
Message-Id: <20200728111800.77641-4-frank-w@public-files.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200728111800.77641-1-frank-w@public-files.de>
References: <20200728111800.77641-1-frank-w@public-files.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hmgR7ODYKvx8oPlcDw8Lc1GdvQDfiX/JgJnDv87nXPtte2migzq
 ZD98y+zmB/ZdT2oYW7Y7j8ofZCmyvZqa5eJRoXNRmZdV4lhEsqqiCqPF33I3WAZ5nzXzcip
 5b5gV7A/c4AzsF40MizKtDOUfJhcDZss5KO+Y5HIkLY1uKWgvNw03Vd+wONHCMSGrAmN1Ya
 g9M6z+lByXTke2b9AhiEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cj6kSjaFYw8=:ibEsBPbF6stniMnVYTZhpV
 zDkTCWx13nsNCZy0D5Scrx7JkmlXPW9zL7/aTnkpDis106jtkcOYgFza12v6q47vNqG2godoh
 gLhY6SVqb6ELX75sq7sW9ju1u74/7nZLjimkkHxejvjvC68ctmMo/7sCG8m2LGloyFKovYFGN
 c084KbHFzK9BOtz9pW99diRqvqZk9muoO8ZF4eUUMP/5Ua+mXClWA35s+POS6yTJrsFPwrJz+
 cM7pYI9fulZGb1LVAnxq27bJR3AaLdbEsE4P5haSQNgi0V0Mh28cY/wEacu2MRiG7NvnFxc+x
 8TIXF4DBnyNnv8jOmtkGTfOKlCcvQnR4J+oh8Vtp459QvDO3rGcWc1AGR1IPwjyT50XSS3VR2
 B7/HNGfrnBFeiqEfvmz+e1TwHznJDsTFNa2PTfjh0e3z0wqLAreht+MlcFoISSgKETCNcdJhY
 378QtY91hzcKzat+4kHeGsq/dGy8uzjqJTepaKJFyoBkM9ZvLW/bCowAvUYZdl3Hy/VJHONB1
 5gZfV8lE5CDynHFSpDYKzbPuQHCc3dZ/Aju0A/Mmuss+HJygnabm37a1Y5joD+/zch5YeehTf
 k0+7i8ELA8ASlNL9e58PPPos4+lgPi78XRBZbHZ0uwLMS9MJl12Bwq6cJ799NDSoBNXJapmfz
 9KPRYgR1OFKg9LSLIz6wLpETayxOFcD0CxlNKVKvaoN6NpjICpTImFwRBsf4COXV8UPWM4R+E
 SJP6QfiPkjP0JGyFQzVCqiCagV8pdNlwahDp7tODe1KbJFS0goSZBVWs8r0uYnW0DVXaBAGh3
 EICMUtSprDwHaR+AloPUW8Ra6ngCNhCyu+VcBhBbjjQGxs5CDQksdQUdEYgGdK+wa+7FXxFKk
 VdOQlWAxgq6NFRas28wxZmZKiJu7cNeqyAzWoufPrLetgvQ3l+zAdxOBumVKoJGEs2wrsTfAx
 iFZDjKY5bQUk1iAAiVZHYWr0SLM8SlY8u7J18msdM6iRv8Xg+bG5t4a//wlAYrMzs1MS0ALVs
 Tj3qoYk/KWnHFUVVg3h2U10q76AkiMaBO3OeakA8+WJJpSer5YuLJm5PtUwQkknRxx7XZe99Z
 x66jqTHfYLKBRUnifsBLBcv8rdDLDDHf2vofJmzUTKUhupHuUuOeWTM8wbq7jw6805Cz9USj+
 /942CydVIXV2AafeVEPUm1hHx3wbdK2S8htiYNjoRmsJoOFPWZEdsPBD91x8OTDWG7iu9sAm8
 C2JokM1mtSHkutkn75y22/U+jB5+nK2NzE4tkNg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stu Hsieh <stu.hsieh@mediatek.com>

Test: build pass and run ok

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
=2D--
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 42 +++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  2 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm=
/mediatek/mtk_drm_ddp_comp.c
index 57c88de9a329..a5f2ff6bea93 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -13,6 +13,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/soc/mediatek/mtk-cmdq.h>
+#include <drm/drm_print.h>
+
 #include "mtk_drm_drv.h"
 #include "mtk_drm_plane.h"
 #include "mtk_drm_ddp_comp.h"
@@ -412,6 +414,22 @@ static const struct mtk_ddp_comp_match mtk_ddp_matche=
s[DDP_COMPONENT_ID_MAX] =3D {
 	[DDP_COMPONENT_WDMA1]	=3D { MTK_DISP_WDMA,	1, NULL },
 };

+static bool mtk_drm_find_comp_in_ddp(struct mtk_ddp_comp ddp_comp,
+					 const enum mtk_ddp_comp_id *path,
+					 unsigned int path_len)
+{
+	unsigned int i;
+
+	if (path =3D=3D NULL)
+		return false;
+
+	for (i =3D 0U; i < path_len; i++)
+		if (ddp_comp.id =3D=3D path[i])
+			return true;
+
+	return false;
+}
+
 int mtk_ddp_comp_get_id(struct device_node *node,
 			enum mtk_ddp_comp_type comp_type)
 {
@@ -427,6 +445,30 @@ int mtk_ddp_comp_get_id(struct device_node *node,
 	return -EINVAL;
 }

+unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
+						struct mtk_ddp_comp ddp_comp)
+{
+	struct mtk_drm_private *private =3D drm->dev_private;
+	unsigned int ret;
+
+	if (mtk_drm_find_comp_in_ddp(ddp_comp, private->data->main_path,
+		private->data->main_len) =3D=3D true) {
+		ret =3D BIT(0);
+	} else if (mtk_drm_find_comp_in_ddp(ddp_comp,
+		private->data->ext_path,
+		private->data->ext_len) =3D=3D true) {
+		ret =3D BIT(1);
+	} else if (mtk_drm_find_comp_in_ddp(ddp_comp,
+		private->data->third_path,
+		private->data->third_len) =3D=3D true) {
+		ret =3D BIT(2);
+	} else {
+		DRM_INFO("Failed to find comp in ddp table\n");
+		ret =3D 0;
+	}
+	return ret;
+}
+
 int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 		      struct mtk_ddp_comp *comp, enum mtk_ddp_comp_id comp_id,
 		      const struct mtk_ddp_comp_funcs *funcs)
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm=
/mediatek/mtk_drm_ddp_comp.h
index debe36395fe7..1d9e00b69462 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -202,6 +202,8 @@ static inline void mtk_ddp_ctm_set(struct mtk_ddp_comp=
 *comp,

 int mtk_ddp_comp_get_id(struct device_node *node,
 			enum mtk_ddp_comp_type comp_type);
+unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
+						struct mtk_ddp_comp ddp_comp);
 int mtk_ddp_comp_init(struct device *dev, struct device_node *comp_node,
 		      struct mtk_ddp_comp *comp, enum mtk_ddp_comp_id comp_id,
 		      const struct mtk_ddp_comp_funcs *funcs);
=2D-
2.25.1

