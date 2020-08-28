Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD27C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F68D2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598605811;
	bh=Q6lzh15EtIDgKW4H3rKBBLyCxSNmFOKGiUTZcN/8FFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QZ46Kf4lbV2e7yojqat4tOEQToeOrYIYU0btaR67OmV3AzZS86efx5l7tUN0vn2Eh
	 dqj5lM+d/ZGe1Mgr29+uk3xnGXgzpYm8oYYVq138crplJm94FY5OOyjP3+rJ5+SaDw
	 r91RnJCLv9apYhoQ3NgTxPle+AsWTOjsYu5K6lwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgH1JKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:10:10 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:34842 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbgH1JKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:10:09 -0400
Received: by mail-ej1-f68.google.com with SMTP id a26so588955ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mJubNjqa+XudkEa895Ask1EqV4yYrNAcnoAT4Dsx/b8=;
        b=E1iAKIwbDTTxiyC9enxoi9QX88rw+hLXErVd7x4zXjy42y/cmkPeq/e/ADC7bHmJvI
         6ljF1XS5UdK1boRQEBDf3mYM4IevYs3uw1mLDenvSyy6eWZKCKBxCIR++vF321XsPNYI
         uwZCTMkG/AhC7dsQlct0UF6dCi9VvZzUqJJ10iljwIqPmsUpJht5f8eoND1lOvdGtV/U
         +PLSnzJsX9gYGfwgQCRu7Wl3swDRk9/cFFL0kkX3uvV8qwcnQSpOCLCieoGi2ADtIpHa
         WYIeI1bigwwtMWgAcp3wDngE4lci4tol072jfqY0G9kdqmB2T4gESG+3yj+0sW8mo3HS
         F9Jg==
X-Gm-Message-State: AOAM533JJNiPrj+SvDigZzKK+/FhDMPDNFfqvaQ3VvVVcVK0epEmwAdK
        9NgsuaquFpPLZNoM62XhYHm1F42ggJV+SXjq
X-Google-Smtp-Source: ABdhPJyooERpw0LvwmLPaTV9qsPD6VFRMiJ7F0Sb8CfrTLmnOOtarEgEd5+QSZafBe3+gniR2X8RMw==
X-Received: by 2002:a17:906:7c82:: with SMTP id w2mr755460ejo.87.1598605807481;
        Fri, 28 Aug 2020 02:10:07 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id q14sm448658edv.54.2020.08.28.02.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 02:10:06 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:10:04 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 2/2] ASoC: wm8994: Ensure the device is resumed in
 wm89xx_mic_detect functions
Message-ID: <20200828091004.GA17786@pi3>
References: <20200827173357.31891-1-s.nawrocki@samsung.com>
 <CGME20200827173426eucas1p13f9f7d358dfcc440db160de3dc658ddf@eucas1p1.samsung.com>
 <20200827173357.31891-2-s.nawrocki@samsung.com>
 <20200828064812.GE17406@pi3>
 <28723053-c305-d359-3862-656ade11bf74@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28723053-c305-d359-3862-656ade11bf74@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 10:50:33AM +0200, Sylwester Nawrocki wrote:
> On 28.08.2020 08:48, Krzysztof Kozlowski wrote:
> >> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> >> index b3ba053..fc9ea19 100644
> >> --- a/sound/soc/codecs/wm8994.c
> >> +++ b/sound/soc/codecs/wm8994.c
> >> @@ -3514,6 +3514,8 @@ int wm8994_mic_detect(struct snd_soc_component *component, struct snd_soc_jack *
> >>  		return -EINVAL;
> >>  	}
> >>  
> >> +	pm_runtime_get_sync(component->dev);
> 
> > The driver enables PM runtime unconditionally so you should probably
> > handle the error code here. I know that driver does not do it in other
> > cases but it should not be a reason to multiple this pattern... unless
> > it really does not matter as there are no runtime PM ops?
> 
> The regmap is provided by the parent MFD device (drivers/mfd/wm8994-core.c)
> and that is where those runtime PM calls get propagated, we could possibly
> get en error if there is something wrong with resuming the parent device.
> 
> If you don't mind I would prefer to omit the return value tests in that
> fix patch. Existing callers of the wm89*_mic_detect() functions are 
> ignoring the return value anyway. Probably the checks could be added 
> in a separate patch. 

I don't mind.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

