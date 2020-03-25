Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE0C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E31D20740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6hHy5wH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgCYPyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:54:46 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:47078 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgCYPyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:54:45 -0400
Received: by mail-il1-f194.google.com with SMTP id e8so2291273ilc.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgFZGosUzS1oRzHI3pEsbboLFH1t4gask+/mwdj4L+I=;
        b=I6hHy5wHrSUflD+HabqizxDRQpER6XZk3XdQ5yVAq2IDa5d2gkKDpanLanQ+WKLJaE
         akCkkmoSQxm4KaKw/AFFZjYla0EnxMDxzNWlogb8m4l8KqXJZqDOWqL/ZB5vyaR7FcJY
         SBqMVn7GTQwtqkvkowNDvB+91Z6qymjyneLUkE63g+5ljRVkfXGeLE9UiCKHmu9a+glt
         Y5cXSP9Rt2dbWNp08O4TqYj54JltA4a40YrRjlhBSLVRwuf9M/D14/gJ1qENE1TNSIxR
         nCXAt3EtgxioDibapL20nokFrQf0FBmcXrFsO2zo8vpVKukYi2hqCWFbkiOCAm5zKaLk
         k5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgFZGosUzS1oRzHI3pEsbboLFH1t4gask+/mwdj4L+I=;
        b=Ht9/DOlYIzRVum8vVL+rCDcvf0qbJoeT9JIRZGhj3d2XDmN3MykxyN3gLF7BNixXcd
         KX8g5scdFosNz6GYfehuC1tyCDAvdi/H/HF/vBlEqhjsAuZC4DU6n0nJHMtdRcTCM6TS
         DT6BviwIL0kjE9rrevGjj1ZqAxpwLhxbkVy6UtYIiVBghv9mue/n1ZJb07onEwS+UL25
         17hyeVRef72BW1fAZQSCGacoWIvgEREz2CCivML0Xp4mbTvHCiwkO7vWPiTlMiWm81yh
         LIrKFLBMgRF1LxiJ+SYDjBDsMhqEYCXUCyZHekbj/CKDDo6vS7m/R1KyjjAZu2C80qkZ
         CObw==
X-Gm-Message-State: ANhLgQ1W/jkgl6LNdd+MzaIeFaO4WtgqTz5QRUqQetAZLvVuPP1RkI6A
        Q3c4wlYWWVaImlDHlFsGWkwU8EXDxT8MOJi3WpM=
X-Google-Smtp-Source: ADFU+vtvtw4AQGOn9J2uCj7jrI/UUoKGmw88Il70Pyfg1OV8qDvGwy2+dBYFXBNoSyFlQetEKWD8GMqIB692DvzdovE=
X-Received: by 2002:a92:c14a:: with SMTP id b10mr4275397ilh.139.1585151684694;
 Wed, 25 Mar 2020 08:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200325090741.21957-1-bigbeeshane@gmail.com> <20200325090741.21957-4-bigbeeshane@gmail.com>
 <14063C7AD467DE4B82DEDB5C278E8663FFFBD48B@fmsmsx107.amr.corp.intel.com>
In-Reply-To: <14063C7AD467DE4B82DEDB5C278E8663FFFBD48B@fmsmsx107.amr.corp.intel.com>
From:   Shane Francis <bigbeeshane@gmail.com>
Date:   Wed, 25 Mar 2020 15:54:33 +0000
Message-ID: <CABnpCuD-A20o3cQrPb+LwbsSRTGPwwdCAYYsSjeCdmimNMYyYA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/radeon: fix scatter-gather mapping with user pages
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx-request@lists.freedesktop.org" 
        <amd-gfx-request@lists.freedesktop.org>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >-----Original Message-----
> >From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
> >Shane Francis
> >Sent: Wednesday, March 25, 2020 5:08 AM
> >To: dri-devel@lists.freedesktop.org
> >Cc: airlied@linux.ie; linux-kernel@vger.kernel.org; bigbeeshane@gmail.com;
> >amd-gfx-request@lists.freedesktop.org; alexander.deucher@amd.com;
> >christian.koenig@amd.com
> >Subject: [PATCH v4 3/3] drm/radeon: fix scatter-gather mapping with user
> >pages
> >
> >Calls to dma_map_sg may return segments / entries than requested
>
> "may return less segment..." ?
>                        ^^^

I will reword / fix the highlighted issues with the text and send a updated
patch set later today.

>
> >if they fall on page bounderies. The old implementation did not
> >support this use case.
> >
> >Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
> >---
> > drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c
> >b/drivers/gpu/drm/radeon/radeon_ttm.c
> >index 3b92311d30b9..b3380ffab4c2 100644
> >--- a/drivers/gpu/drm/radeon/radeon_ttm.c
> >+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> >@@ -528,7 +528,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt
> >*ttm)
> >
> >       r = -ENOMEM;
> >       nents = dma_map_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents,
> >direction);
> >-      if (nents != ttm->sg->nents)
> >+      if (nents == 0)
> >               goto release_sg;
>
> This looks correct to me.
>
> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
>
> M
> >       drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
> >--
> >2.26.0
> >
> >_______________________________________________
> >dri-devel mailing list
> >dri-devel@lists.freedesktop.org
> >https://lists.freedesktop.org/mailman/listinfo/dri-devel
