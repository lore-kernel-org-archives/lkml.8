Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73292C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EAC24654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgBTIRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:17:08 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36935 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgBTIRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:17:08 -0500
Received: by mail-ot1-f67.google.com with SMTP id b3so1669779otp.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 00:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sD2J/5uum42C2xZRjOEEGhvwf/LUtVUFDgCu9pCttwo=;
        b=E/bhVv/IQYElaYIlz2E3abNKPvoHYfgYg6qW0WxNyf5gKNa8uG2dFF+wOXY9qGIEc9
         k0xV+UefNUIGs0LaYzrRaGO0zkwnlDx26Gg43GLDh+Oi9wUS1JFGvT6n869N+8aHd5Ex
         ntJO+sDIrBuUORAwrC7KFLKTGdxFLz3w9wJcYtvkBwkm9rAp3Toa7WdtoMlI8yv8OSpF
         wSFryv6wjGNIgdtjsyZ7J5Mp4/QwuDW7p6s4qEywKIvhkJAII72HGjl8PLDxPTT3Rx1c
         XR8bohZ+cY7QT3T7VHynJTqP09r5b7/nx8n9cHg9P3Q/ATFGUCl7OtJzF7xtgrkzAB4/
         9S5w==
X-Gm-Message-State: APjAAAVvu0v87vXCXTzWj3Seqdj2uu3ylBHBlexyri2+T95sxGhqWV0Q
        pebVoWvdSeqWLQSHg1PY+pkQCkJ6ULqh/J26hiE=
X-Google-Smtp-Source: APXvYqwItDQQVwf7oA5GRL9lws1n+HFJcGAVqsbPVF//RiENrTsIKFqFA6VEWAG6qqdVc8WTfok+ws2CoKk3IGufgI4=
X-Received: by 2002:a9d:7602:: with SMTP id k2mr22857306otl.39.1582186627028;
 Thu, 20 Feb 2020 00:17:07 -0800 (PST)
MIME-Version: 1.0
References: <158218358363.6940.18380270211351882136.stgit@devnote2> <158218359349.6940.8460152450938960505.stgit@devnote2>
In-Reply-To: <158218359349.6940.8460152450938960505.stgit@devnote2>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Feb 2020 09:16:56 +0100
Message-ID: <CAMuHMdVDBMii5RPiMkRo1XbFTiivbJASFUWQBn8_dU1Q5uRSzA@mail.gmail.com>
Subject: Re: [PATCH 1/8] bootconfig: Set CONFIG_BOOT_CONFIG=n by default
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

On Thu, Feb 20, 2020 at 8:26 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> Set CONFIG_BOOT_CONFIG=n by default. This also warns
> user if CONFIG_BOOT_CONFIG=n but "bootconfig" is given
> in the kernel command line.
>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks for your patch!

> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1218,7 +1218,7 @@ endif
>  config BOOT_CONFIG
>         bool "Boot config support"
>         depends on BLK_DEV_INITRD
> -       default y
> +       default n

"default n" is the default, so you can just drop the line.

>         help
>           Extra boot config allows system admin to pass a config file as
>           complemental extension of kernel cmdline when booting.
> diff --git a/init/main.c b/init/main.c
> index 59248717c925..680ff7123705 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -418,6 +418,14 @@ static void __init setup_boot_config(const char *cmdline)
>  }
>  #else
>  #define setup_boot_config(cmdline)     do { } while (0)
> +
> +static int __init warn_bootconfig(char *str)
> +{
> +       pr_err("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOTCONFIG is not set.\n");

pr_warn()?

> +       return 0;
> +}
> +early_param("bootconfig", warn_bootconfig);
> +
>  #endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
