Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0193C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FA3207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7mm1ell"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHLAOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgHLAOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:14:20 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A619CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:14:20 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id q3so402304ybp.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EECTvhpW/4wcpyDgeePO+k8+09CeEjLorKKfjs56l98=;
        b=Q7mm1elliLh/UHacUbs4AY6GzuGqv/sobvXgMmVVIShQYXgCmqnAGdxtfzkOMnC+U/
         bhK/Rrt2OcBrfZTy4gWrnEhDbvLF3xeXFlxU9b7UYSEQhMjrrdMaDipYZ22OcBarKkPL
         4xh+Ewx5xqfkO2AsIqAtBWeB1ddRjT64B5XOHmXlJRwzFCb6QSW58qMInr8KAKvj3rC1
         RV1Z/2FdmkaULwxSy1edCGimjZcn4ylBhuKORFgccLca3NIpsg6q2p6AMhV+NdGOkPx6
         n/Mb9EGoFCSOtrzG4rOpqtK7RDNmyYwSDJF49Soxc7v9kt1xLOuOhz1Bs6WpoQgnFKgX
         fTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EECTvhpW/4wcpyDgeePO+k8+09CeEjLorKKfjs56l98=;
        b=aOe9Na5Mgfh1D0ggtAo1IH0uWJ5lgqR2YwzxtCRHMsge43JiLjR7gBrHi4bPxF8ahT
         yKULqkRIHq03ZuOyJwpNnPjBUSyNZ/IG2rJc8HYbEqk5VYuvZo0d2VlAvjdW9sp132+B
         KYHIH28vDgEKt6/pDVCC6WFcFmHzzcIEiFfiHwrAfPfMEqu52BEXQvg0QvuZ8tCbBr6T
         4PKg9O7X0YN9/3NLNSXNTqkmjauCHypJ2bd06l5JaxHTuK24FtBGOb9FXaZjV8KUuSs/
         7bqE0VPb+RqfrOntZpnPpb03OPFhOyLvUUe3wFA1izxJpFX5invV2+5e481nEabsxfBq
         xbLg==
X-Gm-Message-State: AOAM530ngINbDOhzUsccyNzTMMFu3/9KhZ0oVALnMYSv8D4+K8f2dbO9
        k5/7ahwNcUuM1QoohIccHI3g8s61bko09+8mfRs=
X-Google-Smtp-Source: ABdhPJz8vAYmgWrlaT2Xtt9QXJflCYBZrH/2sTBupWHilMsBAP29/w6/2o4L00xaJt4ODsqFKmzqgguw39l/xleeVQE=
X-Received: by 2002:a25:9c01:: with SMTP id c1mr26232297ybo.83.1597191259687;
 Tue, 11 Aug 2020 17:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200811200457.134743-1-lyude@redhat.com> <20200811200457.134743-21-lyude@redhat.com>
In-Reply-To: <20200811200457.134743-21-lyude@redhat.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Wed, 12 Aug 2020 10:14:08 +1000
Message-ID: <CACAvsv7cqKLa+wSz3JQhZ7sr8dDXeqZt1VjkpGY8E=E2xFaCCQ@mail.gmail.com>
Subject: Re: [Nouveau] [RFC 20/20] drm/nouveau/kms: Start using drm_dp_read_dpcd_caps()
To:     Lyude Paul <lyude@redhat.com>
Cc:     ML nouveau <nouveau@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 at 06:07, Lyude Paul <lyude@redhat.com> wrote:
>
> Now that we've extracted i915's code for reading both the normal DPCD
> caps and extended DPCD caps into a shared helper, let's start using this
> in nouveau to enable us to start checking extended DPCD caps for free.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>

> ---
>  drivers/gpu/drm/nouveau/nouveau_dp.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
> index f41fa513023fd..a4e07d116972f 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dp.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
> @@ -55,15 +55,13 @@ nouveau_dp_probe_dpcd(struct nouveau_connector *nv_connector,
>         int ret;
>         u8 *dpcd = outp->dp.dpcd;
>
> -       ret = drm_dp_dpcd_read(aux, DP_DPCD_REV, dpcd, DP_RECEIVER_CAP_SIZE);
> -       if (ret == DP_RECEIVER_CAP_SIZE && dpcd[DP_DPCD_REV]) {
> -               ret = drm_dp_read_desc(aux, &outp->dp.desc,
> -                                      drm_dp_is_branch(dpcd));
> -               if (ret < 0)
> -                       goto out;
> -       } else {
> +       ret = drm_dp_read_dpcd_caps(aux, dpcd);
> +       if (ret < 0)
> +               goto out;
> +
> +       ret = drm_dp_read_desc(aux, &outp->dp.desc, drm_dp_is_branch(dpcd));
> +       if (ret < 0)
>                 goto out;
> -       }
>
>         if (nouveau_mst) {
>                 mstm = outp->dp.mstm;
> --
> 2.26.2
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
