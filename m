Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384B6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1193820575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyyZshw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504671AbgDNTZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504638AbgDNTYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:24:48 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABD9C03C1AE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:16:51 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y17so14430532iow.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+1oMW+73zk/UZsuvxoLBAtK4iQfyId+yP/pRZMyvftU=;
        b=tyyZshw7bi1xv4INHCsKppsByOssHMw5Hd7CChfUn5fyS1quMU/wi/0vSvbLRN5Q0Z
         r7/t/Nqn3DgGrPZ6Jy/twcQR9eVD5ut3IZ5y95BBYziXbcHSsWHD8PEn8Khsi4aK9HQR
         AbD3EZZXzOUzdC1O48m+N7JWA/ToQYtJQeE7IZDY9hkLAn8b+VHP086jenTJFWFmSqLf
         iNoEZhJVGtkAnCxQ2m1r1WTrKgcWCw+2RlRZMPDjaMfjsdwTCc3Q5UbacoLyeHYtWnxV
         N2bzPBr6iuhTgBiKWew8o30nyelngep2WnqwIHjZD8DDvzJfoXbpev800Kwjvd+0p1lw
         LifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+1oMW+73zk/UZsuvxoLBAtK4iQfyId+yP/pRZMyvftU=;
        b=CXhsCgSxRHHYyk4Kf8OIa7D5S9NPXeOS1Cn62qzuxEoZSpJjlKrlAudoM3XT6V9wKV
         l2SK9jPnK3XfXtpJzTt1M6Wyg1gZ+IH1EBycMypwBlcULrjHCHVhgvY6jboVWv+v4gkp
         nSZFs/En+SgNLOoBpAkM7+tm1vsGcGYLtQXWrNAI2/5ZIxMMIWgfATwDaBpqWscgm78e
         QchDzv2zmiazGrO3TgygzScrbDtKYM9KOZlwTfuXRLBJgzAqAmB4rwciOSUT4V4orWm2
         OrY8H40ZTf/ezZVmDYTh1HTG4DpyLScA0/s5CU4U6973GvLg69RjYNdFiXUk4HyzlRxG
         /ICg==
X-Gm-Message-State: AGi0PuY7YB/ALAip0Hltl+TwEJRU0WYck3l5grgiNFWE19+69ZhGJPt5
        pVO6L2hJt5y+2pb1TaaduFEwGQWfipoMq03M1tE=
X-Google-Smtp-Source: APiQypLvVvaTJ20aRKds80SKfsfkdBP/7YX1znqZgfJflhsOKwwQiDSz+3hfYAWKl5ISCQaexOI42mWWAQkQ2dRBER0=
X-Received: by 2002:a6b:dd16:: with SMTP id f22mr11506998ioc.178.1586891810616;
 Tue, 14 Apr 2020 12:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200411200632.4045-1-peron.clem@gmail.com> <20200411200632.4045-2-peron.clem@gmail.com>
 <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com> <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
 <CAJiuCceU662o7QGJ=mmT3pzVWK7uJUN=6+NKQnZ=Cfj9c2nw7A@mail.gmail.com>
 <d6465e7e-8e05-8b7d-16bd-f40877969089@arm.com> <CAJiuCccv2XPLY6sjcgvvrG5a8ONYHa_xn9i-YUDKUDK5a0DY=A@mail.gmail.com>
 <CAJiuCcfa9ro1V4nBzfD48cCuHpEsLaNA5P0bb-tQ3hcWUCtpkA@mail.gmail.com>
 <000f26f4-3640-797f-c7f6-4b31a5e2669e@arm.com> <CAJiuCccF3tmbmMWNh0nC5WRJ1_iPdj6f1oH1zYMSue_pFrXsPQ@mail.gmail.com>
 <20200414185523.GO5412@sirena.org.uk>
In-Reply-To: <20200414185523.GO5412@sirena.org.uk>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 14 Apr 2020 21:16:39 +0200
Message-ID: <CAJiuCce5ekAed6RF8+x_ehruCXW3900wkFNKRXN_Xo_62MPXew@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panfrost: add devfreq regulator support
To:     Mark Brown <broonie@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, 14 Apr 2020 at 20:55, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Apr 14, 2020 at 08:20:23PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Liam and Mark,
>
> You might want to flag stuff like this in the subject line, I very
> nearly deleted this without opening it since most of the email I get
> about panfrost appears to be coming from me having sent patches rather
> than being relevant.

Ok will do next time,

>
> > We are having an issue with Panfrost driver registering two times the
> > same regulator and giving an error when trying to create the debugfs
> > folder.
>
> > Could you clarify if it is allowed for a device to register two times
> > the same regulator?
>
> > I check Documentation/power/regulator/regulator.rst but this point is
> > not specified.
>
> We don't actively prevent it and I can't think what other than debugfs
> might run into problems (and that's just a warning) but it does seem
> like a weird thing to want to do and like it's pointing to some
> confusion in your code with two different parts of the device
> controlling the same supply independently.  What's the use case here?

Panfrost first probe clock, reset and regulator in device_init:
https://elixir.bootlin.com/linux/v5.7-rc1/source/drivers/gpu/drm/panfrost/p=
anfrost_drv.c#L602
Then it probe for optional devfreq, devfreq will get opp tables and
also get regulator again.
https://elixir.bootlin.com/linux/v5.7-rc1/source/drivers/gpu/drm/panfrost/p=
anfrost_drv.c#L609

That's can be reworked and Panfrost can only probe regulator if there
is no opp-table.

But if multiple regulator is not an issue and as each request is logic.
The first in device_init assure to enable the regulator and the second
in OPP assure the voltage level.

Maybe we can just fix this warning?

Thanks,
Clement
