Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A60AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 03:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4A1206F2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 03:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ngSRzlum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHLDKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 23:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgHLDKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 23:10:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243DFC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 20:10:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c19so3300271wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 20:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3hkg0qu6P9KQ5oYfn7DTQjSamGImaGuetOUyRL9DWkY=;
        b=ngSRzlumHkb0IDY4Pr87hg0ZwDwyroTE0Ld40lvNSNKIijgNhqQpnM6zRj84dIcXj4
         qQ0YIrqSSAk94RpkV98/z5snP7OuL/YSL97sskrxvMAJUeecU/LwDCYHJLTkNbYY6y4S
         ag4+ErdhG3PO6Aaz/J7vZZktVSkGJgZVvQCYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3hkg0qu6P9KQ5oYfn7DTQjSamGImaGuetOUyRL9DWkY=;
        b=WheSNRy1JvbXqd5voy3/q++qkeKWR2ATAdXfr6bCa47KEx9aGAOzw/pW28wiOfLU7v
         MlOG+tzCpSHouzbd6niYtWiGH+MTVUO0GPPwWQYttwYrhuBSgk1vS6bMQrwDQXzaClsd
         2di6dv5RhxMm3YVarBSngDe219sGuzLa/38ejEGjkCX/vb5vev02CKMgrDYGGmePO5m/
         dng3cnyokxU5e3kyqv4qJbj9jQvy7u9l6LUMfPQ9gcGsniKn7aN8idipFizPRephFMMM
         iUUH1re/fC1UhYJcCE/wFc8z71/IVx/SCRojHRo3BB+wpylC25hEskQhfkjBa0TPtY62
         WVog==
X-Gm-Message-State: AOAM53065SMXbA+ocuZq/QZjMGWGTSQUmXmzglbwlOUmsca6W6+sZApG
        GtWYgSG5IJqFvwdePaaqynvB29MRUELo179JJ5wqfg==
X-Google-Smtp-Source: ABdhPJxDOFrYjfmnL/EFseUjo4ptWPav8xuJ2FzYhPDiA/AQYuCzo4N45IBYUvbTgXJuvFyhWdUUCw3z9AyGGUry5Yc=
X-Received: by 2002:a7b:c7c6:: with SMTP id z6mr6825647wmk.17.1597201809730;
 Tue, 11 Aug 2020 20:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <3f3baf5e-f73d-9cd6-cbfb-36746071e126@linux.intel.com>
 <CAGvk5PohOP0Yv22tb53EX=ZLB9_vOMb=iujTh64OvHmjC1d4mg@mail.gmail.com>
 <DM6PR11MB3642AC7F8EC47EB48B384D4797450@DM6PR11MB3642.namprd11.prod.outlook.com>
 <CAGvk5PogmqfEnFRA8hzby+AGgbOSvbELamh_1=eA9KTpyBMPYQ@mail.gmail.com>
 <s5htux939x1.wl-tiwai@suse.de> <CAGvk5PpcmkZ2HarqeCDaXm4id=84wYs-u4vWxJunHaf09gj66g@mail.gmail.com>
 <s5ho8nh37br.wl-tiwai@suse.de> <CAGvk5PphzkdiNfW8hiDuqX+2eQO2FvrpzA0qR3=3VvqM3GBhAA@mail.gmail.com>
 <20200811145353.GG6967@sirena.org.uk> <d78f9adc-d583-f0f2-ce38-3c9175c939b8@linux.intel.com>
 <20200811172209.GM6967@sirena.org.uk>
In-Reply-To: <20200811172209.GM6967@sirena.org.uk>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Wed, 12 Aug 2020 11:09:58 +0800
Message-ID: <CAGvk5PqGi7cXthLHFi4NyypxFiGnoHvD9vp+5nJdH-_VkVvcKw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago board
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Takashi Iwai <tiwai@suse.de>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        "yuhsuan@google.com" <yuhsuan@google.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Lu, Brent" <brent.lu@intel.com>,
        Damian van Soelen <dj.vsoelen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8812=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:22=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Aug 11, 2020 at 11:54:38AM -0500, Pierre-Louis Bossart wrote:
>
> > > constraint logic needs to know about this DSP limitation - it seems l=
ike
> > > none of this is going to change without something new going into the
> > > mix?  We at least need a new question to ask about the DSP firmware I
> > > think.
>
> > I just tested aplay -Dhw: on a Cyan Chromebook with the Ubuntu kernel 5=
.4,
> > and I see no issues with the 240 sample period. Same with 432, 960, 960=
0,
> > etc.
>
> > I also tried just for fun what happens with 256 samples, and I don't se=
e any
> > underflows thrown either, so I am wondering what exactly the problem is=
?
> > Something's not adding up. I would definitively favor multiple of 1ms
> > periods, since it's the only case that was productized, but there's got=
 to
> > me something a side effect of how CRAS programs the hw_params.
>
> Is it something that goes wrong with longer playbacks possibly (eg,
> someone watching a feature film or something)?

Thanks for testing!

After doing some experiments, I think I can identify the problem more preci=
sely.
1. aplay can not reproduce this issue because it writes samples
immediately when there are some space in the buffer. However, you can
add --test-position to see how the delay grows with period size 256.
> aplay -Dhw:1,0 --period-size=3D256 --buffer-size=3D480 /dev/zero -d 1 -f =
dat --test-position
Playing raw data '/dev/zero' : Signed 16 bit Little Endian, Rate 48000
Hz, Stereo
Suspicious buffer position (1 total): avail =3D 0, delay =3D 2064, buffer =
=3D 512
Suspicious buffer position (2 total): avail =3D 0, delay =3D 2064, buffer =
=3D 512
Suspicious buffer position (3 total): avail =3D 0, delay =3D 2096, buffer =
=3D 512
...

2. Since many samples are moved to DSP(delay), the measured rate of
the ring-buffer is high. (I measured it by alsa_conformance_test,
which only test the sampling rate in the ring buffer of kernel not
DSP)

3. Since CRAS writes samples with a fixed frequency, this behavior
will take all samples from the ring buffer, which is seen as underrun
by CRAS. (It seems that it is not a real underrun because that avail
does not larger than buffer size. Maybe CRAS should also take dalay
into account.)

4. In spite of it is not a real underrun, the large delay is still a
big problem. Can we apply the constraint to fix it? Or any better
idea?

Thanks,
Yu-Hsuan
