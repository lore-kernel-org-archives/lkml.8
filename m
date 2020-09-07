Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220B6C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D782F21473
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SKDKiay1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgIGKyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbgIGKyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:54:08 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137E8C061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:54:02 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id m1so12107622ilj.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9or7F3N4uGJ5u794zyeeQfJsXAWR+DFA8Gx8lvKsws=;
        b=SKDKiay1D03pgiV+UpJzmTyefaJ/beR1td+hpIw98akjdM8VTUCwuMVeLlb3osZuE9
         /KX4TukEYGI1vwQo8XNn0elPXGJ/94SDE7VmsuDbdAeXPNF3Tr21rzW8zr8TqLTlTyYE
         1dLxcfZcjsxI15aCI4Bwujp8aEg7SyTQlu/1Xvz9KT5p1Roko10bQo9WqMrLhKId6ZUG
         FHXGNWLYNCX+8Pnw/3+wyi60zjyrVtjbyqfaUxlJn8FQFVZoLyaV6pWJb9wRwJ88PnnS
         2no0sLak8d1PFbnic9JnssKk8fw3Qyp486n1lAo5X7xgmIkEPmiHVQNl6UdfGL4qDc5+
         +BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9or7F3N4uGJ5u794zyeeQfJsXAWR+DFA8Gx8lvKsws=;
        b=lTurbFt2ADlueICDrDX+oxcDMjc5MESqEbSE8nj5LEpP5pzzVB1r9cZNDur6y0vQJ7
         25XOlk7zzTcgsYGAaLPLz1N5+DPltMXB8Do3u3nG6CBhQwWI4EdmVSfqE92MOH4CiWZU
         GPmMu11DlaRz/4Sc5jb0DA9iJ7ulHa+0nLz30G/E78apPt9pDYW27XAqG5qC5pgTupJK
         wFtiLzi2qvFCYJa5J5yb46AIyTC6KCBL854j9FAXO7nvuYsjHOEo6uvksrJ7g3F7S5A3
         ZQo22Dzjq2s5Rh1zS81XWLTboTlkO9/ndvBf1K+XimkQn6ghnPlQiy89ejiaoRffwiL9
         QG3w==
X-Gm-Message-State: AOAM533mWaPpCFlCERxwo8bDKZBPK3vtcWwfk4BnTie/VsSlV+zc2Dia
        VLHAKmEaCFy6IMnQgmKz2hEStVkvGbFfLD5E2k9c0Q==
X-Google-Smtp-Source: ABdhPJxBpaWjVX3fkFg/bcWAsiU5ccj4QQBFPEMsNaOmvDrtar3fGAFBHYqxEdQBwc585SSw+vfckGQqg3PvOdHAs0M=
X-Received: by 2002:a92:1b0b:: with SMTP id b11mr18780714ilb.287.1599476041805;
 Mon, 07 Sep 2020 03:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-6-brgl@bgdev.pl>
 <20200904164015.GY1891694@smile.fi.intel.com>
In-Reply-To: <20200904164015.GY1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Sep 2020 12:53:51 +0200
Message-ID: <CAMRc=MdprNhsRZm=kxkEHFbpftwgMB0a-SR4HjLgiG0tjfWM=Q@mail.gmail.com>
Subject: Re: [PATCH 05/23] gpiolib: unexport devprop_gpiochip_set_names()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 6:42 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 04, 2020 at 05:45:29PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Now that devprop_gpiochip_set_names() is only used in a single place
> > inside drivers/gpio/gpiolib.c, there's no need anymore for it to be
> > exported or to even live in its own source file. Pull this function into
> > the core source file for gpiolib.
>
> I have mixed feelings about this. We may simply unexport and attach object file
> to gpiolib.o. Would it be expected to see more functions in this file in the
> future?
>

This file was created for this function alone over 4 years ago and
never saw any new routines. Personally I think there's no reason to
keep a single helper in its own file. We usually only split big chunks
of code out of gpiolib.c.

Bart
