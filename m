Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66858C18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF8B206D3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585786610;
	bh=uYe4mxrJbF7G3ekp0P2crE2SwUpNcSaw+fpfGOtnClc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0wziUu5MgqWolJUJ4VJqFikornLYij68S+oN9jTO3pvaWGlxuF1Izu7OXMmwJ1dLS
	 rYjMSxlVXj2vuRBjq014jyYxLWHidNlkUr5Rg2dfwHWiWoPXkCa2+OclyL+5hg5fbe
	 sJ7rLQbkcuN4s6mdPKfQYYyfy90EU/xwAu/ixr5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbgDBAQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 20:16:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42771 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732137AbgDBAQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 20:16:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id q19so1346584ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 17:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qPR3tgQj3+hwQujkAPBePnH9Sh69ngTXCezmILuD2BM=;
        b=Tv5EHXbWC4OnwhZFPBZGIINilygmwa7jioVjaGa2ShfB/XQ3XFeF+bhAVxywrSc/Ib
         h/gVf6INlelJtMkTBU0T3z7YDQ+orxizMJV/TgBfxeTZXXJzGoOmnxBEU1PlJ3UMeu9H
         C09Niu8rj1PNP/2w+8dA+nyHREwXZQJj64e4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qPR3tgQj3+hwQujkAPBePnH9Sh69ngTXCezmILuD2BM=;
        b=sao+j3vu//P1EX19zg3TGtjUrG80CdtUSkSBKI98zKze/AOGZiKSXMMry2bPxy50+u
         oqW3X5TmMrjsFpbyG1srxjv+p8PE4dQx0iRHF+dVhy6eyMol6jPU6LHbQklb0ABg5HNe
         0ghmaT/Gz5DOp1QI+3orySGDudcER8SIJoF1z1pUzQldwtT2vQr0RzEIwAdRms54zBB4
         +WEEQW4fuqcHBoEkntv2eflwNhDBrv0q3HvDIaYsErPdXT9JSGD2z81ZMAEXU+RcUkz3
         y/fmabGREI3CkZ9750iBgKEmmKl8e6HZTIsQd0LaEm8xhQ/lQcby0GC2GsNwmJcTYIOs
         4pLQ==
X-Gm-Message-State: AGi0PuaLFkG0gLOOdrAbUPW5kTEDHknBu7rWzcqfiXPQ5tayRpleJPHg
        OGZxVmrtEipORsaS5eSQS7nyyA8FFfI=
X-Google-Smtp-Source: APiQypIfUKsUE5IURP+0cihOuRNR+/ESeNFjvfZdVKruX7esno7CFYG0a2ot5hAAJQCxrSSLk0P3SA==
X-Received: by 2002:a2e:b80d:: with SMTP id u13mr422416ljo.166.1585786602266;
        Wed, 01 Apr 2020 17:16:42 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id a26sm2044003ljn.22.2020.04.01.17.16.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 17:16:41 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id p10so1416828ljn.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 17:16:41 -0700 (PDT)
X-Received: by 2002:a2e:8652:: with SMTP id i18mr417201ljj.265.1585786600770;
 Wed, 01 Apr 2020 17:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200331080111.GA20569@gmail.com> <CAHk-=wjpBohNkBSxyPfC7w8165usbU5TuLohdbPs+D0bUYqJhQ@mail.gmail.com>
 <CAHk-=wijWvUfEkqUZRpvo9FCaJNsioS_qZT+iNWUdqQ6eO8Ozw@mail.gmail.com> <87v9mioj5r.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87v9mioj5r.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Apr 2020 17:16:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3_WTKeR=TTbPpbJYjC8DOPcDPJhhoopTVs3WJimsT=A@mail.gmail.com>
Message-ID: <CAHk-=wh3_WTKeR=TTbPpbJYjC8DOPcDPJhhoopTVs3WJimsT=A@mail.gmail.com>
Subject: Re: [GIT PULL] x86 cleanups for v5.7
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 4:55 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>   - x86 starts the short log after the colon with an uppercase
>     letter

Ahh. I actually tried to match the previous ones by Al, and they don't
follow that pattern.

>   - 'macross' is really gross :)

Oops.

>   - All commits lack a Link:https//lore.kernel.org/r/$MSG-ID tag. That
>     might be an oversight or just reflecting the fact that these patches
>     have never seen a mailing list.

Yeah. They were literally me looking at my patch in my other tree, and
trying to make incremental progress.

Nobody else has a working compiler to even test that patch, because
even upstream tip-of-the-day llvm mis-generates code (I have a patch
that makes it generate ok code, but that one isn't good enough to
actually go upstream in llvm).

I don't think I'll do any more, because the next stage really is to
actually have some CONFIG_ASM_GOTO_WITH_INPUTS code and then try to
make something similar to the SET_CC for this.

> From a quick check I can confirm that the resulting text changes are
> just random noise and I did not notice anything horrible in the
> generated code either.

Btw, do you guys have some better object code comparison thing than my
"objdump plus a few sed scripts to hide code movement effects"

               Linus
