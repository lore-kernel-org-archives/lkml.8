Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24761C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFEE2065E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PqTJVT5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgG1LSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:18:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:41917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbgG1LSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595935101;
        bh=RjztiQu8bvOyUz2B8+6Y6utG8fBygRMWzsrfRLxaT28=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PqTJVT5/1DKAUPspO4Fwvu8KXxLwmZT9gxvwKOC/sayrFfCYOGUrAt1kKuLyuV+/2
         rmV1oZj9libk8OmI/vr47fgm+vwLQ9bE5YsWg4W6ypd68ap6fz8Ixo+NsECqvMjLde
         DmhoS6b7PQ36PJy1dHsMVQb+2gyklriznJ4flhAk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([80.208.215.239]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mr9Bu-1kX1XH0BMs-00oDrD; Tue, 28 Jul 2020 13:18:21 +0200
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
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v2 1/5] drm/mediatek: config component output by device node port
Date:   Tue, 28 Jul 2020 13:17:56 +0200
Message-Id: <20200728111800.77641-2-frank-w@public-files.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200728111800.77641-1-frank-w@public-files.de>
References: <20200728111800.77641-1-frank-w@public-files.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YvbDIbRpFNRzU9CUvTdpvNUkk08xUKy8rbwWD1rLNM8UXAoQuK4
 eICt8UcylHTRfOGkjEX9jjTApIMznChQZ6JLB0JrsjiMAAUXmWoZWVa1uKNNAGYRlIyVrTC
 IKSqIDP+H57GVEHxo0RDq9SNxAHZIaXwDCy1xq9aaTm2FrJdcG2UEvxzlv5POKDx0mQCuV4
 VCgz/4H4bnhMAao7exzPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5JI92cNImiA=:IU9/AVKV/YriZTpTu1OE0e
 O8SnTBpFQJaIKnhNf0ENVS71qiHFJW6fi77esT8+iPhPmyguNpqEi200P15DE396vcSD6HaRy
 jkK+um62hHmvGVD413t3Td/MBamGeZ0K/OHMaCWx9ZlhRNV3p5ddO85KGWDGbKGl3mIQy1ZDO
 gYTMhu1k/shkkXPexV8oBEFwrK1sjylI3UcDJhmVj0v7MvmpjrGSfLohzyhggLMiQrWtSXj1s
 F5lH69pJPnG6XDc6RTp9zCPFR+88z8jqreyd0iU6HGsgSLtteanA1+aosO8ehasnE2LmJs3cq
 XCQhAot6d9BA5lrJCOx3xPDXpsXRDODPrBq51F3FjzrYm0r+R+673O9haC0BJ3bgICsF0xtcB
 r68CTlvnknBcp8o/Xlu4r4mQwOP/IXmr3LOV1iBVAy3JR9UVdyiaAwDpLH0ZjmHhNBSf+kYec
 dil9AXhKdCT17ayWhX6puhITR3fzJONhT9CXwjhzytz+YkWf0A1sLUmXZMriF5HnHqmKo2pBz
 aXWk5rIooPqsAiK4rTMuZ09SbaOSfOUswgDpAdQw/UCtzfRf5HPXFDOoXiNqi988wHVgPH39d
 reopSpTbdHOZL5aeLq4WRU2g35bhX4O8jNUsrcK3R8N/USycjc62YiM/EFptwkec+4eMjw9h1
 nbFEDDoYSLOsPoTl9rzfWc1aiIRq0+Bx+rrfaf23uQPdhRmi8/YF0ZAnar8dhSEhz5Jmct+0I
 lzyhaHfFgFGPBm2i2iEsyUqzSTPEy2q1nYqtCAFMSB60D6oBkWAbWgtVo0n8KvX9Q7fRmKWo4
 9rFBYULsOB0q4GS4C1aZNkk64O39OnVdqHUOOoSVcM7LQU9XVlE35S4gDtIZdqe1EZ8z+smv5
 /+v2VHEZ4IpAf8jQzlxuEyPHyG2CtXV3AMEoA4e+/Xxxq5IL9Ve3rWkrmwxkPm8+/76Zh67e+
 +1ZrOvHoyORJHbaEJSnK3KI6l4bQuCAaMDeqcIp/GX2d8au/zlPDwHGAXlrwwhBBTZIiQ1fht
 6Hu95C5tCaeveDCNyggV4YE4oP2zSdyO+ItSIBCDFQgWj+QA3SvJGu47HvP2JOIHMXjfwmXXR
 L4G2ac3jJFcKw0n5l7Gfty4KURDLrGVL0M9vLkoIH87wz83fAxHjWg2jzQjo3foq1YKgx+XB7
 bV2ZZh1PhCqVaiMTzK6lP4oD/Okofix7b7Ru49cLd353NNBLHoYRY/S8u6Ae6RmYx+SKuRWv6
 8/3j9uIxIhbIUCnAws/QvGWYwSOpixhywPWcY6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bibby Hsieh <bibby.hsieh@mediatek.com>

