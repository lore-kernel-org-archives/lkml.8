Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479BBC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 00:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2053C20757
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 00:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kV/LeCGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgDLAdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 20:33:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37801 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgDLAdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 20:33:51 -0400
Received: by mail-lf1-f66.google.com with SMTP id t11so3952452lfe.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 17:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zsyaQJSTyWtQU6SNb3d/B5KGEXk22uVClxXXTgsbd6E=;
        b=kV/LeCGT51tDEQA6jixYwmFJMhwu+sfWPjZdgnLCFvMfPYUoeMciBwTxKz8slhIA9Q
         QWA2SQ0DoEF4KcBJ2ugrGlY6oybNlOP3mTjUj02Wr0RrkcNl2xtc81cOXyImM4uRmfCh
         qHFe6s3jbXCLQZHpY1gfAD4pb0z7WUFQaZtVlYfD3husYMs4QPBsa7IqM7dVgNiBcm0j
         l+CqzwLgWhQyQ6lYBMOXmRaHGTqL3jxOCcQSriocgol9p2VvpZTL7/pWWZWy4UhhPTI8
         w07GlQOHtAFmejubyEhftiSAWmxQa3xOjY0uZlHCLUd6DBp11BdB5BddyZZUhdfxf268
         Yyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zsyaQJSTyWtQU6SNb3d/B5KGEXk22uVClxXXTgsbd6E=;
        b=D2AshuO+g+G5mT9pjJg6U1A69PWQ4S1Ldk6vzDYUIIpjV8HNJAFpo6+wI6zHzi0Fxo
         HUh9yCQxt4+1/heQSO6aRBWq2nMlQemgyV9BjXNaVv/zy6yEFXQ2wsX9JbFoKW4kecaU
         QoNqhhcXRad8u2cMIlV8TsITqcnm1MyCNHYcAAZSlTYWTjamiXl29CEc8jDjLTWyEC63
         iFJkGeyyEnwR1pLl2TrTRtYEAa8bHo9yiXDUZZ++3QtkK9nPh6e2RgPy++8GiIghO0aB
         USe0Uky+1h1OK62mzbxeHafO3EA1TRGSV+ilN0ZhzQsg1g7XApkBuLoOK/JhkWJEVtGQ
         8Puw==
X-Gm-Message-State: AGi0PuZreMS2hJiIQdOQLFVs1SreqqJUodvnOaWLeuG2CfFKwoeMWGeu
        vdOYr8zfuxxihs+7t75UlHDPBQt89VwVwzZE1qkGmQ==
X-Google-Smtp-Source: APiQypL4dP3s3w7dYreIWE/U9Pw7ftEq+ZzcH56ILtKHt9LXITsoPKEt+dyrtZrmqSv0ag9Tqx6r+iOrde8l3AYonrY=
X-Received: by 2002:a19:48c3:: with SMTP id v186mr6282470lfa.194.1586651629741;
 Sat, 11 Apr 2020 17:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200117224839.23531-1-f.fainelli@gmail.com> <20200117224839.23531-8-f.fainelli@gmail.com>
 <CAKv+Gu_6wWhi418=GpMjfMpE2E+XHbL-DYKT8MJ1jE3+VybrAg@mail.gmail.com>
In-Reply-To: <CAKv+Gu_6wWhi418=GpMjfMpE2E+XHbL-DYKT8MJ1jE3+VybrAg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 12 Apr 2020 02:33:38 +0200
Message-ID: <CACRpkdbR2VG422X0-nhOeWtS3Mhm7M1+RKMozBZbg0Jv5c_TTQ@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] ARM: Enable KASan for ARM
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Andrey Ryabinin <ryabinin@virtuozzo.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Landley <rob@landley.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Garnier <thgarnie@google.com>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Philip Derrin <philip@cog.systems>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 12:45 PM Ard Biesheuvel <ardb@kernel.org> wrote:

> > +CFLAGS_KERNEL          += -D__SANITIZE_ADDRESS__
(...)
> > -                                  $(call cc-option,-mno-single-pic-base)
> > +                                  $(call cc-option,-mno-single-pic-base) \
> > +                                  -D__SANITIZE_ADDRESS__
>
> I am not too crazy about this need to unconditionally 'enable' KASAN
> on the command line like this, in order to be able to disable it again
> when CONFIG_KASAN=y.
>
> Could we instead add something like this at the top of
> arch/arm/boot/compressed/string.c?
>
> #ifdef CONFIG_KASAN
> #undef memcpy
> #undef memmove
> #undef memset
> void *__memcpy(void *__dest, __const void *__src, size_t __n) __alias(memcpy);
> void *__memmove(void *__dest, __const void *__src, size_t count)
> __alias(memmove);
> void *__memset(void *s, int c, size_t count) __alias(memset);
> #endif

I obviously missed this before I sent out my new version of the series.
It bothers me too.

I will try this approach when I prepare the next iteration.

Thanks a lot!

Yours,
Linus Walleij
