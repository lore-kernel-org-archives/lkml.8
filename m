Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E11C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E894246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTTCHN+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgB1Ltd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:49:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36524 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgB1Ltc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:49:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id d9so1402916pgu.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 03:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=U3pHOuJb0ju4jiJmCskuoMjXTXKXx52qYRwMZ11bDBk=;
        b=OTTCHN+YF7FmuTbE1M2H8fAjKLLEY5Vf3DYPEKLeCADnRf63/h1Io9h2TWdWaZkSTH
         wmei7WFFB7K3F9nZhDK/+ZiexQCF7zxujEr6oGDFEau7ldo61L33uuXLgqGzMT8jq3yO
         +q4baDUeUlZULqhWrhq5IovpXASWqckpeetKtVozHeErSeIuVpNyQkfa3WOARoLBeSQE
         a6Vo3irXw2SV5EPiow/3x47Jqa1QXHpFv0N3WXo4Ok8T2GJPvIIaQS1sCc4gBhb3Cp7S
         GiNOaO/xAP7XaRGxV7leo8sDyqbA4WIy40AQ4BrlpMnX6Kq30Y9vn8WSNUUoypINkEy0
         w5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=U3pHOuJb0ju4jiJmCskuoMjXTXKXx52qYRwMZ11bDBk=;
        b=X22hqJMLl+L5mHkMvk9LRFv6ks18uggpT5Nd4umB0HZycJ7qt0SI3Jm9N1rdlfObrr
         fhQcYLaA6+obyouhkRpsUp9bOd8YlZq3vgX2V1y/53JIXqqlV8vtn7FOfzSyKNozSl4f
         AuwjurzK3YxPmtuYJwGIq+T4xT8jWMynIpBYw9/8nrCU+uF5LCR4wVuw4BXyUh3/fS9P
         grxl8wsV7UGvI8kcymJi5b9g/wNRg2CgwsZ+wmGkQFex+lozL90fdW78YxHE4zYeKdWQ
         36ANVjx0KE58datr2zbfbceUoHFTYcXc+xom1jG6g4EkPqzysQrh6s4ueXUiEy4TxcUG
         pdZw==
X-Gm-Message-State: APjAAAU4BGCeZassJQu9ldWwtc6vD9mhcmGKHeQiU1W/Z4mLGrFMLaUM
        yld3gttTSs4QBgCHjCAccwY=
X-Google-Smtp-Source: APXvYqwY3TOgVbpko+ZHVwjOxc/bneusiFNMwrnZjpd6Rjkk5ANEJbP0Yy2w4WtjkkYYLClq86CYDw==
X-Received: by 2002:a62:1883:: with SMTP id 125mr4001917pfy.166.1582890571777;
        Fri, 28 Feb 2020 03:49:31 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id l8sm2158023pjy.24.2020.02.28.03.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 03:49:30 -0800 (PST)
Date:   Fri, 28 Feb 2020 20:49:28 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>,
        John Ogness <john.ogness@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Regression in v4.19.106 breaking waking up of readers of
 /proc/kmsg and /dev/kmsg
Message-ID: <20200228114928.GB121952@google.com>
References: <aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com>
 <20200227123633.GB962932@kroah.com>
 <42d3ce5c-5ffe-8e17-32a3-5127a6c7c7d8@camlintechnologies.com>
 <e9358218-98c9-2866-8f40-5955d093dc1b@camlintechnologies.com>
 <20200228031306.GO122464@google.com>
 <20200228100416.6bwathdtopwat5wy@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200228100416.6bwathdtopwat5wy@pathway.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/28 11:04), Petr Mladek wrote:
> > On (20/02/27 14:08), Lech Perczak wrote:
> > > W dniu 27.02.2020 o 13:39, Lech Perczak pisze:
> > > > W dniu 27.02.2020 o 13:36, Greg Kroah-Hartman pisze:
> > > >> On Thu, Feb 27, 2020 at 11:09:49AM +0000, Lech Perczak wrote:
> > > >>> Hello,
> > > >>>
> > > >>> After upgrading kernel on our boards from v4.19.105 to v4.19.106 we found out that syslog fails to read the messages after ones read initially after opening /proc/kmsg just after booting.
> > > >>> I also found out, that output of 'dmesg --follow' also doesn't react on new printks appearing for whatever reason - to read new messages, reopening /proc/kmsg or /dev/kmsg was needed.
> > > >>> I bisected this down to commit 15341b1dd409749fa5625e4b632013b6ba81609b ("char/random: silence a lockdep splat with printk()"), and reverting it on top of v4.19.106 restored correct behaviour.
> > > >> That is really really odd.
> > > > Very odd it is indeed.
> > > >>> My test scenario for bisecting was:
> > > >>> 1. run 'dmesg --follow' as root
> > > >>> 2. run 'echo t > /proc/sysrq-trigger'
> > > >>> 3. If trace appears in dmesg output -> good, otherwise, bad. If trace doesn't appear in output of 'dmesg --follow', re-running it will show the trace.
> > > >>>
> 
> I have reproduced the problem with a kernel based on v4.19.106
> and I see the following in the log:
> 
> [    0.028250] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.028263] random: get_random_bytes called from start_kernel+0x9e/0x4f6 with crng_init=0
> [    0.028268] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
> [    0.028407] percpu: Embedded 44 pages/cpu s142216 r8192 d29816 u524288
> [    0.028411] pcpu-alloc: s142216 r8192 d29816 u524288 alloc=1*2097152
> [    0.028412] pcpu-alloc: [0] 0 1 2 3 
> 
> Note that percpu stuff is initialized after printk_deferred(). And the
> deferred console is scheduled by:
> 
> void defer_console_output(void)
> {
> 	preempt_disable();
> 	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
> 	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
> 	preempt_enable();
> }

Thanks.
I thought about "per-CPU printk() stuff happening too early", but
couldn't figure out why would it cause any problems later, when we
have everything setup and working.

Note that we test printk_safe_irq_ready only before irq_work_queue(), but
otherwise we access per-CPU printk_context. Theoretically we also can touch
per-CPU printk_context or even printk() to per-CPU buffer "too early".

> I am afraid that the patch creates some mess via the non-initialized
> per-cpu variable.

We have `printk_safe_irq_ready' for printk() related irq_work. Maybe
we can use it in printk.c as well. We never know when printk_deferred()
may trigger, so this type of problems can repeat.

	-ss
