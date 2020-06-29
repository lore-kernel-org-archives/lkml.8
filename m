Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE518C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77DB206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="KTaItmVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404022AbgF2VoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgF2Shq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:46 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8F4C033C05
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:19:50 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b185so5561078qkg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nz1mLb/HdxeeFzjt/WhHL5+3D6vBhDXixYCmk24G57Y=;
        b=KTaItmVPIOJ4TKndqPFZNnDxN6e1bHP33oFGPpxCzsjP0+kj6JLp95d9LrUKkoUfnu
         8EcigUPbANiKCquB6BteEY6R50rhIZtQquKKKJPUvsCG4ZigLjc8cDRCVobGsoSJYkiT
         yrp45btBd/a9pXqBT3DhrEuWhUf1Sevu5vxGSpTNSJF98GrXcCAhw79k+uj5nbhAjG2o
         asXKOi4FvF5nV/L/Y5yZs9aL2Ti5/ZrVxA+Np8BbwY7aL5vj7w1XoesRA7MJwpfOXdGA
         GNGVCCoSk/e3eCjSDwpDNxp16ontCAIPfDzCM4LspFtf85ZafYfnOaTursDxfNsAjpGx
         LjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nz1mLb/HdxeeFzjt/WhHL5+3D6vBhDXixYCmk24G57Y=;
        b=P+HkWn56R5yqYXjMSo8KS0scTndhb2HsDp7XEkNpIk26EV0A/2gYasCMFjipQ8WUHv
         2ii7bGiCwyLGSZfTlK1cViVHhXHDNebrrSMJUhSaLbH6JjEHl6LPqUR9UTpWWSSY3vJu
         hnDXioTvqfuTko1hTzMTLBPMPWcegVBxgGxzT5thQOR9Yj7xWZFhgkEh3JZrTOd9zgJq
         N3aClvc9vN06y6h5ulaRtYZ5KN7awDe4J3bO5YyFHx3buSpTTmkHQRD3Tq5O/FrI731u
         trakYXlB4+GA0oiR/XqOMBQGZzm4Jd9UUghBqL6spN+m4SSae/U7gocg3KP8gYR6+OFH
         z0tg==
X-Gm-Message-State: AOAM531mS8nTPfup8mqI+ohzCRP0vmzNlSpoUhCz3vrCHVohhuBXlYSC
        iRRRaYTtTwnD5nNmOIOyoC2Gj/X1QYUYHFyKPB9m2w==
X-Google-Smtp-Source: ABdhPJw0kKfy29PMxzVdPuyCXAvvVUbrEXcnOevNI79vzRZfnh0YXlM6Z5sp+V92ur7bHOUZ7/Zsr9+aZFGRkK7EXO8=
X-Received: by 2002:a37:2781:: with SMTP id n123mr16407496qkn.106.1593454789227;
 Mon, 29 Jun 2020 11:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200521162518.1809995-1-lma@semihalf.com> <3c89e614-81f5-ba87-19a9-fbe9f5c73925@linux.intel.com>
 <CAFJ_xbr8TN3ynfELJ3NQnkuRg0VRbkjB7=Cyb8yu2L==JGXJiw@mail.gmail.com>
 <475fb5c0-9b26-a8f6-c102-25c7775bc2ca@linux.intel.com> <CAFJ_xbq-QotvPG=AxSp7=Etc5P5f4ePRWLCvSNnTkzUO9o_qjQ@mail.gmail.com>
 <268b11b6-9f4c-d769-a7f9-536d77198705@linux.intel.com> <CAFJ_xboUTDtnpvskb2dY4fGhGLNkEgT0sH3dU0NYJV_Cb_gqPw@mail.gmail.com>
 <BY5PR11MB4307284BAE6DA415CFC0865CFD6E0@BY5PR11MB4307.namprd11.prod.outlook.com>
In-Reply-To: <BY5PR11MB4307284BAE6DA415CFC0865CFD6E0@BY5PR11MB4307.namprd11.prod.outlook.com>
From:   =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@semihalf.com>
Date:   Mon, 29 Jun 2020 20:19:38 +0200
Message-ID: <CAFJ_xbq3DU8NMmymYHLjy0z+QbGRAOmB4NaiXPphAr2Zu0MPAg@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
 be_hw_params_fixup function
To:     "N, Harshapriya" <harshapriya.n@intel.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Ross Zwisler <zwisler@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bob Brandt <brndt@google.com>, Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@chromium.org>,
        "M R, Sathya Prakash" <sathya.prakash.m.r@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harsha,

