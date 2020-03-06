Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E08C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E71220726
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFLFR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 06:05:17 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:50992 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726025AbgCFLFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 06:05:17 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20465561-1500050 
        for multiple; Fri, 06 Mar 2020 11:04:38 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
From:   Chris Wilson <chris@chris-wilson.co.uk>
User-Agent: alot/0.6
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <04221997-79ba-f8a2-4f2d-3c3d9f5219bc@infradead.org>
In-Reply-To: <04221997-79ba-f8a2-4f2d-3c3d9f5219bc@infradead.org>
Message-ID: <158349267722.20069.17505391287458085225@skylake-alporthouse-com>
Subject: Re: [PATCH] drm: unbreak the DRM menu, broken by DRM_EXPORT_FOR_TESTS
Date:   Fri, 06 Mar 2020 11:04:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Randy Dunlap (2020-03-06 01:26:10)
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Unbreak the DRM menu. This Kconfig symbol does not depend on DRM,
> so the menu is broken at that point.
> 
> Move the symbol to a location in the Kconfig file so that it does
> not break the dependency continuity.

I suspect it was me, thanks for fixing it!
 
> Fixes: 6349120ddcbf ("drm: Move EXPORT_SYMBOL_FOR_TESTS_ONLY under a separate Kconfig")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
