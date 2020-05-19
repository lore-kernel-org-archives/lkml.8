Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17728C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FC9207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g7UesDSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgESO7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgESO7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:59:06 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E634C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 07:59:06 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 62so8037947vsi.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 07:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cAwM4xUN+JXfgmnpSakIzQBFryyxT4xbvQKyptF8HfU=;
        b=g7UesDSwco++E9tvDmaeYZHTUzwg0n+acwSdyySMURap5qFLIynLhGq5AUrj1fYMJ0
         sw/JLqS9GpKjA2q16tUiCfnRqLnJvDl/gct6mgVedTlmvLGW1Pf+VGOmT8FCq4ufSVfc
         35euMAF2IOS7EKW54E0VcyplYL+ZhWm0tlpcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAwM4xUN+JXfgmnpSakIzQBFryyxT4xbvQKyptF8HfU=;
        b=Fk+lk/sviDNaR65ZGkXnnq07iAa74Yw3mvGiHvluYhX/sCH/rVzmqugSXhgIuz+lqH
         nX1eZTnwhVzvrzJf8nzQDN6MA/uAJLkNc31lnMAag4E1A6RAUlC3FIO3vvzxVezUoxNY
         9RXVDXS46XUMM9uZ65xac4Lzy5lMl7aQeeEZ0M7HFdcbC8OLJWkv1d25wefb9r8A8Nuv
         JTqvLVJvJXhuF99/EWUfxdt6b3cXvt64da1Y6YCYAk0hHLu0mDgPsA3P6szyEMzQSQjV
         GSI00eX3zkqSa73xY60sKHzkRf8CaBTSjuLdeANIKvWiU2WDHQkTLq63yiQjWuA5Msax
         uXcQ==
X-Gm-Message-State: AOAM5309mSoHN7yaGGmpvcwOdMdGlyCcdTUJ4WFulvA9MFuhtJgYV3AK
        PMYpieqcP40JGV5SlParjH/qBtmSnsk=
X-Google-Smtp-Source: ABdhPJw4ytPiFoNoTgeEFoK4N93MkkCCoKvvis2XOO2NF7D4OK49LlyNIr/v+eNRazMfvee+9CRh4w==
X-Received: by 2002:a67:ef1d:: with SMTP id j29mr1511392vsr.238.1589900345472;
        Tue, 19 May 2020 07:59:05 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 66sm3581189vss.16.2020.05.19.07.59.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 07:59:04 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id k4so4908359uaq.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 07:59:03 -0700 (PDT)
X-Received: by 2002:ab0:6806:: with SMTP id z6mr15603649uar.0.1589900343396;
 Tue, 19 May 2020 07:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200520000524.69af8a86@canb.auug.org.au>
In-Reply-To: <20200520000524.69af8a86@canb.auug.org.au>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 May 2020 07:58:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WuXEO0KCoRnundQxVMJyre9UBdw2NDUSsWxJwADjCR9A@mail.gmail.com>
Message-ID: <CAD=FV=WuXEO0KCoRnundQxVMJyre9UBdw2NDUSsWxJwADjCR9A@mail.gmail.com>
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

On Tue, May 19, 2020 at 7:05 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the kgdb tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/tty/serial/kgdboc.c:418:13: error: expected declaration specifiers or '...' before string constant
>   418 | early_param("ekgdboc", kgdboc_early_init);
>       |             ^~~~~~~~~
> drivers/tty/serial/kgdboc.c:418:24: error: expected declaration specifiers or '...' before 'kgdboc_early_init'
>   418 | early_param("ekgdboc", kgdboc_early_init);
>       |                        ^~~~~~~~~~~~~~~~~
> drivers/tty/serial/kgdboc.c:546:13: error: expected declaration specifiers or '...' before string constant
>   546 | early_param("kgdboc_earlycon", kgdboc_earlycon_init);
>       |             ^~~~~~~~~~~~~~~~~
> drivers/tty/serial/kgdboc.c:546:32: error: expected declaration specifiers or '...' before 'kgdboc_earlycon_init'
>   546 | early_param("kgdboc_earlycon", kgdboc_earlycon_init);
>       |                                ^~~~~~~~~~~~~~~~~~~~
> drivers/tty/serial/kgdboc.c:505:19: warning: 'kgdboc_earlycon_init' defined but not used [-Wunused-function]
>   505 | static int __init kgdboc_earlycon_init(char *opt)
>       |                   ^~~~~~~~~~~~~~~~~~~~
> drivers/tty/serial/kgdboc.c:411:19: warning: 'kgdboc_early_init' defined but not used [-Wunused-function]
>   411 | static int __init kgdboc_early_init(char *opt)
>       |                   ^~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   220995622da5 ("kgdboc: Add kgdboc_earlycon to support early kgdb using boot consoles")
>
> I have used the kgdb tree from next-20200518 for today.

Ugh.  Actually, I think the commit to blame is:

eae3e19ca930 ("kgdboc: Remove useless #ifdef
CONFIG_KGDB_SERIAL_CONSOLE in kgdboc")

The next commit just made it worse.  Apparently the #ifdef wasn't so
useless after all.  It was just subtly keeping the code from compiling
when kgdboc was used as a module.  That's because when it's a module
we instead get this defined:

#define CONFIG_KGDB_SERIAL_CONSOLE_MODULE 1

Apparently I didn't re-test as a module after I made this change in
one of the later spins.  :(

I think I can whip up a quick patch that uses "IS_BUILTIN(option)".
Basically this should go back to how the code was in one of the
earlier patchsets where I tested this.

-Doug
