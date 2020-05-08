Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D380C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10CC02184D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K1x45ekd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgEHQ4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgEHQ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:56:34 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D24CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 09:56:34 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id f12so1742493edn.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSHE/cDUYWET1agiZaWzN/cLhWh+dKZVdX5a77HIV0o=;
        b=K1x45ekdP5M5U1MQqp4w0sbhv6u1/qfAEDLNfXKxfqr5iK3JD9mMli3EIjS1druXx4
         I+/2i166tr6/suS6hqQgXXhRD4Mw7UhlO6V7jlEu3JhlhAdCjNiMoNa0EibtMdpvRMvm
         s2Amar7H23yx37oA/d7ZX04clDeVlZRlKHpCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSHE/cDUYWET1agiZaWzN/cLhWh+dKZVdX5a77HIV0o=;
        b=hxB6hKev4grE/bHxYFte4XGCmIr/IE3Pxs1bEY8gByrDBQ/vEmbadxjGaQH4qBjeSI
         zAIrzStrQKhRoQV2vTgZ/MEXAUvP33OcBOJ36JnMEf6yk7SbkcWx96Zz9X8mOS1z6gNw
         LhK/BZVE0/vJozqunWDb/EjnYBH5MYNYEEZCImCPKnr7tNG2zUlMpvs+Kt+4d1tMe0lR
         bfS9ej71qRBTy8oVySvlMvk07nHmwjGfmmiegeuYaw7wmMTtgAfwGhWYXSjgzZoqnvnv
         nn5nyiJJm1NiKtexwKoq9jBXbWlYiwlkn/8epEEdJbV9uVbuSuT947EOpA+mbYWIcRlQ
         FyuA==
X-Gm-Message-State: AGi0Pub5z4jQqeZSnS4wo0KlhygwjiPPVjYN6sWSHfbJ9yJXTm/JlAee
        79kKqqYXSZxzSP81pjU1NKSvo8DbmVXWgA==
X-Google-Smtp-Source: APiQypIh25SSSCGcvHAl1MjhozEe9CAxKYa6V/sufOjW6Ko2OeGYinbcCBCShfJz25u10ezlP/sVuA==
X-Received: by 2002:aa7:df8a:: with SMTP id b10mr3024424edy.263.1588956992534;
        Fri, 08 May 2020 09:56:32 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id r4sm240105ejz.28.2020.05.08.09.56.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 09:56:31 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id 50so2156103wrc.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 09:56:31 -0700 (PDT)
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr3817089wrw.17.1588956990811;
 Fri, 08 May 2020 09:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134110.3435-1-ezequiel@collabora.com> <20200505134110.3435-4-ezequiel@collabora.com>
 <8e8eda07-e5f5-86dc-899b-0823ea0479f2@xs4all.nl> <b2160325f5b9bae5b437a37069db926d2a464e8d.camel@collabora.com>
