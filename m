Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189D9C433F1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC3C22D2C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUkysNgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgHFIp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgHFIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 04:45:54 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7FBC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 01:45:54 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id a5so33530129ioa.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b581h/DwwqCtloal8vDOli1r/qOdK2w3K3dkhJG5PnA=;
        b=bUkysNgoI/3DolrnPuLM+/o0BheysqbMk/Gnm3+hhcZD3pgCZEhmWMtDB0aGT7PzcS
         VrnonLKgLaBJy1HYiWsdumIc1hZmzaZWwMBY/xE9EfOOom8OvBZkoH54e7KFuyuVFy58
         7eTkBclebOf6NWr8VMFAVIjTcNDJnaIJhkgNlPG5nDnUZlsSfo/h/SrMt3ptnw5o+44f
         5aK1FFzw3/8HAIgr2H2plYwUBqtSYZh7Am1Jmb/KBHjoI7MEwz5qGCzjL+6QtayOdcdB
         JmpKGe1xl+hQEQ4BjMOI7yCdERrwzOyrQYswFpTk29jwCGf8pmw+DfagMZOPwdNeHF9F
         OBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b581h/DwwqCtloal8vDOli1r/qOdK2w3K3dkhJG5PnA=;
        b=LpprW2dyJBvyDP0pQPDK9aJ5va89AQ4arbvbEF0lg16uklS85Z0J11V/otaagwTpz5
         uI7QwZEIVrFPtz/Tfw69Cus5e/+fFHtFTtq+vJRWWsUB6z6FLbQJd2V3Cyyw+AdBJcHV
         3jYRAP++eB8myoxlNqRKFnP1gLiuqxEl8zDCchM5XqqqVURoChG35SQCxb/5gxreJo74
         KZ9GAXoVuRO2NFjOonUg6JnRm9IEWXg4e9qXzD9SbW4WPFhTjIpFDlH6+QrIm8AIFeiz
         49ziu4qFCTYtUCUbtBZ5o5AO93EXplNRVwNzkfnJUw+sEcCkKfcBnKz4Et9eFlt7i+ZD
         KBOQ==
X-Gm-Message-State: AOAM530b9ePfDk1RUSEwSzaj+iHyBCamhoJUTTFsnz04ySCW5L601B2b
        DTqaMSUBDnFdZ5rChuq2qLVu0+Zh4MKGWMXDMBY=
X-Google-Smtp-Source: ABdhPJxnWFvSNqwXeK/mpjkJ8o8HCPWOQSHfKteaXTYMTVC8hoN9rkWePN/omzlZ1+tmo9qPAKdqR6sXTAOiK5iT3xc=
X-Received: by 2002:a5e:dd02:: with SMTP id t2mr8159451iop.90.1596703553451;
 Thu, 06 Aug 2020 01:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200805230555.84214-1-nolange79@gmail.com> <20200806003042.GB1551@shell.armlinux.org.uk>
In-Reply-To: <20200806003042.GB1551@shell.armlinux.org.uk>
From:   Norbert Lange <nolange79@gmail.com>
Date:   Thu, 6 Aug 2020 10:45:42 +0200
Message-ID: <CADYdroPtiEfk9e3Loj-2qyyPqgx9GG-h3S2P2Uz49zrk4wVSTw@mail.gmail.com>
Subject: Re: [PATCH] arm: Add support for ZSTD compressed kernel
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Petr Malat <oss@malat.biz>, Kees Cook <keescook@chromium.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do., 6. Aug. 2020 um 02:30 Uhr schrieb Russell King - ARM Linux
admin <linux@armlinux.org.uk>:
>
> On Thu, Aug 06, 2020 at 01:05:55AM +0200, Norbert Lange wrote:
> > diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> > index 434a16982e34..1af01bfe6638 100644
> > --- a/arch/arm/boot/compressed/head.S
> > +++ b/arch/arm/boot/compressed/head.S
> > @@ -614,7 +614,11 @@ not_relocated:   mov     r0, #0
> >   */
> >               mov     r0, r4
> >               mov     r1, sp                  @ malloc space above stack
> > +#if defined(CONFIG_KERNEL_ZSTD)
> > +             add     r2, sp, #0x30000        @ Context needs ~160K
>
> That's going to mess up kexec:
>
>         /*
>          * The zImage length does not include its stack (4k) or its
>          * malloc space (64k).  Include this.
>          */
>         len += 0x11000;
>
> I guess we need to add this to the information provided to kexec.

Ouch, I guess it's rather impossible to load a new ZSTD kernel with a old
kexec version in that case.

Some ideas to fix that would be:

-   Increase the padding to "192K + 4K is enough for everyone" in kexec
-   Add the required/recommended stack+heap size to zImage so kexec can use it.
-   change boot logic to place heap before/after the *output* range.
    with the various ways of booting arm this will likely cause other
issues in some combinations.
-   try to reduce zstd context size safetly below 64K.
    I believe the entropy tables are computed once and never modified,
so those could be part of the zImage
    (at some loss of compression rate of course). Would need some host
tool to inject those.

Norbert
