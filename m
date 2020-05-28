Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3B7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0DDB20776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404408AbgE1Pbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:31:47 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39993 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404209AbgE1Pbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:31:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id d26so2656800otc.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8RAmBYqicAEf7QIyLzsA7uN+aUAK0BiGPzu0xlZiL6g=;
        b=j9IW22gwPiYG0HZzaYBpx/lAM4KlSTm7cGSyyTAd+YKhL+2fuhRu004lCNhi/0o591
         ADUPGXX7HYaKdH1Ktrl1CM7fdDkHWlEPs1PJuWXyY7Aq/XggfqD/DzRzHHlvzoRVetuJ
         lowbJ0WYgTsy4uYFprJ2unm0R7zjDX6UJsNA23+CklsfRbS4LyR+idS0nJVcjyLTbxPt
         +NM3tvrArmPyugEbWL5V70LCb9/hxFmSiu073Fn7oi/5D5pogr6+ajkU6i8jfcNupqcj
         p6Hmgl24x1p3x0NgVJm9lEt7dUrQ0OvieYVDnUUvdeTmqzXdQPKi4+tnLg3uoz40D2YT
         +X8g==
X-Gm-Message-State: AOAM531I/0Dzo2sZEg/z2iAZk3ic/FZakdZjcsjDJ7YzBvarbtumt8hN
        oPR6xM3d3OaVqiNzcm4cK11lCXw+NDk4xugWTiM=
X-Google-Smtp-Source: ABdhPJyl/v2EheDELtIutnZURbKSbF2p4jvKcpikTz8IPkX1njbHEoL9Rrr7MDsmMzUTSW+eTnzzt2pxKAXJUBxcs2k=
X-Received: by 2002:a9d:7e92:: with SMTP id m18mr2622957otp.145.1590679905088;
 Thu, 28 May 2020 08:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <202005280819.lJ4qjCcP%lkp@intel.com> <CAMuHMdUsD=xGa97tHmHZhohHiEqn5eD0QaOEwGNW7DGibkhB+g@mail.gmail.com>
 <20200528135141.GE2869@paulmck-ThinkPad-P72>
In-Reply-To: <20200528135141.GE2869@paulmck-ThinkPad-P72>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 May 2020 17:31:33 +0200
Message-ID: <CAMuHMdXJOeQuA0+iT27vKAB+pNdrBBzvrfVTV=+cjm9r8=GwVQ@mail.gmail.com>
Subject: Re: [rcu:dev.2020.05.26a 56/72] refperf.c:undefined reference to `__umoddi3'
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, May 28, 2020 at 3:51 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> On Thu, May 28, 2020 at 09:04:38AM +0200, Geert Uytterhoeven wrote:
> > On Thu, May 28, 2020 at 5:26 AM kbuild test robot <lkp@intel.com> wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.05.26a
> > > head:   63fdce1252f16032c9e1eb7244bb674ba4f84855
> > > commit: bd5b16d6c88da451a46d068a25fafad8e83d14a6 [56/72] refperf: Allow decimal nanoseconds
> > > config: m68k-allyesconfig (attached as .config)
> > > compiler: m68k-linux-gcc (GCC) 9.3.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         git checkout bd5b16d6c88da451a46d068a25fafad8e83d14a6
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > >
> > > m68k-linux-ld: kernel/rcu/refperf.o: in function `main_func':
> > > >> refperf.c:(.text+0x762): undefined reference to `__umoddi3'
> > > >> m68k-linux-ld: refperf.c:(.text+0x8f2): undefined reference to `__udivdi3'
> > > m68k-linux-ld: refperf.c:(.text+0x97c): undefined reference to `__udivdi3'
> >
> > | --- a/kernel/rcu/refperf.c
> > | +++ b/kernel/rcu/refperf.c
> > | @@ -375,7 +375,7 @@ static int main_func(void *arg)
> > |                 if (torture_must_stop())
> > |                         goto end;
> > |
> > | -               reader_tasks[exp].result_avg =
> > process_durations(exp) / ((exp + 1) * loops);
> > | +               reader_tasks[exp].result_avg = 1000 *
> > process_durations(exp) / ((exp + 1) * loops);
> >
> > div64_ul() for 64-by-unsigned-long division
>
> Ah, thank you for the explanation!
>
> This is just a performance-test module intended for SMP systems, so
> I don't see much point in making it work on m68k, which looks to be
> UP-only.  But it is clearly useful to prevent the test bots from building
> refperf on m68k.  So one approach would be for me to make its Kconfig
> option depend on SMP.  Another would be to make it depend on 64BIT.
> Still another would be to make it depend on !M68K.
>
> I could potentially dump out the numbers in picoseconds, then
> do the averaging and other division operations in userspace,
> but that is strange enough to cause more trouble than it is worth.
> (An rcu_read_lock()/rcu_read_unlock() pair takes -how- long???)  Though if
> there was some point in running this on m68k, it might be worth it (with
> "PICOSECONDS" in all caps or some such), but in this case it is not.
> But this would probably require more data to be dumped to allow userspace
> to do the operations, increasing the probability of lost printk()s.  :-/
>
> Left to myself, I would take the easy way out and make this depend
> on 64BIT.
>
> But you must have run into this situation before.  Any thoughts?

Oh, this is not just on m68k. I expect the build bots to start complaining
about other 32-bit platforms, too, like i386 and arm32 ;-)

While restricting this to 64BIT will fix the issue, are you sure people
on 32-bit SMP platforms don't want to run this code?

So I'd go for div64_ul() and do_div().

> > |         }
> > |
> > |         // Print the average of all experiments
> > | @@ -386,7 +386,7 @@ static int main_func(void *arg)
> > |         strcat(buf, "Threads\tTime(ns)\n");
> > |
> > |         for (exp = 0; exp < nreaders; exp++) {
> > | -               sprintf(buf1, "%d\t%llu\n", exp + 1,
> > reader_tasks[exp].result_avg);
> > | +               sprintf(buf1, "%d\t%llu.%03d\n", exp + 1,
> > reader_tasks[exp].result_avg / 1000,
> > (int)(reader_tasks[exp].result_avg % 1000));
> >
> > do_div() for 64-by-32 division/modulo

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
