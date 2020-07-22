Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F06C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D3520709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ks1r01r8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbgGVOEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbgGVOEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:04:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407D1C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 07:04:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x5so1491314wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Rs2Y2EqzdkKrOA6XoS+7IQYSW7ep9XsRJtfJ1V00SI=;
        b=ks1r01r8IlR17EoE2Q5OyQVSs4AV9IGOQE1iaO69O1yAzO7nIEE0kbTXCSNW+hmHbm
         RQrHbYI35gsDOVPSFAwtW3J4PPwkOS4OH+pPX3HHOsGNsYhn7f1duuxwYJfCFIWVm9/U
         BZTcbtEpjVEhMLOKSLcMrbEthdks1UCP5rHk+XiUNwf+TywwR8swnUdxnPoTbPd1vPrJ
         JxN9ltz1Mcj6AnzOz7E2oHmT7N0zeSKY1jA+Jac99v/4rO3AFrWeKME/L6wx4Iw/IZ2H
         vl0S02Yj4RUPqrcuYA08ibKKeHPFOkX1ATDQsXqDk/uWWPA8Pz75m758Je0/bUkAJWMC
         Mkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Rs2Y2EqzdkKrOA6XoS+7IQYSW7ep9XsRJtfJ1V00SI=;
        b=sKll4rc76gZOp54htGQ8W2rEvqDfjHLPkHH/MEbvKWfuVXuWC/oqTR0YGctb6wSVei
         xNoR+1Hnrljrrs2Vxm62n47JT1ycEMwR+puIuEiN1qQdIa+DgXJ9IjzwaiVraB8DKV6y
         zFLMMBMDjYjplNYrESIkCmwu6Onuv+sz8trZRKKXK8+UhkY3AmgUfG7ZcBjucrYff0K4
         mPXu9WNgABOFL5AJE//zsAWPNZt4xHwbxiCS+q/l4JQAvHWaeHdHroPQwv22HboLPt3A
         7FPYl06DppVMEEfObOpZeAnn9p/4i0XYk57htl/6B3GxayoVWGjsCee+JA9W+KhytHGW
         dMWg==
X-Gm-Message-State: AOAM530e5hXx0NTFFXui/2fRu4zzW8p1Xk/hgLzrNBxnBJpwk519weuT
        u1eW8aZKSJRZCpRcAP9reENVXL1gfBILGlMoHBY=
X-Google-Smtp-Source: ABdhPJzbBZpmvKOmpiAE1M0Qdqb/UFYsFJDbC0RenHJ5MR1TbtbU/Hqntla9nhteJ8Rfgxb5Lvy5BMZJ2KDmAy9jXz4=
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr2173888wmk.153.1595426682017;
 Wed, 22 Jul 2020 07:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org> <20200721170007.4554-7-srinivas.kandagatla@linaro.org>
In-Reply-To: <20200721170007.4554-7-srinivas.kandagatla@linaro.org>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 22 Jul 2020 17:04:30 +0300
Message-ID: <CAEnQRZA6Y99znD3ZtpuGhc+i-WVDtUW-jP1sF3MTg289S_Mr_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/6] ASoC: q6asm-dai: add support to set_codec_params
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        ckeepax@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 8:03 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Make use of new set_codec_params callback to allow decoder switching
> during gapless playback.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6asm-dai.c | 33 ++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index b5c719682919..a8cfb1996614 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -876,6 +876,37 @@ static int __q6asm_dai_compr_set_codec_params(struct snd_soc_component *componen
>         return 0;
>  }
>
> +static int q6asm_dai_compr_set_codec_params(struct snd_soc_component *component,
> +                                           struct snd_compr_stream *stream,
> +                                           struct snd_codec *codec)
> +{
> +       struct snd_compr_runtime *runtime = stream->runtime;
> +       struct q6asm_dai_rtd *prtd = runtime->private_data;
> +       int ret;
> +
> +       ret = q6asm_open_write(prtd->audio_client, prtd->next_track_stream_id,
> +                              codec->id, codec->profile, prtd->bits_per_sample,
> +                              true);
> +       if (ret < 0) {
> +               pr_err("q6asm_open_write failed\n");

Since you have component->dev here I think it is worth it to use
dev_err instead of pr_err.

Same for the rest of the code.
