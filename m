Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCBDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF83720715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZ/6zRNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgERRt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbgERRtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:49:20 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AEEC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:49:20 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so5175030pgv.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBq4CNh2SzaiNVBNhEkzgkxU7yRKv+pxY1QX3ny6bNo=;
        b=VZ/6zRNAtX7ZLlIID1QWRgdZtiIeGPTy6KpLomMn7JqqlM9TYujBoe1ZNgZVDIwquw
         ALYqr3PEcui0ZwjYYSnWjyK6pf8VE9zmUuIuAtQFogiF0ec5vn+LTgNNgZabT18V1qGp
         fYcHYtQePf5E8AdCeKiarqvj8k7FWkDfvIqOafYwf4u6ghZ2Va4dEK/DOYyuzoIGIp1x
         nyn618v+L6curDrasU9mH0v11URYueVTIs5e7vyBLELrRyQyH/ZtAOW6OdrFc6E8HS/r
         1d9QyjXSKUzE6Hd43GT/swjkdoEgDK36woYmEOjAy3Wzbmc580F9wlAufVZmlJCooCER
         ygQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBq4CNh2SzaiNVBNhEkzgkxU7yRKv+pxY1QX3ny6bNo=;
        b=qazfvMXltUb9TmOO9QYMhrVUe1iU1FAF2by0XXLu7wHcCUCchx3CJSp0Zn5mIcrWdW
         zj4Gg+fvHXFLIZyvmfz3BKa8AotZ+xL1xjXQ7jeugkrgWUadjgApEqR+ZTkp/KzlQTzU
         5RkcyqeUY+5QhZl1ngS/SVL9ILH9i+/8I+EM5JT4BNbHFBZd4LEf0+Fqe6wHOceXNnLv
         myvDCw+IaWM9LkwF/NAUG8g84F/3oOFCICSVmQizKrjT4HzuKoeX8By/7eY7MWgTHkOO
         Sf+4SRzpBhPu7XSVN7W7oVKgupKOUREcZf1PFnLgBu1m84owpGYi+eE4i0jijkmJ6w5J
         ZeMw==
X-Gm-Message-State: AOAM531jqbf4OWiuOXJqT+4wV6xAT0AnGN4JA5pUgAu3P+ppBrdeoIww
        3Hgt9fu4gbmv02zD3nG6zqi1qbqntrDsPsGYhZEjaQ==
X-Google-Smtp-Source: ABdhPJxRHZLfRdK8uwwpMwsbOhVoF9vG5SJy734z8XHqMzN8eGkBO6NS7OWznhB++dzCLKoA34gxjZ8Pn9+T4BRCXLE=
X-Received: by 2002:a63:d010:: with SMTP id z16mr5906980pgf.381.1589824159213;
 Mon, 18 May 2020 10:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200517011732.GE24705@shao2-debian> <20200517034739.GO2869@paulmck-ThinkPad-P72>
 <CANpmjNNj37=mgrZpzX7joAwnYk-GsuiE8oOm13r48FYAK0gSQw@mail.gmail.com>
 <CANpmjNMx0+=Cac=WvHuzKb2zJvgNVvVxjo_W1wYWztywxDKeCQ@mail.gmail.com> <CANpmjNPcOHAE5d=gaD327HqxTBegf75qeN_pjoszahdk6_i5=Q@mail.gmail.com>
In-Reply-To: <CANpmjNPcOHAE5d=gaD327HqxTBegf75qeN_pjoszahdk6_i5=Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 May 2020 10:49:08 -0700
Message-ID: <CAKwvOd=Gi2z_NjRfpTigCCcV5kUWU7Bm7h1eHLeQ6DZCmrsR8w@mail.gmail.com>
Subject: Re: [rcu] 2f08469563: BUG:kernel_reboot-without-warning_in_boot_stage
To:     Marco Elver <elver@google.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@lists.01.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 7:34 AM Marco Elver <elver@google.com> wrote:
>
> On Mon, 18 May 2020 at 14:44, Marco Elver <elver@google.com> wrote:
> >
> > [+Cc clang-built-linux FYI]
> >
> > On Mon, 18 May 2020 at 12:11, Marco Elver <elver@google.com> wrote:
> > >
> > > On Sun, 17 May 2020 at 05:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Sun, May 17, 2020 at 09:17:32AM +0800, kernel test robot wrote:
> > > > > Greeting,
> > > > >
> > > > > FYI, we noticed the following commit (built with clang-11):
> > > > >
> > > > > commit: 2f08469563550d15cb08a60898d3549720600eee ("rcu: Mark rcu_state.ncpus to detect concurrent writes")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2020.05.14c
> > > > >
> > > > > in testcase: boot
> > > > >
> > > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> > > > >
> > > > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > If you fix the issue, kindly add following tag
> > > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > >
> > > > >
> > > > > [    0.054943] BRK [0x05204000, 0x05204fff] PGTABLE
> > > > > [    0.061181] BRK [0x05205000, 0x05205fff] PGTABLE
> > > > > [    0.062403] BRK [0x05206000, 0x05206fff] PGTABLE
> > > > > [    0.065200] RAMDISK: [mem 0x7a247000-0x7fffffff]
> > > > > [    0.067344] ACPI: Early table checksum verification disabled
> > > > > BUG: kernel reboot-without-warning in boot stage
> > > >
> > > > I am having some difficulty believing that this commit is at fault given
> > > > that the .config does not list CONFIG_KCSAN=y, but CCing Marco Elver
> > > > for his thoughts.  Especially given that I have never built with clang-11.
> > > >
> > > > But this does invoke ASSERT_EXCLUSIVE_WRITER() in early boot from
> > > > rcu_init().  Might clang-11 have objections to early use of this macro?
> > >
> > > The macro is a noop without KCSAN. I think the bisection went wrong.
> > >
> > > I am able to reproduce a reboot-without-warning when building with
> > > Clang 11 and the provided config. I did a bisect, starting with v5.6
> > > (good), and found this:
> > > - Since v5.6, first bad commit is
> > > 20e2aa812620439d010a3f78ba4e05bc0b3e2861 (Merge tag
> > > 'perf-urgent-2020-04-12' of
> > > git://git.kernel.org/pub/scm/linux/kernel//git/tip/tip)
> > > - The actual commit that introduced the problem is
> > > 2b3b76b5ec67568da4bb475d3ce8a92ef494b5de (perf/x86/intel/uncore: Add
> > > Ice Lake server uncore support) -- reverting it fixes the problem.
>
> Some more clues:
>
> 1. I should have noticed that this uses CONFIG_KASAN=y.

Thanks for the report, testing, and bisection.  I don't see any
smoking gun in the code.
https://godbolt.org/z/qbK26r

>
> 2. Something about function icx_uncore_mmio_init(). Making it a noop
> also makes the issue go away.
>
> 3. Leaving icx_uncore_mmio_init() a noop but removing the 'static'
> from icx_mmio_uncores also presents the issue. So this seems to be
> something about how/where icx_mmio_uncores is allocated.

Can you share the disassembly of icx_uncore_mmio_init() in the given
configuration?
-- 
Thanks,
~Nick Desaulniers
