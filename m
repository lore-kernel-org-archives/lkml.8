Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3740CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E1A92177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jWO1CmEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbgGaQVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgGaQVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:21:18 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3696C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:21:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j187so29233746qke.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BnIa4h+eeC65N1AqrnaLZXagsmYECUrJzGzZA8l9Vog=;
        b=jWO1CmEEhnw0GFq2OGvufPGk74NyxUfeygR337leqjqyHX4cyFb81nafYu2ISO6mj1
         bU5yB46TG4Lyu0nT17FkUlS4FEC/JQnEAN8htPljg4bg8AKhsUHt9t+dugohNeBUyLBF
         jV1ybypWdVjh7uP7iWZuksUVxHYPx00u9roi2nMM3jj9F8D0rVJDlBh/41uDgIUYFvfH
         iZLbN9nEwcOaJnDzsyhciZBy/x8OUpy6lPDmuXkrvqN5lqylZmkDQBlZob/inNUKYzuQ
         MXX9lEkhuieTaQaPGkEvM73sH4YqIaESYsAOfurCwacisP0IrvShQq3TbI1SuZh4nGnA
         LhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnIa4h+eeC65N1AqrnaLZXagsmYECUrJzGzZA8l9Vog=;
        b=Bo2Atbyu9bzxJX1x0iMYmW9Z+jlV9noemeeYTbHrpXJH6RYvH64k4627+d6c9p/F71
         97kItOZ2U53xFMtYRW3JXrT2wi0YfbWmFHz5dLDF18RZba5cZk7G8kv0Q3yIuvjQZNwD
         qmrTvFDa68eR6ZhksUpfYHN14wjS6mQEuig+ey3o/bfaZ1xwGLjhwpN+UiD9F1eoykFV
         BOslIbn9pzaHuBOtoIttwLHrdaK9lD7yt6pbvp9uOCfmg0fht3OhgvIy29Ge2zbDJ7wl
         Bp0Ok7IhwN1hU8ory5/NXV4nIR82NE130AnSK82I1ChVgYX3YUIKojHoSJHES/jGawEM
         3+Pg==
X-Gm-Message-State: AOAM530a/k8sOT4Bk/C4LkpIX7g6L7CeRAAx8SqonD/bdomztwdhXAHF
        RqpyNOCa14gTvQx+WkyEpc5Cp9jCyUz+1P4BivSiPQ==
X-Google-Smtp-Source: ABdhPJxHdU0D5+yEm1ZJI+QkfXeJAK1ymL+C8OV8jdH6euBe6tZIUHhWHgBV+3Tvo3lqCfUUMcFYKNf4ZCNwx61rWt8=
X-Received: by 2002:a37:8241:: with SMTP id e62mr4980469qkd.250.1596212476932;
 Fri, 31 Jul 2020 09:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000060adcb05abb71eb6@google.com> <CACT4Y+ZnHF_b6hKQ_npjJ2fW7atZ7sP8WeGh-TDhu9UB0dcnPQ@mail.gmail.com>
 <7e93543a-ff0c-2433-7bed-4053da59d5c2@infradead.org>
In-Reply-To: <7e93543a-ff0c-2433-7bed-4053da59d5c2@infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 31 Jul 2020 18:21:05 +0200
Message-ID: <CACT4Y+avpJJdHBg2nKJ7CUON-8q9bqSnrAM=gHMJGVhvSrmnDw@mail.gmail.com>
Subject: Re: upstream boot error: BUG: soft lockup in __do_softirq
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     syzbot <syzbot+8472ea265fe32cc3bf78@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 6:08 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 7/30/20 11:50 PM, Dmitry Vyukov wrote:
> > On Fri, Jul 31, 2020 at 8:44 AM syzbot
> > <syzbot+8472ea265fe32cc3bf78@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    92ed3019 Linux 5.8-rc7
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=10e84cdf100000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=b45e47f6d958ae82
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=8472ea265fe32cc3bf78
> >> compiler:       gcc (GCC) 10.1.0-syz 20200507
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+8472ea265fe32cc3bf78@syzkaller.appspotmail.com
> >
> > This is a qemu-kvm instance killing the host kernel somehow, the host
> > kernel itself running qemu's is full of rcu stalls. I think this is
> > not a bug in the tested kernel.
> > We change rcu stall timeout to 120 seconds from the default 21s, but
> > this happens only after boot using sysctls. I did not find any way to
> > change the rcu timeout via cmdline/config (would be useful).
>
> (adding Paul)
>
>
> Documentation/RCU/stallwarn.rst says there is a Kconfig:
>
> CONFIG_RCU_CPU_STALL_TIMEOUT
>
>         This kernel configuration parameter defines the period of time
>         that RCU will wait from the beginning of a grace period until it
>         issues an RCU CPU stall warning.  This time period is normally
>         21 seconds.
>
> and Documentation/admin-guide/kernel-parameters.txt has 2 RCU stall timeouts,
> one for CPU and one for tasks:
>
>         rcupdate.rcu_cpu_stall_timeout= [KNL]
>                         Set timeout for RCU CPU stall warning messages.
>
>         rcupdate.rcu_task_stall_timeout= [KNL]
>                         Set timeout in jiffies for RCU task stall warning
>                         messages.  Disable with a value less than or equal
>                         to zero.

Hi Randy,

Thanks for looking into this.
But I think I messed things up.  The config  has
CONFIG_RCU_CPU_STALL_TIMEOUT=100, but this is not an RCU stall:

watchdog: BUG: soft lockup - CPU#3 stuck for 21s! [grep:4749]

This is what is controlled by kernel.watchdog_thresh sysctl (?).