In-Reply-To: <b2160325f5b9bae5b437a37069db926d2a464e8d.camel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 8 May 2020 18:56:18 +0200
X-Gmail-Original-Message-ID: <CAAFQd5C3MpWqRRMGQJTW8rNz65T2CRYj6yFa56mJWR+DFqrFzg@mail.gmail.com>
Message-ID: <CAAFQd5C3MpWqRRMGQJTW8rNz65T2CRYj6yFa56mJWR+DFqrFzg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] media: rkvdec: Add the VP9 backend
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Alexandre Courbot <acourbot@chromium.org>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 6:26 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> On Fri, 2020-05-08 at 12:34 +0200, Hans Verkuil wrote:
> > On 05/05/2020 15:41, Ezequiel Garcia wrote:
> > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > >
> > > The Rockchip VDEC supports VP9 profile 0 up to 4096x2304@30fps. Add
> > > a backend for this new format.
> > >
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > > ---
> > >  drivers/staging/media/rkvdec/Makefile     |    2 +-
> > >  drivers/staging/media/rkvdec/rkvdec-vp9.c | 1577 +++++++++++++++++++++
> > >  drivers/staging/media/rkvdec/rkvdec.c     |   56 +-
> > >  drivers/staging/media/rkvdec/rkvdec.h     |    6 +
> > >  4 files changed, 1637 insertions(+), 4 deletions(-)
> > >  create mode 100644 drivers/staging/media/rkvdec/rkvdec-vp9.c
> > >
> > > diff --git a/drivers/staging/media/rkvdec/Makefile b/drivers/staging/media/rkvdec/Makefile
> > > index c08fed0a39f9..cb86b429cfaa 100644
> > > --- a/drivers/staging/media/rkvdec/Makefile
> > > +++ b/drivers/staging/media/rkvdec/Makefile
> > > @@ -1,3 +1,3 @@
> > >  obj-$(CONFIG_VIDEO_ROCKCHIP_VDEC) += rockchip-vdec.o
> > >
> > > -rockchip-vdec-y += rkvdec.o rkvdec-h264.o
> > > +rockchip-vdec-y += rkvdec.o rkvdec-h264.o rkvdec-vp9.o
> > > diff --git a/drivers/staging/media/rkvdec/rkvdec-vp9.c b/drivers/staging/media/rkvdec/rkvdec-vp9.c
> > > new file mode 100644
> > > index 000000000000..37d0ea4e3570
> > > --- /dev/null
> > > +++ b/drivers/staging/media/rkvdec/rkvdec-vp9.c
> > > @@ -0,0 +1,1577 @@
> >
> > <snip>
> >
> > > +static void init_inter_probs(struct rkvdec_ctx *ctx,
> > > +                        const struct rkvdec_vp9_run *run)
> > > +{
> > > +   const struct v4l2_ctrl_vp9_frame_decode_params *dec_params;
> > > +   struct rkvdec_vp9_ctx *vp9_ctx = ctx->priv;
> > > +   struct rkvdec_vp9_priv_tbl *tbl = vp9_ctx->priv_tbl.cpu;
> > > +   struct rkvdec_vp9_inter_frame_probs *rkprobs;
> > > +   const struct v4l2_vp9_probabilities *probs;
> > > +   unsigned int i, j, k;
> > > +
> > > +   rkprobs = &tbl->probs.inter;
> > > +   dec_params = run->decode_params;
> > > +   probs = &dec_params->probs;
> > > +
> > > +   /*
> > > +    * inter probs
> > > +    * 151 x 128 bits, aligned to 152 x 128 bits
> > > +    * inter only
> > > +    * intra_y_mode & inter_block info 6 x 128 bits
> > > +    */
> > > +
> > > +   memcpy(rkprobs->y_mode, probs->y_mode, sizeof(rkprobs->y_mode));
> > > +   memcpy(rkprobs->comp_mode, probs->comp_mode,
> > > +          sizeof(rkprobs->comp_mode));
> > > +   memcpy(rkprobs->comp_ref, probs->comp_ref,
> > > +          sizeof(rkprobs->comp_ref));
> > > +   memcpy(rkprobs->single_ref, probs->single_ref,
> > > +          sizeof(rkprobs->single_ref));
> > > +   memcpy(rkprobs->inter_mode, probs->inter_mode,
> > > +          sizeof(rkprobs->inter_mode));
> > > +   memcpy(rkprobs->interp_filter, probs->interp_filter,
> > > +          sizeof(rkprobs->interp_filter));
> > > +
> > > +   /* 128 x 128 bits coeff related */
> > > +   for (i = 0; i < ARRAY_SIZE(probs->coef); i++) {
> > > +           for (j = 0; j < ARRAY_SIZE(probs->coef[0]); j++) {
> > > +                   for (k = 0; k < ARRAY_SIZE(probs->coef[0][0]); k++)
> > > +                           write_coeff_plane(probs->coef[i][j][k],
> > > +                                             rkprobs->coef[k][i][j]);
> > > +           }
> > > +   }
> > > +
> > > +   /* intra uv mode 6 x 128 */
> > > +   memcpy(rkprobs->uv_mode_0_2, &probs->uv_mode[0],
> > > +          sizeof(rkprobs->uv_mode_0_2));
> > > +   memcpy(rkprobs->uv_mode_3_5, &probs->uv_mode[3],
> > > +          sizeof(rkprobs->uv_mode_3_5));
> > > +   memcpy(rkprobs->uv_mode_6_8, &probs->uv_mode[6],
> > > +          sizeof(rkprobs->uv_mode_6_8));
> > > +   memcpy(rkprobs->uv_mode_9, &probs->uv_mode[9],
> > > +          sizeof(rkprobs->uv_mode_9));
> > > +
> > > +   /* mv related 6 x 128 */
> > > +   memcpy(rkprobs->mv.joint, probs->mv.joint,
> > > +          sizeof(rkprobs->mv.joint));
> > > +   memcpy(rkprobs->mv.sign, probs->mv.sign,
> > > +          sizeof(rkprobs->mv.sign));
> > > +   memcpy(rkprobs->mv.class, probs->mv.class,
> > > +          sizeof(rkprobs->mv.class));
> > > +   memcpy(rkprobs->mv.class0_bit, probs->mv.class0_bit,
> > > +          sizeof(rkprobs->mv.class0_bit));
> > > +   memcpy(rkprobs->mv.bits, probs->mv.bits,
> > > +          sizeof(rkprobs->mv.bits));
> > > +   memcpy(rkprobs->mv.class0_fr, probs->mv.class0_fr,
> > > +          sizeof(rkprobs->mv.class0_fr));
> > > +   memcpy(rkprobs->mv.fr, probs->mv.fr,
> > > +          sizeof(rkprobs->mv.fr));
> > > +   memcpy(rkprobs->mv.class0_hp, probs->mv.class0_hp,
> > > +          sizeof(rkprobs->mv.class0_hp));
> > > +   memcpy(rkprobs->mv.hp, probs->mv.hp,
> > > +          sizeof(rkprobs->mv.hp));
> >
> > Can't you just do: 'rkprobs->mv = probs->mv'?
> >
>
> I think I'd like to keep this as-is.
>
> Having the memcpy makes it explicit that we are copying
> these structs around. While the assignment would
> bring type checking, it can be misleading for readers.

On the other hand, it's not obvious from the code that all fields of
the structure are copied. Perhaps memcpy(&rkprobs->mv, &probs->mv,
sizeof(rkprobs->mv)) would be a good compromise?
