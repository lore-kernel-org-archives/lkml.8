Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4242DC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9C52071C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="buSa8Rvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCRULP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:11:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38437 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRULO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:11:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so71451pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 13:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyesW/I7eVgVyicQueL0CdgpIWranWUqdWTYkhPayEw=;
        b=buSa8RvhjkGTpbBdwHw59o+jZbhgGKbLiBhfH2emwRGZx+wImu/ULynC+CYcg4rbnN
         7u/sZ5xGCoq+T5kYpewP2vLW85uO1fq4YujHF493zxwEabsXuLVHqEVBgMO0yperyLOQ
         AtTa0SNg0Vpxa9cnuaCRmnDgdd6OUlcFvuwrqY2yQKESkO6+71cCLK0W7op0OVEM+m71
         bmHlAQZyTzrYwa9K+oAbP/9IT2f1hX4tKoj3P+qQzuyNSpl9vHmuXGkCkfMgsGFs75PI
         mWxN19hhTjPvb5ClZNqP2xO8sPSOSOpXKlWhnpcOAQxMrQLi1lorTBOjOJgOlh1AkNit
         ImZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyesW/I7eVgVyicQueL0CdgpIWranWUqdWTYkhPayEw=;
        b=nzuy8zmUAfLxKntOyZuiMHW3fvunIxXVnUOGvHCGSQeuCEhhE4HSvgU4dGTZth1EdQ
         uQmGOdkVDWSRyNlb9y3+wyBl5/XNDa1WICVF/74ZAWlhRDI5eVfRWCLAysymj2pfxZtZ
         th7+A9MA3gIyFDj4NKkAawN/YTEH1Jvu0hVNd7S95wDBfUTu1faPnzjBmKyCtzMTHJDU
         Lv+U6MFEzSQhNf4QLlN3dGGkqtuWa3B/jgWVWb69mjZ9vW8LNaMXwq3B4vLDC5llm4lZ
         gSrkjodN2Ad0BCJT0vHeIn2KuAqF0yCq76oF5qfEpZ7DajO6P1xUhFUT3tVAVpkKyVJw
         TnVQ==
X-Gm-Message-State: ANhLgQ0vBa8/3WSR72Pwo6O+T8hb6O4g/7R7b6HULGmlVFp0nosZ5xzg
        CwE7VJkkMHA9Lq5WOIrzq3JPbsVSUp+GFXeqLZgE5A==
X-Google-Smtp-Source: ADFU+vsvmlakcRCCZHYwnyZMgY3Y37TRHQ0ECfXdqwlx7G77wz0frDIB6p4cU0iSRnIO6PsnQPSCLbvLu8yOZe6YOM8=
X-Received: by 2002:a63:4d6:: with SMTP id 205mr6229525pge.10.1584562273205;
 Wed, 18 Mar 2020 13:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200318002500.52471-1-natechancellor@gmail.com>
In-Reply-To: <20200318002500.52471-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 18 Mar 2020 13:11:00 -0700
Message-ID: <CAKwvOdkzdBYgixrSKKfo7=god4Q0GaMORmFWUfrJ27JiGhBx2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Initialize shadow to false in gfx_v9_0_rlcg_wreg
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
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

On Tue, Mar 17, 2020 at 5:25 PM Nathan Chancellor
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
> It is not wrong so initialize shadow to false to ensure shadow is always
> used initialized.

Yep, thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: 2e0cc4d48b91 ("drm/amdgpu: revise RLCG access path")
> Link: https://github.com/ClangBuiltLinux/linux/issues/936
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 7bc2486167e7..affbff76758c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -735,7 +735,7 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
>         static void *spare_int;
>         static uint32_t grbm_cntl;
>         static uint32_t grbm_idx;
> -       bool shadow;
> +       bool shadow = false;
>
>         scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
>         scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
> --
> 2.26.0.rc1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200318002500.52471-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
