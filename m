Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28606C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED36220885
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CJ32tAiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgHJRil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgHJRij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:38:39 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFC7C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 10:38:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k20so326405wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 10:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EcJDg2O7xIbOjM5eLQ8gCplwOfat/XZVzxZppSuBFXA=;
        b=CJ32tAiBMpba2lWqmucba2kWsAmrucVE+nHFEbLfe7F/yDIu8a5GsC+aKvXiXYYyjH
         p6tY4SvZEFynuVENJxRY4zfZMk55Q8+jalMCUt5LbX15hB2LNARaGtL//JDIXpveJBnq
         U97ZMz+k45sAX4uHdrKeocRzAh6Iaba1kKKm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EcJDg2O7xIbOjM5eLQ8gCplwOfat/XZVzxZppSuBFXA=;
        b=WO/4VOJp9+t9GHX/yAEFXpSYiIotEJOBQAXXwynl4qFKF53hisQzFzrouuIs1yg7F/
         RA6aWBXa4CQEnC0BGXgD/0qJ7OhxbxzwGth7A/ak2QPMVVsL3tuvSQhPq7qCrI5NJIMk
         4J3lrKZDz1EhpkFaY6SwUC+7h47AyZJ0EhRROUsKNIeNt6gwRH8BgmN8+D45590kh2H1
         sXKhkma6ahu7i6pUyy/H/TXpiR/wr8D4Esd/f/W+lWPXSlwh4z2LeUhLGRXVvgFeIGnb
         Hw+9bnHC/mNvEP4XBZwfbtoW7dLSj7JF7eLd95rLpu4GkXGfR5G0CM3YEocBOBql8ZNi
         ll9w==
X-Gm-Message-State: AOAM533RSRJ3lAEogzxSOYQKKwWCTqYynmnPVAk8hndwlcE3GzyUhS6+
        j/7K3HRvES05++VzCro5xk6l60mFupozfJwAcPdrAw==
X-Google-Smtp-Source: ABdhPJxWy126EoPeXn68o0RtdQ9AM8iu0r0roUOi2/tEIALG8XKSfLdRwQWvkOSSkWppyvAfQ/KenjZMRMb5iSGO57w=
X-Received: by 2002:a05:600c:2302:: with SMTP id 2mr325053wmo.151.1597081117897;
 Mon, 10 Aug 2020 10:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
 <1596198365-10105-1-git-send-email-brent.lu@intel.com> <1596198365-10105-3-git-send-email-brent.lu@intel.com>
 <s5h5za3ajvb.wl-tiwai@suse.de> <DM6PR11MB3642AE90DF98956CCEDE6C2F974F0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <s5hd04a90o4.wl-tiwai@suse.de> <DM6PR11MB3642B5BC2E1E0708088526D8974D0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <63bca214-3434-16c6-1b60-adf323aec554@linux.intel.com> <DM6PR11MB3642D9BE1E5DAAB8B78B84B0974D0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <s5hpn873by6.wl-tiwai@suse.de> <DM6PR11MB36423A9D28134811AD5A911F974A0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <6466847a-8aae-24f7-d727-36ba75e95f98@linux.intel.com> <DM6PR11MB364259049769F6EF3B84AABD97480@DM6PR11MB3642.namprd11.prod.outlook.com>
 <3f3baf5e-f73d-9cd6-cbfb-36746071e126@linux.intel.com>
In-Reply-To: <3f3baf5e-f73d-9cd6-cbfb-36746071e126@linux.intel.com>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Tue, 11 Aug 2020 01:38:26 +0800
Message-ID: <CAGvk5PohOP0Yv22tb53EX=ZLB9_vOMb=iujTh64OvHmjC1d4mg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago board
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Lu, Brent" <brent.lu@intel.com>, Takashi Iwai <tiwai@suse.de>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuhsuan@google.com" <yuhsuan@google.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Damian van Soelen <dj.vsoelen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> =E6=96=BC
2020=E5=B9=B48=E6=9C=8810=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:=
03=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> On 8/6/20 11:41 AM, Lu, Brent wrote:
> >>
> >> I don't get this. If the platform driver already stated 240 and 960 sa=
mples why
> >> would 432 be chosen? Doesn't this mean the constraint is not applied?
> >
> > Hi Pierre,
> >
> > Sorry for late reply. I used following constraints in V3 patch so any p=
eriod which
> > aligns 1ms would be accepted.
> >
> > +     /*
> > +      * Make sure the period to be multiple of 1ms to align the
> > +      * design of firmware. Apply same rule to buffer size to make
> > +      * sure alsa could always find a value for period size
> > +      * regardless the buffer size given by user space.
> > +      */
> > +     snd_pcm_hw_constraint_step(substream->runtime, 0,
> > +                        SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 48);
> > +     snd_pcm_hw_constraint_step(substream->runtime, 0,
> > +                        SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 48);
>
> 432 samples is 9ms, I don't have a clue why/how CRAS might ask for this
> value.
>
> It'd be a bit odd to add constraints just for the purpose of letting
> userspace select a sensible value.

Sorry for the late reply. CRAS does not set the period size when using it.
The default period size is 256, which consumes the samples
quickly(about 49627 fps when the rate is 48000 fps) at the beginning
of the playback.
Since CRAS write samples with the fixed frequency, it triggers
underruns immidiately.

According to Brent, the DSP is using 240 period regardless the
hw_param. If the period size is 256, DSP will read 256 samples each
time but only consume 240 samples until the ring buffer of DSP is
full. This behavior makes the samples in the ring buffer of kernel
consumed quickly. (Not sure whether the explanation is correct. Need
Brent to confirm it.)

Unfortunately, we can not change the behavior of DSP. After some
experiments, we found that the issue can be fixed if we set the period
size to 240. With the same frequency as the DSP, the samples are
consumed stably. Because everyone can trigger this issue when using
the driver without setting the period size, we think it is a general
issue that should be fixed in the kernel.

Thanks,
Yu-Hsuan
