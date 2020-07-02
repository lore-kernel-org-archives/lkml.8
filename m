Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723F7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9B020771
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="Ga4jYOuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgGBKKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgGBKKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:10:11 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FDDC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 03:10:11 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b4so25028065qkn.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 03:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MNkwKZ84Zrawk816auciDQTYwDrs9ybRS0FVRLuLd9I=;
        b=Ga4jYOuvR8MX3nF2I6L7nPH0rm/ZyxshqRb5F4+rL33+Dnnyb7FevBZZ90KDsvrHKV
         WgfFd92ZJh5hmBt1OEWYUt4vNpzYROC9C4LhqphBIgEmjRIuA2uLoAqnId7O9xEpBOUs
         Nla0Wih4ZFy2hHQ3+TBKtg2SY7KBhlFLwmoyxSWCgb0u9AhCwZrAPgE2nWZbdmGIRdHO
         Bn+d7Dg/YVemE9LvZSnqhR+jUeppn8wUwMia4TUXkC/w3ps8MVS8IgrrSDC0yol2L1RR
         2t/1JL25f6Pb6bomI8yC4grazve3xpODK2cXQrPtDv5FgiCe0uQ6kj9ytlhs6OXRwq6F
         X/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MNkwKZ84Zrawk816auciDQTYwDrs9ybRS0FVRLuLd9I=;
        b=CKye+JRNarVNS1ecMl3M7YjPpl1irH53Rly4FIbO6xjNbrBfHotUZopzc4613290Wh
         lNkKLor1kr2XUB8ZKIxfFAv1IItPCj1Kev7+ctDXbthd9mNJ97K7Sbke9zj2DLgT9Eny
         nzy87QON4RqYY/nOl2N4N7zWt+V+0zbrgQE6h02clY9uitiBnqtbNqEDm1ML4aCBhDt0
         vheASt58Qje3I7ALTThXy55oUsIhs2nXjgN4/dZ7qOaPgLNnoVday8r2Ywxq2QECrGCJ
         S/FDNjW4fluRvlMH1fuB6j/UeiKMQ7Nokhslyab8EzrOoOqf2iQEM8EI4yGPmstW8Nk3
         r8Kw==
X-Gm-Message-State: AOAM5308J09xWd2JLOVDL2jkTXqWWBERLy98f+8TY2mzeRKjn8q4soeA
        xNc5Y4ky3vd0znZAWx0zeKCQD+aBmApJ1y/UAoNyNg==
X-Google-Smtp-Source: ABdhPJxSCrlGDF8VbOkF76c527VsV7+BA6AZM2DosVAXwrPnrjTB9/lEdURnS2JpeZC7MdKZXtTdxC39Y9vZxDerRRc=
X-Received: by 2002:a37:2781:: with SMTP id n123mr29703103qkn.106.1593684610371;
 Thu, 02 Jul 2020 03:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200521162518.1809995-1-lma@semihalf.com> <3c89e614-81f5-ba87-19a9-fbe9f5c73925@linux.intel.com>
 <CAFJ_xbr8TN3ynfELJ3NQnkuRg0VRbkjB7=Cyb8yu2L==JGXJiw@mail.gmail.com>
 <475fb5c0-9b26-a8f6-c102-25c7775bc2ca@linux.intel.com> <CAFJ_xbq-QotvPG=AxSp7=Etc5P5f4ePRWLCvSNnTkzUO9o_qjQ@mail.gmail.com>
 <268b11b6-9f4c-d769-a7f9-536d77198705@linux.intel.com> <CAFJ_xboUTDtnpvskb2dY4fGhGLNkEgT0sH3dU0NYJV_Cb_gqPw@mail.gmail.com>
 <BY5PR11MB4307284BAE6DA415CFC0865CFD6E0@BY5PR11MB4307.namprd11.prod.outlook.com>
 <CAFJ_xbq3DU8NMmymYHLjy0z+QbGRAOmB4NaiXPphAr2Zu0MPAg@mail.gmail.com>
 <BY5PR11MB4307CBA736456853777A9FD9FD6E0@BY5PR11MB4307.namprd11.prod.outlook.com>
 <BY5PR11MB4307C20278F32D17551112FAFD6C0@BY5PR11MB4307.namprd11.prod.outlook.com>
 <7e38bb2e-2132-d305-e94d-043fa53bd836@linux.intel.com> <BY5PR11MB4307BBBCAA78A0506BBC5F74FD6C0@BY5PR11MB4307.namprd11.prod.outlook.com>
 <b2236769-6957-dc41-21b2-aca238994b4b@linux.intel.com>
In-Reply-To: <b2236769-6957-dc41-21b2-aca238994b4b@linux.intel.com>
From:   =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@semihalf.com>
Date:   Thu, 2 Jul 2020 12:09:59 +0200
Message-ID: <CAFJ_xboZp02M3XAzTXMyUJU50CZDNBnrd_oOnYBWxFfMpr=1pg@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
 be_hw_params_fixup function
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "N, Harshapriya" <harshapriya.n@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Ross Zwisler <zwisler@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        "M R, Sathya Prakash" <sathya.prakash.m.r@intel.com>,
        Bob Brandt <brndt@google.com>, Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am also ok with Harsha patch. I have checked it on my Eve and it looks ok=
.

Best regards,

Lukasz

=C5=9Br., 1 lip 2020 o 19:08 Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> napisa=C5=82(a):
>
>
> >>> Tested and the following is something we can use without creating a n=
ew
> >> dailink.
> >>>             struct snd_soc_dai *codec_dai =3D asoc_rtd_to_codec(rtd, =
0);
> >>>     if (!strcmp(codec_dai->name, KBL_REALTEK_DMIC_CODEC_DAI)) {
> >>>             if (params_channels(params) =3D=3D 2 ||
> >> DMIC_CH(dmic_constraints) =3D=3D 2)
> >>>                     channels->min =3D channels->max =3D 2;
> >>>             else
> >>>                     channels->min =3D channels->max =3D 4;
> >>>     } else {
> >>>             rate->min =3D rate->max =3D 48000;
> >>>             channels->min =3D channels->max =3D 2;
> >>>             snd_mask_none(fmt);
> >>>             snd_mask_set_format(fmt, pcm_fmt);
> >>>     }
> >>>
> >>> Pierre, thoughts?
> >>
> >> thanks Harsha, that looks like what I had in mind, but my earlier ques=
tion was
> >> why we deal with the rates and formats only in the last case?
> > The speaker codec supported only 16 bit.  (Vendor mentioned)
> > For playback on this platform, only 48Khz was used.
>
> ok then, as long as Harsha and Lukasz are aligned I'm fine. Thanks!
>
