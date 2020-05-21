Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D71C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268FD2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="s+fpMnTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgEURbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgEURbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:31:00 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A87C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:30:59 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id e16so252359qtg.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oCCuryYDlFG9YsC0tOz8Jhkle66x4DRPsKGwzs4uWUY=;
        b=s+fpMnTFFKbXedSk7ek0RZ/NmBP09zX/j/kZh3APCiqxD3VYd3tyNmjbY2ApPNIlGN
         VQuv8NzLXi/wf23hNmcDqwGwhxS4MW3dA2FFR6bMX0zhXU/Zo1C9FmqECPyrRzcoLFw/
         sjyaScMHcTRYUj5k/d3WpxiCksLHpMmp7SsCMV3vFIR+L8F0ktzcm49jgxdjk2UMOS/T
         cOatk7DTmS2A9a7n6fi2V5CYbNy3vXKlqoy5sHvlpoq5ke0I1goOxpJ2gOmGqC4zWR5L
         1XONoL1+2rx7Qp/aZxO/aVPdP9r4X4kQ4R1/5cQdiCqMxTaweZy9NSPCJXY6uSJgtvsp
         2cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oCCuryYDlFG9YsC0tOz8Jhkle66x4DRPsKGwzs4uWUY=;
        b=gBqx3IkE0bQ6O0uUfaRZ1HNLIKnqdNKGhXkxwReqC+eykTQ59cBNXpZxUQmX1LgKld
         FpBwcack5w6OgusSGFkJc6XKT+ixcF0vSBDoXxhQSl0+Yfzc2ZLc+puKcCyYv9rALVvy
         k+6/t5P0beuFW9F3NNIjy1tpzS/WDsM2RUB43OndPj4I8qVyxteBSbvUO8YPC3/XrtKy
         HJf91+LTIVRJpDs8OHuQtgpox34MVbHqDcgmX/YLq4YyqDAXVxaQCjXBhHkdbXIEUf/z
         Eu8I4u1hJ/GGV2IHllWJox+FBuF3Zzp1pWXMRlw9FCrQlVM+Niy5ElEO3tP7R6DNSWYK
         u62Q==
X-Gm-Message-State: AOAM531Mgp0bGhQeSsKG/fM2/x/pofz8liud0hvvt4I7dOs7o5pNEpvq
        0cUINXSt2Vu6wxw5ixy1ESJuBXctxhqoPritY29szQBRtMKOlQ==
X-Google-Smtp-Source: ABdhPJwtq62EZUQyrC/40B7qqncuvtCEeEnHVUBc2Y5SeI8XY5V7uRJHlrv8zqb1D1OrgskedaqEIMoG9MvNfFgCsow=
X-Received: by 2002:ac8:37a7:: with SMTP id d36mr12285965qtc.375.1590082259124;
 Thu, 21 May 2020 10:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200521162518.1809995-1-lma@semihalf.com> <3c89e614-81f5-ba87-19a9-fbe9f5c73925@linux.intel.com>
 <CAFJ_xbr8TN3ynfELJ3NQnkuRg0VRbkjB7=Cyb8yu2L==JGXJiw@mail.gmail.com> <475fb5c0-9b26-a8f6-c102-25c7775bc2ca@linux.intel.com>
In-Reply-To: <475fb5c0-9b26-a8f6-c102-25c7775bc2ca@linux.intel.com>
From:   =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@semihalf.com>
Date:   Thu, 21 May 2020 19:30:48 +0200
Message-ID: <CAFJ_xbq-QotvPG=AxSp7=Etc5P5f4ePRWLCvSNnTkzUO9o_qjQ@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
 be_hw_params_fixup function
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>,
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

Hi Pierre

If you will take a look at the original kabylake_ssp_fixup() you will
see that it is checking whether the related FE is "Kbl Audio Port",
"Kbl Audio Headset Playback", "Kbl Audio Capture Port" or "Kbl Audio
DMIC cap" - then for the first 3 cases it sets min/max channels to 2
while for the "Kbl DMIC cap" it can be 2 or 4, that's is why I'm
trying to split this, but maybe I'm missing here something.

Best regards,
Lukasz

czw., 21 maj 2020 o 19:17 Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> napisa=C5=82(a):
>
>
>
> On 5/21/20 12:08 PM, =C5=81ukasz Majczak wrote:
> >>
> >> don't add a new dailink, this is not right.
> >>
> > Can you advise a better solution how to assign different fixup
> > functions to mic and to speakers? I was looking at "dmic01" dailink in
> > skl_nau88l25_max98357a.c as an example.
>
> I am not sure I follow. the DMICs are handled on a shared SSP, so how
> would one set a different fixup? The word length have to be the same.
