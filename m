Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA6CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF52C207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QMjKkPPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgESPw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 11:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgESPw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:52:57 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8EBC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 08:52:57 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id u7so4920187vsp.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0DRJUhLfm37xkTsnSB7pw/O4/cZk8AUSxbUDEEDguJA=;
        b=QMjKkPPnnalcEuuPmzHdrdSAibU5SjOBDQPGm7VvbDmQUrw4Da7nrjVBFcqqlfoo5K
         TRu4iVW6Yxw1M0ntcMkjJGWvQ4ZjC3W5jjJ3YoJCC06bih2S5XojKPeiTYy5k5AHVFYJ
         dImPokJR1g/WrLwRq5wL6mHVbufED8u+nADhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0DRJUhLfm37xkTsnSB7pw/O4/cZk8AUSxbUDEEDguJA=;
        b=TBFADu63CZMs2xppraey/P/rmpzOKFqeNE9LZTn9r09ghUlpLl9YaJl9aTcuyWuzz1
         r8UIE4/6xl1i+hck7wI/lOsG2jAJX1FbOn6P43EURxq/Yq6rNdsxHE6LpFejw05hQVRV
         ylCypqUNFJy98kpa7hxnKVtxrYet/XO+JKoAKTRD0gxLeI8tpkx5xO5HF8Qyx+n4BNBH
         qSZ8pBH2Grn/zd73oaLZpYXSmmQA2IlT39R4ukAVtsoZxpP8YOXXmbtXaOGhVOWkTC/T
         ecyCigAHrKQxpTdfHlXCfocFajluyvI62gWxf8Xue9M/i9rdgOr4YVfGHs1f6n6BUxpF
         qbuQ==
X-Gm-Message-State: AOAM532ygqCmE2B+GTQW6ZxgxtrRDsTCo1vzS2JaRc7OkWoVlTKFS6Uo
        C1BQ7Prpp6dugWvIB13kQjbAWbIWu54=
X-Google-Smtp-Source: ABdhPJyPfuicuHJM0GXPxBvjxD4ZuNpDZqtERdNuZguKgKyeMkKXSQLim5gle+p9Ynrh7B4jgx52dA==
X-Received: by 2002:a67:1bc7:: with SMTP id b190mr8517434vsb.82.1589903576146;
        Tue, 19 May 2020 08:52:56 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id z18sm3468342vsq.26.2020.05.19.08.52.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 08:52:55 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id z12so69421uap.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 08:52:55 -0700 (PDT)
X-Received: by 2002:a9f:2804:: with SMTP id c4mr18652uac.8.1589903574983; Tue,
 19 May 2020 08:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200520000524.69af8a86@canb.auug.org.au> <CAD=FV=WuXEO0KCoRnundQxVMJyre9UBdw2NDUSsWxJwADjCR9A@mail.gmail.com>
In-Reply-To: <CAD=FV=WuXEO0KCoRnundQxVMJyre9UBdw2NDUSsWxJwADjCR9A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 May 2020 08:52:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ViDa64P4xM_DH3bFkkSO0wjDjOBmBz3hELCoJLcRbCNA@mail.gmail.com>
Message-ID: <CAD=FV=ViDa64P4xM_DH3bFkkSO0wjDjOBmBz3hELCoJLcRbCNA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kgdb tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 19, 2020 at 7:58 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, May 19, 2020 at 7:05 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the kgdb tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > drivers/tty/serial/kgdboc.c:418:13: error: expected declaration specifiers or '...' before string constant
> >   418 | early_param("ekgdboc", kgdboc_early_init);
> >       |             ^~~~~~~~~
> > drivers/tty/serial/kgdboc.c:418:24: error: expected declaration specifiers or '...' before 'kgdboc_early_init'
> >   418 | early_param("ekgdboc", kgdboc_early_init);
> >       |                        ^~~~~~~~~~~~~~~~~
> > drivers/tty/serial/kgdboc.c:546:13: error: expected declaration specifiers or '...' before string constant
> >   546 | early_param("kgdboc_earlycon", kgdboc_earlycon_init);
> >       |             ^~~~~~~~~~~~~~~~~
> > drivers/tty/serial/kgdboc.c:546:32: error: expected declaration specifiers or '...' before 'kgdboc_earlycon_init'
> >   546 | early_param("kgdboc_earlycon", kgdboc_earlycon_init);
> >       |                                ^~~~~~~~~~~~~~~~~~~~
> > drivers/tty/serial/kgdboc.c:505:19: warning: 'kgdboc_earlycon_init' defined but not used [-Wunused-function]
> >   505 | static int __init kgdboc_earlycon_init(char *opt)
> >       |                   ^~~~~~~~~~~~~~~~~~~~
> > drivers/tty/serial/kgdboc.c:411:19: warning: 'kgdboc_early_init' defined but not used [-Wunused-function]
> >   411 | static int __init kgdboc_early_init(char *opt)
> >       |                   ^~~~~~~~~~~~~~~~~
> >
> > Caused by commit
> >
> >   220995622da5 ("kgdboc: Add kgdboc_earlycon to support early kgdb using boot consoles")
> >
> > I have used the kgdb tree from next-20200518 for today.
>
> Ugh.  Actually, I think the commit to blame is:
>
> eae3e19ca930 ("kgdboc: Remove useless #ifdef
> CONFIG_KGDB_SERIAL_CONSOLE in kgdboc")
>
> The next commit just made it worse.  Apparently the #ifdef wasn't so
> useless after all.  It was just subtly keeping the code from compiling
> when kgdboc was used as a module.  That's because when it's a module
> we instead get this defined:
>
> #define CONFIG_KGDB_SERIAL_CONSOLE_MODULE 1
>
> Apparently I didn't re-test as a module after I made this change in
> one of the later spins.  :(
>
> I think I can whip up a quick patch that uses "IS_BUILTIN(option)".
> Basically this should go back to how the code was in one of the
> earlier patchsets where I tested this.

Fix posted at:

https://lore.kernel.org/r/20200519084345.1.I91670accc8a5ddabab227eb63bb4ad3e2e9d2b58@changeid

I have confirmed:

* x86_64 allmodconfig atop the kgdb tree compiles.

* Building and using kgdboc as a module works with this patch on my
local 5.4-based tree.  Loaded the module both with module parameters
and via echoing to sysfs.  Unloaded the module and confirmed it works.

* Building and using kgdboc builtin allows me to do kgdb_earlycon on
my local 5.4-based tree.


-Doug
