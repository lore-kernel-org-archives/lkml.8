Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE7EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5248220656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704473;
	bh=B57KRccJ758jF0xN74+wxNnwCOVOgwAYcSyGiizN5Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N7IlNqEnzSc7FAyYqNkOM8J7LicQNM2w2oP3sn9YOZf/ADTOve09q+ObDQd4LGe06
	 MD41OGF2LeX5QX0mlQh//5KBB8reh12jUhytFsB2yXlt5faQTAupPyCjyEGjjjUYur
	 vJSEtAtLXg6siN/PkOQcvGEoOLPRrUaesLGf9CC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394861AbgBNSVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:21:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730236AbgBNPtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:49:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 859B824684;
        Fri, 14 Feb 2020 15:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695390;
        bh=B57KRccJ758jF0xN74+wxNnwCOVOgwAYcSyGiizN5Pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vqq2TmAjXjUtP/FovRlWLuH3fstmwyv6yUFJULiR0qvmyBqP7fRu76ebMcSXVz9PU
         kBq/+7ev9O5wuTvjeCCN6qyGwe6u0fm8uAyZJzuKi3vARy96MEs8KeKFuPN512774Q
         0Guyk4wWWgdjl1htNGrQeeTq7cmw83Y0f1rkegWY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 043/542] media: sun4i-csi: Deal with DRAM offset
Date:   Fri, 14 Feb 2020 10:40:35 -0500
Message-Id: <20200214154854.6746-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 249b286171fa9c358e8d5c825b48c4ebea97c498 ]

On Allwinner SoCs, some high memory bandwidth devices do DMA directly
over the memory bus (called MBUS), instead of the system bus. These
devices include the CSI camera sensor interface, video (codec) engine,
display subsystem, etc.. The memory bus has a different addressing
scheme without the DRAM starting offset.

Deal with this using the "interconnects" property from the device tree,
or if that is not available, set dev->dma_pfn_offset to PHYS_PFN_OFFSET.

Fixes: 577bbf23b758 ("media: sunxi: Add A10 CSI driver")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/sunxi/sun4i-csi/sun4i_csi.c      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
index f36dc6258900e..b8b07c1de2a8e 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -155,6 +156,27 @@ static int sun4i_csi_probe(struct platform_device *pdev)
 	subdev = &csi->subdev;
 	vdev = &csi->vdev;
 
+	/*
+	 * On Allwinner SoCs, some high memory bandwidth devices do DMA
+	 * directly over the memory bus (called MBUS), instead of the
+	 * system bus. The memory bus has a different addressing scheme
+	 * without the DRAM starting offset.
+	 *
+	 * In some cases this can be described by an interconnect in
+	 * the device tree. In other cases where the hardware is not
+	 * fully understood and the interconnect is left out of the
+	 * device tree, fall back to a default offset.
+	 */
+	if (of_find_property(csi->dev->of_node, "interconnects", NULL)) {
+		ret = of_dma_configure(csi->dev, csi->dev->of_node, true);
+		if (ret)
+			return ret;
+	} else {
+#ifdef PHYS_PFN_OFFSET
+		csi->dev->dma_pfn_offset = PHYS_PFN_OFFSET;
+#endif
+	}
+
 	csi->mdev.dev = csi->dev;
 	strscpy(csi->mdev.model, "Allwinner Video Capture Device",
 		sizeof(csi->mdev.model));
-- 
2.20.1

