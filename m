Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE290C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F48F206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNSAOniF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgDFJH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:07:57 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44377 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgDFJH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:07:57 -0400
Received: by mail-il1-f193.google.com with SMTP id j69so13881527ila.11;
        Mon, 06 Apr 2020 02:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/9j8DdZJYyLVGpLvuhYgYAvXmfCc0kHfDTcnuG7viz0=;
        b=HNSAOniFzM6jm6vp0c57iOa9y0/X3uZ2z5tkjrwiIng1IfKsrxBzQ0hhjx3XuZZ/u2
         6hLtPhK9VhleZ1LllosidRlLXtoSbp6R7Vr3okE/i94RO7FVsmvnjqon+5zEYHwdYAeM
         Mk5i+86U7o50T/KDGfFAAeSlxyR6QwXvOyFrEOeJQKH4j7U5wUNtBfq4toVis7WZlTfA
         UwGyi5mXfJ/ZDv3sWnLbmiupP80JSFKlYxmq1PjyMUITzZwcxVW8Vv8ijJHF2kICYfc8
         C9IqSAekroHkP5mYGQDSXWbT9DOxRcpZt3aw9vEiPEiF9nfZKvo1BtNlUZleKXptI0sk
         kPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/9j8DdZJYyLVGpLvuhYgYAvXmfCc0kHfDTcnuG7viz0=;
        b=KFZeL56O/E8RzA794Q0Zs9thzlvv/6lLBWZnm84cslhTiO/o7sytCtbxZv52VScoeS
         uWeYUelRry3SDYgIOJNSHMssaQLfyOWur/DBRXA+FnoponqqKF2jJ6uAHuchYfaVDUdi
         gEi+f+YopVLjQlC4vaiC9MnoFqFIfmRSnT61iBiDrUAm2faC0btKa2AoYWPyDm3wdkC8
         5IxyfKQh8OKY829qdtflvPabvUQF1I4kfaykALdkWMO9d18mBxoMUzv+hV8WpeJXU6/6
         ipHp5tHFP73GjdkNo8g2nAJjvvfEL6vPeSlDwRY76qz7tWivMneVF3/wJ9MoSP3nqhfc
         AQDA==
X-Gm-Message-State: AGi0PuYY5ZQUBW6/SG+pbkmZIvBoaHVl8UcOHMfQNQ2MUbUxdU0ip2vI
        ifIogM3Pbt22XLKeZYLbMdC77amyBQlizmnTt64=
X-Google-Smtp-Source: APiQypI5S4sx/nuC+BoUUIBngD3kJd8k+mZEAdHCy9UHtWhnWg7WVKqBk4l0p1gpmHZya6fVvlPa6dwh5Lw7jJAZmyc=
X-Received: by 2002:a92:5ccd:: with SMTP id d74mr18764377ilg.59.1586164076003;
 Mon, 06 Apr 2020 02:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200405173601.24331-1-peron.clem@gmail.com> <20200406081007.k6wlaampgbe46yts@gilmour.lan>
In-Reply-To: <20200406081007.k6wlaampgbe46yts@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 6 Apr 2020 11:07:44 +0200
Message-ID: <CAJiuCccPxnW-YMjENr5-_XMMu_gs5pRnCtYvpXQtHTAVj1QQqw@mail.gmail.com>
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

On Mon, 6 Apr 2020 at 10:10, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Sun, Apr 05, 2020 at 07:35:54PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Now that required drivers are merged we can contibute on DVFS
> > support for Allwinner H6.
> >
> > This serie is based on Yangtao Li serie[0] and Ond=C5=99ej Jirman work[=
1].
> >
> > Most of the OPP tables are taken from original vendor kernel[2].
> > Plus there is a new CPU frequencies at 1.6GHz, 1.7GHz and 1.8GHz.
> >
> > I wrote a simple script to randomly set a frequency during
> > a random time[3].
>
> If you ever need to do that ever again, cpufreq-ljt-stress-test (found
> here https://github.com/ssvb/cpuburn-arm) has proven to be very
> reliable to detect cpufreq related issues. stress-ng might not be
> enough since the (at least older) Allwinner SoCs tend to create cache
> corruption when undervolted, and that might not be unnoticed by
> stress-ng but will be catched by cpufreq-ljt-stress-test.

Thanks for the tool and explanation. I will test the v3 with this one.

>
> Also, it will test each frequency, while random frequencies might skip
> a few.

I didn't count them but there was more than 2000lines, probability to miss
a frequency is really low. Also changing from 500MHz to 1.8GHz could have
trigger some out-of-spec issue.

But just to be sure I will add an init phase before doing random stuff.

>
> > With this script and using stress-ng during several hours, I didn't
> > see any issue. Moreover I have tested specifically the 1.8GHz on my
> > Beelink GS1, max thermal 85=C2=B0C is reached very quickly and then the
> > SoC oscillates quickly between 1.5 and 1.8GHz. So i have added
> > 1.6GHz and 1.7GHz my board now oscillate slower between 1.5GHz and
> > 1.6GHz swapping every second and temperature is also morestable.
> >
> > I also test that that offlining CPU0 and doing DVFS on other CPUs
> > works. As CPU regulator is only set for CPU0.
> >
> > But maybe it doesn't cost much to set the regulator for all the CPUs?
> >
> > Jernej test the GPU devfreq on several H6 board particulary the
> > Tanix TX6 which doesn't have a proper dedicated PMIC and doesn't
> > had any trouble with it.
> >
> > Do you think I can enable GPU OPP for all H6 Boards?
>
> It seems you're doing it?
No I don't, see my answer on patch 4/7.

Thanks for your review,
Cl=C3=A9ment

>
> Maxime
