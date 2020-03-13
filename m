Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105B4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0EC206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UULHVhHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgCMOrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:47:40 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36479 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgCMOrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:47:40 -0400
Received: by mail-il1-f196.google.com with SMTP id h3so9166058ils.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ro1R5ehcYhRf1s0gupnhw5Q+nbHwvID0ows7ral5AwA=;
        b=UULHVhHoV9B8wA8pT06k5F7CEKhKPJTemEriB5P4jsfUl+0MFuocFV+cKfEBUwJOZR
         44SDm19Y7MNYFx7IBYDxU1eeSaW08Y1QdU5wPqJ476lvQgn0/8iH8LZarWTvyzQ8f8Pq
         /yfiAazoYMLLCZA+WD2VvC0CB+j3dinbmK52mQS15VrJHiRU+hrdzgsvFqZQERc3wsoQ
         g+ZBlhE9WbwRtM/eaNTiBOiVTrV5D3Y6m0xAntdjTsJR7LHKx3cw/ImN5JlKvRE2sZTY
         CaoeXluOwsKMbIdEpQHSRSCk8Y3XWPOtb/vcDpCSafXtfOW3R/wFvDbweG9ep+FTXkfs
         6jCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ro1R5ehcYhRf1s0gupnhw5Q+nbHwvID0ows7ral5AwA=;
        b=tKqLShk3TTeXMEsyrFFcSd12F1e+Ic3exe1KBb9GCrffy0z3zZV9tVzysClZbiW1UF
         LfFkcx9Ukasj96SJV4fCHN76xbFHDTYf4WePrfma95jAf/YKsPEaNu8sW481mVF8nOQx
         Z4JZYLcWcOSZybmNISMc+mM91p4OC+T12es3MRxFbf/bboAPTntHqB1Qe8yikI0PnhIW
         9ZDNtVOCxW9DQvGNmb7bCwJF5A6RtHVmshlSzvO9VDRh+j/BRP0OvMphUhZG0AotA3vM
         2VICkswkZXz/vGJO0DmsZcIvG99mtvLFklEiZE7ZPHF8BbbtAFE/OQqPrEUkz1Q4J/TQ
         9LlA==
X-Gm-Message-State: ANhLgQ23dMWpZsgpi/njMm2sTsxexaAm38+qr2ptQ9uRwF9ITn7FfkrB
        gdXKS/ERSP0EcSsBu6cmLuZ/f/WFvUHLz5L6DseoOg==
X-Google-Smtp-Source: ADFU+vsUQdVDGeuArwH8++3efQ8y7YMk8cNafYrhvyIqxS2kFexBfegk6QvD0SkMs57BFtt65r+sa+KzO6NudDFAdpc=
X-Received: by 2002:a92:d191:: with SMTP id z17mr14076733ilz.287.1584110859057;
 Fri, 13 Mar 2020 07:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200224094158.28761-1-brgl@bgdev.pl> <20200224094158.28761-3-brgl@bgdev.pl>
 <CACRpkdZSooH+mXbimgT-hnaC2gO1nTi+rY7UmUhVg9bk1j+Eow@mail.gmail.com>
In-Reply-To: <CACRpkdZSooH+mXbimgT-hnaC2gO1nTi+rY7UmUhVg9bk1j+Eow@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 13 Mar 2020 15:47:28 +0100
Message-ID: <CAMRc=Mf2Mx+rB7du8D66WP=Js0wuK8x44aT9H2q6JhLJvrOcVQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpiolib: use kref in gpio_desc
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 12 mar 2020 o 11:35 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> Hi Bartosz,
>
> I'm struggling to figure out if this is the right way to count
> references for gpio descriptors.
>
> I cleared up the situation of why we don't want to add kref
> to gpio_chip in the previous message: I think we got that covered.
> (If I'm not wrong about it, and I am frequently wrong.)
>
> This mail is about contrasting the suggested gpio_desc
> kref with the existing managed resources, i.e. the
> devm_* mechanisms.
>
> devm_* macros are elusive because they do not use
> reference counting at all.
>
> Instead they put every devm_* requested resource with
> a destruction function on a list associated with the struct
> device. Functions get put on that list when we probe a
> device driver, and the list is iterated and all release functions
> are called when we exit .probe() with error or after calling the
> optional .remove() function on the module. (More or less.)
>
> This means anything devm_* managed lives and dies
> with the device driver attaching to the device.
> Documentation/driver-api/driver-model/devres.rst
>
> If the intention of the patch is that this action is associated
> with the detachment of the driver, then we are reinventing
> the wheel we already invented.
>

In this case I was thinking about a situation where we pass a
requested descriptor to some other framework (nvmem in this case)
which internally doesn't know anything about who manages this resource
externally. Now we can of course simply not do anything about it and
expect the user (who passed us the descriptor) to handle the resources
correctly. But what happens if the user releases the descriptor not on
driver detach but somewhere else for whatever reason while nvmem
doesn't know about it? It may try to use the descriptor which will now
be invalid. Reference counting in this case would help IMHO.

Bart

> E.g. to devm_* it doesn't really matter if someone else is
> using a struct gpio_desc, or not, but if the current driver
> is using it, it will be kept around until that driver detaches.
> No reference counting needed for that.
>
> So is this related to your problem or do I just get things
> wrong?
