Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923CEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6931E22CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgHEWTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:19:44 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:55982 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725830AbgHEWTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 18:19:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B1F10182251C0;
        Wed,  5 Aug 2020 22:19:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soup01_4f0d84926fb2
X-Filterd-Recvd-Size: 3359
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Aug 2020 22:19:40 +0000 (UTC)
Message-ID: <d720b466a2b4b7507a963f9a2605c7f81e82e7ba.camel@perches.com>
Subject: Re: [PATCH] drm/amdgpu: fix spelling mistake "Falied" -> "Failed"
From:   Joe Perches <joe@perches.com>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Aug 2020 15:19:38 -0700
In-Reply-To: <CADnq5_P9hfv=Zt9+m47sFC0z202x+q-Otifv7a5z4afJamtQ2Q@mail.gmail.com>
References: <20200805113510.18277-1-colin.king@canonical.com>
         <CADnq5_NA9f2N3xkH4WAdDEP+0-5W0LkmTRy3yXqFdnWQmfsVmQ@mail.gmail.com>
         <a8ab7d75ef9df54bd193fc88e0670b30026e7e67.camel@perches.com>
         <CADnq5_P9hfv=Zt9+m47sFC0z202x+q-Otifv7a5z4afJamtQ2Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-05 at 17:27 -0400, Alex Deucher wrote:
> On Wed, Aug 5, 2020 at 4:53 PM Joe Perches <joe@perches.com> wrote:
> > On Wed, 2020-08-05 at 16:01 -0400, Alex Deucher wrote:
> > > On Wed, Aug 5, 2020 at 7:35 AM Colin King <colin.king@canonical.com> wrote:
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > > 
> > > > There is a spelling mistake in a DRM_ERROR message. Fix it.
> > > > 
> > > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > 
> > > This is already fixed.
> > 
> > This fix is not in today's -next.
> > 
> > Perhaps whatever tree it's fixed in should be in -next.
> > 
> 
> Weird.  It's in the drm-next tree as:
> 
> commit 4afaa61db9cf5250b5734c2531b226e7b3a3d691
> Author: Colin Ian King <colin.king@canonical.com>
> Date:   Fri Jul 10 09:37:58 2020 +0100
> 
>     drm/amdgpu: fix spelling mistake "Falied" -> "Failed"
> 
>     There is a spelling mistake in a DRM_ERROR error message. Fix it.
> 
>     Signed-off-by: Colin Ian King <colin.king@canonical.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Alex
> 
> > $ git show --oneline -s
> > d15fe4ec0435 (HEAD, tag: next-20200805, origin/master, origin/HEAD) Add linux-next specific files for 20200805
> > 
> > $ git grep -i falied drivers
> > drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:                DRM_ERROR("Falied to terminate tmr\n");
> > 
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > []
> > > > @@ -2010,7 +2010,7 @@ static int psp_suspend(void *handle)
> > > > 
> > > >         ret = psp_tmr_terminate(psp);
> > > >         if (ret) {
> > > > -               DRM_ERROR("Falied to terminate tmr\n");
> > > > +               DRM_ERROR("Failed to terminate tmr\n");
> > > >                 return ret;
> > > >         }

Dunno.

Maybe it's due to some ordering of trees in
how -next accumulates patches?


