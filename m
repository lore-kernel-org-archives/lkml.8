Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29950C55196
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0000320706
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnG+O4+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgDYHta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 03:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgDYHt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 03:49:29 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BB6C09B049
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 00:49:28 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id di6so5887471qvb.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BgbYCAeNQS+0nZ7Fig9vtQKe5K6A7aPPzIrm8C7qsUo=;
        b=CnG+O4+oOV8iNbmiQlvDFqsA7UGQFM7lwHR/uXwOIq6fSWfg2UihtiYQvVvwKZGx80
         Oo7g3L9ILVnmm5FwSeZY3gPrXkK0x0hKBv0KvYXigh7O7th8Xndn4PWCvbqj0KVonEwu
         7ZR6VvHhK8Y0iZpK4n8s/J/ZkqUk9y3WHmiAHGQpaiSYPo+UKeZbyMN5qIo0bCEXZHMH
         zlHBWaEJeARsiEeEZghohFYg80MeDVwSj2BFoUU3kWX1HB0hp7A4BRvjYthgzHQDjg4r
         drAS+b42bIPzFf97etG2yohqn/G9A+6z2EEISXi97Uk1SdMhllxp+siZqfwVq31dXTQ4
         rStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BgbYCAeNQS+0nZ7Fig9vtQKe5K6A7aPPzIrm8C7qsUo=;
        b=IcyAVBlM76CnMwmejIRZDvy4SwB1PhlBKv7QHw2wZ+osOV9QeXiNkKxMVcDL+6kvr5
         +/ldLnHnb44tvbbT3btzkB+eCa92sEPkL3RIh/aZDm+w+3lEv4UUzDXDZrpPK0TRT29N
         pNHKTgdyq7sH25xLR9MtXlkS3tuxbuN8QFetJOwfZ8w7sx2d8V+fMiCHtw/SNlEKBO13
         TmIZ+9QwO5fddEOzHWcV6bmvY/QaR+rkRERKF5+IVcesGCgD60VCR/tflE2F1Op+txGu
         AWJsMJGKMUNvLu18fHe1xMhRXh2WBgzpDhzpyjYl2fb+bhUu9F4ZgtGmGgseqXJ8vmbk
         T5Fw==
X-Gm-Message-State: AGi0PubLDJVq3gxiwdadaELw3ztAQj+QD0XLon62ioPa9AXMW6RPXKcc
        cuPXORnxWA1nd/gkC2TFhuDrP+t2q6Bz7mLgdew=
X-Google-Smtp-Source: APiQypIZ9cAxzqkKEzDmAZGMWki+YHf3qfiPJ4v1ZBfa7GRLio9jmFZpssBeF/e7X4lg8j6LVxO9uU8x48sUYrDjy4s=
X-Received: by 2002:a0c:a9c2:: with SMTP id c2mr12947457qvb.23.1587800967701;
 Sat, 25 Apr 2020 00:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <d23c939f1c9eeb3fce34b6c34d44e2d6156f663a.1587799355.git.shengjiu.wang@nxp.com>
In-Reply-To: <d23c939f1c9eeb3fce34b6c34d44e2d6156f663a.1587799355.git.shengjiu.wang@nxp.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Sat, 25 Apr 2020 15:49:16 +0800
Message-ID: <CAA+D8APuhgO0DF74GtCcR1AXTU0ZRR+Njupr0VP4o5jNgTQ3ew@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_easrc: Check for null pointer before
 dereferencing "ctx" in fsl_easrc_hw_free()
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>, perex@perex.cz,
        Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 3:30 PM Shengjiu Wang <shengjiu.wang@nxp.com> wrote=
:
>
> The patch 955ac624058f: "ASoC: fsl_easrc: Add EASRC ASoC CPU DAI
> drivers" from Apr 16, 2020, leads to the following Smatch complaint:
>
> sound/soc/fsl/fsl_easrc.c:1529 fsl_easrc_hw_free()
> warn: variable dereferenced before check 'ctx' (see line 1527)
>
> sound/soc/fsl/fsl_easrc.c
>   1526          struct fsl_asrc_pair *ctx =3D runtime->private_data;
>   1527          struct fsl_easrc_ctx_priv *ctx_priv =3D ctx->private;
>                                                       ^^^^^
> Dereference
>
>   1528
>   1529          if (ctx && (ctx_priv->ctx_streams & BIT(substream->stream=
))) {
>                     ^^^
> This check is too late, to prevent a NULL dereference.
>
>   1530                  ctx_priv->ctx_streams &=3D ~BIT(substream->stream=
);
>   1531                  fsl_easrc_release_context(ctx);
>
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Sorry=EF=BC=8CI forgot the changes:
changes in v2:
- refine the commit subject.

best regards
Wang shengjiu

>  sound/soc/fsl/fsl_easrc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> index 97658e1f4989..20326bffab64 100644
> --- a/sound/soc/fsl/fsl_easrc.c
> +++ b/sound/soc/fsl/fsl_easrc.c
> @@ -1524,9 +1524,14 @@ static int fsl_easrc_hw_free(struct snd_pcm_substr=
eam *substream,
>  {
>         struct snd_pcm_runtime *runtime =3D substream->runtime;
>         struct fsl_asrc_pair *ctx =3D runtime->private_data;
> -       struct fsl_easrc_ctx_priv *ctx_priv =3D ctx->private;
> +       struct fsl_easrc_ctx_priv *ctx_priv;
>
> -       if (ctx && (ctx_priv->ctx_streams & BIT(substream->stream))) {
> +       if (!ctx)
> +               return -EINVAL;
> +
> +       ctx_priv =3D ctx->private;
> +
> +       if (ctx_priv->ctx_streams & BIT(substream->stream)) {
>                 ctx_priv->ctx_streams &=3D ~BIT(substream->stream);
>                 fsl_easrc_release_context(ctx);
>         }
> --
> 2.21.0
>
