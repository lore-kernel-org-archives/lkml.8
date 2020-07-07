Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FE8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22616206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594119656;
	bh=SPhgPQejzR/07fcEolAXk+aK9D/qqSFwLNJIywwhpVI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PCUHNeE4sUMzDuW/z6Du5ZtMLkKe8LPipB7XjDv3ENs6l9Qj0iMZesjIXXKj5XZ+l
	 ujn5BzoU7gy7s0Naf9XhObaTDaCQjVKNc8FWCtDFEwAgn2QPzsXmPCmCQAxHdIqClF
	 Qz6pGHs1wvImuHt/FSKs075F9rGU2TznRkxKyvY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgGGLAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:00:54 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:57610 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGGLAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:00:54 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 067B0M3d019851
        for <linux-kernel@vger.kernel.org>; Tue, 7 Jul 2020 20:00:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 067B0M3d019851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594119623;
        bh=4yu2n3n5C/fRjnuTP126S3/fQ4gXKW38TCxG+vu9Yfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QhMl2uhfl8jVzfqfeZAGj4XD2OPl5Z51Y3YdlFy2LpD7O6dm6hk3OPB+nQZhEF2S/
         M4qrJd42cOhz3lhbpQxCeliFSRXJTGQhbi+XbjbC6T9d02Yv/XTkQI01H5hNmAwAxC
         6tFLHux7puahnHIhq42mGspsB1RAtrwEJmJ9ThFdfGNHqOX/WT0jGrxKqxrab86hOp
         NNddFl4hv1tktjJM1sXQK//sNUo5KF4aLF+d7tJzGXppRmc6rWTannpejWzalJWbEN
         9WzY/XmlJI/bcYnDsL4J3Yx9UHY7xYF6A45BhwtuCEEkr6iQLDAryAuwijan0sGwB1
         JbnTxU38gSmHw==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id b24so5601318uak.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:00:22 -0700 (PDT)
X-Gm-Message-State: AOAM5337T6lMiKslCEkJT01jRcDSL+8tuB1k8WxHwXDjwgLFu5GxR3tB
        VF7zD7WaknUmOPr1fTR0w2ZStSd6Oyx2J3xn1G0=
X-Google-Smtp-Source: ABdhPJymeeoDYkbNlY6GxjialEfi35FAedJEi2UP4hQmNNDZE11PD/TRgqjDOK419vOntfEQFPdcUsPXFEPdhUoJYxQ=
X-Received: by 2002:ab0:5b91:: with SMTP id y17mr38993416uae.95.1594119621316;
 Tue, 07 Jul 2020 04:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200707101642.1747944-1-lee.jones@linaro.org> <20200707101642.1747944-18-lee.jones@linaro.org>
In-Reply-To: <20200707101642.1747944-18-lee.jones@linaro.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 7 Jul 2020 19:59:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQynE+HJDf=qGkw9qxTeHd81DZmiM2iXhODkWHNd9qXig@mail.gmail.com>
Message-ID: <CAK7LNAQynE+HJDf=qGkw9qxTeHd81DZmiM2iXhODkWHNd9qXig@mail.gmail.com>
Subject: Re: [PATCH 17/28] ASoC: uniphier: aio-core: Fix incorrectly named
 struct property and remove another
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 7:18 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Both issues are likely due to bitrot.  Let's bring them up-to-date.
>
> Fixes the following W=1 kernel build warning(s):
>
>  sound/soc/uniphier/aio-core.c:107: warning: Function parameter or member 'pll_id' not described in 'aio_chip_set_pll'
>  sound/soc/uniphier/aio-core.c:107: warning: Excess function parameter 'source' description in 'aio_chip_set_pll'
>  sound/soc/uniphier/aio-core.c:279: warning: Excess function parameter 'ch' description in 'aio_port_set_ch'
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>

but Pierre-Louis Bossart had already sent an equivalent patch.



> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  sound/soc/uniphier/aio-core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
> index 9bcba06ba52ea..86eb0915d80ad 100644
> --- a/sound/soc/uniphier/aio-core.c
> +++ b/sound/soc/uniphier/aio-core.c
> @@ -93,9 +93,9 @@ void aio_iecout_set_enable(struct uniphier_aio_chip *chip, bool enable)
>
>  /**
>   * aio_chip_set_pll - set frequency to audio PLL
> - * @chip  : the AIO chip pointer
> - * @source: PLL
> - * @freq  : frequency in Hz, 0 is ignored
> + * @chip:      the AIO chip pointer
> + * @pll_id:    PLL
> + * @freq:      frequency in Hz, 0 is ignored
>   *
>   * Sets frequency of audio PLL. This function can be called anytime,
>   * but it takes time till PLL is locked.
> @@ -267,7 +267,6 @@ void aio_port_reset(struct uniphier_aio_sub *sub)
>  /**
>   * aio_port_set_ch - set channels of LPCM
>   * @sub: the AIO substream pointer, PCM substream only
> - * @ch : count of channels
>   *
>   * Set suitable slot selecting to input/output port block of AIO.
>   *
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
