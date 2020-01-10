Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2633BC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0472082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx4M913t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgAJMCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 07:02:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46442 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgAJMCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:02:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id n9so1028377pff.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 04:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVgrOdGz7Nd81kR9xhpmj5Xk2gjHvzEDC59L9KZddRQ=;
        b=Nx4M913t/A7WLGrNeq3nvxLSnxkHudGLac8kmN9Fjen0/xg3m9y0UDuRxUGEvWVL4z
         p0Ur4M4O6k2r7E1G1aG/q3R+d8YXhWDg/0gpo+OrW0IgafoERzh51hqK+JixXKNexu+O
         YXsFzEUVkYBbxdKnVEOdSD9y8q6hwCbpotRJ9A4GRvqC1/vgOS+r2TQAvWkK8K5i0sD6
         ISJh6p5HyrF0bY054+7Uz/smPUBVVeNgAOQeQzvrPOF3rzc07f14DjpczxzyFGyzAqnm
         eT9GpeqXhZar+/tngeNl3012Yj+YgF/yk3kc8t3Qgz1OzZpta/t9sGE5FGanAlDw3S2E
         U7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVgrOdGz7Nd81kR9xhpmj5Xk2gjHvzEDC59L9KZddRQ=;
        b=IpgQGXvWop86Nu1nfXNOi5c8K+6Ao+nVM+MYGDx72cmJ8jEGRekbn1bzTH5F/6TJJK
         8ShQtXBbT49dTEdkrQoGckyu+MBPmgpcI7C/8iKvnjfk45dVNaPgEk/IjcwYLro6HW9E
         8m6l30CVESgPmM6J0QiOxJQMp5IJFnK5mRE9HuOdPUjw7UYRdLcq8HB/u7Wzio8U7aS0
         2Y6KGiexNryctk1DbR+sitIC0dnSGMJU90BrTi127voRPI6hah9PQJh3rqTJ2hP7q77V
         SHcxnxSubG5TojWpQlISGgFBny4KdWUB/3f4EhUpymWA+BaCga9mdJYm4xRlM05VSZ6e
         XyXQ==
X-Gm-Message-State: APjAAAXhq7Kl4DsDBQ0BXEJxHzKuaw+OZyZrqT9msQEe+2ehIhHLTwDn
        BHS3hw8bz+GPHyfs5RiWoxxn8RChe34j9MsPxOmLqIWXmn4=
X-Google-Smtp-Source: APXvYqwR2YER5AhQDNo1ARUnwIpngD2FGTpqLMkO7KpTjlJOW1pC7JyMUqdokOsYkIRwweUoxBEKzK2/e1T+IbuqwLw=
X-Received: by 2002:aa7:9474:: with SMTP id t20mr3569690pfq.241.1578657765822;
 Fri, 10 Jan 2020 04:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20200110101510.87311-1-andriy.shevchenko@linux.intel.com> <CAK8P3a1ruyzoMb18yNWdEn20sv+Sum4FW0AYqmD-SfyR28OygA@mail.gmail.com>
In-Reply-To: <CAK8P3a1ruyzoMb18yNWdEn20sv+Sum4FW0AYqmD-SfyR28OygA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jan 2020 14:02:37 +0200
Message-ID: <CAHp75VcR5xWjzNQQz7_gGc-fJg8AUpe4ZpBrKffz5vFo1YByaQ@mail.gmail.com>
Subject: Re: [PATCH v1] mfd: syscon: Switch to use devm_ioremap_resource()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 12:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jan 10, 2020 at 11:15 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Instead of checking resource pointer for being NULL and
> > report some not very standard error codes in this case,
> > switch to devm_ioremap_resource() API.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> With syscon, I'm worried there are users that map the same region in another
> driver, so doing devm_ioremap_resource() here will make another driver fail.
>
> Maybe just change the error code and add a comment warning about that
> instead?

Oh, yes, you are right.

Thanks for review.

-- 
With Best Regards,
Andy Shevchenko
