Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E83C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178F020880
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pw5/utme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgAKKUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:20:13 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:38842 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbgAKKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:20:10 -0500
Received: by mail-il1-f196.google.com with SMTP id f5so3896948ilq.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 02:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pOSVA5uhmk+VM6N/EM2MNyLEc6cHeflZPvPBN7eAFd8=;
        b=pw5/utmeH7AJPk+rdLyGJXCipp5gbd77aEW91QiO9nVl1bIYk06x9dOeM6DkcadL58
         3thq1tEd7eV8Nk2Di5aj+lj3IqdBd0HlBKMDbHIe8LSE2THZsFPOc7IEKhJNKs1iQB4N
         fyMgl2nAWPPIS0iFJi4ZHtj0pbys3V90Rn3BAuWXdf8cNzpORabQQGVJfp7Mc7j+tAah
         zr0fG3AtvyOqUulcuzL8K6asfjfI3WdmIJ5cc58q+3TnUAFRkOQDijfaYNqKQPiAZ0Ku
         g9qLawUQMHBrppemekkJ7SH4Fc84ZEvwhuWQYTZIS0GOxqBZZ8ZSXyUgGvu1EyiB7ttE
         fOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pOSVA5uhmk+VM6N/EM2MNyLEc6cHeflZPvPBN7eAFd8=;
        b=bSGubFYm5YNPHCJWIejz02PetV2gRs0PP7Tj3WVF807IprgKULFiW0uw2xIzxti46l
         n9cGxMC2czMXAnCnMx03H9jYdYT7l8QB8bhfk6NJTVEvsIlesFVteX6l5zEEkrlxG1DT
         Sh5Jf6BVP6UaLcM+1Z11V8PczKN/yXUOd9mIQbOzMqfqcJsfWypx8R/gRV1UJf5G857S
         9tz9YJrDf8hFh6Pn+o6C+SCRk8Kod0d3dgyA1li4cwm/R1U1F3PG5I5GNpbrnOjpdBqA
         UNpJtWmTjNVQmjjN/tt8/rrd9yPkiLG2SBj2rFOWePsRovlC+9UGqseGrXp94LTAXSil
         CUlA==
X-Gm-Message-State: APjAAAXNmDyps7G+ubSaaCzTt401hOmelrmOTTlLRURAD55kUDm5FKt5
        p5Zd5Rw+ngk/0PtervMnGtnL7fmWTEOloiaZlib1wg==
X-Google-Smtp-Source: APXvYqysd4ztguN5R8BjDyEl38Q6mSx+PX/LFjJaUO4FAbZ+5rNBxo3P9IYXANJafr9f+JqMLd1b2jjfjMxinkK3Aco=
X-Received: by 2002:a92:8712:: with SMTP id m18mr6703847ild.40.1578738009666;
 Sat, 11 Jan 2020 02:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20200110171643.18578-1-brgl@bgdev.pl> <20200110171643.18578-2-brgl@bgdev.pl>
 <7be95251-7e26-6090-4770-6e4dbebfadd2@linaro.org>
In-Reply-To: <7be95251-7e26-6090-4770-6e4dbebfadd2@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 11 Jan 2020 11:19:58 +0100
Message-ID: <CAMRc=McesmYcJv7iqE3rLHFyeTJtnW4Gq1TjMjHGSkpcHNPahw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] clocksource: davinci: only enable clockevents once
 tim34 is initialized
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 10 sty 2020 o 18:56 Daniel Lezcano <daniel.lezcano@linaro.org> napisa=
=C5=82(a):
>
> On 10/01/2020 18:16, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The DM365 platform has a strange quirk (only present when using ancient
> > u-boot - mainline u-boot v2013.01 and later works fine) where if we
> > enable the second half of the timer in periodic mode before we do its
> > initialization - the time won't start flowing and we can't boot.
> >
> > When using more recent u-boot, we can enable the timer, then reinitiali=
ze
> > it and all works fine.
> >
> > To work around this issue only enable clockevents once tim34 is
> > initialized i.e. move clockevents_config_and_register() below tim34
> > initialization.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Shall I take it through my tree?
>

Not sure, I'd say Sekhar should take it through arm-soc together with
the latter two patches if he's ok with this. Let's wait for him to
respond.

Bart
