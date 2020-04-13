Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22679C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6B6206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586780138;
	bh=I6u5nJX+v3gJqSQyOJNA0fIQf+n4hfhFOsPbgSruo7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rAtzIqtqv22BV48LLG8znqbqbGjNCKN+sdeUfC+AAW3hS4J77TO3XIJ0+m4QnLc3m
	 KDECSFAFpSHjV0JoTWmr+EZhVRsbYlk3eNZ2/2JZ++KTfYXi1kZpOLzTIgaGnCoHYS
	 C46YMpyf2yuUJbZ9wh6onPTIRZP4c0U1DloSBru8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgDMMPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:15:36 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:32794 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgDMMPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:15:35 -0400
Received: by mail-ed1-f41.google.com with SMTP id z65so11755223ede.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 05:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9YJKgQFf9t5/ZOVeXCDhEo4n2HKOssPBhy3fPCqfEpo=;
        b=X0zjaddkShwVvPzKqJpFUSjjWdZeH7jHyoQI0x5l+6vyKBPQfb9zBVIWwnqxmEfvMw
         0pvzulUpL9dNwbAuJ5Gb1nuuG4eGB8lzbqRr2gH2g10ZrmjoIx4qgp4OqVk114jPc31H
         4CNfbNpto8g7l7lwOAbwrQc6MPYeshfIOmoNsXgpidssf8/x8m8Fg+x68dABwrAt1v5p
         QAasmKnYBWQppjJKYH3Vk5ovscjTUHt20FfSEuS1tBfnxm2ehlPVFw6dBnBrzUgJn1hK
         ybs/ns0IG2KpVvU57pjNMXXG7b7W3LEq32fcn2bZvZF+bV3dcuy388S8WAIWNCQUC8at
         i8Ww==
X-Gm-Message-State: AGi0Pub2L6mFNLu6mcE8UwN4vtYYiLCnhalP/NVI/5t9kseMc3DGPyJC
        WzJVgn2rabN+SEkOx2DL3bs=
X-Google-Smtp-Source: APiQypJNxCoN/5n4rPjzHYpBIZwWKiVt224/0H4faLSZIwXiff05UKjmeUMQzAzxJRMUy4LNfII+SQ==
X-Received: by 2002:a17:906:e01:: with SMTP id l1mr15105365eji.76.1586780132912;
        Mon, 13 Apr 2020 05:15:32 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id k18sm1570960ejq.84.2020.04.13.05.15.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Apr 2020 05:15:32 -0700 (PDT)
Date:   Mon, 13 Apr 2020 14:15:30 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: ASoC: s3c-i2s-v2 regression, was: [GIT PULL] sound updates for
 5.6-rc1
Message-ID: <20200413121530.GA5200@kozik-lap>
References: <s5h5zgwouw8.wl-tiwai@suse.de>
 <CAK8P3a1La1gbSp0A9JaQ5KavGELQ8NsKQvCdAdya24agJzTOJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1La1gbSp0A9JaQ5KavGELQ8NsKQvCdAdya24agJzTOJA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 10:41:52AM +0200, Arnd Bergmann wrote:
> On Tue, Jan 28, 2020 at 9:21 AM Takashi Iwai <tiwai@suse.de> wrote:
> 
> > Kuninori Morimoto (66):
> >       ASoC: bcm: cygnus-ssp: move .suspend/.resume to component
> >       ASoC: atmel: atmel_ssc_dai: move .suspend/.resume to component
> >       ASoC: cirrus: ep93xx-i2s: move .suspend/.resume to component
> >       ASoC: jz4740: jz4740-i2s: move .suspend/.resume to component
> >       ASoC: mediatek: move .suspend/.resume to component
> >       ASoC: samsung: s3c24xx-i2s: move .suspend/.resume to component
> >       ASoC: samsung: spdif: move .suspend/.resume to component
> >       ASoC: sti: sti_uniperif: move .suspend/.resume to component
> >       ASoC: ti: omap-mcpdm: move .suspend/.resume to component
> >       ASoC: uniphier: move .suspend/.resume to component
> >       ASoC: dwc: dwc-i2s: move .suspend/.resume to component
> >       ASoC: samsung: i2s: move .suspend/.resume to component
> >       ASoC: ux500: ux500_msp_dai: remove unused DAI .suspend/.resume
> >       ASoC: pxa: pxa-ssp: move .suspend/.resume to component
> >       ASoC: pxa: pxa2xx-i2s: move .suspend/.resume to component
> >       ASoC: soc-core: remove DAI suspend/resume
> 
> I only found it now during randconfig testing, but it seems that there is
> (at least) one patching in this conversion series that was part of linux-5.6:
> 
> sound/soc/samsung/s3c-i2s-v2.c: In function 's3c_i2sv2_register_component':
> sound/soc/samsung/s3c-i2s-v2.c:726:9: error: 'struct
> snd_soc_dai_driver' has no member named 'suspend'
>   726 |  dai_drv->suspend = s3c2412_i2s_suspend;
>       |         ^~
> sound/soc/samsung/s3c-i2s-v2.c:727:9: error: 'struct
> snd_soc_dai_driver' has no member named 'resume'
>   727 |  dai_drv->resume = s3c2412_i2s_resume;
>       |         ^~
> 
> I tried fixing it myself but could not see an obvious solution. Can someone
> else who understands this code better than me have a look?

This can be triggered after enabling SND_SOC_SAMSUNG and
SND_SOC_SAMSUNG_JIVE_WM8750.

I can fix it but only compile-tested.

Best regards,
Krzysztof


