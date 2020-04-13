Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A02C352B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610DD2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQcKEQFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbgDMNhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbgDMNhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 09:37:31 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF64C0A3BDC;
        Mon, 13 Apr 2020 06:37:31 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id i75so8433738ild.13;
        Mon, 13 Apr 2020 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ea+AOiln+p4Qy5/mVa8RywsqxHntH9b9jIOPl9ej+Mw=;
        b=tQcKEQFd8PMqnD+4j8G67WXRwyH9D6p3Cftbf35vnV8SSd4bPiY3j4/5qbyyyfPDe5
         J7D7WeYkFSFp+qshxgJZtI59BPTu3zYvLX/Mp8eg/hcZOEr9hvHzlk0nkIRX2Q9XdY/c
         T1esTRnF1oiPZu7hxr3Xp2bNaGjeLhLVSOQn9s1V8XA6ZX3lawzfY7aTkleJV/pOzfdk
         GqFJ0lAU7gs5MnlBSKTCKZkfECwyqiH/uVkZWLZcpP1Xei4M9CezlEhMEJ7rpnmmAOv6
         mGXe9vtEe0j4L2IdsPim186DNpQmRcQVgqQcO98rHXw1/8ePLG6TOr2hbcmDHjS/xOA4
         z8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ea+AOiln+p4Qy5/mVa8RywsqxHntH9b9jIOPl9ej+Mw=;
        b=ImCdPyV3n5ND6RooQuqRhg2kWAwLVrIG54Baqsu6TKaCCxP8Z077dhYgUyMdWyNexi
         pfd5dVh+stdXgjXQIeWsafECOL5UNly70N7BjHzxe8pnAMyAVBaUwm1PIlI20vHPbrX4
         QsTlflI+4l+olPWrn1u1IDia282x5cSNPEGX4tQrntAkG+9dLu+Qe+I7QQ6M3qzk+sx1
         WTXc1DCepgUJ8TccfwX7Yi/INY85uloQPifiWZoLpb3F9A1rnzYf7B68sdN1sNy6/OSH
         eanTnYG1okOrg8NdYnPcVZ73V6noRB2Y45znkwSTGD2KXcEfkrVmyuWJv58+o5gMJ9/P
         Y5Lg==
X-Gm-Message-State: AGi0PuZ5lqeohNCrMmFPbBBDIFjMuMCKAwWBZ+HQT681mhWdUDvZfbMF
        FewfQqV8zxsFo35VIgXPm11u8wymOya0NPNeK1w=
X-Google-Smtp-Source: APiQypIM2ZRhlP9h2CjO4B6Hd4XvLJWrNZ6hK8abi0gSqx5AwSSu+AfbIJo8Vs9cRPZM1Kd+QasFJv/1twNb/nfYPqw=
X-Received: by 2002:a05:6e02:c8f:: with SMTP id b15mr15395581ile.35.1586785050679;
 Mon, 13 Apr 2020 06:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200405173601.24331-1-peron.clem@gmail.com> <20200406081007.k6wlaampgbe46yts@gilmour.lan>
 <CAJiuCccPxnW-YMjENr5-_XMMu_gs5pRnCtYvpXQtHTAVj1QQqw@mail.gmail.com>
