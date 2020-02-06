Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE7FC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A46E21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgBFIHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:07:06 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43558 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBFIHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:07:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so4631757oth.10;
        Thu, 06 Feb 2020 00:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Id5Si7PsBgV/5UriLIHb4WyiAl4QS9Vzrwa0lTz3goQ=;
        b=XGAyRUng8Sg/sDTF1w/zOpUHtHRzfOCkHSVl6e6rGri8HmFYsKHhag+27Z542BnGha
         AFMe3rwN82B7L+vhfl+D0CsHfprN5qAZNFjAJsrm33a/4+5OsABsG2M2DgmDZl5ISDM0
         4cu7NgwDzWj38wSKqqTg6u+r7e5PSgCsErTiVXeCS6usIYP4KahLAj9kbqvjvU6ZYc7B
         MF9BU52IZiXgkpyC5EL53agZ9cB+wsBHy9DAFGaUFzLSBeLnKP1ucvAlKUPfkT6/nLaJ
         /SogXVQwX0kH2T0y3YJCE1Y6YKGE9Qjyf+gUDr1tkM7QLvoCIHWxAmQMX7rV4DtCGIQO
         /Yew==
X-Gm-Message-State: APjAAAW2cbFBw8Twvn9Qw7ObXOu+UjpScoHiGJjBWLClj0DAVoGslJDc
        +RsAIpptSH1QfP2q0aBekRT2lGhRSmxdSO0hTTQ=
X-Google-Smtp-Source: APXvYqyIaRpVcqlLoNT5REckbKTlfq6ceFveBrFPUMguk47N5cYuEDtZ/dv9fpMrmyvj/GC1jCTFTEfS5c3t7GXjfU4=
X-Received: by 2002:a9d:7602:: with SMTP id k2mr385248otl.39.1580976425083;
 Thu, 06 Feb 2020 00:07:05 -0800 (PST)
MIME-Version: 1.0
References: <20200205194649.31309-1-geert+renesas@glider.be> <20200205225145.5486220730@mail.kernel.org>
In-Reply-To: <20200205225145.5486220730@mail.kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Feb 2020 09:06:53 +0100
Message-ID: <CAMuHMdXLFq+Ebtmfsw45=08U7X5Fv9ZvsHO=q-PcNON51HjqaQ@mail.gmail.com>
Subject: Re: [PATCH] of: clk: Make <linux/of_clk.h> self-contained
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Feb 5, 2020 at 11:51 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Geert Uytterhoeven (2020-02-05 11:46:49)
> > Depending on include order:
> >
> >     include/linux/of_clk.h:11:45: warning: \u2018struct device_node\u2019 declared inside parameter list will not be visible outside of this definition or declaration
> >      unsigned int of_clk_get_parent_count(struct device_node *np);
> >                                                  ^~~~~~~~~~~
> >     include/linux/of_clk.h:12:43: warning: \u2018struct device_node\u2019 declared inside parameter list will not be visible outside of this definition or declaration
> >      const char *of_clk_get_parent_name(struct device_node *np, int index);
> >                                                ^~~~~~~~~~~
> >     include/linux/of_clk.h:13:31: warning: \u2018struct of_device_id\u2019 declared inside parameter list will not be visible outside of this definition or declaration
> >      void of_clk_init(const struct of_device_id *matches);
> >                                    ^~~~~~~~~~~~
> >
> > Fix this by adding forward declarations for struct device_node and
> > struct of_device_id.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Noticed when cleaning up some platform code.
> > I am not aware of this being triggered in upstream, but this will become a
> > dependency for these cleanups.
>
> So apply for fixes? I'll just throw it in now.

Yep.

> Applied to clk-next.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
