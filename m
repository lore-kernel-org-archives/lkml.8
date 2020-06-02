Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URG_BIZ,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3A0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1868620679
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgFBJ6F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:58:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44165 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgFBJ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:58:04 -0400
Received: by mail-oi1-f196.google.com with SMTP id x202so11039804oix.11;
        Tue, 02 Jun 2020 02:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iyewGMkXuJg3DmH4dw7+D04mCzZJepxSb898orAzqYE=;
        b=WqC7ap9kSJWq9edwz1WCwhEyaNVw6XWb63nI9Qb533drLQUp//cO3O3JWDyiBGCiLo
         HX6s8Fav5SoxNaOF5Cy5gqf1p1qCT9vo3QXmdGtG0AS1Yq519pnqQd9O+CSxpi4njx1O
         i8OTFau0hprYj5FLjf+An65WJsIQ3xB51jWOhBLEcUpT/ar1phLilcQ9K+vHNcqb6BO+
         2LnrwuKxeBablFahh5zNt1/OXog3lf2Pz6QI7cexyyxEbptTIjawqx5LYt+JHxUKxJX2
         uh0+UQ6KgeKNV7qRy/OBSPKmAfr7YeFMD0yZof2xzQm1wNumEGami4rcABgGbVcgawS6
         i2Ow==
X-Gm-Message-State: AOAM530SLwhAiEqvmtrvEjgzG0s9t20ddx4cFando6W7Uuad2rAq3dmG
        awoRBgrsioX1Lg5BXFJsOu6ApeZYkJ+u1EBdp34=
X-Google-Smtp-Source: ABdhPJyvmRip82nf1YTS55HK8PTzXOrpeX0lgVwXjy8zq0flE3jPmfLBFLzpm3mGBvRwgejHWjZu3JNklv6lc9+XOPY=
X-Received: by 2002:aca:210a:: with SMTP id 10mr2284816oiz.153.1591091882187;
 Tue, 02 Jun 2020 02:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <158923078019.390.12609597570329519463.tip-bot2@tip-bot2>
 <20200526182744.GA3722128@gmail.com> <20200526191408.GN2869@paulmck-ThinkPad-P72>
In-Reply-To: <20200526191408.GN2869@paulmck-ThinkPad-P72>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Jun 2020 11:57:51 +0200
Message-ID: <CAMuHMdUfsGSWco5rEidmPmZBH+PbUVq3tyXu=cc67x-X5LyXpA@mail.gmail.com>
Subject: Re: [PATCH] rcu/performance: Fix kfree_perf_init() build warning on
 32-bit kernels
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, May 26, 2020 at 9:17 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> On Tue, May 26, 2020 at 08:27:44PM +0200, Ingo Molnar wrote:
> > * tip-bot2 for Joel Fernandes (Google) <tip-bot2@linutronix.de> wrote:
> >
> > > The following commit has been merged into the core/rcu branch of tip:
> > >
> > > Commit-ID:     f87dc808009ac86c790031627698ef1a34c31e25
> > > Gitweb:        https://git.kernel.org/tip/f87dc808009ac86c790031627698ef1a34c31e25
> > > Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
> > > AuthorDate:    Mon, 16 Mar 2020 12:32:26 -04:00
> > > Committer:     Paul E. McKenney <paulmck@kernel.org>
> > > CommitterDate: Mon, 27 Apr 2020 11:02:50 -07:00
> > >
> > > rcuperf: Add ability to increase object allocation size
> > >
> > > This allows us to increase memory pressure dynamically using a new
> > > rcuperf boot command line parameter called 'rcumult'.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  kernel/rcu/rcuperf.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> > > index a4a8d09..16dd1e6 100644
> > > --- a/kernel/rcu/rcuperf.c
> > > +++ b/kernel/rcu/rcuperf.c

> > > @@ -722,6 +723,8 @@ kfree_perf_init(void)
> > >             schedule_timeout_uninterruptible(1);
> > >     }
> > >
> > > +   pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
> >
> > There's a new build warning on certain 32-bit kernel builds due to
> > this commit:
> >
> > In file included from ./include/linux/printk.h:7,
> >                  from ./include/linux/kernel.h:15,
> >                  from kernel/rcu/rcuperf.c:13:
> > kernel/rcu/rcuperf.c: In function ‘kfree_perf_init’:
> > ./include/linux/kern_levels.h:5:18: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘unsigned int’ [-Wformat=]
> >     5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
> >       |                  ^~~~~~
> > ./include/linux/kern_levels.h:9:20: note: in expansion of macro ‘KERN_SOH’
> >     9 | #define KERN_ALERT KERN_SOH "1" /* action must be taken immediately */
> >       |                    ^~~~~~~~
> > ./include/linux/printk.h:295:9: note: in expansion of macro ‘KERN_ALERT’
> >   295 |  printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
> >       |         ^~~~~~~~~~
> > kernel/rcu/rcuperf.c:726:2: note: in expansion of macro ‘pr_alert’
> >   726 |  pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
> >       |  ^~~~~~~~
> > kernel/rcu/rcuperf.c:726:32: note: format string is defined here
> >   726 |  pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
> >       |                              ~~^
> >       |                                |
> >       |                                long unsigned int
> >       |                              %u

This issue is now upstream.

> > The reason for the warning is that both kfree_mult and sizeof() are
> > 'int' types on 32-bit kernels, while the format string expects a long.

sizeof() is of type size_t, which is either unsigned int (32-bit) or
unsigned long (64-bit).
Hence the result of the multiplication is also of type size_t.

> >
> > Instead of casting the type to long or tweaking the format string, the
> > most straightforward solution is to upgrade kfree_mult to a long.
> > Since this depends on CONFIG_RCU_PERF_TEST

So the proper fix is Kefeng's patch from April:
"[PATCH -next] rcuperf: Fix printk format warning"
https://lore.kernel.org/r/20200417040245.66382-1-wangkefeng.wang@huawei.com

":"--
> Makes sense, and I have queued the patch below, which I am assuming
> that you want in the upcoming merge window.  If you don't tell me
> otherwise, I will send you an urgent pull request later today.
> Or, if you just put it directly into -tip yourself:
>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>
> Either way, please let me know.
>
> > BTW., could we please also rename this code from 'PERF_TEST'/'perf test'
> > to 'PERFORMANCE_TEST'/'performance test'? At first glance I always
> > mistakenly believe that it's somehow related to perf, while it isn't. =B-)
>
> Fair enough, especially given that perf was there first and is also way
> more heavily used.  ;-)
>
> But I am guessing that this one is OK for the v5.9 merge window.
> Either way, I will update as you say.
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 2fbc7d67a2ed108e3ac63296670fecb3a42fddd0
> Author: Ingo Molnar <mingo@kernel.org>
> Date:   Tue May 26 12:10:01 2020 -0700
>
>     rcuperf: Fix kfree_mult to match printk() format
>
>     This commit changes the type of kfree_mult from int to long in order
>     to match the printk() format on 32-bit systems.
>
>     Reported-by: kbuild test robot <lkp@intel.com>
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index d906ca9..fb3a1f0 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -93,7 +93,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
>  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
>  torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
>  torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
> -torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
> +torture_param(long, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
>
>  static char *perf_type = "rcu";
>  module_param(perf_type, charp, 0444);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
