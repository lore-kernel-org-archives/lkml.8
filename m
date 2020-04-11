Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B4EC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB4C206F7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648802;
	bh=Wzja1lnSxcvyujKbql1QcN7eEshT9Y47jqXMe56SKFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SliEeBOAQ68lBJYNObMoY6GWrko0w0mYZEPC4+UvEP7krJX5Ez1gwqVcfhebD+8XT
	 yO0fgfPlM9Se9bg40zHw7JuHWh3GlvmXhIPDQEpORcIuHjQdAFgyuASfGgWqPyonJs
	 8qaatWUT76etRCNbopip2Augh4RpPMnUHdWcv1xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgDKXqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbgDKXFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:05:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2DC120CC7;
        Sat, 11 Apr 2020 23:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646312;
        bh=Wzja1lnSxcvyujKbql1QcN7eEshT9Y47jqXMe56SKFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wYadVdE0IIv28LOhnz4KFnzZ8/wKw88T5ms6OgC4zp1Ic2TSlrCacSWflBqyGMxbH
         VIFjK6UbufK5UXdlpWUoVvZwJvunPb/yYwRK3GSmZcrOwBdWpPtS4nApViKClmt3Gq
         iCWaC4AcuKw/sDg57WQxe1jnRW3n6bHLzvQiJsOg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        dri-devel@lists.freedesktop.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 069/149] drm/omap: fix possible object reference leak
Date:   Sat, 11 Apr 2020 19:02:26 -0400
Message-Id: <20200411230347.22371-69-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit 47340e46f34a3b1d80e40b43ae3d7a8da34a3541 ]

The call to of_find_matching_node returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c:212:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 209, but without a corresponding object release within this function.
drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c:237:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 209, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1554692313-28882-2-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
index 31502857f013d..ce67891eedd46 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
@@ -192,7 +192,7 @@ static int __init omapdss_boot_init(void)
 	dss = of_find_matching_node(NULL, omapdss_of_match);
 
 	if (dss == NULL || !of_device_is_available(dss))
-		return 0;
+		goto put_node;
 
 	omapdss_walk_device(dss, true);
 
@@ -217,6 +217,8 @@ static int __init omapdss_boot_init(void)
 		kfree(n);
 	}
 
+put_node:
+	of_node_put(dss);
 	return 0;
 }
 
-- 
2.20.1