In-Reply-To: <CAJiuCccPxnW-YMjENr5-_XMMu_gs5pRnCtYvpXQtHTAVj1QQqw@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 13 Apr 2020 15:37:19 +0200
Message-ID: <CAJiuCcdqv=mGmUvZ8=35P7fC=sePCpXFWw0_K7rEH+qPQT7W+g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add support for Allwinner H6 DVFS
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, 6 Apr 2020 at 11:07, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
>
> Hi Maxime,
>
> On Mon, 6 Apr 2020 at 10:10, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > On Sun, Apr 05, 2020 at 07:35:54PM +0200, Cl=C3=A9ment P=C3=A9ron wrote=
:
> > > Now that required drivers are merged we can contibute on DVFS
> > > support for Allwinner H6.
> > >
> > > This serie is based on Yangtao Li serie[0] and Ond=C5=99ej Jirman wor=
k[1].
> > >
> > > Most of the OPP tables are taken from original vendor kernel[2].
> > > Plus there is a new CPU frequencies at 1.6GHz, 1.7GHz and 1.8GHz.
> > >
> > > I wrote a simple script to randomly set a frequency during
> > > a random time[3].
> >
> > If you ever need to do that ever again, cpufreq-ljt-stress-test (found
> > here https://github.com/ssvb/cpuburn-arm) has proven to be very
> > reliable to detect cpufreq related issues. stress-ng might not be
> > enough since the (at least older) Allwinner SoCs tend to create cache
> > corruption when undervolted, and that might not be unnoticed by
> > stress-ng but will be catched by cpufreq-ljt-stress-test.

The test seems good (see result below) :

# cpufreq-ljt-stress-test
Creating './whitenoise-1920x1080.jpg' ... done
CPU stress test, which is doing JPEG decoding by libjpeg-turbo
at different cpufreq operating points.

Testing CPU 0
 1800 MHz ............................................................ OK
 1704 MHz ............................................................ OK
 1608 MHz ............................................................ OK
 1488 MHz ............................................................ OK
 1320 MHz ............................................................ OK
 1080 MHz ............................................................ OK
  888 MHz ............................................................ OK
  816 MHz ............................................................ OK
  720 MHz ............................................................ OK
  480 MHz ............................................................ OK

Testing CPU 1
 1800 MHz ............................................................ OK
 1704 MHz ............................................................ OK
 1608 MHz ............................................................ OK
 1488 MHz ............................................................ OK
 1320 MHz ............................................................ OK
 1080 MHz ............................................................ OK
  888 MHz ............................................................ OK
  816 MHz ............................................................ OK
  720 MHz ............................................................ OK
  480 MHz ............................................................ OK

Testing CPU 2
 1800 MHz ............................................................ OK
 1704 MHz ............................................................ OK
 1608 MHz ............................................................ OK
 1488 MHz ............................................................ OK
 1320 MHz ............................................................ OK
 1080 MHz ............................................................ OK
  888 MHz ............................................................ OK
  816 MHz ............................................................ OK
  720 MHz ............................................................ OK
  480 MHz ............................................................ OK

Testing CPU 3
 1800 MHz ............................................................ OK
 1704 MHz ............................................................ OK
 1608 MHz ............................................................ OK
 1488 MHz ............................................................ OK
 1320 MHz ............................................................ OK
 1080 MHz ............................................................ OK
  888 MHz ............................................................ OK
  816 MHz ............................................................ OK
  720 MHz ............................................................ OK
  480 MHz ............................................................ OK

Overall result : PASSED




>
> Thanks for the tool and explanation. I will test the v3 with this one.
>
> >
> > Also, it will test each frequency, while random frequencies might skip
> > a few.
>
> I didn't count them but there was more than 2000lines, probability to mis=
s
> a frequency is really low. Also changing from 500MHz to 1.8GHz could have
> trigger some out-of-spec issue.
>
> But just to be sure I will add an init phase before doing random stuff.
>
> >
> > > With this script and using stress-ng during several hours, I didn't
> > > see any issue. Moreover I have tested specifically the 1.8GHz on my
> > > Beelink GS1, max thermal 85=C2=B0C is reached very quickly and then t=
he
> > > SoC oscillates quickly between 1.5 and 1.8GHz. So i have added
> > > 1.6GHz and 1.7GHz my board now oscillate slower between 1.5GHz and
> > > 1.6GHz swapping every second and temperature is also morestable.
> > >
> > > I also test that that offlining CPU0 and doing DVFS on other CPUs
> > > works. As CPU regulator is only set for CPU0.
> > >
> > > But maybe it doesn't cost much to set the regulator for all the CPUs?
> > >
> > > Jernej test the GPU devfreq on several H6 board particulary the
> > > Tanix TX6 which doesn't have a proper dedicated PMIC and doesn't
> > > had any trouble with it.
> > >
> > > Do you think I can enable GPU OPP for all H6 Boards?
> >
> > It seems you're doing it?
> No I don't, see my answer on patch 4/7.
>
> Thanks for your review,
> Cl=C3=A9ment
>
> >
> > Maxime
