Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D13DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7912080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598553641;
	bh=3rVr7CGpP71DL96a9V+Xr1Qn6CW2RhK3XaE9+rIDBts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F/hnRmjr2zmbiB7LljUIf6w7lb+/a8+u13etoP48gpvVVQEQVEdGb/s6J1/6Uc7iS
	 Yt5p0jTkAIgObuhw4ub8b2BmsB/Z9DJPbkk1vNM6Y4SM/apnz9PbSn2dCQLID7tWzQ
	 ygpeBro/quABJcRYy3qsxaaIdRjJ6X0dVY7A/pV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgH0Ski (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgH0Ski (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:40:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960B0C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:40:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so7606292ljn.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3Vd6g98KhVU6Iqw4vSL8bglGybIxelOWt5FP/Sv7j4=;
        b=c5KMKyG6C7XEnhdxvESgyMYwmFezTimYCP0s3XadBQFgwZl9BYx8wM0CZwKfLEmj5Y
         EPdPKzf2xFbs3wsYbHXCFag04NDG6SXaKu3bMGVW7Rb1oXNSQUY0oVth6/mNM31LZ5Ks
         HKwLOkuzj60m09lJs5zfs8apSj9dwIjpQ+beE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3Vd6g98KhVU6Iqw4vSL8bglGybIxelOWt5FP/Sv7j4=;
        b=IwtOJQNp6OGhWDAoP+2numq27H3cf0Rjgy3iLtsdtukTslypOnyObUedhpPH3Wxs9y
         k85lYkx4IhKUzt/ipBEAAvs7pyIBazAZ9Gv0TpXHMultTD9HsHYQlxbG26HhigsYoRYf
         epnYiepYFBKbESJV6fF3Zhn2X6hXGWnM2BsoXUUdEu08eturv2ykHtpo8jv72WRAS7L/
         5+VQBgG/tfgxZIzjL0c+/k6bLaE+I/0lS8xJIJ+vtBHkMvJBUZwJvAX0Dua0tpsWgiB9
         gxMGqthjS47CcEDSSQ9ue3SOXHs701SkVjjvdu+hIdsYbh95z1VEcNC9UljfxJCY5WFy
         03Ug==
X-Gm-Message-State: AOAM532YgOlN4+OUMBDsIFnWoFufM8SI5iz+2EgagCAJgWt98DvcqKN/
        EX+vC9BLaciGyRpyXIDgc+wprD8JS88LLg==
X-Google-Smtp-Source: ABdhPJyHxLuCzId3wrJFIZVnJMoxz9tcRr3xsplxM7WRSFTIxHGgF/GgvXp3+LMMYOp7f8EpWdYr3g==
X-Received: by 2002:a05:651c:1b4:: with SMTP id c20mr9878928ljn.432.1598553635692;
        Thu, 27 Aug 2020 11:40:35 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id j1sm641044ljb.35.2020.08.27.11.40.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 11:40:34 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id m22so7575000ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:40:34 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr11144185ljp.312.1598553634230;
 Thu, 27 Aug 2020 11:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200827013636.149307-1-allen.lkml@gmail.com> <CAHk-=whiEUUrtnbgUH2xsD0+jNyoXudYJ4hGCA55MCjryaHGjw@mail.gmail.com>
 <1598553133.4237.8.camel@HansenPartnership.com>
In-Reply-To: <1598553133.4237.8.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 11:40:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8o+FvfQkUiH_2MUs3J19FzfMzumOViAJ2aboGg9qY7Q@mail.gmail.com>
Message-ID: <CAHk-=wi8o+FvfQkUiH_2MUs3J19FzfMzumOViAJ2aboGg9qY7Q@mail.gmail.com>
Subject: Re: [PATCH] linux/kernel.h: add container_from()
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Allen Pais <allen.lkml@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:32 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
>
> The tasklet rework people don't want to use container_of, which was our
> first suggestion, because it produces lines which are "too long".

WTF?

Next somebody will decide that our list handling macros don't match
their mood, and make up their own.

Guys, there's a real advantage to just following convention and not
confusing people with new made-up stuff that does the same thing just
using slightly different names and slightly different semantics.

So let the tasklet rework people work on their own little thing if
they can't play with the rest of the kernel.

We'll just ignore them.

              Linus
