Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FCCC4BA09
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE37B2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbmqYJ3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgBYXyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:54:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40566 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbgBYXyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:54:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id i6so1265129otr.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 15:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oAqDSepBGZ4n0kSIgLmpw4sGTwUtrjb0cUzefUU3KuM=;
        b=MbmqYJ3bTxMe7ILHkl8V1BpKi1o65X47MQwpIZFrKvtnxk5Ia7N4Yxh5jXyzl2UHvg
         LFq79hPlxXf+vrVpK/EaB0+1KrISSykbDer85dM71TmGGfWgEsppOzZcSB5V83fUgmF7
         aDssLGD4jKvmaA4YHFtgPZ5gPfHlhFTuFPJtyqzseOdWael2CHhcynNMr4O0jrAt3Evz
         LEAQjMvnMx0lLTC2hu5KJWQmalT4BxaNRZmUwh14P5YNkQW2oUMFpeOtu9xr1IoumhII
         5nQzlJtlv4Itjcmv5ROdVTh+fM0ynFs6JeOFmnDPyps9PFIgACjP8ZuyJySV304cOToe
         mK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oAqDSepBGZ4n0kSIgLmpw4sGTwUtrjb0cUzefUU3KuM=;
        b=g+gYggqnIrjzHnY67pn3kDm0nagpgr9kkmvPl0cqzApSEgJca+5IVVaLf3bfgpXC4E
         ulkk9dWTVzosXzob2KOplp4jcrDLdQLnomf6oXCvHY+kNBX1eBS8acjHE6DbbsfPRfZ9
         P2JAgJ9sZjqKPq+SeROtrBe3vpAgvmyEWpNlGVAP4woCXcdnz8kTrwnJNDbVkKxTXeZ8
         rCdAtRhFt87KLa9qf+BJ/YjN4bvcqtSVGuatqhTPcoOC0WuYswWlsMg+PKX/BxJYkPVv
         a8/XYrdIXPfOSYdXSsBMBg0svLrqMYJiRtV0dW1n9sK5VCEkbCrRYUp8NsmyVBBfZEls
         UUYA==
X-Gm-Message-State: APjAAAVgvr2F9dijdy2zQwUMmJfESJAUCkcMRX3maHv0X+gbDAcj1K4/
        FB7Sjc5GgCD8phGRHeRgxIfD7dIJNI0ViOWXOA0OYg==
X-Google-Smtp-Source: APXvYqxHExvDxP3YDUCsYTbRz8HnGzFZhKBTxskzmLJjMa5mreChK7b0tovjYeFp4V6uvGP5Rvmqe9fzCWzwee3BXhU=
X-Received: by 2002:a05:6830:1184:: with SMTP id u4mr791163otq.221.1582674870075;
 Tue, 25 Feb 2020 15:54:30 -0800 (PST)
MIME-Version: 1.0
References: <1582223216-23459-1-git-send-email-jcrouse@codeaurora.org> <1582223216-23459-5-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1582223216-23459-5-git-send-email-jcrouse@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 25 Feb 2020 15:54:19 -0800
Message-ID: <CALAqxLWc4QQPyh=R6=0uFnLLicTYJ3NMO6QSc_yF31bJ2Z_rkQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/msm/a6xx: Use the DMA API for GMU memory objects
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:27 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> The GMU has very few memory allocations and uses a flat memory space so
> there is no good reason to go out of our way to bypass the DMA APIs which
> were basically designed for this exact scenario.
>
> v2: Pass force_dma false to of_dma_configure to require that the DMA
> region be set up and return error from of_dma_configure to fail probe.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 112 +++-------------------------------
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |   5 +-
>  2 files changed, 11 insertions(+), 106 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 983afea..c36b38b 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
...
> -       count = bo->size >> PAGE_SHIFT;
> +       bo->virt = dma_alloc_attrs(gmu->dev, bo->size, &bo->iova, GFP_KERNEL,
> +               bo->attrs);
>
...
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> index 2af91ed..31bd1987 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> @@ -13,7 +13,7 @@ struct a6xx_gmu_bo {
>         void *virt;
>         size_t size;
>         u64 iova;
> -       struct page **pages;
> +       unsigned long attrs;
>  };

As a head up, Todd reported that this patch is causing build trouble
w/ arm32, as the iova needs to be a dma_attr_t.

I've got a patch for the android-mainline tree to fix this, but you
might want to spin a v3 to address this.
  https://android-review.googlesource.com/c/kernel/common/+/1243928

thanks
-john
