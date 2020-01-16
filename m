Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2059EC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CE2206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199527;
	bh=EAJbWnwBlpDDCXgh5JtZ8Bw4nWOjmpO5KaecW+klynY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j9PK6Nez97c+rO4PuLYdfw1gsgj83q8Mrdt4JRkE+9rBOCgGD3ypf8+qNjcE39Wsz
	 gAE9FRzfxMO2GHiRxXUlUx0f+ZHpdIJTsOMjHs6UFSS8+V/oY4xKfiKuVpTe3J6H7d
	 6j0fPMaHhPs/I+9/rJ4BiGVu5n97vN3sW5Ikcdg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391870AbgAPRZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:25:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391808AbgAPRYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:24:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1331E246B2;
        Thu, 16 Jan 2020 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195489;
        bh=EAJbWnwBlpDDCXgh5JtZ8Bw4nWOjmpO5KaecW+klynY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VZuWLbuA7Z63ZCvO0KxO97j3xYvWT/ERgtrbPiDJ4GHfryzhuQVOuZzBnJi/EII5G
         MIFGk96gxKmthAu5AfZqv7AzpGxXoifsb/oOw4+b4Jl6tvy3Gwzy1ID1NG6u+UegvR
         fpz2/wnidwJM9hby81rIK379gFayrdwFm5D9TjUw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH AUTOSEL 4.14 092/371] drm/etnaviv: potential NULL dereference
Date:   Thu, 16 Jan 2020 12:19:24 -0500
Message-Id: <20200116172403.18149-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 9e05352340d3a3e68c144136db9810b26ebb88c3 ]

The etnaviv_gem_prime_get_sg_table() is supposed to return error
pointers.  Otherwise it can lead to a NULL dereference when it's called
from drm_gem_map_dma_buf().

Fixes: 5f4a4a73f437 ("drm/etnaviv: fix gem_prime_get_sg_table to return new SG table")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index ae884723e9b1..880b95511b98 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -26,7 +26,7 @@ struct sg_table *etnaviv_gem_prime_get_sg_table(struct drm_gem_object *obj)
 	int npages = obj->size >> PAGE_SHIFT;
 
 	if (WARN_ON(!etnaviv_obj->pages))  /* should have already pinned! */
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	return drm_prime_pages_to_sg(etnaviv_obj->pages, npages);
 }
-- 
2.20.1

