Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBF0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C10A207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389217AbgEYIqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:46:22 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:45056 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbgEYIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:46:22 -0400
Received: by mail-oo1-f65.google.com with SMTP id p123so3457108oop.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ubzZtv8ijyTCkjYnqGrhQi6vWDPzStF+JDYNjTjJn0I=;
        b=EfqRA/9/mGzVAa/Tk8VTKibH5CL6XWq3tO+Y9e8b3cTvF4bNsGNHABg78QVLSi6miT
         lAJFQgnTkytasahgRzNjY64tPrktH/KQHF97Al5GB/I+p3PxXvS45L0ISXwHX/WFkUNK
         GrUVbiYq+mG/tVK33OeNEZ0kd/8KjalncM98FKjWwkrQt8Ptd8Jsx627FOvXoFFNIM0o
         6plA9opr7AsQU/65x2/BkW6CYkmmS7cIEqxpHoJSXw3ymRUYB5pvZHBT+8r0kHr9jn+P
         lD6e1KwTNmaomTrk/taXVQ4DEV3me2T19af+GEZMz8TceKgbgymaBbZDoZq1ypibOOPA
         +MHQ==
X-Gm-Message-State: AOAM532N8Knl1DZOy8+Lyb7G3c6uSui+f3nu/5DUYzgtCp7d48Dy3N/R
        8Yu2M5vgYMDFJGmYtmrQ3G8Jf0oZEJ3GtLtAC819Eh4I
X-Google-Smtp-Source: ABdhPJwfjprgjzv7kU2ov1BX7oUvTVQiDv6t4ZKPgak3qtmm/RWZs7QsAW2ZbhEUquXsngwLU6GQFZJOi3PiZBjoXUI=
X-Received: by 2002:a4a:e295:: with SMTP id k21mr12605732oot.11.1590396381231;
 Mon, 25 May 2020 01:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <bfbb71db52c5e162d3afa25a28fc5d535ca87138.1589949122.git.fthain@telegraphics.com.au>
In-Reply-To: <bfbb71db52c5e162d3afa25a28fc5d535ca87138.1589949122.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 May 2020 10:46:10 +0200
Message-ID: <CAMuHMdWSxz98B4HcBPbGj5e3TQx+ndUCLPeNg7ggdvpTzOA54A@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Avoid stuck ISM IOP interrupt on Quadra 900/950
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 6:41 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On a Quadra 900/950, the ISM IOP IRQ output pin is connected to an
> edge-triggered input on VIA2. It is theoretically possible that this
> signal could fail to produce the expected VIA2 interrupt.
>
> The two IOP interrupt flags can be asserted in any order but the logic
> in iop_ism_irq() does not allow for that. In particular, INT0 can be
> asserted right after INT0 is checked and before INT1 is cleared.
>
> Such an interrupt would produce no new edge and VIA2 would detect no
> further interrupts from the IOP. Avoid this by looping over the INT0/1
> handlers so an edge can be produced.
>
> Cc: Joshua Thompson <funaho@jurai.org>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.8 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
