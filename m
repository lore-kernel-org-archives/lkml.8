Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBCDC3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AA72073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ap2KuNpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCFB0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 20:26:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCFB0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IM09bFbw6S6+4rViw6K0nGdpnibTrR4TbK4+sNqEqaE=; b=ap2KuNpTbN4wNm2smPXvg8YbIC
        vdyY8aGhH9unHqXeICUoT2h+XOA7GvY3doIkQeJI0mb8ra8bwcc0upvOCigEgqssNzCdP96S9q/cv
        un5ttP0FFsLgChnZ0PMbEdyKdGF+kO45lDaDj15jaHpWNHn7VU0dPgC86MjpRdVd3LfxgfejoS6WF
        5GU52FbqMXnjBDAB6stdsEbSGavDiA9CdQ9Xe0wUvIrjSBh3EGWMBwZH1WjJ+C4WDNOnYtdkISt0+
        c35dMt2YmVv/tDeqQBqEHY99BKe5EZw23ozqcW/BmWR9l+mmpXAdItVamP7wz2d6zjD/IV+vLKJFY
        HyGueXQg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jA1kg-0007Xt-Pa; Fri, 06 Mar 2020 01:26:10 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] drm: unbreak the DRM menu, broken by DRM_EXPORT_FOR_TESTS
Message-ID: <04221997-79ba-f8a2-4f2d-3c3d9f5219bc@infradead.org>
Date:   Thu, 5 Mar 2020 17:26:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Unbreak the DRM menu. This Kconfig symbol does not depend on DRM,
so the menu is broken at that point.

Move the symbol to a location in the Kconfig file so that it does
not break the dependency continuity.

Fixes: 6349120ddcbf ("drm: Move EXPORT_SYMBOL_FOR_TESTS_ONLY under a separate Kconfig")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200305.orig/drivers/gpu/drm/Kconfig
+++ linux-next-20200305/drivers/gpu/drm/Kconfig
@@ -54,9 +54,6 @@ config DRM_DEBUG_MM
 
 	  If in doubt, say "N".
 
-config DRM_EXPORT_FOR_TESTS
-	bool
-
 config DRM_DEBUG_SELFTEST
 	tristate "kselftests for DRM"
 	depends on DRM
@@ -470,6 +467,9 @@ config DRM_SAVAGE
 
 endif # DRM_LEGACY
 
+config DRM_EXPORT_FOR_TESTS
+	bool
+
 # Separate option because drm_panel_orientation_quirks.c is shared with fbdev
 config DRM_PANEL_ORIENTATION_QUIRKS
 	tristate

