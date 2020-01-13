Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F08C33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70212073D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgAMJK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:10:58 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41072 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgAMJK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:10:58 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so7557554oie.8;
        Mon, 13 Jan 2020 01:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6gZhw224Esa/F9sYWDsm6MZRd7GWVp77Xi2oOVzj7I=;
        b=V7wnikmOZLN603li5YBHQakodO0LzwZktqTdHO95ymRSP5Waavyv0rP2z8fCLsECfY
         UEMExC/6/WuaW977AI66Et8vDSYzw/3TSdiL7gR7PczdgFp4q/G+1/x0M3zRvQElCSQC
         3NqFzDR6mqKoFMlh5wRr4WAA02z9sau4Lt1J7BVFn67biQeHUTNJ+H6OdtLSBfGFni4g
         wkcLXna5yUe1h0Vvbxsc0PoTkyojhWXEPsaoFQzBMzUvFLimPqcqBA6m7QxDqKGXvFUW
         Aj2IQxrRx2AmMq0BXSBInF1msExPPQ14GsurT9+9VKzH+zmIKXp0hnlJcUm9ZpPWDamz
         XmnA==
X-Gm-Message-State: APjAAAVBkKUnr2qqC0Rtof6hqAmNUgr2Mr0OjEmf8niiyJRdw0WQrcJ/
        cVsARoLBhbSv+d96ZbCjpzfQ7i0hig5ypPykou0=
X-Google-Smtp-Source: APXvYqwxP5TUTn30AonNUa0Qc77P4zv+kJkUuwsv4y7LcQg2Yk9B+2R4a6oHO1XnIuST8PjVuXdYuOG9TUI9CaDqClk=
X-Received: by 2002:a05:6808:292:: with SMTP id z18mr11350725oic.131.1578906657627;
 Mon, 13 Jan 2020 01:10:57 -0800 (PST)
MIME-Version: 1.0
References: <20191124195225.31230-1-jongk@linux-m68k.org> <CAMuHMdXQAbw_Skj99q_PWXKn77bzVbJf60n38Etmq-zhOoHsHQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXQAbw_Skj99q_PWXKn77bzVbJf60n38Etmq-zhOoHsHQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jan 2020 10:10:26 +0100
Message-ID: <CAMuHMdU9hu+EAAnBD5dH3+LS5pNi9fOjFNesv3eFSCoqbW3CCA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Wire up clone3() syscall
To:     Kars de Jong <jongk@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Amanieu d'Antras" <amanieu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2020 at 5:06 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sun, Nov 24, 2019 at 8:52 PM Kars de Jong <jongk@linux-m68k.org> wrote:
> > Wire up the clone3() syscall for m68k. The special entry point is done in
> > assembler as was done for clone() as well. This is needed because all
> > registers need to be saved. The C wrapper then calls the generic
> > sys_clone3() with the correct arguments.
> >
> > Tested on A1200 using the simple test program from:
> >
> >   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/
> >
> > Cc: linux-m68k@vger.kernel.org
> > Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
>
> Thanks, applied and queued for v5.6.

Which is now broken because of commit dd499f7a7e342702 ("clone3: ensure
copy_thread_tls is implemented") in v5.5-rc6 :-(

BTW, was this the reason for the failures at the end of
https://lore.kernel.org/lkml/CACz-3rhmUfxbfhznvA6NOF69SR49NDZwnkZ=Bmhw_cf4SkiadQ@mail.gmail.com/?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
