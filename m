Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436C3C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E351B206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599732933;
	bh=AcUbWjUNABtsxL784pj65r84bPoExG1gWe7wAJecyfQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ep7e5YG5HReudZ7UFfU+MVZRwfXR3mBFIjt3QFyfHsrtZWtsZsCihQdz/JLXHkN86
	 ecfAnDVDMD7RkSg5uEL3THJAugaBZmCZAR8WTo53Ffc6mrt7Gw232sc/HJKdu911EB
	 R7sn9/hjDwdlOP/3XFpAzGCeX03J1DHQaJqAseKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgIJKPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbgIJKOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:14:52 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD94321556;
        Thu, 10 Sep 2020 10:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599732891;
        bh=AcUbWjUNABtsxL784pj65r84bPoExG1gWe7wAJecyfQ=;
        h=Date:From:To:Cc:Subject:From;
        b=qVf8Rc8AqGxyxVKw4/gDV9LstyBxSyBmcuGudVr7FlLI/lyuwQOLYen1OarGXTy6O
         S2J5ptH/XTuXwqPaNYGmTjAhonpEwLAHD0Xok6FNUA+cqRtCTTGHF9jMdvMr9NYRBy
         9XqcLvm2eqp5zVZqKKlIT0MKhMUc20/LehslBQGc=
Date:   Thu, 10 Sep 2020 05:21:20 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] drm/i915: Fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20200910102120.GA9481@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in i915_gem_object_copy_blt().

The proper pointer to be passed as argument to PTR_ERR() is vma[1].

This bug was detected with the help of Coccinelle.

Fixes: 6b05030496f7 ("drm/i915: Convert i915_gem_object/client_blt.c to use ww locking as well, v2.")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_object_blt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_blt.c b/drivers/gpu/drm/i915/gem/i915_gem_object_blt.c
index d93eb36160c9..aee7ad3cc3c6 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object_blt.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object_blt.c
@@ -364,7 +364,7 @@ int i915_gem_object_copy_blt(struct drm_i915_gem_object *src,
 
 	vma[1] = i915_vma_instance(dst, vm, NULL);
 	if (IS_ERR(vma[1]))
-		return PTR_ERR(vma);
+		return PTR_ERR(vma[1]);
 
 	i915_gem_ww_ctx_init(&ww, true);
 	intel_engine_pm_get(ce->engine);
-- 
2.27.0

