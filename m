Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46431C47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C74206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="sE1pIwLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgEDPAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:00:30 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.9]:31229 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727786AbgEDPA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:00:28 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 1CD58B2C372
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:00:26 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Vca1jJn41EfyqVca2j7oNe; Mon, 04 May 2020 10:00:26 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+1JYBdusNEcbfurXrebTZTOPT2a0N++LhWMXr79SGeg=; b=sE1pIwLxvKhX30ejPg28L6ami+
        g0vB8HKkCvGgT29H+zyump16lqlpqZRFS39S51Od7vXiOTcbVL+5tBXKEIVlsOfTvs9L9OKWn9Npn
        7cful0T6ESyw28FAh6q7IXZSZpJYdKlfDTTVfKDAKePEEHgog7P5Ra3luXvgE016QpfbiO3jvZqvs
        1zXhpGu9OLZniUEetyYACoHPk1Qk8u/C/8Sjttz3VdJVyN1vzx1O4QGsVIbVSsXlpZkRN0uNvuz+2
        fqGSbAFdu9Ur1oTdeK2mJFeCa706ViUEhs6k3NMlBsHaA3lSSkg42rdfxxLCnuanV76gvbkOZyTRS
        wUBaeR4g==;
Received: from [189.207.59.248] (port=60830 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jVca1-003k6N-Cu; Mon, 04 May 2020 10:00:25 -0500
Date:   Mon, 4 May 2020 10:04:50 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] drm/i915/gem: Fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20200504150450.GA20991@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.207.59.248
X-Source-L: No
X-Exim-ID: 1jVca1-003k6N-Cu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.207.59.248]:60830
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in __reloc_gpu_alloc().

The proper pointer to be passed as argument is ce.

This bug was detected with the help of Coccinelle.

Fixes: 6f576d6277ce ("drm/i915/gem: Try an alternate engine for relocations")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index cce7df231cb9..78fdbfd068d3 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1325,7 +1325,7 @@ static int __reloc_gpu_alloc(struct i915_execbuffer *eb,
 
 		ce = intel_context_create(engine);
 		if (IS_ERR(ce)) {
-			err = PTR_ERR(rq);
+			err = PTR_ERR(ce);
 			goto err_unpin;
 		}
 
-- 
2.26.0

