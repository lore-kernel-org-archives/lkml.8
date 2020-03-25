Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE8AC54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2B320409
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov3F0xX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgCYQIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:08:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39883 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgCYQIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:08:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id a9so3345957wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixbROLOmeLq0mO6PeYIhR3XCaB7opkScZZtzUhky/AU=;
        b=Ov3F0xX7WSaaviMCXK0Dc2jrJMmWPM2VVdqHBzQZJGmP6HtdrGenkjnmRVyigWy17E
         HXPW/SLWbeXv4klht679yeL3jmXHl15tKHIGwN5hWbrY+TkDUX7dpGG1n9mLD5tI0Vrs
         6eX19Y8vn/EeDYvEJpevNchth9OA1mwqPdvYVQ1fgF5hgFpUTiZF0EwZCkGlHga8qD+F
         QecnjvDt1IFv5iNA15MRo0FBW7GDAudi+PHFdwjogaeGVb5/4wcV+IhiGpNq7P01ie98
         kDHnVp5Am0xQtI8ieiift6CbcLHmPAgMwyNwhFWkHrO+anFH7o/TlkF0l6OgtsOHpX8X
         VkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixbROLOmeLq0mO6PeYIhR3XCaB7opkScZZtzUhky/AU=;
        b=i9D7wT3NcJ5r5vl+5C2eT+AbeRawYsUTXYFCuJPDLE5MMoLu4a0DQU7v3/WUlgQLbg
         QuwzPRbpQOUAvOPUyYeKoi96OsO99hRyFPieUl3T6DGqD7GwxE14lAI5+UCsNlMbbI4Z
         zsVUaheGnxNnnSgH0/7Fh9rQBQvFNBe0/ELy5jerKO3ugDRVU/I84r2oy4empeviKiEL
         MzrIHR2SyigYgwvJTtGwXjCkyZ+Wbz9XMxNDNEuZWqNrc6im04rliCTondOeb8kami4y
         wzUahRB/K32LQJBY1m5zD99A1dI+unMmBRGQddMlFA6URI/PXDnoFe4DVKhIUDdXXmNd
         YgFg==
X-Gm-Message-State: ANhLgQ32FHKPGKx5RSuaXHUQSS37psZ9X48r8oPupxfgWzrQCb4Xe4+3
        eb19Tlj/TYddQQgJyLFdNy5cmk3L+bBEjWNgNNg=
X-Google-Smtp-Source: ADFU+vttpgaM6WIjzO6/7c2r+BmhO3Fd/fDVy8h/NTwzqh3BMyNi1q8/25wBGAqNuGumuiOmNyPz8YdSkWE1Gr4REvc=
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr4136098wmb.39.1585152491439;
 Wed, 25 Mar 2020 09:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200325090741.21957-1-bigbeeshane@gmail.com> <20200325090741.21957-4-bigbeeshane@gmail.com>
 <14063C7AD467DE4B82DEDB5C278E8663FFFBD48B@fmsmsx107.amr.corp.intel.com> <CABnpCuD-A20o3cQrPb+LwbsSRTGPwwdCAYYsSjeCdmimNMYyYA@mail.gmail.com>
In-Reply-To: <CABnpCuD-A20o3cQrPb+LwbsSRTGPwwdCAYYsSjeCdmimNMYyYA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 25 Mar 2020 12:08:00 -0400
Message-ID: <CADnq5_Op0Yn9vtWkYdzhr8rz3FFJwVbhiBKBprvqSosVx8fmyA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/radeon: fix scatter-gather mapping with user pages
To:     Shane Francis <bigbeeshane@gmail.com>
Cc:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx-request@lists.freedesktop.org" 
        <amd-gfx-request@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 11:54 AM Shane Francis <bigbeeshane@gmail.com> wrote:
>
> > >-----Original Message-----
> > >From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
> > >Shane Francis
> > >Sent: Wednesday, March 25, 2020 5:08 AM
> > >To: dri-devel@lists.freedesktop.org
> > >Cc: airlied@linux.ie; linux-kernel@vger.kernel.org; bigbeeshane@gmail.com;
> > >amd-gfx-request@lists.freedesktop.org; alexander.deucher@amd.com;
> > >christian.koenig@amd.com
> > >Subject: [PATCH v4 3/3] drm/radeon: fix scatter-gather mapping with user
> > >pages
> > >
> > >Calls to dma_map_sg may return segments / entries than requested
> >
> > "may return less segment..." ?
> >                        ^^^
>
> I will reword / fix the highlighted issues with the text and send a updated
> patch set later today.

I'll fix it up locally when I apply it.  Thanks!

Alex

>
> >
> > >if they fall on page bounderies. The old implementation did not
> > >support this use case.
> > >
> > >Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
> > >---
> > > drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > >diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c
> > >b/drivers/gpu/drm/radeon/radeon_ttm.c
> > >index 3b92311d30b9..b3380ffab4c2 100644
> > >--- a/drivers/gpu/drm/radeon/radeon_ttm.c
> > >+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> > >@@ -528,7 +528,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt
> > >*ttm)
> > >
> > >       r = -ENOMEM;
> > >       nents = dma_map_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents,
> > >direction);
> > >-      if (nents != ttm->sg->nents)
> > >+      if (nents == 0)
> > >               goto release_sg;
> >
> > This looks correct to me.
> >
> > Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> >
> > M
> > >       drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
> > >--
> > >2.26.0
> > >
> > >_______________________________________________
> > >dri-devel mailing list
> > >dri-devel@lists.freedesktop.org
> > >https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
