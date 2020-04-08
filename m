Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0C6C2BB54
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BD3206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyPmrIDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgDHAhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:37:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37314 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgDHAhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:37:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id n17so4323269qtv.4;
        Tue, 07 Apr 2020 17:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0QEs4QF1dLNDkHNcj/Hb1mTnMIfVWg6wQGYaSYAjEuI=;
        b=pyPmrIDpX4c8iYcVhnc8Zqf/JsvMtmMT8+2xfzdml946CT9w1ApuOamrLBfSmqbq9/
         emWtT0Td9yJ4n9LGQQUxPi9BA8jeaDhsb8fWohpbINILuX/EdaBdTIAfypSJVwPOsykP
         HpP6O9DvA+j+yyGQsmKMoRfMm+A4+MXbIOXW1DxqBAJNtNRgzvdyvczIIjyKsGvLDz1S
         UWXMj6OBKw/qKc/Ea2nWsr4qvMbRBh4E7VdawowEAL+qyrsI/I29XSaU3IilnG7ExR1g
         BdpVK6SxppoUop+xIr96RetqhCGA9nRdoFo7g1aOa9yJ1XaBBQy14WFR+dPa3qcyxRI/
         of4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0QEs4QF1dLNDkHNcj/Hb1mTnMIfVWg6wQGYaSYAjEuI=;
        b=TLBjoqPMjlvtNpNsDOAtVWOpxnqp4Zf5odp1rvOkggB08S5rRhjYVBkaBzyFJzp01b
         Gh5bJDv8PgmarWXrEvr34DEljUvg4FFdqU9K2ldynLtyKMLapt/RSs7Xqv1M8oVHKOK5
         0Dqlto5vOEUrZQzhPfQRIKk+ZXbG6YYSUMEp082sO26UJXglUNeI8nhg+u78lvshcLo4
         QnR3sjpPEXz/V+23mTHRt3dpkLQZSZA3Z5UHSPtDFscV0cnda2da6vFhD6TSbi6z+Vvi
         DALCgWHqIpd5aKsQ5fnHyD9Ipm7n8szSLEi+WMsCEI/Vm33b4sJAHbxAIaXwr5Dsr6hJ
         dROg==
X-Gm-Message-State: AGi0PuawoFF49g/UUDj8BhduBrVw6O0NvvEvwLFA0biqtfsW+KvEuHHj
        +httT53Fgj+FkvsDH4NPJLwAYTOpRGrYHSEN1s4=
X-Google-Smtp-Source: APiQypL4S1cYkdiIXBkGpDQ/r3HyQDcmzfSmL8BUkVkT9urkaNW9j2BBEB7WRkuJQpxDZkafPAXfcY1mKOMhx5+HGRs=
X-Received: by 2002:ac8:7185:: with SMTP id w5mr4867920qto.356.1586306265596;
 Tue, 07 Apr 2020 17:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200406194110.21283-1-digetx@gmail.com> <20200406194110.21283-7-digetx@gmail.com>
 <20200407100829.GB1720957@ulmo> <70ad6fd6-9603-a114-2d0f-608110b68c0b@gmail.com>
In-Reply-To: <70ad6fd6-9603-a114-2d0f-608110b68c0b@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 7 Apr 2020 20:37:34 -0400
Message-ID: <CAMdYzYr76GUEEXgKippfCJDTU1L+A0UXTyO_B14vkOxVp_pijw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] ARM: tegra_defconfig: Enable options useful for
 Nexus 7 and Acer A500
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?Q?Pedro_=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 12:38 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 07.04.2020 13:08, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Mon, Apr 06, 2020 at 10:41:10PM +0300, Dmitry Osipenko wrote:
> >> Enable several drivers for hardware that is found on Nexus 7 and Acer =
A500
> >> tablet devices. Please note that some drivers may require firmware fil=
es
> >> extracted from original Android image.
> >>
> >> Link: https://github.com/digetx/linux-firmware
> >
> > What's the license for these files?
>
> It's either GPL (like touchscreen config) or something else
> redistributeable.
>
> > Can they be made available through the official linux-firmware reposito=
ry?
>
> Yes, but I don't know yet for sure whether it's really needed for all
> firmware files.
>
> For example, the T30 Broadcom WiFi doesn't work using stock
> linux-firmware, it's on my to-do list to try to figure out why.

I've encountered the same issue on the Ouya, only the original
firmware that came with it will work with the chip. (AW-NH660)
I wonder if it's an azurewave quirk.

I've also noticed the Ouya specific configuration txt file seems a lot
more involved than the standard brcm configs.

>
> While Bluetooth FW seems to be reusable be many different devices,
> although (AFAIK) nobody cared to upstream it to the linux-firmware.
