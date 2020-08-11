Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D385C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29E520756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fq8SQKvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgHKJf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgHKJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:35:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E22C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 02:35:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c19so1737442wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ItIu5ePf9JKIpjj5PDgXBJfnpsujSceF1j6mqZLY9xc=;
        b=fq8SQKvgjJxayeI7HmuFGs0oD96AKDdltc0/qy0MyDFZLz1W4mYReqmtyk2nIuCp8V
         0mz5asZyNw/it7myybopvl4W3UJaoBxyj72tUdF0QCNbv6/fXNDI2pHx285LdeZUsSsA
         6muP/2dkKw5rXn6YPgjCWbLJLC0TKp0d92eV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ItIu5ePf9JKIpjj5PDgXBJfnpsujSceF1j6mqZLY9xc=;
        b=IBAwQmpJ4PONUHLPcRrzn4SCyInAlsp8RhWnLAJvfvGh4577aFjTpWo4UTyYdE/yCr
         XfXNQTMa/arQtPIYQYpzB59eqKR9VgPZG4i4WLzMMZZ6RuImZfyflidPFOR1wob5uQK0
         F06Vjh83oM6kIzsp0X32aArrwWOhSOkqM2A7GXRVnJHDbYL1Bce4gWnYscL98p5UUOuH
         tKRUs2xbu+nAoRf4xaZnoLRmdGavFLiwaJWLc5/2+7j1e44LZT3MblzSzWYr/akbBMVL
         Go8Yt+1xD8m9AYWXEjYt9lKKQYuOf0tZ6PevmBpNy5xrGGrYLpm5R0vbQg/b7EFYr0gy
         TOtg==
X-Gm-Message-State: AOAM532V99MbD4ci+oW2yjZCxz4G5OWY6LCtQSGhj/KWOghQlW4xJsNC
        YG4namKvnwiWd2axgbXebw51BbzGKxuURFVYblWnvg==
X-Google-Smtp-Source: ABdhPJzNmvcXB2yY6xQZHWMtdPpynSNcr6Ip7cflkE50vI1L0D2+vnCcTNtKLvDgRgHAGIOuf1XRKejVmWy/NKqIgVk=
X-Received: by 2002:a7b:c401:: with SMTP id k1mr3153089wmi.18.1597138556389;
 Tue, 11 Aug 2020 02:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
 <1596198365-10105-1-git-send-email-brent.lu@intel.com> <1596198365-10105-3-git-send-email-brent.lu@intel.com>
 <s5h5za3ajvb.wl-tiwai@suse.de> <DM6PR11MB3642AE90DF98956CCEDE6C2F974F0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <s5hd04a90o4.wl-tiwai@suse.de> <DM6PR11MB3642B5BC2E1E0708088526D8974D0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <63bca214-3434-16c6-1b60-adf323aec554@linux.intel.com> <DM6PR11MB3642D9BE1E5DAAB8B78B84B0974D0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <s5hpn873by6.wl-tiwai@suse.de> <DM6PR11MB36423A9D28134811AD5A911F974A0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <6466847a-8aae-24f7-d727-36ba75e95f98@linux.intel.com> <DM6PR11MB364259049769F6EF3B84AABD97480@DM6PR11MB3642.namprd11.prod.outlook.com>
 <3f3baf5e-f73d-9cd6-cbfb-36746071e126@linux.intel.com> <CAGvk5PohOP0Yv22tb53EX=ZLB9_vOMb=iujTh64OvHmjC1d4mg@mail.gmail.com>
 <DM6PR11MB3642AC7F8EC47EB48B384D4797450@DM6PR11MB3642.namprd11.prod.outlook.com>
 <CAGvk5PogmqfEnFRA8hzby+AGgbOSvbELamh_1=eA9KTpyBMPYQ@mail.gmail.com>
 <s5htux939x1.wl-tiwai@suse.de> <CAGvk5PpcmkZ2HarqeCDaXm4id=84wYs-u4vWxJunHaf09gj66g@mail.gmail.com>
 <s5ho8nh37br.wl-tiwai@suse.de>
In-Reply-To: <s5ho8nh37br.wl-tiwai@suse.de>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Tue, 11 Aug 2020 17:35:45 +0800
Message-ID: <CAGvk5PphzkdiNfW8hiDuqX+2eQO2FvrpzA0qR3=3VvqM3GBhAA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago board
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Lu, Brent" <brent.lu@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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

