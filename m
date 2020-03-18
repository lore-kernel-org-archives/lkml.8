Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4437BC4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138FB2076F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/X1upys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgCRUoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:44:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37764 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRUoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:44:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id a32so13469547pga.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 13:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=suYHs9658zHP4xficEGq5WrBjqIzHfAOzaIFRECzM5Y=;
        b=n/X1upys3h4rJNYvIw5j6AOUliQjvpmhy+m+9DZtWbYDpENrMWU9gX5OfOPjZCHqCq
         3N7EyTuBY29aXC98swHoyCoDuXnLG1HE/1H5jXDW/qG1EW1lh3uw7U7CfUWRbfjqOkcL
         hSX9Of+C0ataFtlnWTZFimXaINj+GxUPy1TZ1osPcSFYCZ/kscC0Ip/qBbdiSN6vpz8B
         PpgAdT3mzS/u+Sv9CKxeQP2Ut+/oAyg0LMSWhIbEHFuVBW/XOVLB2LgC/R2qCD140Jcm
         MxM0L8LtdKgiUYTUC3GZ3Oceg48BDmYiFzjjt+SlBqWpTOO5mU17+RKzxJjJStQpV7vw
         OnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=suYHs9658zHP4xficEGq5WrBjqIzHfAOzaIFRECzM5Y=;
        b=Y5yCH+tGvn+oPBl/3uxueIl1dEYx6kE7feGFQnP6/gr0w9fDREHD5Ol1Fam9A3krpv
         vTsLvRq5F4UIn49tF1BibBv1zYBS1TT3pb8HQJNLVdM68Cdnt9st3xVc6umFoNOeUr42
         HNyDnOZrbW+nTe2DtJsSm/OJW+AbC4GOo1rM9Nu4Asd+6Ahr5YU2O7ZYGmrHQ+S0OH8z
         ScNultlIpo4IqygL/3plqY8rlJSLGLWemJpUqeh3gJJg5mPAXwT6YKXvXqfWOQKiy+eS
         iX7zXb/9IEJpuQerG1+o97asI6NrZjshKZM0+b3nJKPcN/qaCnsZGYUWDSGxM54cmz02
         KZdQ==
X-Gm-Message-State: ANhLgQ1UUbelgtS8um7IVikJIAPHgeh7KaZcvwRtHrWmRuiB/zlvzEOQ
        XDWkj2OKX8unwO8MSESM0Uvq5Ki73U7Ij7G6uHYBAA==
X-Google-Smtp-Source: ADFU+vvuYGfe5Sd8RCUOsHGVZHh0QkYvusq8LOKEvmO8g5PG8CN5UlQKq17NQMJwPUgG4KkltVfEVBtrogvoQJfagUE=
X-Received: by 2002:aa7:8b54:: with SMTP id i20mr116252pfd.39.1584564247262;
 Wed, 18 Mar 2020 13:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200318002500.52471-1-natechancellor@gmail.com> <3a997f4ee640e607a171a19668f5f5484062116c.camel@perches.com>
In-Reply-To: <3a997f4ee640e607a171a19668f5f5484062116c.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 18 Mar 2020 13:43:54 -0700
Message-ID: <CAKwvOd=AA8NrqmOR=E7+e6dHEVo3DZwfSuK72DGzHG+X56pB7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Initialize shadow to false in gfx_v9_0_rlcg_wreg
To:     Joe Perches <joe@perches.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 1:28 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-03-17 at 17:25 -0700, Nathan Chancellor wrote:
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
>
> Wouldn't it be better to get rid of the shadow variable completely?

Yes, much better indeed. Seems it only has one use.

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 7bc248..496b9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -735,7 +735,6 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
>         static void *spare_int;
>         static uint32_t grbm_cntl;
>         static uint32_t grbm_idx;
> -       bool shadow;
>
>         scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
>         scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
> @@ -751,10 +750,7 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
>                 return;
>         }
>
> -       if (offset == grbm_cntl || offset == grbm_idx)
> -               shadow = true;
> -
> -       if (shadow) {
> +       if (offset == grbm_cntl || offset == grbm_idx) {
>                 if (offset  == grbm_cntl)
>                         writel(v, scratch_reg2);
>                 else if (offset == grbm_idx)
>
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/3a997f4ee640e607a171a19668f5f5484062116c.camel%40perches.com.



-- 
Thanks,
~Nick Desaulniers
