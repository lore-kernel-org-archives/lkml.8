Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F03C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA66E206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgFVKYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:24:21 -0400
Received: from nautica.notk.org ([91.121.71.147]:48747 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgFVKYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:24:19 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id DBA46C01A; Mon, 22 Jun 2020 12:24:16 +0200 (CEST)
Date:   Mon, 22 Jun 2020 12:24:01 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, liuzhiqiang26@huawei.com,
        joel@joelfernandes.org, paulmck@linux.vnet.ibm.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kernel/signal.c: Export symbol __lock_task_sighand
Message-ID: <20200622102401.GA12377@nautica>
References: <20200621133704.77896-1-alexander.kapshuk@gmail.com>
 <20200622062527.GA6516@redhat.com>
 <20200622083905.c3nurmkbo5yhd6lj@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622083905.c3nurmkbo5yhd6lj@wittgenstein>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner wrote on Mon, Jun 22, 2020:
> On Mon, Jun 22, 2020 at 08:25:28AM +0200, Oleg Nesterov wrote:
>> current->sighand is stable and can't go away. Unless "current" is exiting and
>> has already passed exit_notify(). So I don't think net/9p needs this helper.
> 
> From what I can gather from the thread (cf. [1]) that is linked in the
> commit message the main motivation for all of this is sparse not being
> happy and not some bug. (Maybe I'm not seeing something though.)
> 
> The patch itself linked here doesn't seem to buy anything. I agree with
> Oleg. Afaict, lock_task_sighand() would only be needed here if the task
> wouldn't be current. So maybe it should just be dropped from the series.

Sure. I honestly have no idea on what guarantees we have from the task
being current here as opposed to any other task -- I guess that another
thread calling exit for exemple would have to wait?
What about the possibility of sighand being null that the function does
check, is that impossible for current as well?


Honestly not a part of the code I'm much familiar with, this all
predates my involvement with 9p by a fair bit...

Anyway, not particularily fussy on this, it just looked like "the right
way" to lock a task signal handler among the few common patterns I could
see; I think it would make sense to just convert all such locks to a
single pattern for a maintenance pov but it's much more work than I'm
willing to do.
I'll just drop the patch :)


>> However, the games with TIF_SIGPENDING doesn't look right in any
>> case.

I definitely agree with this, hence my comment about an old patchset
that will remove these eventually, but while I did send the patches over
a year ago I never took them up due to lack of proper testing.
It's been something people regularily complained about that it makes the
task unkillable in a weird way and many tools like syzbot don't like it
(and potentially users who try ^C won't either)

I guess I'll try to find some time to finish that instead... Will be
more useful than trying to wrap my head around all of that :P


Thanks!
-- 
Dominique
