Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31728C33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 02:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091672084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 02:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyYkFlQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgANCNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 21:13:05 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42909 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgANCNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 21:13:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id s64so5624399pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 18:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zUSom5y/SpzD4gpSNkPj43/HDsOCuEZmG337PZbQYo8=;
        b=cyYkFlQZok93LSehSRlnGBzLEkIUdGUnVOT/p74e4fpEWiw8zHElU9fJYZ9Wne7d00
         /OdxwVagUz7ZshYpxrEv+HqLxweEPH9giSHzK4Pp3kXrJvWFt6nYb7U45yu0uwsqf2Ot
         8RBkAWXb5+ttdVKyDPy06bgU9MrkZe4RaGdeqAoNaR0BM+DUG6yJNQrqpP4GRu5/nSmi
         LFp0lBPL4OdIgASUy/yeCMcBDrUnL9xQswb2qhRBoBLemYGqu0RaWp1deB9CUlk66o4w
         bvLc3QlmQvsUMEtLQOtn9I0RJooADxrvrdgaSQP5j135CBGOPc8S4trhEF2qL5YuSIke
         Uwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUSom5y/SpzD4gpSNkPj43/HDsOCuEZmG337PZbQYo8=;
        b=NNIjRgxLdSv0vN0ocVZPIJl7It03d8O7TIoyxvoQx95DaVoFs1jV/t2DI9j4yWa8am
         oLyyM4sYW6bj2tAl/gc6MkKXE16YTgJV/Je5HMcgcToWwqauVb5vGInrR88Yy0TxrTx7
         pDilTIzZTuW8CDe3N70tr3HI5T9a1zDrRAPqtFPm02AUWrS+IuNRobG5ynmxJ7uBAd4+
         UgTZjsPEGuU+RdsqS2Q3b+TEp/c7LaYHg2GUT3x2x8we3F3lZ0YWcSHHCJFYcI8HwBo9
         4DMjfvu5woCFYlv5Qrdu3HsBe37Eog3HsTNRv0Jk7pF3oAEIIKwtlViJ+iBBnqmuBPjF
         PrpQ==
X-Gm-Message-State: APjAAAX/pWsCtfaUnu6cCl/lSovxYCBoH5Y0Vz98F4vUDHLu+DMgVadV
        jBjn7MkAGrUugd1VWeFLW+WQsNRSsL91waUbNVmGhA==
X-Google-Smtp-Source: APXvYqypfv58ylivqJTBVztzlhGfVdZJlsG0+KSfHsblqefMkp7awRb1viY3OVtvK9nvgYSsFwKTHuYSrXt1YG/dSGE=
X-Received: by 2002:aa7:93ce:: with SMTP id y14mr22918972pff.185.1578967983633;
 Mon, 13 Jan 2020 18:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20200110134337.1752000-1-arnd@arndb.de>
In-Reply-To: <20200110134337.1752000-1-arnd@arndb.de>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 13 Jan 2020 18:12:52 -0800
Message-ID: <CAFd5g47+_oyqsS0o0kQ+CaLNtjqbvOmQc-n0Ch1jAT6P6RSFiw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] kunit: move binary assertion out of line
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 5:43 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> In combination with the structleak gcc plugin, kunit can lead to excessive
> stack usage when each assertion adds another structure to the stack from
> of the calling function:
>
> base/test/property-entry-test.c:99:1: error: the frame size of 3032 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>
> As most assertions are binary, change those over to a direct function
> call that does not have this problem.  This can probably be improved
> further, I just went for a straightforward conversion, but a function
> call with 12 fixed arguments plus varargs it not great either.

Yeah, I am not exactly excited by maintaining such a set of functions.

I don't think anyone wants to go with the heap allocation route.

Along the lines of the union/single copy idea[1]. What if we just put
a union of all the assertion types in the kunit struct? One is already
allocated for every test case and we only need one assertion object
for each test case at a time, so I imagine that sould work.

I will start messing around with the idea. Still, it sounds like we
are down to either reducing the number of instances of this struct
that get created per test case, or we need to remove it entirely (as
you have done here).

Cheers
