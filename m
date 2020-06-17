Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D730EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CAC21897
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592431093;
	bh=1vD+OrQ4Alve7L6hWTCBhaaxl02dnjxL2N2pS8QwJ8o=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ZVa/HxUpX2fFkHMcu+rETBl14+acyTT9UWEzLJgsjYNdw3au5bG3LIN9P1Y7rrTgU
	 3K/ga9o++VvuSj3fRtjfW7VfSbKhPwN6IJp4KCA9KWzCaHDJQgFzdM5TNGoodnxOtj
	 PSJ94euxI0i+T9uQpggFPNefp7Z/etZmFTcQRXvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFQV6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgFQV6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:58:11 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90F5021852;
        Wed, 17 Jun 2020 21:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592431091;
        bh=1vD+OrQ4Alve7L6hWTCBhaaxl02dnjxL2N2pS8QwJ8o=;
        h=Date:From:To:Cc:Subject:From;
        b=Rya8g3eaFsy3zINxuvjwWV9rqrgchkU9YFOvHE9ExKi6MI882XFhasmZp8VrqffLb
         t8zaVYf2Ma0+bbRmjPUIOI4r10FqBsADe2mrcbcP9QTrS6j+G2NMOZja+fDf5UynP0
         JLBihE/Ij4cRleCfGKtXHB/O+Ejo8yAGXJOVnWHM=
Date:   Wed, 17 Jun 2020 17:03:31 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] drm/i915/query: Use struct_size() helper
Message-ID: <20200617220331.GA19550@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/i915/i915_query.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i915_query.c
index e75c528ebbe0..c1ebda9b5627 100644
--- a/drivers/gpu/drm/i915/i915_query.c
+++ b/drivers/gpu/drm/i915/i915_query.c
@@ -109,8 +109,7 @@ query_engine_info(struct drm_i915_private *i915,
 	for_each_uabi_engine(engine, i915)
 		num_uabi_engines++;
 
-	len = sizeof(struct drm_i915_query_engine_info) +
-	      num_uabi_engines * sizeof(struct drm_i915_engine_info);
+	len = struct_size(query_ptr, engines, num_uabi_engines);
 
 	ret = copy_query_item(&query, sizeof(query), len, query_item);
 	if (ret != 0)
-- 
2.27.0

