Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD382C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88ED52051A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgBKJZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:25:43 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33534 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgBKJZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:25:43 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so9431851otp.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 01:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1ZMuRusCoTAqMkdtdU8FV6cexR3vgoJmeR/zAbXdpE=;
        b=NA7oD9KJD9dvpu2g8pcmvQhOjsKIsMkGgGDqBMmo0ctgUtM5AxoFN0Rm4TqWtflWFz
         tXn0i9sbuY8z0EWEKH/E9d/0oPpqcwuIc3y1Mkbo7u/JrCdGvTNoojsEh5aRUg/unn7a
         24cXCkPZqeLZpWDuAPriczVIc0rbWSLeB/Q+r3a++7SAtmblCZN8lrU1oyz3DKbm9CUk
         +UnibGHhsfwPj4QATQAJn8/MhhZAoK5yjpOg+E0/1eAwTYULagSKFIVwXoa1ruQUN/yp
         Qvp/Bso1e0fLQTBsEXBOaYHqJzYWlTKdmcv4g2w6HwXbHTO2ZxpgQhUwUsvX33lD17th
         Dwdg==
X-Gm-Message-State: APjAAAX3cNjEex/EFw/03Pkg0Lh+U9qru9z/1lZxrLjTxGvfgd6sHfNJ
        CN5yip+OaPTnRKsrPJ0/JCW3dmwQJ0LpGudencEgXA==
X-Google-Smtp-Source: APXvYqwmcqm1wbo0V34LBB/CSb7qX9XNQWdEtX4m7VY13qGkHYGr57VKehhvzcL3zExZrlFHWyiWtdgpOzTSkxY6vYg=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr4540072otm.297.1581413142376;
 Tue, 11 Feb 2020 01:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20200114210316.450821675@goodmis.org> <20200114210336.259202220@goodmis.org>
 <20200206115405.GA22608@zn.tnic> <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
 <20200206175858.GG9741@zn.tnic> <20200207114617.3bda49673175d3fa33cbe85e@kernel.org>
 <20200207114122.GB24074@zn.tnic> <20200208000648.3383f991fee68af5ee229d65@kernel.org>
 <20200210112512.GA29627@zn.tnic> <20200211001007.62290c743e049b231bdd7052@kernel.org>
 <20200210174053.GD29627@zn.tnic>
In-Reply-To: <20200210174053.GD29627@zn.tnic>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Feb 2020 10:25:31 +0100
Message-ID: <CAMuHMdUifvp==VQfsp1D8GTK_ZOyZxQJqqm59bQ2K3sNOnqAkA@mail.gmail.com>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 6:41 PM Borislav Petkov <bp@alien8.de> wrote:
> On Tue, Feb 11, 2020 at 12:10:07AM +0900, Masami Hiramatsu wrote:
> > Boot time tracing is just a example. I think we can expand this for some
> > other subsystems too. And this might be also helpful for adding a bit more
> > complex syntax to those parameters without parser.
>
> Yes, I think I see it now. And I still don't think you want this enabled
> by default on every box. It is expressed perfectly fine here:
>
> config BOOTTIME_TRACING
>         bool "Boot-time Tracing support"
>         depends on BOOT_CONFIG && TRACING

Which is BTW "default y", too...

> so if distros want to enable that, they will enable BOOT_CONFIG too,
> transitively. And other subsystems would simply depend on it the same if
> they wanna use bootconfig.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
