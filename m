Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA13C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE4120777
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qN4+WX6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgCRVHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:07:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39885 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgCRVHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:07:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so145374pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UnW3oRxVQHnYvwZ2+HCKUVYxiIim+eBLvaQELpxrRqU=;
        b=qN4+WX6llXdXg7OP2ngw/tmuSenPNNwNDboXm8R0BqN7TKq6AnxLkKLG8Q99y9IZ6T
         YDfO8JIUTC9v2tBafpZVOOd0JFYHC0mDB+lxnynMKQQLixMFCn9aOM1p/8pLBMWijDoE
         rLQazFqDavwllYsf3wPN4aql2BpoZjato+DcTWKqNtpooKdE/nwFO0dcUImcroRCILJO
         aPVcdVsQK6Yfq1FM6t0YjsW0hhvgLZRy2qsN7Ze0/hX0uJaqnU3valz6jPspG792A5BE
         UiFdDU6CdJPC5k87CYj8sMC2aAKdppbSCjkh0rgWDLetIMv33zXhdzo2jCnPehDY1cV5
         BkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UnW3oRxVQHnYvwZ2+HCKUVYxiIim+eBLvaQELpxrRqU=;
        b=LeQv+CQR1CA3yBjacjIw8zpclyTBe6zRabo9E/Cg/+m8Ok/qCnXdcaPN6amUc4zzNw
         9NzTXwTy6+j9mOqTubA2nYwtHhbR52LnEOKl3HzU134hxRAnhRORVYwd81smaSxj40ke
         gCxad6U73EwkMjyO6NP7sw9Ln2Owj3S07KwjCgMKQQsGEQ7oZvAsnDrVgSElyR+SQrBf
         +f/yRcIfKlOFfiprhJ55ZI34DwE3P07L54cp5Q8jXZNcpp1X2g2yKWuIP74E2Wi2apOl
         mLl+uft+JYx7W6zS6uZV0dSYWX6Aw8OxdaiZPpALodB+da3rOdHp/MA51SNum1hxmD1V
         L1Gw==
X-Gm-Message-State: ANhLgQ0ma8KqHX8+HlMOaORhMUXoq9us+X8k5NblCvUH2diTXJkmuq7l
        fAy88TyqdgTpzzQ8knMCGltEgbpuqHXC6vmh/dv2Yg==
X-Google-Smtp-Source: ADFU+vtrCbWLsD9Kl2sgpRCLWJgG9WETEekWUwb95aIHCLvQp5JpBJCHYMAZGw01/Hcy77aG8jAmyFceFlIcLkd5Les=
X-Received: by 2002:aa7:8b54:: with SMTP id i20mr215129pfd.39.1584565667463;
 Wed, 18 Mar 2020 14:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200318002500.52471-1-natechancellor@gmail.com> <20200318210408.4113-1-natechancellor@gmail.com>
In-Reply-To: <20200318210408.4113-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 18 Mar 2020 14:07:34 -0700
Message-ID: <CAKwvOdmjzemFW9jF-CW1RhLJJbMvFO_NrPUeyi=rdLNVZURsfw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Remove unnecessary variable shadow in gfx_v9_0_rlcg_wreg
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 2:05 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> clang warns:
>
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:754:6: warning: variable 'shadow'
> is used uninitialized whenever 'if' condition is
> false [-Wsometimes-uninitialized]
>         if (offset == grbm_cntl || offset == grbm_idx)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:757:6: note: uninitialized use
> occurs here
>         if (shadow) {
>             ^~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:754:2: note: remove the 'if' if
> its condition is always true
>         if (offset == grbm_cntl || offset == grbm_idx)
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:738:13: note: initialize the
> variable 'shadow' to silence this warning
>         bool shadow;
>                    ^
>                     = 0
> 1 warning generated.
>
> shadow is only assigned in one condition and used as the condition for
> another if statement; combine the two if statements and remove shadow
> to make the code cleaner and resolve this warning.
>
> Fixes: 2e0cc4d48b91 ("drm/amdgpu: revise RLCG access path")
> Link: https://github.com/ClangBuiltLinux/linux/issues/936
> Suggested-by: Joe Perches <joe@perches.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> * Remove shadow altogether, as suggested by Joe Perches.
> * Add Nick's Reviewed-by, as I assume it still stands.

yep, thanks

>
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 7bc2486167e7..496b9edca3c3 100644
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
> --
> 2.26.0.rc1
>


-- 
Thanks,
~Nick Desaulniers
