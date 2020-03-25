Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4B0C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8F62077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgCYM1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:27:39 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39287 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgCYM1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:27:39 -0400
Received: by mail-oi1-f194.google.com with SMTP id d63so1881736oig.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 05:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyGK8XM9Ah7vhVkzHhVphf8AlqAci1T9MYy4TCipGWo=;
        b=Uo7qhnW1JCEcmWiewa0ib518CE8/OLH01AixO49j+W86xe4jeGtbYP6nEheDnyeZ6e
         4hN8G65r+kkeb92jPnf3mJH5q6c4J/ETmCvxgSsZiTdbcuNb7iKCcZEEWSiZ8p+AZviy
         fjjfGgb9ls4F0884EhE1FwNnaCkIeXsuc2LalukFctuZo30G8Ts+zgHEYamD8/AVgYTS
         DRHwez2GevQgS2uQG/I7f3PeHN/YZcuWKtD+dyTBT4csRqKecGejgfWXIGLL3poMSQfY
         Xx1+ggvJ6SRmrK+7bQiTSL8bP9mthqqU1P5/nah0t0QK9nDICyosK2B3DPgdmZGD4fhQ
         b14A==
X-Gm-Message-State: ANhLgQ1sxvD3PvGG3wvXFwU/1gt2l3806OKo4a5DVDTigl2irzO0bxuR
        fpqKgFX/rYJT8lyOAbQwb8VkUu3oFHZPgIU7PGY=
X-Google-Smtp-Source: ADFU+vvOhisyLVGAV9VIxSTYKk8/kXfUSLmdm9ztHoSYf/RNIdIVhNX4vNStW7xdfd6+ssavMvQaKZ7jjRltYX6jv1M=
X-Received: by 2002:aca:cdd1:: with SMTP id d200mr2135910oig.153.1585139258592;
 Wed, 25 Mar 2020 05:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <202003220209.CjthuGEA%lkp@intel.com> <87fte1qzh0.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87fte1qzh0.fsf@nanos.tec.linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Mar 2020 13:27:27 +0100
Message-ID: <CAMuHMdX2vK4DeGNGqWQ09Z1UyP8+QAREDjH82+u9xeWtY0ayHw@mail.gmail.com>
Subject: Re: [tip:locking/core 19/28] include/linux/fs.h:1422:29: error: array
 type has incomplete element type 'struct percpu_rw_semaphore'
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild test robot <lkp@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sat, Mar 21, 2020 at 8:29 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> kbuild test robot <lkp@intel.com> writes:
> > All errors (new ones prefixed by >>):
> >
> >    In file included from include/linux/huge_mm.h:8,
> >                     from include/linux/mm.h:567,
> >                     from arch/m68k/include/asm/uaccess_no.h:8,
> >                     from arch/m68k/include/asm/uaccess.h:3,
> >                     from include/linux/uaccess.h:11,
> >                     from include/linux/sched/task.h:11,
> >                     from include/linux/sched/signal.h:9,
> >                     from include/linux/rcuwait.h:6,
> >                     from include/linux/percpu-rwsem.h:7,
> >                     from kernel/locking/percpu-rwsem.c:6:
> >>> include/linux/fs.h:1422:29: error: array type has incomplete element type 'struct percpu_rw_semaphore'
> >     1422 |  struct percpu_rw_semaphore rw_sem[SB_FREEZE_LEVELS];
> >          |                             ^~~~~~
>
> Same problem as in the other architectures and same cure.

Indeed it does.

> ---
> Subject: m68knommu: Remove mm.h include from uaccess_no.h
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Sat, 21 Mar 2020 20:22:10 +0100
>
> In file included
>   from include/linux/huge_mm.h:8,
>   from include/linux/mm.h:567,
>   from arch/m68k/include/asm/uaccess_no.h:8,
>   from arch/m68k/include/asm/uaccess.h:3,
>   from include/linux/uaccess.h:11,
>   from include/linux/sched/task.h:11,
>   from include/linux/sched/signal.h:9,
>   from include/linux/rcuwait.h:6,
>   from include/linux/percpu-rwsem.h:7,
>   from kernel/locking/percpu-rwsem.c:6:
>  include/linux/fs.h:1422:29: error: array type has incomplete element type 'struct percpu_rw_semaphore'
>     1422 |  struct percpu_rw_semaphore rw_sem[SB_FREEZE_LEVELS];
>
> Removing the include of linux/mm.h from the uaccess header solves the problem
> and various build tests of nommu configurations still work.
>
> Fixes: 80fbaf1c3f29 ("rcuwait: Add @state argument to rcuwait_wait_event()")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
