Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AADC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F566206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594119546;
	bh=HgP0jte1uEBp0/EldBW2mmfa/xaCi6WXeXmXNLmIHk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=M8WpJrBxnTAZuN0/X/8hLUpeSyr2fnuHB/6SbEV7GLMhszKuc37G8vtfuqUiG/ocQ
	 0e2GSnqzqtR3w0vkDnUIuv+WW543Ju+6OaNHdSXQyiDlwFcOD8INYJheXBvs5KfF8M
	 5MSjGleXVbUb2ZBXYa/f0LYMdIdtKmMK2LEzti/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgGGK7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:59:05 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:57372 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGGK7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:59:04 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 067AwmIs021946
        for <linux-kernel@vger.kernel.org>; Tue, 7 Jul 2020 19:58:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 067AwmIs021946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594119529;
        bh=Q7blUsQ9JbN98/2v6PmnTU26WzCTrui/OAXxYYFuhio=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dLgZqZOb+1s/K5aLOfNDqded0K4JdophwcRkFTTL4Po8yMixKmG+ezypY5cDyonf4
         2baAVDsHGf9tXnEbJkwAkUxwBjhzElyQYq6jF71BODCtrwzGkQDlhZK+zV5aJ6muWv
         Otb0oPc/nL3cgndiZ0BQSAr/9aeG1Sy5JYzIMpNB/HffKJxL+r+fxAQ4oEfCYwL92T
         LG3UHUJiJIPz3P1f9B/s6n/RGQOyFtSzHitUaiR2rwMA/uy6ZTvGI/rJiRmt5c/B6N
         KHt92Tf5QfGQkq4D9JeqidL8NYp96aajg4loIh+m7/AT8B96bZbBSJemFzbtDhBEqo
         ZmPN9LuYqhm5Q==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id e15so22279646vsc.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:58:49 -0700 (PDT)
X-Gm-Message-State: AOAM53138caLwGcbytUJ5/LNjbWQQi1rlbAOoXpkCReInYDC5g6kRBKn
        XFj9IiD2PHoFWeF2AE2tlwheagP2prWSVKJI1mk=
X-Google-Smtp-Source: ABdhPJx5C6TC1CTC3ZI4pLzUX4bW+vK98tg3hyw8GkksN3pcaONQiKgWX4RJM4Cxt/R3M5Kza1brZQUcvvb5lnQhBNU=
X-Received: by 2002:a67:6c84:: with SMTP id h126mr35660734vsc.181.1594119527826;
 Tue, 07 Jul 2020 03:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com> <20200702165901.164100-9-pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200702165901.164100-9-pierre-louis.bossart@linux.intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 7 Jul 2020 19:58:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNARV9p=TF+5kPx-MBOsGnE9mafndYTEoaWRAaieqeL5a5A@mail.gmail.com>
Message-ID: <CAK7LNARV9p=TF+5kPx-MBOsGnE9mafndYTEoaWRAaieqeL5a5A@mail.gmail.com>
Subject: Re: [PATCH 8/8] ASoC: uniphier: aio-core: fix kernel-doc
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:ARM/UNIPHIER ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 1:59 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> Fix W=1 warning - wrong parameter description and bad format
>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


>  sound/soc/uniphier/aio-core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
> index 9bcba06ba52e..b8195778953e 100644
> --- a/sound/soc/uniphier/aio-core.c
> +++ b/sound/soc/uniphier/aio-core.c
> @@ -93,9 +93,9 @@ void aio_iecout_set_enable(struct uniphier_aio_chip *chip, bool enable)
>
>  /**
>   * aio_chip_set_pll - set frequency to audio PLL
> - * @chip  : the AIO chip pointer
> - * @source: PLL
> - * @freq  : frequency in Hz, 0 is ignored
> + * @chip: the AIO chip pointer
> + * @pll_id: PLL
> + * @freq: frequency in Hz, 0 is ignored
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
