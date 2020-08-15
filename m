Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56324C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E66D20658
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgHOW2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:28:42 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:50178 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgHOW2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:28:41 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 2ED4520027;
        Sat, 15 Aug 2020 16:09:41 +0200 (CEST)
Date:   Sat, 15 Aug 2020 16:09:39 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] drm/panel: A few cleanups and improvements
Message-ID: <20200815140939.GA1196814@ravnborg.org>
References: <20200811002240.55194-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811002240.55194-1-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=2LY2f65kBtWg6R36iiwA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Tue, Aug 11, 2020 at 02:22:35AM +0200, Paul Cercueil wrote:
> Hi list,
> 
> Here's a list of 5 patches that bring some cleanups and improvements.
> 
> Patches 1-2 clean up the novatek,nt39016 code to remove custom handling
> of the backlight and to add the missing carriage returns on error
> messages.
> 
> Patches 3-5 updates the modes list of the sharp,ls020b1dd01d panel, to
> make it use 'struct drm_display_mode' instead of 'struct
> display_timing', modify the timings to get a perfect 60.00 Hz rate, and
> add a 50 Hz mode.

While touching logging stuff in panle/ I made the same fix adding
newlines. Glad to see you did it so I can drop one of my patches.

All patches applied to drm-misc-next.

	Sam

> 
> Cheers,
> -Paul
> 
> Paul Cercueil (5):
>   drm/panel: novatek,nt39016: Handle backlight the standard way
>   drm/panel: novatek,nt39016: Add missing CR to error messages
>   drm/panel: simple: Convert sharp,ls020b1dd01d from timings to
>     videomode
>   drm/panel: simple: Tweak timings of sharp,ls020b1dd01d for perfect
>     60Hz
>   drm/panel: simple: Add 50Hz mode for sharp,ls020b1dd01d
> 
>  drivers/gpu/drm/panel/panel-novatek-nt39016.c | 34 ++++++----------
>  drivers/gpu/drm/panel/panel-simple.c          | 40 +++++++++++++------
>  2 files changed, 40 insertions(+), 34 deletions(-)
> 
> -- 
> 2.28.0
