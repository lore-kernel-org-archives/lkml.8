Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534AAC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3193B2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt8w7KS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgHLAMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgHLAMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:12:08 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D330FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:12:07 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id i10so386110ybt.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANisI7MawC30nrIBSjMSXLgYwLyr20x+LoTvwdtr3Sc=;
        b=jt8w7KS0d9R8I0y6qYP7BXoLqMunGTkSfoLt7r1G+NWD3l+RBKwXgk1IAA53wxCn/b
         cBWmSGimcl2Z7wRaumBNoisfrAz4a6QcDFhMXBWZjlO7d9igL9SLcfSzABjiNgpPo2dw
         fbCEOvssdKwkVwxt8lcU4gD/7+sIrwGjJKUApqWqSTqXkHoEfK+4DMyNi1xWH20fXfgH
         k5klOKWtNP95qArhsmn0ZgmZ72PzkVxlwfNeqpcA6BkJyt5JNDbVV/wIYPXPFFIYese3
         uCFXrugVDiTa3rj3JguNOm9ukexFC7V9xjdOn8xSw9wTy8n5k3dAx4dMgsG0jab/JpeF
         il0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANisI7MawC30nrIBSjMSXLgYwLyr20x+LoTvwdtr3Sc=;
        b=cgRYthsarEeq5QC3NeNgwn+QFNIDSnmfyEpi7GkeFdhJtdrbi8bKG7SWH+fCWsYYuD
         MYLT7yZRYV3Y4zdlH0zFt7ti41NmIxHf3ATVl5pjUlBa8k4F/2M+Hx5NLaOqBoK4Wms4
         44XVmcNs575mL4SAEcr0zkwnSzMLYyLXKzpGfdz7mRNHoqrYkzJ6MFcXFhrzqcuoXI6T
         jKAbw1HKK+Q9EZqslDCaatSfHn0Vw+nqtgXKH7cQIVLhMoV4Yo/XVgkb0YkJ3nfa18mV
         Vxr21DpzvFrMFEHeey9np42mWDY7dxL/NR7g1clNYT3mFUq/bhYYR6bvydr4JhA58yVV
         8b+w==
X-Gm-Message-State: AOAM530GmbNI/POvncC3GHFCcQMk5w+opteo3TFLQnKzzOraWFqZ6SHB
        dxIuM0x7itzGapLUrquUG04dS4y0IkRPQZLAGvs=
X-Google-Smtp-Source: ABdhPJwxJMEczs4u6ViJWr7Vt+u/2jmPSxvj3eAufTe/uJ56YXuOqV5u5G89FcccuYXQC7MGZw0EbpSDkyhLVL23HLY=
X-Received: by 2002:a25:9c01:: with SMTP id c1mr26221367ybo.83.1597191126680;
 Tue, 11 Aug 2020 17:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200811200457.134743-1-lyude@redhat.com> <20200811200457.134743-11-lyude@redhat.com>
In-Reply-To: <20200811200457.134743-11-lyude@redhat.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Wed, 12 Aug 2020 10:11:55 +1000
Message-ID: <CACAvsv6HZpgSC=gyJa_HyWLYAd70GefPp9j10ZOZ07CDQ70phA@mail.gmail.com>
Subject: Re: [RFC 10/20] drm/nouveau/kms: Use new drm_dp_has_mst() helper for
 checking MST caps
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

On Wed, 12 Aug 2020 at 06:06, Lyude Paul <lyude@redhat.com> wrote:
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>

> ---
>  drivers/gpu/drm/nouveau/nouveau_dp.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
> index d701f09aea645..bb85d81c25244 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dp.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
> @@ -44,7 +44,6 @@ nouveau_dp_probe_dpcd(struct nouveau_connector *nv_connector,
>         struct nv50_mstm *mstm = NULL;
>         int ret;
>         u8 *dpcd = outp->dp.dpcd;
> -       u8 tmp;
>
>         ret = drm_dp_dpcd_read(aux, DP_DPCD_REV, dpcd, DP_RECEIVER_CAP_SIZE);
>         if (ret == DP_RECEIVER_CAP_SIZE && dpcd[DP_DPCD_REV]) {
> @@ -56,19 +55,10 @@ nouveau_dp_probe_dpcd(struct nouveau_connector *nv_connector,
>                 return connector_status_disconnected;
>         }
>
> -       if (nouveau_mst)
> +       if (nouveau_mst) {
>                 mstm = outp->dp.mstm;
> -
> -       if (mstm) {
> -               if (dpcd[DP_DPCD_REV] >= DP_DPCD_REV_12) {
> -                       ret = drm_dp_dpcd_readb(aux, DP_MSTM_CAP, &tmp);
> -                       if (ret < 0)
> -                               return connector_status_disconnected;
> -
> -                       mstm->can_mst = !!(tmp & DP_MST_CAP);
> -               } else {
> -                       mstm->can_mst = false;
> -               }
> +               if (mstm)
> +                       mstm->can_mst = drm_dp_has_mst(aux, dpcd);
>         }
>
>         return connector_status_connected;
> --
> 2.26.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
