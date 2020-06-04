Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA197C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFAC205CB
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgFDI3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:29:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:57214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgFDI3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:29:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 29F20AC96;
        Thu,  4 Jun 2020 08:29:52 +0000 (UTC)
Date:   Thu, 4 Jun 2020 10:29:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     linux-kernel@vger.kernel.org, chenwandun@huawei.com,
        xiexiuqi@huawei.com, bobo.shaobowang@huawei.com,
        huawei.libin@huawei.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org
Subject: Re: [RFC PATCH] panic: fix deadlock in panic()
Message-ID: <20200604082947.GB22497@linux-b0ei>
References: <20200603141915.38739-1-cj.chengjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603141915.38739-1-cj.chengjian@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-06-03 14:19:15, Cheng Jian wrote:
>  A deadlock caused by logbuf_lock occurs when panic:
> 
> 	a) Panic CPU is running in non-NMI context
> 	b) Panic CPU sends out shutdown IPI via NMI vector
> 	c) One of the CPUs that we bring down via NMI vector holded logbuf_lock
> 	d) Panic CPU try to hold logbuf_lock, then deadlock occurs.
> 
> we try to re-init the logbuf_lock in printk_safe_flush_on_panic()
> to avoid deadlock, but it does not work here, because :
> 
> Firstly, it is inappropriate to check num_online_cpus() here.
> When the CPU bring down via NMI vector, the panic CPU willn't
> wait too long for other cores to stop, so when this problem
> occurs, num_online_cpus() may be greater than 1.
> 
> Secondly, printk_safe_flush_on_panic() is called after panic
> notifier callback, so if printk() is called in panic notifier
> callback, deadlock will still occurs. Eg, if ftrace_dump_on_oops
> is set, we print some debug information, it will try to hold the
> logbuf_lock.
> 
> To avoid this deadlock, drop the num_online_cpus() check and call
> the printk_safe_flush_on_panic() before panic_notifier_list callback,
> attempt to re-init logbuf_lock from panic CPU.

It might cause double unlock (deadlock) on architectures that did not
use NMI to stop the CPUs.

I have created a conservative fix for this problem for SLES, see
https://github.com/openSUSE/kernel-source/blob/SLE15-SP2-UPDATE/patches.suse/printk-panic-Avoid-deadlock-in-printk-after-stopping-CPUs-by-NMI.patch
It solves the problem only on x86 architecture.

There are many hacks that try to solve various scenarios but it
is getting too complicated and does not solve all problems.

The only real solution is lockless printk(). First piece is a lockless
ringbuffer. See the last version at
https://lore.kernel.org/r/20200501094010.17694-1-john.ogness@linutronix.de

We prefer to work on the lockless solution instead of adding more
complicated workarounds. This is why I even did not try to upstream
the patch for SLES.

In the meantime, you might also consider removing the offending
message from the panic notifier if it is not really important.

Best Regards,
Petr
