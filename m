Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C628DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979D122CAF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iss3pKtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHEV2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgHEV2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 17:28:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879BFC061575;
        Wed,  5 Aug 2020 14:28:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r2so36943509wrs.8;
        Wed, 05 Aug 2020 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6WPDYUZ14+12fa9p20hCnFswNLhVf+R408Nanv/qE7c=;
        b=iss3pKtb89pua0CYNGxRySekijxQv/pPUrxBJlx6jTqI33/ZnSwpLiE60rAIo2FXFX
         qEwOjRxQ4dX+8uANPFm+Bf0AF3rp9zQK1DHFk5C/lc2+Lqrq0Y9YxdB2ciIUBtelBnik
         JPcBOB1N8QHiYlEGc5BJpCTjdlP9CywTNzZwOwywmePVc6xR8qMt6Lq1Je29GxwjC3on
         X/mN58ZVFndDnCsCQ81O1xMH5e/Ra8+hnNlH1gvQTxBaXRgGZPtT5z4U+5/rbmA/V1WM
         S3h5uYntwkBuGosWAPCqgFin1Ow3Hdcvkaagh0gbhppllYzgloPtGxVg1xSJD8vqYrGh
         vSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WPDYUZ14+12fa9p20hCnFswNLhVf+R408Nanv/qE7c=;
        b=a7aQtkvujQEb4zUO6VEIWcn9URX41HC5A/5WC7+wYKFl6BSuAsDEGrh40A++7C55Ss
         b6ui1Mv4bdU1btYzRJOW1PNjwQAl9j3vOFf/9hretFd26Ze1R6E0XLQU32FtH+MYujog
         R79yzSR1QjErB/MC6hnu69IwwSSbwScURXI8BBikMxNO4kNUwwn5tFgkFPyX1PgJSQgd
         t60G7/vQM7RHkWQnoCT3McFIdr7a6vw6V4co7r6zynxBDUu+414wKkpP5TmVUop6yuIf
         wlJXxpJAEa8uqzhmyvm6MJDWDpDICxBpUuzJIbx7zJJ1YrMDfIE8I86AconRl0YlO5fd
         O9Xw==
X-Gm-Message-State: AOAM530F3nFurZJ+FoniXzJ1+7CExIL1YyxHIMzMuQReJ/6infcVa2x4
        qwyHV9PafPxuxvp8mN/Vq6j768SD9ncGDKYZ/7Y=
X-Google-Smtp-Source: ABdhPJyBK/cbBcI4rvHjV/DHrHtaqN/MY/CiyNmAQ6EUmLaiZjqOooeuhG5Pf+XAEhKEywNcSF4OaNQUAGDY+uG8v/g=
X-Received: by 2002:a5d:618e:: with SMTP id j14mr4560853wru.374.1596662887120;
 Wed, 05 Aug 2020 14:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200805113510.18277-1-colin.king@canonical.com>
 <CADnq5_NA9f2N3xkH4WAdDEP+0-5W0LkmTRy3yXqFdnWQmfsVmQ@mail.gmail.com> <a8ab7d75ef9df54bd193fc88e0670b30026e7e67.camel@perches.com>
In-Reply-To: <a8ab7d75ef9df54bd193fc88e0670b30026e7e67.camel@perches.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 5 Aug 2020 17:27:55 -0400
Message-ID: <CADnq5_P9hfv=Zt9+m47sFC0z202x+q-Otifv7a5z4afJamtQ2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix spelling mistake "Falied" -> "Failed"
To:     Joe Perches <joe@perches.com>
Cc:     Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 4:53 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-08-05 at 16:01 -0400, Alex Deucher wrote:
> > On Wed, Aug 5, 2020 at 7:35 AM Colin King <colin.king@canonical.com> wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > There is a spelling mistake in a DRM_ERROR message. Fix it.
> > >
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >
> > This is already fixed.
>
> This fix is not in today's -next.
>
> Perhaps whatever tree it's fixed in should be in -next.
>

Weird.  It's in the drm-next tree as:

commit 4afaa61db9cf5250b5734c2531b226e7b3a3d691
Author: Colin Ian King <colin.king@canonical.com>
Date:   Fri Jul 10 09:37:58 2020 +0100

    drm/amdgpu: fix spelling mistake "Falied" -> "Failed"

    There is a spelling mistake in a DRM_ERROR error message. Fix it.

    Signed-off-by: Colin Ian King <colin.king@canonical.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> $ git show --oneline -s
> d15fe4ec0435 (HEAD, tag: next-20200805, origin/master, origin/HEAD) Add linux-next specific files for 20200805
>
> $ git grep -i falied drivers
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:                DRM_ERROR("Falied to terminate tmr\n");
>
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> []
> > > @@ -2010,7 +2010,7 @@ static int psp_suspend(void *handle)
> > >
> > >         ret = psp_tmr_terminate(psp);
> > >         if (ret) {
> > > -               DRM_ERROR("Falied to terminate tmr\n");
> > > +               DRM_ERROR("Failed to terminate tmr\n");
> > >                 return ret;
> > >         }
>
>
