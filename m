Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DE6C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8292070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFWm6Psq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgGTKU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbgGTKU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:20:56 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BDAC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:20:56 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g13so12486135qtv.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MhkKfJe2vN50KwqiqlKQ9gFxPDyQEC8YdZGqi/NZNXo=;
        b=SFWm6PsqSFR5b1rJnuTYoVeqYWbN2x/nOSAIGXrqH9MsPly4B8p26uO0N/N5d36lYh
         xMyxG8prCiRCfPsUbu9TnohIxoo+twqSvyI0zw88XksQNZBCTLZ4HsZJ8pIoDkn9qGyh
         KXd+ht0o2RbNnZrVn1xM0XOVk0mPqtaxmNnkuQkQz6xDaZbsYhqjL3hFLxO4zWyvedTH
         QTHv+CsdnRCC7FNpU4Sbs0gIz8Aa8mzOLcRjmK9iacF2oHr/dNM0auwBW1Jy49RzwhW1
         YqoSZGVIQnOaqVryp4jVT8fRFNUxlw7Avw904PWdl5MEbzr4+fxwsqSOjXsa7UzsxqwM
         RJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MhkKfJe2vN50KwqiqlKQ9gFxPDyQEC8YdZGqi/NZNXo=;
        b=aYnKzr2Zuo0OsnV/YTgDXKlRCzhPJbjRWBmHVYuOwSC46d2fkn2wc9T7un98ZkPM8p
         qm6uqZ9yZoD7XP1c/06wrPLu+MK1judXpGhY+AzEOy1llWS+6JCjAHg6+1FaMAjt+ZpX
         QAN61Gv0qdQbNARSoE/B/MKbH3Cpd9Q3QnHk2R/q8U1Vp8Qt24RnhFeEdlB9b+RYOqav
         aW1fWWyDoLOxDGV483r6DJa7PVafOKX6E6+ywEL938E0yJB37+aZbt7yIlPucMC0JyFH
         ayfDPrnq5cF6QBlzfbFw/QUdZnSaEAgg3wJLulxo7A0P5Nq7hK+bGC5YcKJgQG1QBtD4
         w+Rw==
X-Gm-Message-State: AOAM531/fhJPI8Yf5iijqOw0nF5oLaNDMuJbdSTmDFzyMT+QVYCasS5X
        4m3NNmtqPIwA7bzfuxlRl5ev56Qqdja71LPmXzo=
X-Google-Smtp-Source: ABdhPJz7fulXENVaQqfHlTahgzq5pfizgFs85b1RislcevMtP/GeZ4wxSo6H4gSafIdQOyr/wGv/xjr793+x0CkOfDg=
X-Received: by 2002:ac8:4316:: with SMTP id z22mr22618788qtm.121.1595240455411;
 Mon, 20 Jul 2020 03:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200716145201.186270-1-arnaud.ferraris@collabora.com>
 <20200716151352.193451-1-arnaud.ferraris@collabora.com> <20200716151352.193451-3-arnaud.ferraris@collabora.com>
 <20200716233742.GA27376@Asurada-Nvidia> <e4d96e1f-b988-bb24-b784-b4198d172e40@collabora.com>
In-Reply-To: <e4d96e1f-b988-bb24-b784-b4198d172e40@collabora.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 20 Jul 2020 18:20:44 +0800
Message-ID: <CAA+D8AP+cN5Z_ahBm2Kh+eE4TzA=LHaSoFQEiZw=Qr2jCf1OwA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: fsl_asrc: always use internal ratio
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 5:58 PM Arnaud Ferraris
<arnaud.ferraris@collabora.com> wrote:
>
>
>
> Le 17/07/2020 =C3=A0 01:37, Nicolin Chen a =C3=A9crit :
> >> @@ -507,8 +507,7 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pa=
ir *pair, bool use_ideal_rate)
> >>
> >>      /* Enable Ideal Ratio mode */
> >
> > The code is against the comments now -- need to update this line.
>
> It isn't, the following code still enables "Ideal Ratio" mode (see below)
>
> >>      regmap_update_bits(asrc->regmap, REG_ASRCTR,
> >> -                       ASRCTR_IDRi_MASK(index) | ASRCTR_USRi_MASK(ind=
ex),
> >> -                       ASRCTR_IDR(index) | ASRCTR_USR(index));
> >> +                       ASRCTR_IDRi_MASK(index), ASRCTR_IDR(index);
> >
> > The driver falls back to ideal ratio mode if there is no matched
> > clock source. Your change seems to apply internal ratio mode any
> > way? Probably would break the fallback routine.
>
> Strictly speaking, internal ratio is only enabled when we have matched
> clock sources, and is used in addition to the calculated dividers
> (allows the ASRC to better adjust to drifting/inaccurate physical
> clocks). "Ideal Ratio" mode is different, and still enabled as a
> fallback when no clock source is matched.
>
> Ideal ratio requires both USRi and IDRi bits to be set, and that would
> still be the case if there is no matched clock source.
>
> The only difference my patch introduces is that USRi is always set (was
> previously cleared for "normal" mode), and therefore only IDRi needs to
> be set in order to enable ideal ratio mode.
>

In my experience, the USRi =3D 0, no matter the value of IDRi, it is
internal ratio mode.  USRi=3D1, IDRi=3D0, it is also internal ratio mode.
So original code should be ok for internal ratio mode,  no need
to add this change.
could you please double check it?

best regards
wang shengjiu
