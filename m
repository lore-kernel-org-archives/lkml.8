Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B202AC4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2672467F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgB0JWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 04:22:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44125 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgB0JWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:22:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so2233702otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 01:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdGGXnyitOyAbCgzeOKpEqIhoQiSrSdOK/s6ZZpWJVw=;
        b=JQ/lUJEhQxp5Y7Fz79HDNIBRTdEkomxC+nRLCyU4gODnfCzejLFMmHdQk+pXM1zQ+D
         qRE0F9FcZzVwgD3g5kboMQEiW51rBZud/WI55+fvNNm2amaSJsKGrX1Ulnrjgq0sVCYX
         ocPgeEUI0yiLktrbYr45l70BRq6Dg0HPPmw2JR1mM8YrYslf+04w5faR5qYTT0LoX6lt
         1wYIDjrotP4tBpmMK9TKupI8GYETKxLAG/EhDrVlAT+85POerK5iCYUUCXOEWRTbFI1l
         gb5ibmIeSR2YMMfAPJJ2UTpx/j/e/xJV2ERHe2oUz+yplYieq2pqdsu0YrhRGHxqKpCd
         Cyaw==
X-Gm-Message-State: APjAAAUC2BqDMQhsVklKzQsVtwWJdPaL66ep5sQgo5IT3++kKC3b74Z0
        O0tUDhQ4kbpZbfF7eQ6HxG3T1bGjgjvUVvjRmmw=
X-Google-Smtp-Source: APXvYqw7x9GwUZiS/F0uGj84W+tKsD9kM1zeJvWdBsIi3MeQmnVzWKxNF8591ODHa6Vum/i4xElvQtrzLmbtvD7uL24=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr2440524otk.145.1582795333362;
 Thu, 27 Feb 2020 01:22:13 -0800 (PST)
MIME-Version: 1.0
References: <158220110257.26565.4812934676257459744.stgit@devnote2> <158220111291.26565.9036889083940367969.stgit@devnote2>
In-Reply-To: <158220111291.26565.9036889083940367969.stgit@devnote2>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Feb 2020 10:22:00 +0100
Message-ID: <CAMuHMdWEoBrFRhmLEByhDCasuMrbGS4PreRivYRApdsME7x2AA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] bootconfig: Set CONFIG_BOOT_CONFIG=n by default
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hiramatsu-san,

On Thu, Feb 20, 2020 at 1:18 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> Set CONFIG_BOOT_CONFIG=n by default. This also warns
> user if CONFIG_BOOT_CONFIG=n but "bootconfig" is given
> in the kernel command line.
>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks for your patch!

> --- a/init/main.c
> +++ b/init/main.c
> @@ -418,6 +418,14 @@ static void __init setup_boot_config(const char *cmdline)
>  }
>  #else
>  #define setup_boot_config(cmdline)     do { } while (0)
> +
> +static int __init warn_bootconfig(char *str)
> +{
> +       pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOTCONFIG is not set.\n");
> +       return 0;
> +}
> +early_param("bootconfig", warn_bootconfig);

Yeah, let's increases kernel size for the people who don't want to jump
on the bootconfig wagon :-(

Is this really needed?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