We can select output component by decive node port.
Main path default output component is DSI.
External path default output component is DPI.

without this Patch i get this warning:

WARNING: CPU: 3 PID: 70 at drivers/gpu/drm/drm_mode_config.c:621 drm_mode_=
config_validate+0x1d8/0x258

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>

added small fixes for warnings

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 46 ++++++++++++++++++++++----
 drivers/gpu/drm/mediatek/mtk_drm_drv.h |  4 +--
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/medi=
atek/mtk_drm_drv.c
index 6bd369434d9d..ce7abf2743d9 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -24,6 +24,13 @@
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
+#include <linux/component.h>
+#include <linux/iommu.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_graph.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>

 #include "mtk_drm_crtc.h"
 #include "mtk_drm_ddp.h"
@@ -61,7 +68,7 @@ static const struct drm_mode_config_funcs mtk_drm_mode_c=
onfig_funcs =3D {
 	.atomic_commit =3D drm_atomic_helper_commit,
 };

-static const enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] =3D {
+static enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] =3D {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_RDMA0,
 	DDP_COMPONENT_COLOR0,
@@ -69,12 +76,12 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_main[=
] =3D {
 	DDP_COMPONENT_DSI0,
 };

-static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] =3D {
+static enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] =3D {
 	DDP_COMPONENT_RDMA1,
 	DDP_COMPONENT_DPI0,
 };

-static const enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] =3D {
+static enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] =3D {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_COLOR0,
 	DDP_COMPONENT_AAL0,
@@ -84,7 +91,7 @@ static const enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] =
=3D {
 	DDP_COMPONENT_PWM0,
 };

-static const enum mtk_ddp_comp_id mt2712_mtk_ddp_ext[] =3D {
+static enum mtk_ddp_comp_id mt2712_mtk_ddp_ext[] =3D {
 	DDP_COMPONENT_OVL1,
 	DDP_COMPONENT_COLOR1,
 	DDP_COMPONENT_AAL1,
@@ -100,7 +107,7 @@ static const enum mtk_ddp_comp_id mt2712_mtk_ddp_third=
[] =3D {
 	DDP_COMPONENT_PWM2,
 };

-static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] =3D {
+static enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] =3D {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_COLOR0,
 	DDP_COMPONENT_AAL0,
@@ -111,7 +118,7 @@ static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[=
] =3D {
 	DDP_COMPONENT_PWM0,
 };

-static const enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] =3D {
+static enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] =3D {
 	DDP_COMPONENT_OVL1,
 	DDP_COMPONENT_COLOR1,
 	DDP_COMPONENT_GAMMA,
@@ -459,6 +466,7 @@ static int mtk_drm_probe(struct platform_device *pdev)

 	/* Iterate over sibling DISP function blocks */
 	for_each_child_of_node(phandle->parent, node) {
+		struct device_node *port, *ep, *remote;
 		const struct of_device_id *of_id;
 		enum mtk_ddp_comp_type comp_type;
 		int comp_id;
@@ -522,6 +530,32 @@ static int mtk_drm_probe(struct platform_device *pdev=
)

 			private->ddp_comp[comp_id] =3D comp;
 		}
+
+		if (comp_type !=3D MTK_DSI && comp_type !=3D MTK_DPI) {
+			port =3D of_graph_get_port_by_id(node, 0);
+			if (!port)
+				continue;
+			ep =3D of_get_child_by_name(port, "endpoint");
+			of_node_put(port);
+			if (!ep)
+				continue;
+			remote =3D of_graph_get_remote_port_parent(ep);
+			of_node_put(ep);
+			if (!remote)
+				continue;
+			of_id =3D of_match_node(mtk_ddp_comp_dt_ids, remote);
+			if (!of_id)
+				continue;
+			comp_type =3D (enum mtk_ddp_comp_type)of_id->data;
+			for (i =3D 0; i < private->data->main_len - 1; i++)
+				if (private->data->main_path[i] =3D=3D comp_id)
+					private->data->main_path[i + 1] =3D
+					mtk_ddp_comp_get_id(node, comp_type);
+			for (i =3D 0; i < private->data->ext_len - 1; i++)
+				if (private->data->ext_path[i] =3D=3D comp_id)
+					private->data->ext_path[i + 1] =3D
+					mtk_ddp_comp_get_id(node, comp_type);
+		}
 	}

 	if (!private->mutex_node) {
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/medi=
atek/mtk_drm_drv.h
index b5be63e53176..7fcaab648bf1 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -21,9 +21,9 @@ struct drm_property;
 struct regmap;

 struct mtk_mmsys_driver_data {
-	const enum mtk_ddp_comp_id *main_path;
+	enum mtk_ddp_comp_id *main_path;
 	unsigned int main_len;
-	const enum mtk_ddp_comp_id *ext_path;
+	enum mtk_ddp_comp_id *ext_path;
 	unsigned int ext_len;
 	const enum mtk_ddp_comp_id *third_path;
 	unsigned int third_len;
=2D-
2.25.1

