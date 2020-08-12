Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350DDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B13B2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfUxsu28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgHLAKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgHLAKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:10:25 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D601C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:10:25 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id x10so377210ybj.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8uOzj1voyuCKHRpxgq/4pDKuyjBgBLo5ZiC1tPpLll8=;
        b=PfUxsu28J+k0tt2T60XuyfbMtFAitx9KdbRdPbiTevfHT9OuvszkOVp6HdNs4S0oHc
         p6R5vS0fipF5cik14YFkQatdJ1zII7ViQJiLPTdNtuo80Ih5Oxj+nSWE7sn54rW9HK/x
         H4oaP9zlZcL4EHAtrwmBJi6nrIqDYFWLD2Lez2KE9v4SgN/T0FWwAslu/rEqoaO1A97F
         qRxcJfRsR14jofd7sYxL1YPYdlkYmYnyJD36utn+DAb5JYRb5jumHg9FEWV0Ov+00n9a
         u/m6wYzHQp36O9NWnduDy7Y9apuqjWNkQ0iYWnts9RdUdvShjYPt7qOnRkdPfxdaUHIV
         Cmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uOzj1voyuCKHRpxgq/4pDKuyjBgBLo5ZiC1tPpLll8=;
        b=oitXUQBNUkyXXl/kNWivWjf7fUissw/vehN1S57mE+3g6jVlsOXheKQdGmv5i64k9o
         bMiT9wLNnQbqOSRMDUeCnTwLoOaXkKmQiLBqADEjyRqEv4oZRtof0McFYX2rcoOMRNID
         A5mid4KpdR+OJlSdLf4g/ShuaNySGArnwdJw1GithoQkwSnRDW73tDDV7X6BxWdvjGym
         lax8XAHhbS/HQzqKUlyiODlQzsS2bXAsNGdA4/XnrpShtop1/oDYnQB3akCaBOzvLzRP
         ctKSXgZImqY3G01zjUeBbPVaC1sPSHUYWt/dNwH9v+qGf9TQ3G9zZvd1+MJ5RO60dpTy
         wXPg==
X-Gm-Message-State: AOAM531PB9+406bNhJiK1h14BP2LwI6E3e5PmwDkUnzgz6jxvCxXsVo8
        y+geqibaifvulQBEWBLWXKvOs/LkNzd68tmQ6no=
X-Google-Smtp-Source: ABdhPJywz5Q/451nmNo3nqmKYvaDye1yBXeQ45F23UMljvWfQL6O7dMrT8GiEhMPtmxrhdR1cSHpFuq3PI9yzuM0z1Q=
X-Received: by 2002:a25:2e12:: with SMTP id u18mr48009916ybu.200.1597191023984;
 Tue, 11 Aug 2020 17:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200811200457.134743-1-lyude@redhat.com> <20200811200457.134743-2-lyude@redhat.com>
In-Reply-To: <20200811200457.134743-2-lyude@redhat.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Wed, 12 Aug 2020 10:10:13 +1000
Message-ID: <CACAvsv5FnVom3Od=EfZO3Y1WhCXDhBvCSNwFx8bc_BNg75iL4g@mail.gmail.com>
Subject: Re: [RFC 01/20] drm/nouveau/kms: Fix some indenting in nouveau_dp_detect()
To:     Lyude Paul <lyude@redhat.com>
Cc:     ML nouveau <nouveau@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 at 06:05, Lyude Paul <lyude@redhat.com> wrote:
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>

> ---
>  drivers/gpu/drm/nouveau/nouveau_dp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
> index 8a0f7994e1aeb..ee778ddc95fae 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dp.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
> @@ -76,10 +76,10 @@ nouveau_dp_detect(struct nouveau_encoder *nv_encoder)
>         nv_encoder->dp.link_nr = dpcd[2] & DP_MAX_LANE_COUNT_MASK;
>
>         NV_DEBUG(drm, "display: %dx%d dpcd 0x%02x\n",
> -                    nv_encoder->dp.link_nr, nv_encoder->dp.link_bw, dpcd[0]);
> +                nv_encoder->dp.link_nr, nv_encoder->dp.link_bw, dpcd[0]);
>         NV_DEBUG(drm, "encoder: %dx%d\n",
> -                    nv_encoder->dcb->dpconf.link_nr,
> -                    nv_encoder->dcb->dpconf.link_bw);
> +                nv_encoder->dcb->dpconf.link_nr,
> +                nv_encoder->dcb->dpconf.link_bw);
>
>         if (nv_encoder->dcb->dpconf.link_nr < nv_encoder->dp.link_nr)
>                 nv_encoder->dp.link_nr = nv_encoder->dcb->dpconf.link_nr;
> @@ -87,7 +87,7 @@ nouveau_dp_detect(struct nouveau_encoder *nv_encoder)
>                 nv_encoder->dp.link_bw = nv_encoder->dcb->dpconf.link_bw;
>
>         NV_DEBUG(drm, "maximum: %dx%d\n",
> -                    nv_encoder->dp.link_nr, nv_encoder->dp.link_bw);
> +                nv_encoder->dp.link_nr, nv_encoder->dp.link_bw);
>
>         nouveau_dp_probe_oui(dev, aux, dpcd);
>
> --
> 2.26.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
