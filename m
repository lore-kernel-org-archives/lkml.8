Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D000C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42ADB20714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VixHdO8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgC0KZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:25:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41714 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgC0KZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:25:16 -0400
Received: by mail-io1-f68.google.com with SMTP id y24so9234075ioa.8;
        Fri, 27 Mar 2020 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DtgW0asTVLRmsP/wkgDLG5KuILtoelQrHJyD4vPRGk=;
        b=VixHdO8Hw9jXt84SnnDFMGQQjN+nZh5xzNUbbN5TwxzAF/tN0b966nHiajtCMIUjRe
         QPrW8LgWJCh/qCTIWcBul+nq3pGxjVd7qN3hBNLBZYo3Y9nAKcG7/MJZNbYiZUsWgWqj
         0dKw5nHWGX5HMroQsYECsSA9OoFyjOYNaPcNTtb9/7Yp9p075eTwNb0T24TdH6CBlI+8
         ZPKuxCQ7llQkFU+Qcwl26aLr8yUREpdsDvFvrAbnBPcXWG9hjM82ZqZ5DF6d+w+Q6OyV
         N0VWSHaOOhgSSsYHaOaRx7NnFfDkTSADaPM1dlNEZdjVBsM+oX7z0luWXoaNI4VKban+
         abfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DtgW0asTVLRmsP/wkgDLG5KuILtoelQrHJyD4vPRGk=;
        b=rgCNTVcUQr2YTAfqWw7ntT5ENjipNOnwhSgCXFCvLw9cXGOVTJ0UuYB213P6RTY4mQ
         DFVCb9gqr/pmOr17Li6GGsj7KuSsFVweHOGTJHx7xvLVkpOaIc3WHHdYQsk8jZ4Oo2kY
         /ciVc6LqlYdVwFSuqSZJHXk2DptlwhYyNPPqzCTsqK002bH92TJkx3Z5yGP/a6LbHM+6
         83b34FlBQ/1xTA6tFgIVfEBnhM/u1uFvFztOAA/0+c2trwoY6u4FkT3TLYcJHH9XRRSs
         Yg/JbPz9bUhrYi0SqsBtwvoj1RpU779om/OtR6mJIdTAWEBUyWghMzkJ8NzO6HkNGthS
         tQKw==
X-Gm-Message-State: ANhLgQ0b6fRG3YEeK8aXeWGRYcs4jsJ4xkK/Epm8bMZhJTTfTBvs5w2D
        /I9KSqmlTFsLJ5kM5pkfPb+rx5oAvB0kYsQgMbo=
X-Google-Smtp-Source: ADFU+vvlcRTv5JovTHQ7RzXH0cra/ZdGkjZHlnblRSUuAxnLXSZ5BrZueQ9HJCBkcc1dc3kUFDm7yiF7dseHsA+NeRA=
X-Received: by 2002:a6b:c916:: with SMTP id z22mr12020083iof.138.1585304714741;
 Fri, 27 Mar 2020 03:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200327082453eucas1p15b2371b61f653031408f319cc6d13893@eucas1p1.samsung.com>
 <20200327082446.18480-1-m.szyprowski@samsung.com> <CABnpCuDySf89HL2AksMB2fOcVCci+1zgB9r8zjRdpCAH3GWhPA@mail.gmail.com>
 <64025801-10f0-9f28-17b2-2c04d4308ac5@samsung.com>
In-Reply-To: <64025801-10f0-9f28-17b2-2c04d4308ac5@samsung.com>
From:   Shane Francis <bigbeeshane@gmail.com>
Date:   Fri, 27 Mar 2020 10:25:04 +0000
Message-ID: <CABnpCuBUEO6V=hwzHkUEKK5KDXC=ovPrTHyb9zFYrj0KaHHdww@mail.gmail.com>
Subject: Re: [PATCH] drm/prime: fix extracting of the DMA addresses from a scatterlist
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Michael J . Ruhl" <michael.j.ruhl@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marek,

On Fri, Mar 27, 2020 at 9:00 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> > I have tested the above patch against my original issues with amdgpu
> > and radeon drivers and everything is still working as expected.
> >
> > Sorry I missed this in my original patches.
>
> No problem. Thanks for testing!
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
Just a thought.

Would it be worth adding some comments to the code to explain why this
is needed, reading
the thread around my original patches and the DMA-API documentation it
is not instantly
clear why you would be mapping the pages in this way.

Would probably prevent someone in the future making the same mistake I
did while updating
this code.

Regards,

Shane Francis
