Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014F8C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3B120CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3A82NAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbgBYPFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:05:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39195 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgBYPFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:05:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so3477215wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 07:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r7RmpUlHRyrdl4Ij2+xzKKWEEb70EyMwIdUyaPKBWHM=;
        b=R3A82NAa/uw4zA2GaMHN4wQKlKTBMeb9jJ6zMIDMMHoLK/XxFIQbJcc0L2Ki3+yvFj
         yxpyC6FdWlYlRYnWvGTn6zeomT9vLy0FD++LjOn67mzf9FZYOkrzXXpRyOjizKp2Wxe9
         quaB7+Zp2qBvkzt7s7yjoFxrEpR9HQJAFq8A4RzEkk8n1v/mHb6qK4kHTSOgtDWYQhlp
         07VLTA9Rr3bGPXR18KOPCMz34eYkXWRLJHp2bILREpBXIRHcg1RlorcjYvfsuvfCz1za
         V6evnpd8umP2v3Gyx+XxrfbMuSINL8jEAxJvqV8AVWfC6tqfWyH+TYoXmrPhu0MFkOWc
         G7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7RmpUlHRyrdl4Ij2+xzKKWEEb70EyMwIdUyaPKBWHM=;
        b=IulNUwRdKFaxkSpa9zjqeAZmz8bxNfMmQMKJp/NFOzQNqj76HOYTIHaJF+AYZ9kGB/
         02Bty43HBislkWf/JBevi76MOZJwMwj2mKQa7jt820YrY2qBKKUtCBvoFG+bWRdwPU7f
         NqGLHeWMn9A7jKmbqmSAKsP8f4YVqxvNe0cmLDyRzi390785gfnFn7UrK8cFYFNLYZAs
         eXnu2144NKpKI/pqCWaC5YODPzr7h8WFwzOpeEeL16MocgH1mny30VzmJtcIc/52f/1J
         6Csjpe5Icg5i9z5vYQweHH3jXTlFX5x/Fq1MlQCmVtZBrv33ojcMbCeYRkqQvdXn28Kl
         qPWQ==
X-Gm-Message-State: APjAAAVDw/XIqBE35Y2L9qnjVPJKjgWlzPn/b2UtheZceHjmj4ey3zEK
        b4gozjKp1QqxQ1Em0At/XLkWTpLNjYTu7okfgRA=
X-Google-Smtp-Source: APXvYqxamkV18hd8RMOkHpaLfKNXGsJAnJPKR6dxW+maJw1T8Ozr00KpCqAbTEghrzqJnprPz2AY/+kL7zl5pzkzFzA=
X-Received: by 2002:a05:600c:218b:: with SMTP id e11mr5878703wme.56.1582643137974;
 Tue, 25 Feb 2020 07:05:37 -0800 (PST)
MIME-Version: 1.0
References: <20200221132433.16532-1-yuehaibing@huawei.com>
In-Reply-To: <20200221132433.16532-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 25 Feb 2020 10:05:26 -0500
Message-ID: <CADnq5_O7YQB6_hfsFMCCpoZzrhrcYECocZ56DB6ZuE76sACicg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: remove set but not used variable 'mc_vm_apt_default'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Cheng, Tony" <tony.cheng@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        Eric Yang <Eric.Yang2@amd.com>,
        Yongqiang Sun <yongqiang.sun@amd.com>, joseph.gravenor@amd.com,
        jaehyun.chung@amd.com,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:33 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c:
>  In function hubp21_set_vm_system_aperture_settings:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c:343:23:
>  warning: variable mc_vm_apt_default set but not used [-Wunused-but-set-variable]
>
> It is never used, so remove it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  thanks!

Alex


> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
> index aa7b0e7..d285ba6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
> @@ -340,13 +340,9 @@ void hubp21_set_vm_system_aperture_settings(struct hubp *hubp,
>  {
>         struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
>
> -       PHYSICAL_ADDRESS_LOC mc_vm_apt_default;
>         PHYSICAL_ADDRESS_LOC mc_vm_apt_low;
>         PHYSICAL_ADDRESS_LOC mc_vm_apt_high;
>
> -       // The format of default addr is 48:12 of the 48 bit addr
> -       mc_vm_apt_default.quad_part = apt->sys_default.quad_part >> 12;
> -
>         // The format of high/low are 48:18 of the 48 bit addr
>         mc_vm_apt_low.quad_part = apt->sys_low.quad_part >> 18;
>         mc_vm_apt_high.quad_part = apt->sys_high.quad_part >> 18;
> --
> 2.7.4
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
