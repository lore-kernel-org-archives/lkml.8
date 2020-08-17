Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFD7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0FEC2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgHQNVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:21:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33975 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgHQNV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:21:28 -0400
Received: by mail-oi1-f194.google.com with SMTP id z22so14771788oid.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 06:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Kc3WTUpOwNkmQ3vO1d9YQM+sAy36NgWXJVc8/GCvo0=;
        b=eQa26YK8zm+suH9fLj6IJVPkAx7/N1XqQUhpMya57SbfvRB60rrRA+gJ4qRGRAsXpy
         Z/BHDt8VXfdx+0X1KEWHYqWSUnORVJrX6VoE0b/p86TdCUIXAO6wQ9u5e9WrG/X9xiJ8
         cTOlVhxkqJ4O3MKps0YQpqbAD3vbltxstoK8K+O93X+co+j8pxagxg0hSlbgvF9D+Sdn
         VkYStjz4WCDV7j2V+S/yTuKgE9Y860BEoXQG00KG0xezj89K1ZW75gzB3rmshh5zkoBe
         T/YjBlhvK+N+FlxcZvOo9yz9sJEb8GDiUUWNPf+7ZKcjKIitXiSmJ4w0Vj1QK2Cz0D4K
         Qbxw==
X-Gm-Message-State: AOAM531d2cD0Q8jq9BEr9PvgMEO1q1nuKll/r3NSAX/BCbtMYXpzT9W0
        NF+EBZ/RKBWiwQdMfxQZZeFPx0n8Ao4uajDxA2ODngsIY8o=
X-Google-Smtp-Source: ABdhPJzItNUIHsOHtQm0H1dNHrsGUloh2lbcfGxKniDyRwtjNJUiQ6I4x9yNJC3XaRbZLGs5NYZ4qE8ARv6PvNWeH+0=
X-Received: by 2002:aca:adc4:: with SMTP id w187mr8982386oie.153.1597670487791;
 Mon, 17 Aug 2020 06:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200817131209.20027-1-geert@linux-m68k.org>
In-Reply-To: <20200817131209.20027-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Aug 2020 15:21:16 +0200
Message-ID: <CAMuHMdVT470w9j7rsj1L22zRq=+_XZ01Kw7hzBUmm9omHrMFBw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.9-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 3:18 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.9-rc1[1] compared to v5.8[2].
>
> Summarized:
>   - build errors: +1/-12
>   - build warnings: +68/-124
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9123e3a74ec7b934a4a099e98af6a61c2f80bbf5/ (all 192 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bcf876870b95592b52519ed4aafcf9d95999bc9c/ (all 192 configs)
>
>
> *** ERRORS ***
>
> 1 error regressions:
>   + error: modpost: "fw_arg3" [drivers/mtd/parsers/bcm63xxpart.ko] undefined!:  => N/A

mips-allmodconfig (reported against next 3 weeks ago)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