Takashi Iwai <tiwai@suse.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=8811=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:39=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 11 Aug 2020 10:25:22 +0200,
> Yu-Hsuan Hsu wrote:
> >
> > Takashi Iwai <tiwai@suse.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=8811=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:43=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Tue, 11 Aug 2020 04:29:24 +0200,
> > > Yu-Hsuan Hsu wrote:
> > > >
> > > > Lu, Brent <brent.lu@intel.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8811=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8810:17=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > >
> > > > > >
> > > > > > Sorry for the late reply. CRAS does not set the period size whe=
n using it.
> > > > > > The default period size is 256, which consumes the samples quic=
kly(about 49627
> > > > > > fps when the rate is 48000 fps) at the beginning of the playbac=
k.
> > > > > > Since CRAS write samples with the fixed frequency, it triggers =
underruns
> > > > > > immidiately.
> > > > > >
> > > > > > According to Brent, the DSP is using 240 period regardless the =
hw_param. If the
> > > > > > period size is 256, DSP will read 256 samples each time but onl=
y consume 240
> > > > > > samples until the ring buffer of DSP is full. This behavior mak=
es the samples in
> > > > > > the ring buffer of kernel consumed quickly. (Not sure whether t=
he explanation is
> > > > > > correct. Need Brent to confirm it.)
> > > > > >
> > > > > > Unfortunately, we can not change the behavior of DSP. After som=
e experiments,
> > > > > > we found that the issue can be fixed if we set the period size =
to 240. With the
> > > > > > same frequency as the DSP, the samples are consumed stably. Bec=
ause everyone
> > > > > > can trigger this issue when using the driver without setting th=
e period size, we
> > > > > > think it is a general issue that should be fixed in the kernel.
> > > > >
> > > > > I check the code and just realized CRAS does nothing but request =
maximum buffer
> > > > > size. As I know the application needs to decide the buffer time a=
nd period time so
> > > > > ALSA could generate a hw_param structure with proper period size =
instead of using
> > > > > fixed constraint in machine driver because driver has no idea abo=
ut the latency you
> > > > > want.
> > > > >
> > > > > You can use snd_pcm_hw_params_set_buffer_time_near() and
> > > > > snd_pcm_hw_params_set_period_time_near() to get a proper configur=
ation of
> > > > > buffer and period parameters according to the latency requirement=
. In the CRAS
> > > > > code, there is a UCM variable to support this: DmaPeriodMicrosecs=
. I tested it on
> > > > > Celes and it looks quite promising. It seems to me that adding co=
nstraint in machine
> > > > > driver is not necessary.
> > > > >
> > > > > SectionDevice."Speaker".0 {
> > > > >         Value {
> > > > >                 PlaybackPCM "hw:chtrt5650,0"
> > > > >                 DmaPeriodMicrosecs "5000"
> > > > > ...
> > > > >
> > > > > [   52.434761] sound pcmC1D0p: hw_param
> > > > > [   52.434767] sound pcmC1D0p:   ACCESS 0x1
> > > > > [   52.434770] sound pcmC1D0p:   FORMAT 0x4
> > > > > [   52.434772] sound pcmC1D0p:   SUBFORMAT 0x1
> > > > > [   52.434776] sound pcmC1D0p:   SAMPLE_BITS [16:16]
> > > > > [   52.434779] sound pcmC1D0p:   FRAME_BITS [32:32]
> > > > > [   52.434782] sound pcmC1D0p:   CHANNELS [2:2]
> > > > > [   52.434785] sound pcmC1D0p:   RATE [48000:48000]
> > > > > [   52.434788] sound pcmC1D0p:   PERIOD_TIME [5000:5000]
> > > > > [   52.434791] sound pcmC1D0p:   PERIOD_SIZE [240:240]
> > > > > [   52.434794] sound pcmC1D0p:   PERIOD_BYTES [960:960]
> > > > > [   52.434797] sound pcmC1D0p:   PERIODS [852:852]
> > > > > [   52.434799] sound pcmC1D0p:   BUFFER_TIME [4260000:4260000]
> > > > > [   52.434802] sound pcmC1D0p:   BUFFER_SIZE [204480:204480]
> > > > > [   52.434805] sound pcmC1D0p:   BUFFER_BYTES [817920:817920]
> > > > > [   52.434808] sound pcmC1D0p:   TICK_TIME [0:0]
> > > > >
> > > > > Regards,
> > > > > Brent
> > > > Hi Brent,
> > > >
> > > > Yes, I know we can do it to fix the issue as well. As I mentioned
> > > > before, we wanted to fix it in kernel because it is a real issue,
> > > > isn't it? Basically, a driver should work with any param it support=
s.
> > > > But in this case, everyone can trigger underrun if he or she does n=
ot
> > > > the period size to 240. If you still think it's not necessary, I ca=
n
> > > > modify UCM to make CRAS set the appropriate period size.
> > >
> > > How does it *not* work if you set other than period size 240, more
> > > exactly?
> > >
> > > The hw_constraint to a fixed period size must be really an exception.
> > > If you look at other drivers, you won't find any other doing such.
> > > It already indicates that something is wrong.
> > >
> > > Usually the fixed period size comes from the hardware limitation and
> > > defined in snd_pcm_hardware.  Or, sometimes it's an alignment issue.
> > > If you need more than that, you should doubt what's really not
> > > working.
> > >
> > >
> > > Takashi
> > Thank Takashi,
> >
> > As I mentioned before, if the period size is set to 256, the measured
> > rate of sample-consuming will be around 49627 fps. It causes underrun
> > because the rate we set is 48000 fps.
>
> But this explanation rather sounds like the alignment problem.
> However...
>
> > This behavior also happen on the
> > other period rate except for 240.
>
> ... Why only 240?  That's the next logical question.
> If you have a clarification for it, it may be the rigid reason to
> introduce such a hw constraint.
>
>
> Takashi

According to Brent, the DSP is using 240 period regardless the
hw_param. If the period size is 256, DSP will read 256 samples each
time but only consume 240 samples until the ring buffer of DSP is
full. This behavior makes the samples in the ring buffer of kernel
consumed quickly.

Not sure whether the explanation is correct. Hi Brent, can you confirm it?

Thanks,
Yu-Hsuan
