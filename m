Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580BBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358DE20709
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NAgCEJ2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgERKLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgERKLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:11:19 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9465C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:11:18 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g25so1826320otp.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p5V2TDyBbMYSJ79LXCJ9ta9ZzOnmwcoM0FRidOCjFOk=;
        b=NAgCEJ2LCYHDH+8dNut5e6WNjfiijwMLoq4fE/lTpjdL1VSecApet2i66qYHhuGoyF
         eGpHNdo/eYZHhP85JM3KXaZzJcz9eb9Re3fD1ZucaWHmm+LSeweg5w3kzIj0pdQO2OT/
         4E1IgB5pteWYvkMKJyH+uVjVhQQmjyPiruXFrgFjWe9pg5dX37d7gN2AU0Fiig5y//QM
         S675vB5wG3K+SWXy/ts0Biy6gtI845BHe2ooVAcc8J3Q3mfla/q5w4Wiu3S72Fzh3yQF
         lXSZmpEQCKkOobxTU32MxWGIf+L7MoUg86xK9u0p0d5ZD9roZHggSdHj8xr4cladYi6m
         r08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5V2TDyBbMYSJ79LXCJ9ta9ZzOnmwcoM0FRidOCjFOk=;
        b=AkYwDWYtsFKEqA+FrXNTjq3iIQMjjFqLpf4TQ8k4/UoQePQiMMQ9ycmqUUsRR6Aj52
         ObXLjJgJSB+uFE53axI5ARaQDnc5/njSk4CLKgM0c28KMRYB5jtft11YCYJ1MOEFLQtx
         sKi4iIH1j6Ze/yshphT7U3w//U2JKtZ5OLWPcfSbb++dBe9kaGDsk8kebV9L/SA9kppE
         MLe/Pfirs9MBgSzN0ID2xS4zNF5a1IhEvkgbFRhlUXRoi3sz/9uv5OfqzninBZ5PusbB
         lXPUYG1m4VwISAMUWAWr6fekUYGeIN6gCvYUUGumEZM8f+f6LDSTeNF3RHy5eJZzAq74
         c2lw==
X-Gm-Message-State: AOAM530/2beDGobPnKQ7fxOMhH5FLRkAxRqf6pRQGHUs8hoXtDq2vkUA
        Ir/EG0PnzFVUqDFhKIMJuDSXssb4cVlKIyYGjqMaRWMKz5M=
X-Google-Smtp-Source: ABdhPJwzIzwO9ZDQ1VzPd04pZH5Sdmi7B2GjJ4TBR+lKOBljWJnXQPwsvIdflq/GKDbT3dsUapt94I+39/Ofmy7tZio=
X-Received: by 2002:a9d:7608:: with SMTP id k8mr12514193otl.233.1589796677877;
 Mon, 18 May 2020 03:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200517011732.GE24705@shao2-debian> <20200517034739.GO2869@paulmck-ThinkPad-P72>
In-Reply-To: <20200517034739.GO2869@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Mon, 18 May 2020 12:11:06 +0200
Message-ID: <CANpmjNNj37=mgrZpzX7joAwnYk-GsuiE8oOm13r48FYAK0gSQw@mail.gmail.com>
Subject: Re: [rcu] 2f08469563: BUG:kernel_reboot-without-warning_in_boot_stage
To:     "Paul E. McKenney" <paulmck@kernel.org>, kan.liang@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 May 2020 at 05:47, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, May 17, 2020 at 09:17:32AM +0800, kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed the following commit (built with clang-11):
> >
> > commit: 2f08469563550d15cb08a60898d3549720600eee ("rcu: Mark rcu_state.ncpus to detect concurrent writes")
> > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2020.05.14c
> >
> > in testcase: boot
> >
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> >
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> >
> >
> > [    0.054943] BRK [0x05204000, 0x05204fff] PGTABLE
> > [    0.061181] BRK [0x05205000, 0x05205fff] PGTABLE
> > [    0.062403] BRK [0x05206000, 0x05206fff] PGTABLE
> > [    0.065200] RAMDISK: [mem 0x7a247000-0x7fffffff]
> > [    0.067344] ACPI: Early table checksum verification disabled
> > BUG: kernel reboot-without-warning in boot stage
>
> I am having some difficulty believing that this commit is at fault given
> that the .config does not list CONFIG_KCSAN=y, but CCing Marco Elver
> for his thoughts.  Especially given that I have never built with clang-11.
>
> But this does invoke ASSERT_EXCLUSIVE_WRITER() in early boot from
> rcu_init().  Might clang-11 have objections to early use of this macro?

The macro is a noop without KCSAN. I think the bisection went wrong.

I am able to reproduce a reboot-without-warning when building with
Clang 11 and the provided config. I did a bisect, starting with v5.6
(good), and found this:
- Since v5.6, first bad commit is
20e2aa812620439d010a3f78ba4e05bc0b3e2861 (Merge tag
'perf-urgent-2020-04-12' of
git://git.kernel.org/pub/scm/linux/kernel//git/tip/tip)
- The actual commit that introduced the problem is
2b3b76b5ec67568da4bb475d3ce8a92ef494b5de (perf/x86/intel/uncore: Add
Ice Lake server uncore support) -- reverting it fixes the problem.

Thanks,
-- Marco
