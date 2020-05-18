Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED34C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF2C20671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hyxzuMqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgEROeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:34:21 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EBEC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:34:20 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id a83so2069977oob.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCFSvoO5nHEFutdDZ7u001WboaSd8JW+ksXM71B70LQ=;
        b=hyxzuMqEEgGGzRInYLAx5i6ch0Dgh031FZA6S0BYG15yNwswPJgHXmo/PPjAbAwHFe
         +77V+l5h+kqwuDP/wDkQkQSD4Tbybsh8Bs5ppZTUg+vFkTcxEVcQ/aUBHgGAvGYUxa2c
         YzFCrWl6pNgnwxGRIkMD1rePniCAYXpl0fpeReC/NCOwPR4ZlTZw+Ejbq0CohYa8WAf4
         XoDTOJ0XkjzSU4mIMwQ94TevCqtztm2VwuQLAS/REs8sfqZqabU0aWajBS0b3y929xs1
         i1jR0omjyG6pkbe7kqHo7aD/4nhhiCp4iy5DBGUAMZ6U3FBGb/+v7kFZ7xSidDKC8MZ2
         pYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCFSvoO5nHEFutdDZ7u001WboaSd8JW+ksXM71B70LQ=;
        b=QLyTaR1nPkfOrm4D3uDcYLrBca8Jq8GyVv3gmMLbGZf2X2TurNfgnK3n8tV360lwow
         1cphicAgdTfYSGl4DZ0WyrDKYr/0687+Ffsjoj/Vl9O4FTXrkRSZc4tpzvbjsm2uls5e
         Pnnwz4OHBEQvS81zOfNfGIoDXiZ1btzUR22TmSeFI3Jq/dmLvWBO0E8X7VmBvmDPC+24
         2+Ss6fLNXnmRkRzJtKS2Hclc9yQ8VNdwCSQ6NeFaU3epfXEr9AB5XKeVyPLPF3Oqlu4G
         xzM/70+gP3tLov2sWWN7N9zvZMXezQe6Zbzb8KH5nT8LB/ZbRyd7C9uwVr3pKDUg4rVY
         MkVQ==
X-Gm-Message-State: AOAM531+m7FccMPI8z+MeurFZNemXKxY5rNebjw3ty+zQj4VZcHDQsKM
        X2T4VElxN6rtRI1rIdBXvKxCOcQCh8/ikVU36abIsg==
X-Google-Smtp-Source: ABdhPJzTwA8rfBAfV7HynwETeHZGE+hGb0u5oTRcJ1nV6DzZMJl6Li6YK5deBbxWiRC2YYLkgH2AKcYE4yhnDHrchTU=
X-Received: by 2002:a4a:2809:: with SMTP id h9mr13202991ooa.36.1589812459734;
 Mon, 18 May 2020 07:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200517011732.GE24705@shao2-debian> <20200517034739.GO2869@paulmck-ThinkPad-P72>
 <CANpmjNNj37=mgrZpzX7joAwnYk-GsuiE8oOm13r48FYAK0gSQw@mail.gmail.com> <CANpmjNMx0+=Cac=WvHuzKb2zJvgNVvVxjo_W1wYWztywxDKeCQ@mail.gmail.com>
In-Reply-To: <CANpmjNMx0+=Cac=WvHuzKb2zJvgNVvVxjo_W1wYWztywxDKeCQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 18 May 2020 16:34:07 +0200
Message-ID: <CANpmjNPcOHAE5d=gaD327HqxTBegf75qeN_pjoszahdk6_i5=Q@mail.gmail.com>
Subject: Re: [rcu] 2f08469563: BUG:kernel_reboot-without-warning_in_boot_stage
To:     kan.liang@linux.intel.com,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Mon, 18 May 2020 at 14:44, Marco Elver <elver@google.com> wrote:
>
> [+Cc clang-built-linux FYI]
>
> On Mon, 18 May 2020 at 12:11, Marco Elver <elver@google.com> wrote:
> >
> > On Sun, 17 May 2020 at 05:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Sun, May 17, 2020 at 09:17:32AM +0800, kernel test robot wrote:
> > > > Greeting,
> > > >
> > > > FYI, we noticed the following commit (built with clang-11):
> > > >
> > > > commit: 2f08469563550d15cb08a60898d3549720600eee ("rcu: Mark rcu_state.ncpus to detect concurrent writes")
> > > > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2020.05.14c
> > > >
> > > > in testcase: boot
> > > >
> > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> > > >
> > > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > >
> > > >
> > > >
> > > >
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > >
> > > >
> > > > [    0.054943] BRK [0x05204000, 0x05204fff] PGTABLE
> > > > [    0.061181] BRK [0x05205000, 0x05205fff] PGTABLE
> > > > [    0.062403] BRK [0x05206000, 0x05206fff] PGTABLE
> > > > [    0.065200] RAMDISK: [mem 0x7a247000-0x7fffffff]
> > > > [    0.067344] ACPI: Early table checksum verification disabled
> > > > BUG: kernel reboot-without-warning in boot stage
> > >
> > > I am having some difficulty believing that this commit is at fault given
> > > that the .config does not list CONFIG_KCSAN=y, but CCing Marco Elver
> > > for his thoughts.  Especially given that I have never built with clang-11.
> > >
> > > But this does invoke ASSERT_EXCLUSIVE_WRITER() in early boot from
> > > rcu_init().  Might clang-11 have objections to early use of this macro?
> >
> > The macro is a noop without KCSAN. I think the bisection went wrong.
> >
> > I am able to reproduce a reboot-without-warning when building with
> > Clang 11 and the provided config. I did a bisect, starting with v5.6
> > (good), and found this:
> > - Since v5.6, first bad commit is
> > 20e2aa812620439d010a3f78ba4e05bc0b3e2861 (Merge tag
> > 'perf-urgent-2020-04-12' of
> > git://git.kernel.org/pub/scm/linux/kernel//git/tip/tip)
> > - The actual commit that introduced the problem is
> > 2b3b76b5ec67568da4bb475d3ce8a92ef494b5de (perf/x86/intel/uncore: Add
> > Ice Lake server uncore support) -- reverting it fixes the problem.

Some more clues:

1. I should have noticed that this uses CONFIG_KASAN=y.

2. Something about function icx_uncore_mmio_init(). Making it a noop
also makes the issue go away.

3. Leaving icx_uncore_mmio_init() a noop but removing the 'static'
from icx_mmio_uncores also presents the issue. So this seems to be
something about how/where icx_mmio_uncores is allocated.

Thanks,
-- Marco
