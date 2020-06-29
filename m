Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97744C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A03720720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="Qlh/C2Si"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390128AbgF2VBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731199AbgF2TM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:57 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C7CC00862D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 04:11:27 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id i16so12466598qtr.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tfv7vMX8zqf+KfHaA8JVxdjImJiQttmClnXwjby4rK4=;
        b=Qlh/C2Si9KuqV8DlShjWN9r1U/ujzT7mJ0nPxB8gzmTL4bhYkHXavuQkfF24tWFJmu
         FiT4upWYrEjC51EgP6FDrfvijHlSw8249drYY8WoGCVarzqLsdvDUmczgxaI3cN9v99C
         46k9AKijYQpLkJxOF4HZWlPmOuYEIasBD96nLDDTAOhk72yZS7HqZ/E3ehGsKahZhy44
         H/K8RFCDW3lGgmL0899QJ40bautJESc9na0MWjfncH3Irp6P7RHcAVT1f+OgwQE8jg6N
         KSiYN3ep1hRPcDOLbzd6ackRDiAgvFHFKFWwzzhvhomoZeeHkuz16bCxtI06AUgQor18
         yvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tfv7vMX8zqf+KfHaA8JVxdjImJiQttmClnXwjby4rK4=;
        b=q8EUSZKLHgKUK9L2TgD2c/8B0yKUHVC8OfxBIBrBCAeCQiSZ12wdLedB2XT93QSdak
         bblPVFB7jBi8KjrPgx2vvSMTDSfUDYHetOzbyt5NoXrNXiEscooRm8mV5kiu4IB6OR/l
         mY6A7FkuIZb1HFNaT4D7YjJgJCRjfLW1CT9SdQwHpD/hpAQP24nMh/FE2sIE6KgQIvNp
         K9EebluprZsJcUuQacSfZW9NU+17kAbHRoMQ8VKTK4MAimz2NsyE0JBKNt3TaOfqCfXR
         LIlb9jjA8WOlvE3eJ4nEWyVRkAcKxEmi5YIXZJwWY2UcjJgG6uZBtYkJ1UVKOGzpYZVk
         CRfQ==
X-Gm-Message-State: AOAM531PZ7Ht3nr6W/ngKkg+IVsdOVliy/9FR3U69IferLHksYzC6i5R
        HvmEDrLZyU4BW4ivb/+OoEmL68nkQlbqwvu7J0Qm+A==
X-Google-Smtp-Source: ABdhPJwJlC3jb4FspekGZ2zZFbumeGe86bJU/RzU6zbSwvDGQ8M7H0EEjtLRjMJhl17j4fcbTxPiBr5Aq/KlXdtcz/Q=
X-Received: by 2002:ac8:1871:: with SMTP id n46mr14159717qtk.252.1593429086671;
 Mon, 29 Jun 2020 04:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200521162518.1809995-1-lma@semihalf.com> <3c89e614-81f5-ba87-19a9-fbe9f5c73925@linux.intel.com>
 <CAFJ_xbr8TN3ynfELJ3NQnkuRg0VRbkjB7=Cyb8yu2L==JGXJiw@mail.gmail.com>
 <475fb5c0-9b26-a8f6-c102-25c7775bc2ca@linux.intel.com> <CAFJ_xbq-QotvPG=AxSp7=Etc5P5f4ePRWLCvSNnTkzUO9o_qjQ@mail.gmail.com>
 <268b11b6-9f4c-d769-a7f9-536d77198705@linux.intel.com>
In-Reply-To: <268b11b6-9f4c-d769-a7f9-536d77198705@linux.intel.com>
From:   =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@semihalf.com>
Date:   Mon, 29 Jun 2020 13:11:15 +0200
Message-ID: <CAFJ_xboUTDtnpvskb2dY4fGhGLNkEgT0sH3dU0NYJV_Cb_gqPw@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
 be_hw_params_fixup function
To:     Harsha Priya <harshapriya.n@intel.com>
Cc:     alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Ross Zwisler <zwisler@google.com>,
        linux-kernel@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bob Brandt <brndt@google.com>, Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harsha,

We would like to continue the work on this, could you please suggest
the correct approach.

Best regards,
Lukasz

czw., 21 maj 2020 o 20:10 Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> napisa=C5=82(a):
>
>
>
> On 5/21/20 12:30 PM, =C5=81ukasz Majczak wrote:
> > Hi Pierre
> >
> > If you will take a look at the original kabylake_ssp_fixup() you will
> > see that it is checking whether the related FE is "Kbl Audio Port",
> > "Kbl Audio Headset Playback", "Kbl Audio Capture Port" or "Kbl Audio
> > DMIC cap" - then for the first 3 cases it sets min/max channels to 2
> > while for the "Kbl DMIC cap" it can be 2 or 4, that's is why I'm
> > trying to split this, but maybe I'm missing here something.
>
> I don't understand this code either.
>
> I believe the intent is that for all SSP1-RT5663 usages, we should use
>
>                 rate->min =3D rate->max =3D 48000;
>                 chan->min =3D chan->max =3D 2;
>                 snd_mask_none(fmt);
>                 snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
>
> That is pretty easy to move to a dedicated ssp1 fixup.
>
> for SSP0, we have RT5514 for capture and max98927 for playback, but the
> existing code does not explicitly deal with rate/channels/format for all
> cases, so it's not clear what should happen.
>
> Harsha, can you help here?
>
> >
> > Best regards,
> > Lukasz
> >
> > czw., 21 maj 2020 o 19:17 Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> napisa=C5=82(a):
> >>
> >>
> >>
> >> On 5/21/20 12:08 PM, =C5=81ukasz Majczak wrote:
> >>>>
> >>>> don't add a new dailink, this is not right.
> >>>>
> >>> Can you advise a better solution how to assign different fixup
> >>> functions to mic and to speakers? I was looking at "dmic01" dailink i=
n
> >>> skl_nau88l25_max98357a.c as an example.
> >>
> >> I am not sure I follow. the DMICs are handled on a shared SSP, so how
> >> would one set a different fixup? The word length have to be the same.
