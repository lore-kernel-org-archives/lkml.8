Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B30C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A63320760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgGCN0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:26:07 -0400
Received: from mail5.windriver.com ([192.103.53.11]:33602 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgGCN0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:26:06 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 063DNHqc002307
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 3 Jul 2020 06:23:27 -0700
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Fri, 3 Jul 2020 06:23:06 -0700
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 1A1512E0381; Fri,  3 Jul 2020 09:23:06 -0400 (EDT)
Date:   Fri, 3 Jul 2020 09:23:06 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <mgorman@techsingularity.net>,
        <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
CC:     Michal Kubecek <mkubecek@suse.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200703132305.GA25509@windriver.com>
References: <20200702171548.GA11813@codemonkey.org.uk>
 <20200702211555.GA27819@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200702211555.GA27819@windriver.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: weird loadavg on idle machine post 5.7] On 02/07/2020 (Thu 17:15) Paul Gortmaker wrote:

> [weird loadavg on idle machine post 5.7] On 02/07/2020 (Thu 13:15) Dave Jones wrote:

[...]

> > both implicated this commit:
> > 
> > commit c6e7bd7afaeb3af55ffac122828035f1c01d1d7b (refs/bisect/bad)
> > Author: Peter Zijlstra <peterz@infradead.org>
> > Date:   Sun May 24 21:29:55 2020 +0100
> > 
> >     sched/core: Optimize ttwu() spinning on p->on_cpu
> 
> I was down to 10 commits roughly above and below this guy before hearing
> you were working the same problem.
> 
> I just got this guy to reveal a false load after a 2h test as well.
> I want to let the one underneath soak overnight just to also confirm it
> is "good" - so that is pending.

As per above, I ran a 12h test overnight on 505b8af5891 and it seems
fine.  Every other "bad" bisect point failed in 7h or less.  So my
testing seems to give the same result as Dave.

Paul.
--

root@t5610:/home/paul/git/linux-head# 
[1]-  Done                    nohup
tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 24 --duration 720 --configs TREE03 --trust-make > /tmp/kvm.sh.out 2>&1
root@t5610:/home/paul/git/linux-head# uptime
 09:10:56 up 13:12,  2 users,  load average: 0.00, 0.00, 0.14
root@t5610:/home/paul/git/linux-head# cat /proc/version 
Linux version 5.7.0-rc6-00029-gd505b8af5891 (paul@t5610) (gcc version 9.3.0 (Ubuntu 9.3.0-10ubuntu2), GNU ld (GNU Binutils for Ubuntu) 2.34) #2 SMP Thu Jul 2 18:55:40 EDT 2020
