Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A3DC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8702082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgBGI7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:59:49 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40185 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgBGI7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:59:49 -0500
Received: by mail-ot1-f68.google.com with SMTP id i6so1469729otr.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 00:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8EwzFJmRZOPnQjt0j+LlBU7xGSBsnFWbFlTfXumubw=;
        b=CPKKx0zGxUw71snly4dw4qAD6um2gXuyQZyc58IGlpvrNsb8dq2dXqL/8BhC7R8oOt
         R8wtT6rpROyPhp07Vp5lIXebdunfQg8HwnTZCQ/yacqNB0VZyQhT4omfNHuSuaW2sqAc
         Httq0zfvW1ntArAX4ZODb4SPl9I7lZelxQY0fejr4CjUUV2b3XLwHOr53NBSZ5UUcYU7
         L568a4UBv6i+8t7MoxqdT8dxE13w6r2L4yd9CYppV31/qAFPpOtQ3N6wGLlmaMshkbkw
         9/hGte3wFUn2DTkF87Lq4/iHDZSKbW9UrS5py7kXL4Rco34x9B1ycVR+eOfzgfsAaeZy
         tmPw==
X-Gm-Message-State: APjAAAUZpE01axWEiazclc89uAitODbbZFn/SvXMZgqceMpscxuyG+Ls
        IOBg2YdArbzMH/GrXxAEv5Nxjw7iG2pLycfWNM8=
X-Google-Smtp-Source: APXvYqy4CyeVFAe9ipMueMZlSSDD/xpy1lWCaiOKZ8jk0gNksAOiweC50FIUM34hdqtrIHPOXFPEjOZQ1TFdtDVbCRo=
X-Received: by 2002:a9d:8f1:: with SMTP id 104mr1775671otf.107.1581065988449;
 Fri, 07 Feb 2020 00:59:48 -0800 (PST)
MIME-Version: 1.0
References: <20200114210316.450821675@goodmis.org> <20200114210336.259202220@goodmis.org>
 <20200206115405.GA22608@zn.tnic> <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
 <20200206175858.GG9741@zn.tnic> <7280e507-cafd-f981-88b5-0e7d375e26d4@infradead.org>
 <20200206173945.0596d32a@oasis.local.home>
In-Reply-To: <20200206173945.0596d32a@oasis.local.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Feb 2020 09:59:27 +0100
Message-ID: <CAMuHMdUq0+fTz=HHB4J+N=mt8Kc+42EcC_zzK6M5ZUFKzKh4wg@mail.gmail.com>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config support
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Thu, Feb 6, 2020 at 11:40 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 6 Feb 2020 10:10:28 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> > old news: some Kconfig symbols are Special & Important.  ;)
>
> Well, to me its as important as the kernel command line itself, and
> printk(). I know printk() can be disabled, should that be default 'n'?
>
> What I really like about this, is that you can have custom kernel
> configs for each initrd. My fear is if this is default off, an initrd

s/configs/command lines/?

> that use to boot may no longer boot, because of a forgotten enabling of
> this.

I may be missing something here, but 12 KiB for extra command line support
sounds a bit excessive to me.
Currently the maximum value of COMMAND_LINE_SIZE is 4096, while many
architectures still use 256 or 512.
How much data do you want to pass?
What kind of configuration do you want to pass?
Is there some existing data structure you can use to hold this?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
