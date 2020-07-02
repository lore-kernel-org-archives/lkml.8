Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFB4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 519C020702
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgGBRsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgGBRsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:48:06 -0400
X-Greylist: delayed 1933 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jul 2020 10:48:06 PDT
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB18C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 10:48:06 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1jr2oO-0007xq-D4; Thu, 02 Jul 2020 13:15:48 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 2CC4056011F; Thu,  2 Jul 2020 13:15:48 -0400 (EDT)
Date:   Thu, 2 Jul 2020 13:15:48 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     peterz@infradead.org, mgorman@techsingularity.net,
        mingo@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: weird loadavg on idle machine post 5.7
Message-ID: <20200702171548.GA11813@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        mgorman@techsingularity.net, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I upgraded my firewall to 5.7-rc2 I noticed that on a mostly
idle machine (that usually sees loadavg hover in the 0.xx range)
that it was consistently above 1.00 even when there was nothing running.
All that perf showed was the kernel was spending time in the idle loop
(and running perf).

For the first hour or so after boot, everything seems fine, but over
time loadavg creeps up, and once it's established a new baseline, it
never seems to ever drop below that again.

One morning I woke up to find loadavg at '7.xx', after almost as many
hours of uptime, which makes me wonder if perhaps this is triggered
by something in cron.  I have a bunch of scripts that fire off
every hour that involve thousands of shortlived runs of iptables/ipset,
but running them manually didn't seem to automatically trigger the bug.

Given it took a few hours of runtime to confirm good/bad, bisecting this
took the last two weeks. I did it four different times, the first
producing bogus results from over-eager 'good', but the last two runs
both implicated this commit:

commit c6e7bd7afaeb3af55ffac122828035f1c01d1d7b (refs/bisect/bad)
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Sun May 24 21:29:55 2020 +0100

    sched/core: Optimize ttwu() spinning on p->on_cpu
    
    Both Rik and Mel reported seeing ttwu() spend significant time on:
    
      smp_cond_load_acquire(&p->on_cpu, !VAL);
    
    Attempt to avoid this by queueing the wakeup on the CPU that owns the
    p->on_cpu value. This will then allow the ttwu() to complete without
    further waiting.
    
    Since we run schedule() with interrupts disabled, the IPI is
    guaranteed to happen after p->on_cpu is cleared, this is what makes it
    safe to queue early.
    
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
    Signed-off-by: Ingo Molnar <mingo@kernel.org>
    Cc: Jirka Hladky <jhladky@redhat.com>
    Cc: Vincent Guittot <vincent.guittot@linaro.org>
    Cc: valentin.schneider@arm.com
    Cc: Hillf Danton <hdanton@sina.com>
    Cc: Rik van Riel <riel@surriel.com>
    Link: https://lore.kernel.org/r/20200524202956.27665-2-mgorman@techsingularity.net

Unfortunatly it doesn't revert cleanly on top of rc3 so I haven't
confirmed 100% that it's the cause yet, but the two separate bisects
seem promising.

I don't see any obvious correlation between what's changing there and
the symtoms (other than "scheduler magic") but maybe those closer to
this have ideas what could be going awry ?

	Dave
