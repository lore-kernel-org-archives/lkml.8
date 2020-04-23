Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5192DC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B28F206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BTr1Wi4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbgDWR6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgDWR6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:58:45 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381D9C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:58:45 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id i27so7625596ota.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfTuN1GL8FeDNGb9kVTe6ZjLhJdk6HBFvGUQWKfTZaw=;
        b=BTr1Wi4pt3CKPmc7eUWoYsjYOlCXW+9iFUIOKas6l/QvDPwXPtE0kDU0KOACjOgc6F
         3e8Fvecfp5+5Arl6svwNLtfBHCnElBvOlAHABbY80B27DPZSYBpaPF4gydIDYcB+/IZ0
         jPebPdOFlEOVPo3A7S+5NcPyh+onQKu7YIiL8UUyHBGwnLzR+nlsLeqZ9uz8chfx7Vcp
         +WeLr9iVCINd8JoBK2yliJsH8UE/JmH7bde0WqRLL7KRFlx8/1zfpVF2LTqdSnGQLZFH
         Bj1kDDzmNW+WSh6NdjXFmmkjt/nepry9y4gS+PLqrT9Wy4tqxyTGUV6RuOAnFogoA7Aj
         gD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfTuN1GL8FeDNGb9kVTe6ZjLhJdk6HBFvGUQWKfTZaw=;
        b=M/ye5iV6oKWkzUKMmxGAyAgigofbwqD4/QJQRD64ZDgZ2b9pOkOzondumtYFRkE/Bq
         QJRCoe/vzAPklKQ6BiNeXe2GcYPSU+bSibQLLmzHFfHmszhaba3f8yUp/uCVlj0/V+fB
         svzEQTBCPuQdetecXRWDWkh9l4rYN4X5yiZLRrzJp29Cf0GiAKDHOdp7a4wXYmBpL9bi
         ZUYYfwW0PGliPG6v9x08rU9U31S2sML8H05DvWsMcgmI9TnZ6xb8SPeC70AHGIeVTM22
         /u7ath2svjtVl0L4whzWKcpgCJQPqhD40GbqETRVH6/otMmvjVsd+at+Su9ke063KLO5
         XD/w==
X-Gm-Message-State: AGi0Puau89uVj6rfHDAJRIwc+z32W4/AjaQpGdnjV0bCxivjxzflXq44
        BhnkI+RYQM/72w0kT99cmn2YSu31WHceAio9/D/8NA==
X-Google-Smtp-Source: APiQypJGsZZdVAlUvsMum7KWXfeDMIl50YF/tvwOieRFKCZfk5hNZ19j8rsdTXL1UjDvwClRXRtFrsYzlUnJqgj3O70=
X-Received: by 2002:a54:4f02:: with SMTP id e2mr4120853oiy.10.1587664724608;
 Thu, 23 Apr 2020 10:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLURuJ-tMxMY6Z2BvLmyd6X+w7SiSB5otoH6vx+NxJm-NA@mail.gmail.com>
 <jhj8simxgqo.mognet@arm.com> <CALAqxLXGQa-sPjNQV-uXzJLOVMyJtHqdfk0J48dhs+WVbWu+Sw@mail.gmail.com>
In-Reply-To: <CALAqxLXGQa-sPjNQV-uXzJLOVMyJtHqdfk0J48dhs+WVbWu+Sw@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 23 Apr 2020 10:58:33 -0700
Message-ID: <CALAqxLWBxgfFxv_STHnnU75GAQs-S-KQXiReVSaFDK50pjokSw@mail.gmail.com>
Subject: Re: BUG: Invalid wait context with 5.7-rc2?
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 10:29 AM John Stultz <john.stultz@linaro.org> wrote:
>
> On Thu, Apr 23, 2020 at 10:19 AM Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> > On 23/04/20 17:40, John Stultz wrote:
> > > Hey Folks,
> > >
> > > Recently, I've seen some occasional hangs earlyish in boot on my
> > > HiKey960 board with 5.7-rc1/rc2. The kernel isn't totally wedged as I
> > > will see some kernel messages (firmware loading failures, etc) much
> > > later if I leave it.  But oddly sysrq doesn't respond.
> > >
> > > Figuring it must be some sort of deadlock, I added LOCKDEP and a bunch
> > > of other debug options and started booting in a loop. So far I've not
> > > been able to trigger the original problem, but I do see the following
> > > every boot:
> > >
> >
> > Interestingly I can't seem to reproduce that one with the latest master
> > (5.7.0-rc2-00115-g8c2e9790f196). Is that with some of the extra h960
> > patches?
>
> There are additional patches for hikey960, but nothing from the
> tracelog (which looked pretty generic).
> But I'll pull everything out to confirm and re-check against
> linus/master in case there's a recent fix.

Yep. Still seeing it against linus/master with nothing else:
[    2.091225] clocksource: Switched to clocksource arch_sys_counter
[    2.091406]
[    2.098896] =============================
[    2.102942] [ BUG: Invalid wait context ]
[    2.106991] 5.7.0-rc2-00069-g18bf34080c4c #250 Not tainted
[    2.112528] -----------------------------
[    2.116574] swapper/1/0 is trying to lock:
[    2.120710] ffffff82194af258 (&pool->lock){..-.}-{3:3}, at:
__queue_work+0x108/0x7c8
[    2.128550] other info that might help us debug this:
[    2.133649] context-{2:2}
[    2.136290] 1 lock held by swapper/1/0:
[    2.140159]  #0: ffffffc011d049c8 (rcu_read_lock){....}-{1:3}, at:
__queue_work+0x48/0x7c8
[    2.148513] stack backtrace:
[    2.151421] CPU: 1 PID: 0 Comm: swapper/1 Not tainted
5.7.0-rc2-00069-g18bf34080c4c #250
[    2.159593] Hardware name: HiKey960 (DT)
[    2.163554] Call trace:
[    2.166023]  dump_backtrace+0x0/0x1a8
[    2.169719]  show_stack+0x18/0x28
[    2.173066]  dump_stack+0xdc/0x148
[    2.176500]  __lock_acquire+0x5c0/0x1568
[    2.180458]  lock_acquire+0x100/0x378
[    2.184159]  _raw_spin_lock+0x64/0x108
[    2.187942]  __queue_work+0x108/0x7c8
[    2.191637]  queue_work_on+0xd0/0xf0
[    2.195248]  timers_update_nohz+0x28/0x38
[    2.199296]  tick_setup_sched_timer+0x110/0x178
[    2.203870]  hrtimer_run_queues+0x114/0x170
[    2.208092]  run_local_timers+0x30/0x70
[    2.211963]  update_process_times+0x28/0x58
[    2.216189]  tick_periodic+0x48/0x148
[    2.219884]  tick_handle_periodic+0x28/0xc8
[    2.224112]  arch_timer_handler_phys+0x2c/0x50
[    2.225533] VFS: Disk quotas dquot_6.6.0
[    2.228600]  handle_percpu_devid_irq+0xe0/0x460
[    2.228605]  generic_handle_irq+0x30/0x48
[    2.228608]  __handle_domain_irq+0x88/0xf8
[    2.228613]  gic_handle_irq+0x5c/0xb0
[    2.228619]  el1_irq+0xf4/0x1c0
[    2.232654] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.237146]  arch_cpu_idle+0x2c/0x230
[    2.237151]  default_idle_call+0x20/0x44
[    2.237156]  do_idle+0x1ec/0x2d0
[    2.237159]  cpu_startup_entry+0x24/0x48
[    2.241701] pnp: PnP ACPI: disabled
[    2.245338]  secondary_start_kernel+0x160/0x210
