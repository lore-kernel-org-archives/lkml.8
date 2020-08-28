Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D4BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781FB2098B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598597311;
	bh=TkhgczOGtkifWB/TVIlRts5Vlh4369xzTFV+is7IYo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E5GeTupCNgaoOCE570cPmyFWgH7Kd8bXy3dr+L/qLzniRgDIRkB7jx4M1kpmB/WFW
	 lbP9k/QNZYkp8WvTTV0cXOULb6wpuIU8s++mSFUg+aDkc5tJRK14zzUqS2yOpWQTJh
	 C5vsKuFPSpnUTi78SQM33lKzxg9N5DvJpZSc845Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgH1GsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 02:48:19 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:40217 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgH1GsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 02:48:17 -0400
Received: by mail-ej1-f68.google.com with SMTP id o18so93255eje.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 23:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yGha4SiD+sJIY9+V0onyYAsFpD65q4MyMopm/dvyYaY=;
        b=QCTH3cQnG7wXYfj1DjdsdM9+DYXcwdAKbX6r9tB87itXGO7HvJjWz+Y7FVt1RkjL7u
         zsPqkbYgSMpLv4zSW5vyFkZGmIHEYk+GEOhMxpqbXiS5dc+anc/naEcwcpspdE1kj2cl
         4lXmODdVxkCx6qgWHDo/1m36gqWw6qPolF9NtCdsHJEiiiW7pe4S7shlCN1iCbXHNaY/
         oy1N2OH64RPuNAzIwep6PtvXegGDuJiCebf+3uiSdmRbY1xNkLr/5Hym3ghtbYAd6OFb
         72aABIBva0TA8pfEnc0GH9bdC477xJfmvW8mHJwIM7hVGOOW0HEshYCd5JpdcVloqR3y
         X8tA==
X-Gm-Message-State: AOAM530GTziBcq7CVuROvFVgMhMJZX4/DQ7X7qxRiIJAAS4yBgS0+K7f
        vG9MHF/b1Lc2um/7O86oxxlwKZKfCbWW6qAa
X-Google-Smtp-Source: ABdhPJxhsWIy8WW+Tr4xQbQCXRqLiOto2ndTlcft3CciYCq2dpG8mxvQSmAG9Sd2ZbVjMFwrTmeR6Q==
X-Received: by 2002:a17:906:4c97:: with SMTP id q23mr327734eju.11.1598597295563;
        Thu, 27 Aug 2020 23:48:15 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id dr21sm22807ejc.112.2020.08.27.23.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 23:48:15 -0700 (PDT)
Date:   Fri, 28 Aug 2020 08:48:12 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 2/2] ASoC: wm8994: Ensure the device is resumed in
 wm89xx_mic_detect functions
Message-ID: <20200828064812.GE17406@pi3>
References: <20200827173357.31891-1-s.nawrocki@samsung.com>
 <CGME20200827173426eucas1p13f9f7d358dfcc440db160de3dc658ddf@eucas1p1.samsung.com>
 <20200827173357.31891-2-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827173357.31891-2-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 07:33:57PM +0200, Sylwester Nawrocki wrote:
> When the wm8958_mic_detect, wm8994_mic_detect functions get called from
> the machine driver, e.g. from the card's late_probe() callback, the CODEC
> device may be PM runtime suspended and any regmap writes have no effect.
> Add PM runtime calls to these functions to ensure the device registers
> are updated as expected.
> This suppresses an error during boot
> "wm8994-codec: ASoC: error at snd_soc_component_update_bits on wm8994-codec"
> caused by the regmap access error due to the cache_only flag being set.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/codecs/wm8994.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index b3ba053..fc9ea19 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -3514,6 +3514,8 @@ int wm8994_mic_detect(struct snd_soc_component *component, struct snd_soc_jack *
>  		return -EINVAL;
>  	}
>  
> +	pm_runtime_get_sync(component->dev);

The driver enables PM runtime unconditionally so you should probably
handle the error code here. I know that driver does not do it in other
cases but it should not be a reason to multiple this pattern... unless
it really does not matter as there are no runtime PM ops?

Best regards,
Krzysztof
