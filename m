Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A79C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A3F21D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKrnZ/ZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgDQMdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728196AbgDQMd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:33:26 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D04C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:33:26 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id f19so2101385iog.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/DFFcAX16DLaq9WdO2qiN8rBml+MJK+Egu3pWqI85c=;
        b=rKrnZ/ZIdm1aeUPIX2i7Z77058PYDAyNI6+iFrsFSDl7Je/8OlgZDCy9z5ii3rx9bw
         gLH9lHRSc7kG5idpQgApSohV1Wts12wfoCocXqxJ7RGXlYL7wXut+NkfjnWBjxe+c84P
         5zbwC5uXVCo23D5lkdwM6MYjBe7JgeBmr1VycqpHixyxRgUohE5P4qRn7FnQl4If7cRQ
         VFaunHobZ42q9csRi2N7XlnSGOOLQgrEBaDnNLJqS+jo3hykyly0n0zAaPDNZu8TFf/f
         pxenS/GTz2RYzFkthc5Q2EsN3kzDihUUVfhVnJQkb7OqJ+3FdagJ8GRpyNSlS2DFJdh2
         gGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/DFFcAX16DLaq9WdO2qiN8rBml+MJK+Egu3pWqI85c=;
        b=E6hRM6YHqijyHwyF20eknEyC601pqWAd8q3XnRN9pmk90mifxyfHne2yj/Lw2FIASJ
         ow0aFU2fd4BYPoLIIpx7HvE1iON8P6ZTFsgnU1cO83kJ0nldlMpixzzUCmGb+0O0vUL/
         ZjGo/e+nJCfVYZ/EMAvceIily8Iyf/u0AqQTPxCak3buwhJhNcMJYuhS1Kl0BDFyZZAH
         ClX8LSh10sU2T4wVEHzBJxlNbkDS0OZJU2brdKcUOuJSdDVWBqBHrT7h3zVcAPNezU+u
         wDwMy1pWr8zFCwAO4rnTA2eEa9PtNtbh0Kuod0tlpaY82rfZFU38fiOfY02t3YcNDcm1
         LtLg==
X-Gm-Message-State: AGi0PuYQgVcqqLi2eWSpVE267MZdKsqOBRZwXT8hCZfOCbB9sDZsw13Q
        T4WBNn6Otj4pZUmLS+VfNgRHIlpjDhF2svO1EhI=
X-Google-Smtp-Source: APiQypIMz5q9puyyBCHECnAJTResjfLLf+aqAmOmoCL1sM4QnW8xe6r7rdXvDq1VFz83xdHIPkyef4LGIVeKFPSENdQ=
X-Received: by 2002:a5d:9494:: with SMTP id v20mr2793842ioj.101.1587126805638;
 Fri, 17 Apr 2020 05:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200411200632.4045-1-peron.clem@gmail.com> <20200411200632.4045-2-peron.clem@gmail.com>
 <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com> <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
 <CAJiuCceU662o7QGJ=mmT3pzVWK7uJUN=6+NKQnZ=Cfj9c2nw7A@mail.gmail.com>
 <d6465e7e-8e05-8b7d-16bd-f40877969089@arm.com> <CAJiuCccv2XPLY6sjcgvvrG5a8ONYHa_xn9i-YUDKUDK5a0DY=A@mail.gmail.com>
 <CAJiuCcfa9ro1V4nBzfD48cCuHpEsLaNA5P0bb-tQ3hcWUCtpkA@mail.gmail.com>
 <000f26f4-3640-797f-c7f6-4b31a5e2669e@arm.com> <CAJiuCccF3tmbmMWNh0nC5WRJ1_iPdj6f1oH1zYMSue_pFrXsPQ@mail.gmail.com>
 <20200414185523.GO5412@sirena.org.uk> <CAJiuCce5ekAed6RF8+x_ehruCXW3900wkFNKRXN_Xo_62MPXew@mail.gmail.com>
 <5e15e7ac-1d9c-d614-8fd9-27525c88cafb@arm.com> <5290a7a8-2a0a-cb89-9d62-270393123054@arm.com>
In-Reply-To: <5290a7a8-2a0a-cb89-9d62-270393123054@arm.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 17 Apr 2020 14:33:14 +0200
Message-ID: <CAJiuCccm4gTAUWhTy+gK0kt4of=8yWcz2n_JtnmeAJofcpBKeQ@mail.gmail.com>
Subject: Re: Multiple regulators for one device [was drm/panfrost: add devfreq
 regulator support]
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Steven Price <steven.price@arm.com>,
        Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Fri, 17 Apr 2020 at 13:10, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-04-16 2:42 pm, Steven Price wrote:
> [...]
> > Perhaps a better approach would be for Panfrost to hand over the struct
> > regulator objects it has already got to the OPP framework. I.e. open
> > code dev_pm_opp_set_regulators(), but instead of calling
> > regulator_get_optional() simply populate the regulators we already have?
> >
> > The other benefit of that is it would provide a clear hand-over of
> > responsibility between Panfrost handling it's own regulators and the OPP
> > framework picking up the work. The disadvantage is that Panfrost would
> > have to track whether the regulators have been handed over or not.
>
> Sounds like the most logical thing to do is to shuffle things around so
> we start by trying to set up an OPP table, then fall back to explicitly
> claiming clocks and regulators if necessary. Then we can easily make the
> devfreq decision later in probe based on how that turned out.

Ok I will propose a new serie with this behavior,

Thanks
Clement

>
> Robin.
