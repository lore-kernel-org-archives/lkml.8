Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B981BC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 04:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926EB207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 04:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0lx+5Vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgEMEFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 00:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgEMEFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 00:05:46 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D0FC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 21:05:45 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z22so12440295lfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 21:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5DfVl3UTVTePHaLcFBtqqP4Bgt2fHKIIZV0vLdJMfw=;
        b=X0lx+5VgRKBUjgcLIUXo0l4kNqa+HWCEuwieMLGfX7R6gJsysKdNLip/Z5aNBtqcKq
         ZHyzngzkgSh1+R7lrCgnXihuggnUozIwQkMfxmHQW6hSS4p5Aj+8n2I+E1ahRsJ5MeYK
         Ai74UTj4c+mDLjVlXVmkmNqcLpiXu8oLZBO4pVDmpfbtMtFyGCpm9v7QJkiiH++B1SEB
         n2Hj93K25HcZa6GUD4ZboQ6N6RK1Wt3GxC7VdWH0JZkvdhzUKCghhPDXrnLTZ57nq3MQ
         pJ9v2W9pKM2atx1b86GIUD+h9q7wAQeKMfPHQ5Tt5MsuX5KxcwRsAS4grZGt83d7kAfy
         wSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5DfVl3UTVTePHaLcFBtqqP4Bgt2fHKIIZV0vLdJMfw=;
        b=sK4woesQS0Zj2HFXG9KZm78Nr6mVIVt6RN8D+UXYuUvXonUPT5PgIBhpZEzvnhnJmE
         AO3ZTnJ+H2K67576Mla19j9BeeEpSEIX5iAg0pt4obE+Zewm41q8h6Mw8YgfdATZTghB
         Qdxkt+S45fTSR/Di46Vmhk9cnG7lWVrE4fY1odQ02KhnR52+Kj/TfhkRrB0xo6PTx4Zg
         OckJINPD0tsebaWolye9XxMig1ybSodbL+yprpTB089SGL9656UHkm02GF2PT+h+c2+R
         iobN0KGJmbcURVLeVdZDRiqMY0jirg65aC9bVus7AdOjUlEq3wd6pIMJlUij7of+1Z/j
         2emQ==
X-Gm-Message-State: AOAM531L8sR2U2UmMszRWLpiHG0XYRQfvllnBOBBvEN8Rjiv9VkUzVUT
        0F2yLsEmF2hhuFUpvZH1cTQ6mciUM78z8KAvN9Y=
X-Google-Smtp-Source: ABdhPJwVbX814H5PlLygUc2P4zM8+ColDOjxqNR+yG2t1A4WZKHAtcZSofnK2cs+OTZUhXgYDydXDZcxKnwkxgsdP0k=
X-Received: by 2002:a19:4a97:: with SMTP id x145mr16471976lfa.66.1589342744155;
 Tue, 12 May 2020 21:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200509031919.9006-1-steves.lee@maximintegrated.com>
 <20200511110346.GE8216@sirena.org.uk> <CABff4NQXs622x1X6ZvNABHNZoTMS57f4Y5sdo1Cng3JeTgboCw@mail.gmail.com>
 <20200512103316.GB5110@sirena.org.uk>
In-Reply-To: <20200512103316.GB5110@sirena.org.uk>
From:   Steve Lee <steves.lee.maxim@gmail.com>
Date:   Wed, 13 May 2020 13:05:32 +0900
Message-ID: <CABff4NTm77Cr+FwO8p0-3AKBCWOvzXaHfdbP8guzWQ2Zzcrobg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: max98390: Added Amplifier Driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, dmurphy@ti.com,
        jack.yu@realtek.com, nuno.sa@analog.com,
        steves.lee@maximintegrated.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        ryan.lee.maxim@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 7:33 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, May 12, 2020 at 06:13:05PM +0900, Steve Lee wrote:
> > On Mon, May 11, 2020 at 8:03 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > > +static const char * const max98390_current_limit_text[] = {
> > > > +     "0.00A", "0.50A", "1.00A", "1.05A", "1.10A", "1.15A", "1.20A", "1.25A",
> > > > +     "1.30A", "1.35A", "1.40A", "1.45A", "1.50A", "1.55A", "1.60A", "1.65A",
>
> > > This looks like it should be in DT too.
>
> > Since this control  is needed while running system according to system
> > battery situation.
> > I'd keep this mixer for further use.
>
> That's...  interesting for a current limit, and sounds like it would
> have issues for the common case use of current limits to protect the
> hardware.
>
> > > > +static int max98390_dsm_calib_get(struct snd_kcontrol *kcontrol,
> > > > +             struct snd_ctl_elem_value *ucontrol)
> > > > +{
> > > > +     struct snd_soc_component *component =
> > > > +             snd_soc_kcontrol_component(kcontrol);
> > > > +
> > > > +     dev_warn(component->dev, "Get dsm_calib_get not supported\n");
> > > > +
> > > > +     return 0;
> > > > +}
>
> > > Just don't implement the operation if you can't implement it.
>
> > If this not exist as dummy operation and all mixer was not working and
> > could not implement better idea.
>
> Could you be more specific about what you mean by "not working" or how
> simply not initializing the value returned fixes things please?
I mean that xhandler_get pointing to NULL makes mixer list unexpected operation.
I will do return fixed value without warn message.
>
> > Could you consider it as with warn message ?
>
> No, if there's a problem here we should fix it properly.
Thanks for feed back.I will do return fixed value without warn message.
