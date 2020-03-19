Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67043C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 03:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5D320768
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 03:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juAR90r9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCSDPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:15:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39905 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCSDPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 23:15:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id h6so916775wrs.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 20:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXI23a1IwY3ie8JXqjTRuDBwO8bkem8ij+8i6dgXZmY=;
        b=juAR90r9kj6szrVeLjR3TGTvGt/zMcldxYmJn8U9QYj+8QdhVaV9VAK/GQ0DfLl4TW
         fd5jFaPfTiKlxV6yK40M6vrXKaEcmVx/CnTFKtRbDCfP0HeO1OdVnNUQ65gY6A/bp/3s
         Spc/FLz/mz/ni0GkDzqK75LDiInTbzU2Hw9s2XVpWwtIdSCMLVSvjLqfZjmMFQ1Cv/hf
         GVFfb7qI8sO6rb/ro5TyESvBQBiVEKFQyVhfpwnTcswdV6c0FQ7pDo6eFGQ6qW+fEtlF
         AIjAW/z74drtsAkU4QYGi3zsAqWvSvrnCDUmW/PhkiTx6YqR4K8lSzGcls8SuBhA9O1E
         6zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXI23a1IwY3ie8JXqjTRuDBwO8bkem8ij+8i6dgXZmY=;
        b=t2VMXRwPez9Q/9ni2I80yqAqi7R/0tJtcp9/+viWA8YQeVhb7Qoy9fNIaJ4EEgkG7W
         5cqZYXL5gGq0u+n8uNuC9Ab7I4P3iF0Q4NRauZrcXyy1/xRDTTrIPmGjUGi4ReTeYXlD
         TkogOR3JU9kUAJRmplZzHMZNidvWSq+64IVEJcwJaq5hJon5+NR62Yc5TcqHFKPPUjpj
         K5zg1mobtitoluJMD4xK5m0+QyOtLFyYEk/JTOlMlIZXRxiSvTjlQv2Sye/Ph7T3XPKa
         7kgYSV7eigy+inOVmGD/0qQvpR30U9HulC2smerKow19Y9RkHzUf/TNG90423z3aBO+s
         WtTQ==
X-Gm-Message-State: ANhLgQ3QebZ3cwVsEQQ8jaHkE0+CKYSNn6bsZmbvjdw9/Ch2YVUM3GwW
        RFunRBBL0QUNy3FP+cJx6Mp9uoUcJNWOS8vAFyk=
X-Google-Smtp-Source: ADFU+vvmBMldInC533FJxKMKkpTbquGoRgXlwFhvaoYRPaxBTNJcHixQ4n2h9Zrmd9So4evF+r8PD+2g6jOeFH6Io5M=
X-Received: by 2002:a05:6000:111:: with SMTP id o17mr1210855wrx.111.1584587751002;
 Wed, 18 Mar 2020 20:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200318002500.52471-1-natechancellor@gmail.com>
 <20200318210408.4113-1-natechancellor@gmail.com> <CAKwvOdmjzemFW9jF-CW1RhLJJbMvFO_NrPUeyi=rdLNVZURsfw@mail.gmail.com>
In-Reply-To: <CAKwvOdmjzemFW9jF-CW1RhLJJbMvFO_NrPUeyi=rdLNVZURsfw@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 18 Mar 2020 23:15:40 -0400
Message-ID: <CADnq5_NjjorZhuAx+4gCW=LLGGvRhYqVKXUhAcXriehN3_y-UQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Remove unnecessary variable shadow in gfx_v9_0_rlcg_wreg
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Joe Perches <joe@perches.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 5:08 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Mar 18, 2020 at 2:05 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > clang warns:
> >
> > drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:754:6: warning: variable 'shadow'
> > is used uninitialized whenever 'if' condition is
> > false [-Wsometimes-uninitialized]
> >         if (offset == grbm_cntl || offset == grbm_idx)
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:757:6: note: uninitialized use
> > occurs here
> >         if (shadow) {
> >             ^~~~~~
> > drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:754:2: note: remove the 'if' if
> > its condition is always true
> >         if (offset == grbm_cntl || offset == grbm_idx)
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:738:13: note: initialize the
> > variable 'shadow' to silence this warning
> >         bool shadow;
> >                    ^
> >                     = 0
> > 1 warning generated.
> >
> > shadow is only assigned in one condition and used as the condition for
> > another if statement; combine the two if statements and remove shadow
> > to make the code cleaner and resolve this warning.
> >
> > Fixes: 2e0cc4d48b91 ("drm/amdgpu: revise RLCG access path")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/936
> > Suggested-by: Joe Perches <joe@perches.com>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.  thanks!

Alex

> > ---
> >
> > v1 -> v2:
> >
> > * Remove shadow altogether, as suggested by Joe Perches.
> > * Add Nick's Reviewed-by, as I assume it still stands.
>
> yep, thanks
>
> >
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 7bc2486167e7..496b9edca3c3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -735,7 +735,6 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
> >         static void *spare_int;
> >         static uint32_t grbm_cntl;
> >         static uint32_t grbm_idx;
> > -       bool shadow;
> >
> >         scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
> >         scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
> > @@ -751,10 +750,7 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
> >                 return;
> >         }
> >
> > -       if (offset == grbm_cntl || offset == grbm_idx)
> > -               shadow = true;
> > -
> > -       if (shadow) {
> > +       if (offset == grbm_cntl || offset == grbm_idx) {
> >                 if (offset  == grbm_cntl)
> >                         writel(v, scratch_reg2);
> >                 else if (offset == grbm_idx)
> > --
> > 2.26.0.rc1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
