Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C3AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0729F2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgEVCrR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 22:47:17 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:64489 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727004AbgEVCrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 22:47:17 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21254549-1500050 
        for multiple; Fri, 22 May 2020 03:47:00 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200521233841.1279742-1-jhubbard@nvidia.com>
References: <20200521233841.1279742-1-jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] mm/gup: fixup gup.c for "mm/gup: refactor and de-duplicate gup_fast() code"
Message-ID: <159011561851.32320.15372940900085926477@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Fri, 22 May 2020 03:46:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting John Hubbard (2020-05-22 00:38:41)
> Include FOLL_FAST_ONLY in the list of flags to *not* WARN()
> on, in internal_get_user_pages_fast().
> 
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Hi Andrew, Chris,
> 
> Andrew: This is a fixup that applies to today's (20200521) linux-next.
> In that tree, this fixes up:
> 
> commit dfb8dfe80808 ("mm/gup: refactor and de-duplicate gup_fast() code")
> 
> Chris: I'd like to request another CI run for the drm/i915 changes, so
> for that, would you prefer that I post a v2 of the series [1], or
> is it easier for you to just apply this patch here, on top of [2]?

If you post your series again with this patch included to intel-gfx, CI
will pick it up. Or I'll do that in the morning.
-Chris
