Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F1BC2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF11220737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585849235;
	bh=e0cPfK7PzDT+DEFKNBXg8fwQOR96zbgAGI4XMavhYBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Mw35ywQUnsQnbifPBdMjf6oPBbOBL2nUi3fEXm6VeaI/YVfmNvM9/6AsUAGBr+FYB
	 wgO/67zE60T4p3bhe0lnflAlnEQcBaC6LrmNVxemTX5tFUfKlivYg8+QmLZCACHjYp
	 f5nRtu7uP0+OccUqzz+hwv0anYdG8GmE3KQK63F4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390106AbgDBRkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:40:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45674 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390038AbgDBRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:40:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id f8so2098801lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iY33WSfg2+BlLBCqLu07xUtOQLPOpN5N3YeHbBLhx6Y=;
        b=Z9aqKjRrEZJDXaLqeHtV64B35CP0RfSJY4EO4dTHgnslpuruJgfXRVmNjFuOU+cnx5
         kVHsuGSL9vWvZVUuZGGoaD+Vlqt/9NiqpCmlveSSLT0zXxtt7ray80snXoylzmqvGnmt
         ISwuXHaK7OoOpyIaDwJv27rjW/l2js7AFLlrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iY33WSfg2+BlLBCqLu07xUtOQLPOpN5N3YeHbBLhx6Y=;
        b=anh9ymCz/YCGEW9i8iLN67/EBGNJ3YdIdqf9+9Fyv1VgK5+hqDfVJItK+q+CNHZ4+p
         sbd6M9TtwY+PbKRwuaRHiWFf8YF6s3gYMM+AQs2rsl4xBj9asISlnHw+61+ci3kV9pU9
         +iMUwGxRRUIAFCpINthSkok8t8vdvUL6/NCStQooel74QR12uN6lykGa1jOwiVATX3KW
         YvbSHhRurfNzQdKxwgG3WWy7NNF6XanVo4tbXJ+e3OohpAca7VTzV+P2TgJarF183xiy
         OFgmt9IMCh0EzxWprh+pBGwMN41CfSeLvQt/he6sv0mK8EsPwh9aZSexuAdEPguD+uu6
         YDjw==
X-Gm-Message-State: AGi0PuaPMdS2kOk3YvX6euHHzNrZr9TIAtXpxSj0r171MQQnwTkm0JUm
        YGWasLmxv7lM1muYm6MDt0B46BvLnIE=
X-Google-Smtp-Source: APiQypJChM7iNXEdL0HeHhJLCJpgPWsFM5mL+4IaGJC7nn081Xnsgl3ZwAxJi+UZmKiv8x/hiL2+UQ==
X-Received: by 2002:ac2:4199:: with SMTP id z25mr2848134lfh.90.1585849231483;
        Thu, 02 Apr 2020 10:40:31 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id i190sm4601676lfi.7.2020.04.02.10.40.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 10:40:30 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id f8so2098719lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:40:30 -0700 (PDT)
X-Received: by 2002:ac2:4a72:: with SMTP id q18mr2883556lfp.10.1585849230229;
 Thu, 02 Apr 2020 10:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200331080111.GA20569@gmail.com> <CAHk-=wjpBohNkBSxyPfC7w8165usbU5TuLohdbPs+D0bUYqJhQ@mail.gmail.com>
 <CAHk-=wijWvUfEkqUZRpvo9FCaJNsioS_qZT+iNWUdqQ6eO8Ozw@mail.gmail.com>
 <87v9mioj5r.fsf@nanos.tec.linutronix.de> <CAHk-=wh3_WTKeR=TTbPpbJYjC8DOPcDPJhhoopTVs3WJimsT=A@mail.gmail.com>
 <20200402134051.GC9352@zn.tnic> <CAHk-=whCw-WFbHhq6uYZcXrMEoi4y_FhZk48adf4JePxBzmFsg@mail.gmail.com>
 <20200402172443.GG9352@zn.tnic>
In-Reply-To: <20200402172443.GG9352@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Apr 2020 10:40:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhJmgbBaz9s=+OPgBVRyYOweLB=4n42snqSRJ7WePwFw@mail.gmail.com>
Message-ID: <CAHk-=whhJmgbBaz9s=+OPgBVRyYOweLB=4n42snqSRJ7WePwFw@mail.gmail.com>
Subject: Re: [GIT PULL] x86 cleanups for v5.7
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Matz <matz@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 10:24 AM Borislav Petkov <bp@alien8.de> wrote:
>
> But, TBH, I have myself wondered a couple of times, "dang, if that
> asm goto only had outputs" so I'm thinking if gcc guys are bored and
> wondering what to put in gcc11, why not this. :-)

Yeah. And there are other places where we might want to use it.

Yes, it happens to be particularly useful for exception handling where
it avoids some register pressure (that can be a bigger deal than the
trivial extra instructions) and gets rid of the fixup code in a
different segment.

But it's potentially very useful for alternatives code too (where a
fallback alternatives could be "jump out-of-line to different code
entirely").

I originally wanted it for things like cmpxchg, but getting the
condition codes out of the asm and letting the compiler generate the
jump was even better.

            Linus
