Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7EDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF612085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591661144;
	bh=zoPUu6VReNltlF5ukysiF0rm/a/PTQJdp5lkU8Ej1aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WsiIDjhBGYcNpvQXklhWnX+lpCJPSgqhvh3OHx61EDCuG93jKmfqK2S49WpQAqs8R
	 jHXcQ9XrsmM/WY4tM9/CACOJIwlS+f3IDxNZDfwCR0O4jy7tVF+rDnfcFXAmGVlXDI
	 ikDSbG+He3lOcPQOayEnfbJH3fSDtqy3Ge+Z78RQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732854AbgFIAFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731143AbgFHXVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:21:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5339208E4;
        Mon,  8 Jun 2020 23:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658484;
        bh=zoPUu6VReNltlF5ukysiF0rm/a/PTQJdp5lkU8Ej1aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iY1RAlN8cbwG2DvvR3nB1OfZQz32t9PovdFg0Orw3sD/syaYwrFSmI1fHL/ehUPKx
         BPxTpWodj9yqlwObAYszxHokHOQMYfF0wWpX+H4veQsyBRLNY793wSkTGRfnIVFPFP
         pxgDUpLtSvjagckBbEI2D1BFp2z0W9rqFyJl2UK8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 119/175] drm/mcde: dsi: Fix return value check in mcde_dsi_bind()
Date:   Mon,  8 Jun 2020 19:17:52 -0400
Message-Id: <20200608231848.3366970-119-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 761e9f4f80a21a4b845097027030bef863001636 ]

The of_drm_find_bridge() function returns NULL on error, it doesn't return
error pointers so this check doesn't work.

Fixes: 5fc537bfd000 ("drm/mcde: Add new driver for ST-Ericsson MCDE")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200430073145.52321-1-weiyongjun1@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mcde/mcde_dsi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_dsi.c
index 35bb825d1918..8c8c92fc82e9 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -940,10 +940,9 @@ static int mcde_dsi_bind(struct device *dev, struct device *master,
 			panel = NULL;
 
 			bridge = of_drm_find_bridge(child);
-			if (IS_ERR(bridge)) {
-				dev_err(dev, "failed to find bridge (%ld)\n",
-					PTR_ERR(bridge));
-				return PTR_ERR(bridge);
+			if (!bridge) {
+				dev_err(dev, "failed to find bridge\n");
+				return -EINVAL;
 			}
 		}
 	}
-- 
2.25.1

