Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C757DC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B497246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582887521;
	bh=MIJgYe6dv/WBQVWKYJzvlFL9bzufzsvz7PkOFfl8pEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oWJMMiBiOGS+EZBvl1NkhlS9gUwu6TIqcdoywKoccYeoygmhiMtXKFKlL/ETLtgCu
	 BLL66I2GpBHdfZGJVZ4C4APSVH7IaHF2njgooq6258NTBj2mUyQSzSlwoIERwsw2t7
	 nIa4tN0+3JjNfivIUJmcIWFloqsxsosCm6aNGsdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgB1K6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:58:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgB1K6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:58:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E6C246A3;
        Fri, 28 Feb 2020 10:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582887519;
        bh=MIJgYe6dv/WBQVWKYJzvlFL9bzufzsvz7PkOFfl8pEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EoF37kjFTgntKHlBIO2lJSAN2jOpUE4lw3Amu3rbrSpg5k+edyuw6yTCcDTZfhkbX
         LkxvfnJsDwwX2MPBkbvdtg1GQcb6DK/9Vhs4L4DjShDy2u1x1KIcA3kfCrzeJZ3J+z
         bqg61fom5lRjLgG21dQjrBFx0tUl7sZHP1xZJjig=
Date:   Fri, 28 Feb 2020 11:58:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20200228105836.GA2913504@kroah.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 11:04:16AM +0100, Petr Mladek wrote:
> On Fri 2020-02-28 12:13:06, Sergey Senozhatsky wrote:
> > Cc-ing Petr, Steven, John
> > 
> > https://lore.kernel.org/lkml/e9358218-98c9-2866-8f40-5955d093dc1b@camlintechnologies.com
> > 
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
> 
> I am afraid that the patch creates some mess via the non-initialized
> per-cpu variable.
> 
> I see that x86 has some support for EARLY_PER_CPU stuff but it seems
> to be arch-specific.
> 
> I do not see a reliable way to detect when per-cpu variables are
> initialized. Adding Tejun and PeterZ into CC if they have any
> idea.
> 
> I suggest to revert the patch until we have some easy and safe solution.

Ok, I'll do so, but why is this not an issue in 5.4.y and newer kernels?

thanks,

greg k-h