I've put the reason for this change in the commit message.
I had to split be_hw_params_fixup function for different codecs
because current approach (made for kernel 4.4) used in kernel 5.4,
leads to crash while trying to get snd_soc_dpcm with container_of()
macro in kabylake_ssp_fixup().
The crash call path looks as below:
soc_pcm_hw_params()
snd_soc_dai_hw_params(codec_dai, substream, &codec_params);
rtd->dai_link->be_hw_params_fixup(rtd, params)
kabylake_ssp_fixup()
In this case, codec_params is just a copy of an internal structure and is
not embedded into struct snd_soc_dpcm thus we cannot use
container_of() on it.

Best regards,
Lukasz

pon., 29 cze 2020 o 18:51 N, Harshapriya <harshapriya.n@intel.com> napisa=
=C5=82(a):
>
> > -----Original Message-----
> > From: =C5=81ukasz Majczak <lma@semihalf.com>
> > Sent: Monday, June 29, 2020 4:11 AM
> > To: N, Harshapriya <harshapriya.n@intel.com>
> > Cc: alsa-devel@alsa-project.org; Pierre-Louis Bossart <pierre-
> > louis.bossart@linux.intel.com>; Jie Yang <yang.jie@linux.intel.com>; Ra=
doslaw
> > Biernacki <rad@semihalf.com>; Ross Zwisler <zwisler@google.com>; linux-
> > kernel@vger.kernel.org; Liam Girdwood <liam.r.girdwood@linux.intel.com>=
;
> > Bob Brandt <brndt@google.com>; Marcin Wojtas <mw@semihalf.com>; Alex
> > Levin <levinale@chromium.org>
> > Subject: Re: [PATCH v3] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
> > be_hw_params_fixup function
> >
> > Hi Harsha,
> >
> > We would like to continue the work on this, could you please suggest th=
e
> > correct approach.
> >
> > Best regards,
> > Lukasz
> >
> > czw., 21 maj 2020 o 20:10 Pierre-Louis Bossart <pierre-
> > louis.bossart@linux.intel.com> napisa=C5=82(a):
> > >
> > >
> > >
> > > On 5/21/20 12:30 PM, =C5=81ukasz Majczak wrote:
> > > > Hi Pierre
> > > >
> > > > If you will take a look at the original kabylake_ssp_fixup() you
> > > > will see that it is checking whether the related FE is "Kbl Audio
> > > > Port", "Kbl Audio Headset Playback", "Kbl Audio Capture Port" or
> > > > "Kbl Audio DMIC cap" - then for the first 3 cases it sets min/max
> > > > channels to 2 while for the "Kbl DMIC cap" it can be 2 or 4, that's
> > > > is why I'm trying to split this, but maybe I'm missing here somethi=
ng.
> > >
> > > I don't understand this code either.
> > >
> > > I believe the intent is that for all SSP1-RT5663 usages, we should us=
e
> > >
> > >                 rate->min =3D rate->max =3D 48000;
> > >                 chan->min =3D chan->max =3D 2;
> > >                 snd_mask_none(fmt);
> > >                 snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
> > >
> > > That is pretty easy to move to a dedicated ssp1 fixup.
> > >
> > > for SSP0, we have RT5514 for capture and max98927 for playback, but
> > > the existing code does not explicitly deal with rate/channels/format
> > > for all cases, so it's not clear what should happen.
> > >
> > > Harsha, can you help here?
> Apologies for missing the email I had to respond to.
>
> SSP0 - has the speakers
> SSP1 - has headset and dmic
> For speakers and headsets its 48Khz, 2 ch and 24 bit and this setting is =
done based on the front-end dai
> For speakers, however support only 16 bit, so we set it back to 16 bit
> If the front end dai is dmic, then the channel is set to either 2 or 4 dm=
ic_constraints. No other formats need to be set.
>
> All the SSP1 usages do not have the same parameters (as dmic is on SSP1 a=
nd its different as given above)
> Most parameters are same for speakers and headset which are on different =
SSP. This is the reason we had a single fixup function.
>
> Is there a reason why the fixup function needs to be split?
>
> > >
> > > >
> > > > Best regards,
> > > > Lukasz
> > > >
> > > > czw., 21 maj 2020 o 19:17 Pierre-Louis Bossart
> > > > <pierre-louis.bossart@linux.intel.com> napisa=C5=82(a):
> > > >>
> > > >>
> > > >>
> > > >> On 5/21/20 12:08 PM, =C5=81ukasz Majczak wrote:
> > > >>>>
> > > >>>> don't add a new dailink, this is not right.
> > > >>>>
> > > >>> Can you advise a better solution how to assign different fixup
> > > >>> functions to mic and to speakers? I was looking at "dmic01"
> > > >>> dailink in skl_nau88l25_max98357a.c as an example.
> > > >>
> > > >> I am not sure I follow. the DMICs are handled on a shared SSP, so
> > > >> how would one set a different fixup? The word length have to be th=
e same.
