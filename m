Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7AAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70922071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkSJvyrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389142AbgEYIjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388283AbgEYIjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:39:54 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E58C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:39:54 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x27so10067265lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCc/31TsXpXT4jfAByxZrCog3XZ1wIYQwxxRVmqL+io=;
        b=EkSJvyrJNdbgTdByzIamnXu3Kss424auslcb1AMhzrBmA/Ve29aOU39ARSiFH6uFX4
         U/9JGV+7NwG36q4BUpOWf8lPe0/CJaThJ/JdcBkjk22ugEqgyGnPSPdP3RCMemX82+f8
         QS3Bk8+P39O5JMfdd1FWRJZ6TcHx0Y7nbCn9fZtTowTSSFEQry2OU3IztRdZVKoURpWD
         bBUeoegP+pshrWJC3W/0WXTcZYU0RifDHzgZtyxXYA0c22szU3YH1NI0EjxmsIjiPuHy
         SyEC+jBRTpWgCuAQkwziX6YrIGm8IKVBtFoQF1rn5YS01hlwpCH1UQ97bGygCjiRJJHC
         UNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCc/31TsXpXT4jfAByxZrCog3XZ1wIYQwxxRVmqL+io=;
        b=pDAIsUiiU96DRUhg9jjE5h5h2dg84cvc0cr5oGdH1PiirUazBc4Ky9RuPzJP1g/MTr
         4bL+nppjt9UPRYOEbhgDYaBXGjesaAb4FWktY2mUjbAduqGTTGzzAR/bNCdkwtRVHjNl
         J6YSnlTzn2G1SvnaCrgwJ6FusDDvYCOHwItIZWR+UlDqk+5hPEirl6/brFuIDfyKW0vN
         AK/PCbJjGXvo4nuNy65u4ed0/5je3KNBMcSBPd50qRDUhSr4NZCpih59wMk2A6dFydYb
         S1oDszf6yMX0rA1GNSjPpNmwf5v6SjFwKmjiUl39o0OoTM1keKNH7H1nBIXpioW0DoGi
         ZOvg==
X-Gm-Message-State: AOAM532JXTTvCIB388L6kvTFsFBqbyEoPBjoI06dhIGv2Z2t+DhYKM5f
        bb8jR+sK/JKAkVUw3k31iXSBJo8mKwzYo+FJYGB5WQ==
X-Google-Smtp-Source: ABdhPJzu5fwXlJgASpsOFrhTDexm+rndGYjPOC5hVimqa6e8hFxeWPyg659dPFics03YVqsHcnHHe39ptWFD24iyG2w=
X-Received: by 2002:a19:be87:: with SMTP id o129mr10313716lff.217.1590395992826;
 Mon, 25 May 2020 01:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200516064507.19058-1-warthog618@gmail.com>
In-Reply-To: <20200516064507.19058-1-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 10:39:42 +0200
Message-ID: <CACRpkdbputuoHFWL_FhUNR-ZywvJt=qYdaa+i2cLt-Odmgxe2w@mail.gmail.com>
Subject: Re: [RFC PATCH] gpio: uapi: v2 proposal
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 8:45 AM Kent Gibson <warthog618@gmail.com> wrote:

> Add a new version of the uAPI to address existing 32/64bit alignment
> issues, add support for debounce, and provide some future proofing by
> adding padding reserved for future use.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>

I don't see any major problems with it, just some comments:

+ * @padding: reserved for future use and should be zero filled

*MUST* be zerofilled is what it should say.

> +struct gpioline_config {
> +       __u8 default_values[GPIOLINES_MAX];

So 32 bytes

> +       __u32 flags;
> +       __u8 direction;
> +       __u8 drive;
> +       __u8 bias;
> +       __u8 edge_detection;

Some comment in the struc that this adds up to 32 bits?

> +       __u32 debounce;
> +       __u32 padding[7]; /* for future use */

What we need to do inside the kernel with all of these
is to ascertain that they are 0 for now when they are
sent in and refuse them otherwise, I think it was Lars-Peter
Clausen who said that they had to retire a whole slew of
ioctl()s because some userspace just used unallocated
memory for this and since that was random bytes it needed to
be supported with that content forever and the reserved
padding could never be used for the reserved purpose.

This kind of comment goes for all the structs.

But mostly it is a question about the kernel code receiving
or emitting these.

Yours,
Linus Walleij
