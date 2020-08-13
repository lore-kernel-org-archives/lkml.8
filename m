Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFF1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF7020716
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VKZLwG+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgHMGZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 02:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgHMGZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:25:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278D8C061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:25:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so4165128wrl.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rkxg7BbjMCs7clQXqrkuuJfUcLuYZQzc5cqQVGT0bkA=;
        b=VKZLwG+LBvxKNHW01Y5Vq1/8AYhApv5uc8wgcsV/vbbo4UJGTn/e5mkESWhcGdLN1z
         9WWewNaDZMHCE+ZCrJMu3icDG4+cPlyocZWkv0BwiQvVqFNGfAhD0jvtaOrwou6FzGr4
         pL6Fs3rCu1m/uUWiC6PdMZz9hLGdlCSTrNt6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rkxg7BbjMCs7clQXqrkuuJfUcLuYZQzc5cqQVGT0bkA=;
        b=H9ZjT1g6W6AlaiUJtzFRT3k2T3hXn2tcq+PHmwqwGTbip0s0hW6BAdKyFYEQAoKTxU
         e9Nm/M2ojRjDr8xDZ/kw+QS9fq2ptT7kifldvxJYjkQdk4cq7oGc1KoKOElqpCIrpjVL
         oAf4q4TlxeXANrCJ7zy0Z0oxBG/+tqJKRwMnCi2rnei9bOZ+aTscy6QCrs6mOE6Oaosr
         eU8KLS1vRxehJQvH6Ww0KNBl+6vCt4qjKOby4Rb+pBtsiDmTSEUqnMs+FS9GiTwT2+Th
         DkhRyoXPpNfqVC8t0OZZTBMvlx8t6/jDwIBzBG3BTkJ9tamjQeUAPIOabR/trNeE8HkO
         8B8w==
X-Gm-Message-State: AOAM531fmS5BKGsfYy5/befOxQ+ar01MQ6xNSBFeVqsMKgLnC8Bcfhly
        IOBC4RzjBow86YheLBxkRjMmhjr3yYx8wCW3jAkVJA==
X-Google-Smtp-Source: ABdhPJwX7HQyKe8Lf22vhQBwhwUlh4q7DNvkacWIafhRKIRTVUNnp1ZfiClutenFSWuoQDpO5dzZeguBrPMnyG5BM9s=
X-Received: by 2002:adf:97d3:: with SMTP id t19mr2321367wrb.138.1597299905388;
 Wed, 12 Aug 2020 23:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <3f3baf5e-f73d-9cd6-cbfb-36746071e126@linux.intel.com>
 <CAGvk5PogmqfEnFRA8hzby+AGgbOSvbELamh_1=eA9KTpyBMPYQ@mail.gmail.com>
 <s5htux939x1.wl-tiwai@suse.de> <CAGvk5PpcmkZ2HarqeCDaXm4id=84wYs-u4vWxJunHaf09gj66g@mail.gmail.com>
 <s5ho8nh37br.wl-tiwai@suse.de> <CAGvk5PphzkdiNfW8hiDuqX+2eQO2FvrpzA0qR3=3VvqM3GBhAA@mail.gmail.com>
 <20200811145353.GG6967@sirena.org.uk> <d78f9adc-d583-f0f2-ce38-3c9175c939b8@linux.intel.com>
 <20200811172209.GM6967@sirena.org.uk> <CAGvk5PqGi7cXthLHFi4NyypxFiGnoHvD9vp+5nJdH-_VkVvcKw@mail.gmail.com>
 <s5hr1scz908.wl-tiwai@suse.de> <CAGvk5Pp+Gk5Uk-iLdhVPWuCL0FiL9OhsaAtwkotay5JAYUNxdQ@mail.gmail.com>
 <s5hlfikz6y8.wl-tiwai@suse.de> <CAGvk5Pq3rEGJX=WjriPfWg_sEAVWHGZ9S=4iySNfYaHX7Xcw0g@mail.gmail.com>
 <s5h8sekz4ox.wl-tiwai@suse.de> <e4cc6231-8b19-c145-1b18-91d3a00131d3@linux.intel.com>
 <s5hv9hnx6am.wl-tiwai@suse.de> <be45d821-57c6-6ca5-0864-ac3aa521d82e@linux.intel.com>
 <DM6PR11MB364242D3652EDC2F9B8B214897420@DM6PR11MB3642.namprd11.prod.outlook.com>
 <0714b222-d3fc-5744-1147-bfac7df2651e@linux.intel.com>
In-Reply-To: <0714b222-d3fc-5744-1147-bfac7df2651e@linux.intel.com>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Thu, 13 Aug 2020 14:24:54 +0800
Message-ID: <CAGvk5Pqg000SnrRhVD+8cOtAVokomRSa6MLdaKKnY2P6R_ruGA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago board
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Lu, Brent" <brent.lu@intel.com>, Takashi Iwai <tiwai@suse.de>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        "yuhsuan@google.com" <yuhsuan@google.com>,
        Damian van Soelen <dj.vsoelen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> =E6=96=BC
2020=E5=B9=B48=E6=9C=8813=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:=
38=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> On 8/12/20 11:08 AM, Lu, Brent wrote:
> >>>
> >>> I also wonder what's really missing, too :)
> >>>
> >>> BTW, I took a look back at the thread, and CRAS seems using a very
> >>> large buffer, namely:
> >>> [   52.434791] sound pcmC1D0p:   PERIOD_SIZE [240:240]
> >>> [   52.434802] sound pcmC1D0p:   BUFFER_SIZE [204480:204480]
> >>
> >> yes, that's 852 periods and 4.260 seconds. Never seen such values :-)
> >
> > CRAS calls snd_pcm_hw_params_set_buffer_size_max() to use as large
> > buffer as possible. So the period size is an arbitrary number in differ=
ent
> > platforms. Atom SST platform happens to be 256, and CML SOF platform
> > is 1056 for example.
>
> ok, but earlier in this thread it was mentioned that values such as 432
> are not suitable. the statement above seems to mean the period actual
> value is a "don't care", so I don't quite see why this specific patch2
> restricting the value to 240 is necessary. Patch1 is needed for sure,
> Patch2 is where Takashi and I are not convinced.

I have downloaded the patch1 but it does not work. After applying
patch1, the default period size changes to 320. However, it also has
the same issue with period size 320. (It can be verified by aplay.)
