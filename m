Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA7FC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7D22468A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="bSukH/zF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgA2MFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:05:40 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38161 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgA2MFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:05:40 -0500
Received: by mail-qt1-f193.google.com with SMTP id c24so12995520qtp.5;
        Wed, 29 Jan 2020 04:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mBhYDjlMYt9oPvJDVZEMOGajq1ap97bap+avx9OLRTo=;
        b=bSukH/zF9ERehDN/leiT06EaG3VBfbDrDV4lszITXI4Bv+2DtvigXYXFE1g7lcxN0O
         U2TKdN0v29NYCpDpbbW1Oj8POlnIAD5jLUQ1X+Apt36OVF4hjycewluABof0RELDGbNI
         X55E988XDoPirlb+bbSnfoASlDrXczeMzHdX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mBhYDjlMYt9oPvJDVZEMOGajq1ap97bap+avx9OLRTo=;
        b=NdZxfRQy0PH1j0typkcwxQEZr+mbrDLW8wnbbEGlaZhJoNIrk8rrEAfkLTuQA3/Fc9
         xv37t8B2nhMIG7BoD77FdSXdjfyBvUfyHiSMHXng0PLXIV33vvtaKc/gwum48mcvjk3C
         ZdzZ5GsKTBPpgTgrfchn6eFeUHL8TvzTDDrAYne9UEVEr4wTMRgHLOJ0f3gPiHbhYLvh
         9a4DgW/YWu+xrsBNeo5ZK++GXqZQMJN4lCJMc0rdwE6ID8j3EGdkyrAJ2qbAK4YH1ncV
         T++OyeAP1CioQm04ycvFTIt1VkqEhDhNBaXEJUcrlDNtI0peOqj3O2kpFozPeFftpbYm
         O21A==
X-Gm-Message-State: APjAAAWPaL7iPNn/PIuEHivJUU/4nj/BzdJb66OeiMiUOPiIx62tLj78
        j2w3NKehBauQtjDJ7dIYIUIR+njz6hGQweZkLcQULw==
X-Google-Smtp-Source: APXvYqwwYOnEPeP6zNxmB7ArfBKhqOZuvhZ78RvYhGJ4L6VqO8SHJNxy14/eqW+VoKPy2f0j6WfUfjKO/Jnfil+w88c=
X-Received: by 2002:aed:3b3b:: with SMTP id p56mr26336771qte.234.1580299538663;
 Wed, 29 Jan 2020 04:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20191107094218.13210-1-joel@jms.id.au> <20191107094218.13210-2-joel@jms.id.au>
 <747e3c0a-ee10-4a41-d0b7-1d54e0f56dd0@linaro.org> <CACPK8XeWY-upP-b_aAMWv-Rx9qaNSbPxOZLVd67-khEVjG877A@mail.gmail.com>
 <805bbfa2-e6ff-3b22-02cf-cd1419bcf929@linaro.org>
In-Reply-To: <805bbfa2-e6ff-3b22-02cf-cd1419bcf929@linaro.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 29 Jan 2020 12:05:27 +0000
Message-ID: <CACPK8Xcq27cRQOwKCmVHD0uphERPm=hxQUscw2Z6zzi8DTT9Nw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] clocksource: fttmr010: Parametrise shutdown
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 at 11:53, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 29/01/2020 12:41, Joel Stanley wrote:
> > On Wed, 29 Jan 2020 at 11:25, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
> >>
> >> On 07/11/2019 10:42, Joel Stanley wrote:
> >>> In preparation for supporting the ast2600 which uses a different meth=
od
> >>> to clear bits in the control register, use a callback for performing =
the
> >>> shutdown sequence.
> >>>
> >>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >>> Signed-off-by: Joel Stanley <joel@jms.id.au>
> >>
> >> It will be cleaner if you create a struct of_device_id array where you
> >> store the different variant data.
> >
> > I agree, and that's the path I would have taken when writing a normal
> > driver. However as the timer drivers probe with the
> > TIMER_OF_DECLARE/timer_probe infrastructure, we can't register our own
> > .data pointer (TIMER_OF_DECLARE uses .data  to store the _init
> > function).
> >
> > Unless I'm missing something?
>
> I was suggesting to add the array like:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/clocksource/timer-atmel-tcb.c#n351
>
> TIMER_OF_DECLARE is used and the probe functions relies on the match arra=
y:
>
> match =3D of_match_node(atmel_tcb_of_match, node->parent);

I see. So we don't use this table for probing the driver, just getting
the associated data.

I'm not convinced that's an improvement over what we have. If you have
a strong preference I can try it out.
