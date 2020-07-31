Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B487C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4AC2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+9UYRQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgGaQXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbgGaQXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:23:18 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CADC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:23:18 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id t23so20221023qto.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mR36arX/9jjctMvBDkDHGxDZY/0P9pHSk/hLgHVZnc=;
        b=D+9UYRQOpGBiqVPwvtNz1TrvIuBNYgvOH4AFWWL2/WDA2tAneesOTOreEqWNlhun1z
         MPKR5b/3CElWHnaesmAqqvqVjKliTIgV2qGx/0YzOWQC5WvLLtMOdA3m8bjSxuL8D+iM
         sXXGd4cilyGeEV9D4WClXHqUvDdkbBghPDvnfCsw6enhWdKUxZM7mgkJYYh6vlzbQxdr
         bGIwFtBLJDGSw6ZbPNInAUDFaF94ssqejoCuGA5tk6saalXiNzm7SGcCHCTWZPUNH0rL
         5v0BMxlNGnDRqI3fzE93Pdw4YJdzUOwQH4ZoGkycRy0yliTxobToR9fJYbPIsrOfgqmP
         uD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mR36arX/9jjctMvBDkDHGxDZY/0P9pHSk/hLgHVZnc=;
        b=mh5NPe2fnmJg75/vdYjJMUr1HQ7smtYpfi5BtcbTDeDe7u+RL4X1m+vvgat1V2/jKL
         gRKmC+jBCp4uC3fNsnITs5UwgIrz+zSTe/LEkoUWu4ru34f9xPr7FGvMlLSzndIe3Y0s
         EqiNpY166D7OWavB5cQRmrQ54jwPgWqwEv+N8RzP4iUWGsSwBzXw2IrrK8BPgpMpzMlk
         Ud3HzBgL2dTG6lq2dTWxTlCqK86oKVNmIOMgMeAAraA1NNv+hIADLONngJM366p6uXHI
         YERwg9L2W1lW1AhAj+6vks1EFgMGvx+hLr7UdM0UFI64N5PsgujXivNZ3xF+3vxg2ONI
         vikA==
X-Gm-Message-State: AOAM531IsTXOM6SiQGBUVk7Oi5yX6cHKp1YwKhZd+ieZCPtFBdTAnE95
        noxO3FjeQFTPLgJwyZfwpq0Jx6m3daZ0QWUf2vt2Wg==
X-Google-Smtp-Source: ABdhPJzxM7U4vluJYzcXoS2aI9zC6/TZ514XHvQe5eMODJEw5z/AbMDAtjIRyPBtMrB068GE3S/ihHcIBbR19+7NnTQ=
X-Received: by 2002:ac8:7609:: with SMTP id t9mr4437428qtq.158.1596212597443;
 Fri, 31 Jul 2020 09:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000060adcb05abb71eb6@google.com> <CACT4Y+ZnHF_b6hKQ_npjJ2fW7atZ7sP8WeGh-TDhu9UB0dcnPQ@mail.gmail.com>
 <7e93543a-ff0c-2433-7bed-4053da59d5c2@infradead.org> <CACT4Y+avpJJdHBg2nKJ7CUON-8q9bqSnrAM=gHMJGVhvSrmnDw@mail.gmail.com>
In-Reply-To: <CACT4Y+avpJJdHBg2nKJ7CUON-8q9bqSnrAM=gHMJGVhvSrmnDw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 31 Jul 2020 18:23:05 +0200
Message-ID: <CACT4Y+Y5QSbgiLhPuv+1vKfSjanF0_p80Pr6GVWPuVwwEzSExA@mail.gmail.com>
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

On Fri, Jul 31, 2020 at 6:21 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Jul 31, 2020 at 6:08 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 7/30/20 11:50 PM, Dmitry Vyukov wrote:
> > > On Fri, Jul 31, 2020 at 8:44 AM syzbot
> > > <syzbot+8472ea265fe32cc3bf78@syzkaller.appspotmail.com> wrote:
> > >>
> > >> Hello,
> > >>
> > >> syzbot found the following issue on:
> > >>
> > >> HEAD commit:    92ed3019 Linux 5.8-rc7
> > >> git tree:       upstream
> > >> console output: https://syzkaller.appspot.com/x/log.txt?x=10e84cdf100000
> > >> kernel config:  https://syzkaller.appspot.com/x/.config?x=b45e47f6d958ae82
> > >> dashboard link: https://syzkaller.appspot.com/bug?extid=8472ea265fe32cc3bf78
> > >> compiler:       gcc (GCC) 10.1.0-syz 20200507
> > >>
> > >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > >> Reported-by: syzbot+8472ea265fe32cc3bf78@syzkaller.appspotmail.com
> > >
> > > This is a qemu-kvm instance killing the host kernel somehow, the host
> > > kernel itself running qemu's is full of rcu stalls. I think this is
> > > not a bug in the tested kernel.
> > > We change rcu stall timeout to 120 seconds from the default 21s, but
> > > this happens only after boot using sysctls. I did not find any way to
> > > change the rcu timeout via cmdline/config (would be useful).
> >
> > (adding Paul)
> >
> >
> > Documentation/RCU/stallwarn.rst says there is a Kconfig:
> >
> > CONFIG_RCU_CPU_STALL_TIMEOUT
> >
> >         This kernel configuration parameter defines the period of time
> >         that RCU will wait from the beginning of a grace period until it
> >         issues an RCU CPU stall warning.  This time period is normally
> >         21 seconds.
> >
> > and Documentation/admin-guide/kernel-parameters.txt has 2 RCU stall timeouts,
> > one for CPU and one for tasks:
> >
> >         rcupdate.rcu_cpu_stall_timeout= [KNL]
> >                         Set timeout for RCU CPU stall warning messages.
> >
> >         rcupdate.rcu_task_stall_timeout= [KNL]
> >                         Set timeout in jiffies for RCU task stall warning
> >                         messages.  Disable with a value less than or equal
> >                         to zero.
>
> Hi Randy,
>
> Thanks for looking into this.
> But I think I messed things up.  The config  has
> CONFIG_RCU_CPU_STALL_TIMEOUT=100, but this is not an RCU stall:
>
> watchdog: BUG: soft lockup - CPU#3 stuck for 21s! [grep:4749]
>
> This is what is controlled by kernel.watchdog_thresh sysctl (?).

And there is actually a cmdline parameter for this:

static int __init watchdog_thresh_setup(char *str)
{
    get_option(&str, &watchdog_thresh);
    return 1;
}
__setup("watchdog_thresh=", watchdog_thresh_setup);

I will write it down somewhere.
