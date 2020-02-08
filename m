Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A12C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 08:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F4521741
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 08:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G7nrdJE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBHIpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 03:45:44 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34913 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgBHIpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 03:45:44 -0500
Received: by mail-ot1-f67.google.com with SMTP id r16so1681253otd.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 00:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZha96z8rVZYcs0zGmqsrfRmZlzEIuB6POHU7WyI7S4=;
        b=G7nrdJE6FtBvLr6+YX8u9gLnfBDZl43Dw4UCC2yoCEXsnNq8jSpiIqXXSkhaZfI80O
         NN3Vk5npf5exsHXERGjNkdbJhIFkBPB+12fNE1aQECI83CDM75dJz87HvOxCuM9hKaUp
         7jFyxpZP5N8hbOAWV151nuuLtXUBIiTSxljT8qOHRMgi/1V5hMpd0rYt6RTKIKNMsxUq
         QMaDhRnqzf7VGYk/W+OxtcB6Lqtz+Wgw0MCtMudLDejPaCO3oujwU8QarjWGeC22lLTu
         cdj93ZhhMS5mG4o6e8DS4DYkeiDRoDDmMj+GM0CIpM6l7Up4pnOSyLe+k2WcThOehYqe
         HOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZha96z8rVZYcs0zGmqsrfRmZlzEIuB6POHU7WyI7S4=;
        b=QGlpUlpthNqDjLMJqfJpsQPqwFPmduOjMvtcKxfB8zrcLfe3nBcQDMC90Iblpn8Iyq
         i4/ZekX9XNtDvIGT63lHRViapAdjU+cciPbjw7fkUturqyGtbSFzHQ9BlZj2mEYiLvB6
         kGpesyTUG+ixgpH/ZP198Zd3qxWt/rMxi6LDae0I72UuQ62ix5kxZERRhbZVMawn7We+
         8w+OIYj+jazQISoq5RsBPWnHVwx/VMn0jyobUKH7mGEfS/BfDeXAHU4M1MUfEw9ld9aj
         qkN51QP+0r10b7kxJJYsDKrwB7IOJBE+7+sXghT+i1bbhmezfQib7RGJ+5j3RHTgm0Ci
         nntA==
X-Gm-Message-State: APjAAAXe7Zdh12MINIZfqTE/jYsNbj4FiV+hwg6Tybkuk7LYcoXuQ1Yc
        9PgWxZH9ncHLCyNWcrPP02WO87o259m2dyYhU4xM3FCf
X-Google-Smtp-Source: APXvYqwKhYsYYhRzCKcD5JvleEI6T6o2CrjigAudHhTKmYDvSJzrDB4PTtY5fdJjWkvcwOSqzTKAacQKWSfYZ7D69wk=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr2785149otq.75.1581151541959;
 Sat, 08 Feb 2020 00:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20200207095245.21955-1-zong.li@sifive.com> <20200207095245.21955-3-zong.li@sifive.com>
 <fdcfd8548707e2d6c61fc9739bc91c6720673c81.camel@perches.com>
In-Reply-To: <fdcfd8548707e2d6c61fc9739bc91c6720673c81.camel@perches.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Sat, 8 Feb 2020 16:45:31 +0800
Message-ID: <CANXhq0qL6oSsHOr+eFOYhBSAXPP5k=k0mwxEdHMGfUV9CSBHkA@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: adjust the indent
To:     Joe Perches <joe@perches.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 7, 2020 at 6:59 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-02-07 at 17:52 +0800, Zong Li wrote:
> > Adjust the indent to match Linux coding style.
>
> trivia:
>
> > diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> []
> > @@ -86,7 +89,8 @@ void __init kasan_init(void)
> >       unsigned long i;
> >
> >       kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
> > -                     (void *)kasan_mem_to_shadow((void *)VMALLOC_END));
> > +                                 (void *)kasan_mem_to_shadow((void *)
> > +                                                             VMALLOC_END));
>
> could also remove an unnecessary (void *) as kasan_mem_to_shadow
> returns a void *
>
>         kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
>                                     kasan_mem_to_shadow((void *)VMALLOC_END));
>

OK, I'll remove it in next version. Thanks.
