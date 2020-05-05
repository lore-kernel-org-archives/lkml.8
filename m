Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A095C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D3A206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+27bzh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgEEPkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729317AbgEEPkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:40:14 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF62C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:40:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t9so1331221pjw.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bSFaPsY9Q06ol7z3I9i5NZy6Mx1BYRJOSiQQ/ADJ9Gg=;
        b=N+27bzh+IMZfcRnh55NZgeIVBEml3gus4hp7iFUF6zcjpxNRyptB9OdCDWaJewid8l
         zzggysGdilyS219iat2RsDVXdStYATE8skmp1BvkxX5T9jRUe2HsvL7E8uFvItikAObz
         b9gwPB/r+co6aVYZdf0ShOVytK37AWhko/qoZYFNboprhcDhWsLbd8cCM/IIjsTSpz0l
         f0N33fSctiP/mSHFqqUFrW/2BkUX+VQR/hx6ChD1Nv4YIqbI+uTvDE1JGGvhyFc4EI5/
         crIBcVXx9W3f0frtN+DBlHtDkiDZWz/viDcRZu+ychATsekTG9x5kHtynjiBy6DeCqjM
         owQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bSFaPsY9Q06ol7z3I9i5NZy6Mx1BYRJOSiQQ/ADJ9Gg=;
        b=UXYV0AhadCKfBqw97pk+xdTlaUJ23qWMmjguVN/JqvYsJRMAa9GBLbLJ2zGcmn0h1Y
         fFmBeMSragi1uF8/Y/f7Wwt9qnd8vdVWslbfWp31sIyxIx4CZdHTP844k7KeyF4hbkCS
         BU4twd9klBgsL924RYQ8pU+Wctm5JAaK/sSnIHM6aTsshcLb6KwdEESm/Uz1zK14s/M7
         JJ4XVQs8DHt412o/zg8QmHvhyxgWyTwY5T0eEetXjulVYunvWOX3tei1VY1UwGqyJzq7
         2fw0cevNEz1dMu1kBFk5wilbqAO6U8eDkLF2Wqc/19Y69pTsDPzD72XqdLpYcf9pRwmm
         SgQw==
X-Gm-Message-State: AGi0PuYCM99Jk1hpVKMollfMdkwTgVZMYv4aHsK3odMJr2qSgtYJgVq2
        HLxnslSmGUwhsCdZJRb8RGppHGpXYVD4QCgWnHZ7Kg==
X-Google-Smtp-Source: APiQypJk7WFBLwQNHlWpEpX+GDFUCZgtHUU8RxuEIsH3h6aMqRYcSuecN1kdds/zND2KUHypdFOJyiF/OToVqwLaK+A=
X-Received: by 2002:a17:90a:8c85:: with SMTP id b5mr3737036pjo.187.1588693212806;
 Tue, 05 May 2020 08:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200505141606.837164-1-arnd@arndb.de> <e4a852b2-807b-bc73-7328-bcc399341085@amd.com>
In-Reply-To: <e4a852b2-807b-bc73-7328-bcc399341085@amd.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 May 2020 08:39:59 -0700
Message-ID: <CAKwvOd=JLsksy5adE_rnRKetqAMcSFsJPHXVsidOP9RPo+YpCA@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: fix integer overflow on 32-bit architectures
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Monk Liu <Monk.Liu@amd.com>,
        Kent Russell <kent.russell@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See also https://lore.kernel.org/lkml/CADnq5_NdtZh5_RGDWKJ9c_42XLvrncCs5DDU=
1YSptfZP94KXkQ@mail.gmail.com/T/#me707e09e92c6e487285e8bb382a607e4e782c249

On Tue, May 5, 2020 at 7:17 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 05.05.20 um 16:15 schrieb Arnd Bergmann:
> > Multiplying 1000000000 by four overruns a 'long' variable, as clang
> > points out:
> >
> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4160:53: error: overflow in =
expression; result is -294967296 with type 'long' [-Werror,-Winteger-overfl=
ow]
> >                  expires =3D ktime_get_mono_fast_ns() + NSEC_PER_SEC * =
4L;
> >                                                                    ^
> > Make this a 'long long' constant instead.
> >
> > Fixes: 3f12acc8d6d4 ("drm/amdgpu: put the audio codec into suspend stat=
e before gpu reset V3")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > I'm not sure the ktime_get_mono_fast_ns() call is necessary here
> > either. Is it intentional because ktime_get_ns() doesn't work
> > during a driver suspend, or just a mistake?
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 6f93af972b0a..2e07e3e6b036 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4157,7 +4157,7 @@ static int amdgpu_device_suspend_display_audio(st=
ruct amdgpu_device *adev)
> >                * the audio controller default autosuspend delay setting=
.
> >                * 4S used here is guaranteed to cover that.
> >                */
> > -             expires =3D ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4L;
> > +             expires =3D ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4LL=
;
> >
> >       while (!pm_runtime_status_suspended(&(p->dev))) {
> >               if (!pm_runtime_suspend(&(p->dev)))
>
> --
> You received this message because you are subscribed to the Google Groups=
 "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/clang-built-linux/e4a852b2-807b-bc73-7328-bcc399341085%40amd.com.



--=20
Thanks,
~Nick Desaulniers
