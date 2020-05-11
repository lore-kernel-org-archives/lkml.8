Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D332C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC32206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1eWOfAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgEKVka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgEKVk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:40:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32C3C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 14:40:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so6948828wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 14:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5X8EFCpZJBd5h5C0SmmApdosK9J40B8tFJDCu42fLm0=;
        b=p1eWOfAz4Y+0E99msj9lGfrdnuQxij1SNRHI75WOlswQF3ZvXEm8CmYt424g94JLjp
         j5fLYRORhOd8kySHVVYLnAtQuEPiuqF1oJtvRgRhVDfgnvVlgRPE+c/68Mvl0pXEyzZd
         Sp1MXB5LxoRkegDDCJpmAPCjdr1R2adZQNYqEVXxwnQIr8BHriEeCGObU1eMsvMqzPMT
         yNpB+dDJNbvN4J8KSeJnCloC5cQlf98wykdjPQtorYF+VJnNwUshof2llEsAZ/5qsKkl
         f1m0w1T3Uwu4NEYj8RKcrVNNEcD5Es/++82d7PPAq35MWNPgr271UifWTkLbV8qqnbWi
         X8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5X8EFCpZJBd5h5C0SmmApdosK9J40B8tFJDCu42fLm0=;
        b=uEcRNEXtBXOP/SbUo5ulI85rvgoMOPBERarxupTgMtydi7bZhhTpvUjZEfbtRXbFdG
         S5pAGkpAdVA12XgzYBEiNlkSMJMoin7lBhbmSVVtA82fjBp4W8XIZSNjCAL8+9mNXyKA
         /TVc9jFUYxvgIy9jA64HhhFRom1OeLlHqMNkpe9nhzjajS9bFILjt0KyUbLTjlQqTSkC
         LunzZjfCiCP/LiBpatCvQLzxGLB0z9qGeM6V9ad/pj4CiMyTtD5khINmSg4BoetkxyWl
         UoBvueMhJQmE3gAXhvN47uIPrs13JV6IUNMXGdeUthbsFewuy0QYIuxdVvUI1z1Prec2
         vK9g==
X-Gm-Message-State: AGi0PuYkcCAc0cNfxm+HTGmpHYW3f0qnm6Fi0k0x2Svmbyej0CLpnBqi
        iMD1Su0pnlkJejXYic0mqJEO8p5iaRT7KldSDIs=
X-Google-Smtp-Source: APiQypJLuAuptFSaBs8Nd4XMm2iRcJ4ZOKS1lydP9mvLSkNanXsBJCdXf5ZUIyn0+FQu86Hv1bissqd4AK6IYc2CIBA=
X-Received: by 2002:adf:93a3:: with SMTP id 32mr9674255wrp.124.1589233226569;
 Mon, 11 May 2020 14:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200509062959.42481-1-yanaijie@huawei.com>
In-Reply-To: <20200509062959.42481-1-yanaijie@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 May 2020 17:40:15 -0400
Message-ID: <CADnq5_NVPsQDsqQBPk2EB_LguN0R+NsSBnDcUtwFxZKqdYLa+Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: remove defined but not used 'crtc_offsets'
To:     Jason Yan <yanaijie@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Sat, May 9, 2020 at 5:05 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> Fix the following gcc warning:
>
> drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:65:18: warning: =E2=80=98crtc_offse=
ts=E2=80=99
> defined but not used [-Wunused-const-variable=3D]
>  static const u32 crtc_offsets[6] =3D
>                   ^~~~~~~~~~~~
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v6_0.c
> index c1a530dbe162..a75e472b4a81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -61,17 +61,6 @@ MODULE_FIRMWARE("amdgpu/si58_mc.bin");
>  #define MC_SEQ_MISC0__MT__HBM    0x60000000
>  #define MC_SEQ_MISC0__MT__DDR3   0xB0000000
>
> -
> -static const u32 crtc_offsets[6] =3D
> -{
> -       SI_CRTC0_REGISTER_OFFSET,
> -       SI_CRTC1_REGISTER_OFFSET,
> -       SI_CRTC2_REGISTER_OFFSET,
> -       SI_CRTC3_REGISTER_OFFSET,
> -       SI_CRTC4_REGISTER_OFFSET,
> -       SI_CRTC5_REGISTER_OFFSET
> -};
> -
>  static void gmc_v6_0_mc_stop(struct amdgpu_device *adev)
>  {
>         u32 blackout;
> --
> 2.21.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
