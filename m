Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E4EC47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC4321775
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rePtkf+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgEAVaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgEAVaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:30:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61539C061A0C;
        Fri,  1 May 2020 14:30:01 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d16so8276149edv.8;
        Fri, 01 May 2020 14:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k4vhp0VlA+4eKJJcpzlGuSTcol2cbO4w29cWTar5YXw=;
        b=rePtkf+jPvelgNBY44aw3nYMFa5z7pgcs5SldQ92lZp43pUqhAGeePfH2odr3ADJDA
         QcZ2cYJvsG8/zzDg8bG5QqCa5nIgYZUXusJKm70zAXfwDKs2VRWUnGzmiCKrgFLSp4md
         AxGc42MrTZwXh0z5npeuKdDg/q0hsILpewPYO3tmaGmP4e5ZTaTMubB/inuhUXp3f5Lv
         mGpNnEBsRoH8SFO5PuH61qp73o+idjmg7CjB9UnzjvHyMRcpu/uBjAQeWhU3OQmQEDx1
         3fjjnP3++pQIv+Bh+qPKNRhTiU2fnq4OoNZugrikgH7RDm4xhW75IKYDqC6XT3Kl1Q0q
         wojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k4vhp0VlA+4eKJJcpzlGuSTcol2cbO4w29cWTar5YXw=;
        b=TYqSIqpO+++2+yv9Brf1Xig7lrldCGX/c3OUUsZ/aDK0zPxn3eJ+baBF7O8P8XVh3K
         Dg3vDFhPyI6DDNyGm8J4tKMO3hs0hKpXCYBGmrB1QUmudwBnbvEDejbAqVfI3tUKe9et
         ryhDqLg4raoIBvxjnUYQrxrbzZP4uA9g3SZ3mz55wTl7UzJzZjQ84xC0A0kCGW1kH4DL
         KLeBK+xYoNGovvfZvoElV+qDH2WLMtPXsAXwqQG4h64MVOPUu5NUZS2kGJxpozilRAqI
         ATnDTmx+tzvuZuzcK5IWla3bSj/ev1HYwJ3Uyw6FO+lriL9aYfZRkqNSjLoZ6tYljkIK
         jImA==
X-Gm-Message-State: AGi0PuZBFor+iJpQehAsCka0xIkBghAHDm/Pi554bveyEmNHMw75k4y1
        FugXACmswaawpophHKTQH4Qem4r+6D/UoqUt/gU=
X-Google-Smtp-Source: APiQypJtLZZnIVsTjvuuhCzWaXfXP7wpnGa9G6PIdiNusehMFzCx8SssWzyKYi0NZLrZBEfGDbSYqPU6qlS+yngIqY4=
X-Received: by 2002:aa7:dcc3:: with SMTP id w3mr5012926edu.231.1588368599999;
 Fri, 01 May 2020 14:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200501204825.146424-1-konradybcio@gmail.com> <20200501210038.GB26726@ravnborg.org>
In-Reply-To: <20200501210038.GB26726@ravnborg.org>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Fri, 1 May 2020 23:29:24 +0200
Message-ID: <CAMS8qEXLAoY9mA5iEA8hqhpejwvDQj1CC_E6QFh3+qgrEWb6cA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add support for TM5P5 NT35596 video mode panel
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     skrzynka@konradybcio.pl, Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very strange.. I just fetched drm-misc-next and had no issues building...

Thanks for your initial thoughts!

pt., 1 maj 2020 o 23:00 Sam Ravnborg <sam@ravnborg.org> napisa=C5=82(a):
>
> Hi Konrad.
>
> On Fri, May 01, 2020 at 10:48:21PM +0200, Konrad Dybcio wrote:
> > I am aware of the fact that this is probably not the correct
> > naming of this panel, yet I am unable to retrieve any additional
> > information about it, as it is used in a smartphone to which no
> > schematics are released.
> >
> > The driver has been generated with the help of
> > linux-mdss-dsi-panel-driver-generator [1] and works perfectly
> > on a Asus Zenfone 2 Laser Z00T smartphone, including brighness
> > control and switching on/off.
> >
> > [1] https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-gen=
erator
>
> Panle driver looks good.
> Will take a closer look tomorrow.
>
> Any chance you can work on the TODO in the driver so we can have that
> resolved before we apply it?
>
> Also for a v2 it would be perfect if you could work on top of
> drm-misc-next.
> There is at least one small fix needed to build that I spotted.
>
> But wait until I get back on the driver patch before submitting a v2.
>
>         Sam
>
> >
> > Konrad Dybcio (2):
> >   drivers: drm: panel: Add TM5P5 NT35596 panel driver
> >   dt-bindings: display: Document TM5P5 NT35596 panel compatible
> >
> >  .../bindings/display/panel/tm5p5,nt35596.txt  |   7 +
> >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> >  drivers/gpu/drm/panel/Makefile                |   1 +
> >  drivers/gpu/drm/panel/panel-tm5p5-nt35596.c   | 366 ++++++++++++++++++
> >  4 files changed, 383 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/tm5=
p5,nt35596.txt
> >  create mode 100644 drivers/gpu/drm/panel/panel-tm5p5-nt35596.c
> >
> > --
> > 2.26.1
