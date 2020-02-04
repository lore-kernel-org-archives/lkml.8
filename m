Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01838C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30F620674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgBDPBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:01:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54206 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgBDPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:01:49 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iyzhx-0003UX-Je; Tue, 04 Feb 2020 15:01:45 +0000
Date:   Tue, 4 Feb 2020 16:01:44 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v5 5/6] clone3: allow spawning processes into cgroups
Message-ID: <20200204150144.fojbdmuyr7bnvgnj@wittgenstein>
References: <20200121154844.411-1-christian.brauner@ubuntu.com>
 <20200121154844.411-6-christian.brauner@ubuntu.com>
 <20200204115351.GD14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200204115351.GD14879@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 12:53:51PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 21, 2020 at 04:48:43PM +0100, Christian Brauner wrote:
> > This adds support for creating a process in a different cgroup than its
> > parent. Callers can limit and account processes and threads right from
> > the moment they are spawned:
> > - A service manager can directly spawn new services into dedicated
> >   cgroups.
> > - A process can be directly created in a frozen cgroup and will be
> >   frozen as well.
> > - The initial accounting jitter experienced by process supervisors and
> >   daemons is eliminated with this.
> > - Threaded applications or even thread implementations can choose to
> >   create a specific cgroup layout where each thread is spawned
> >   directly into a dedicated cgroup.
> > 
> > This feature is limited to the unified hierarchy. Callers need to pass
> > an directory file descriptor for the target cgroup. The caller can
> > choose to pass an O_PATH file descriptor. All usual migration
> > restrictions apply, i.e. there can be no processes in inner nodes. In
> > general, creating a process directly in a target cgroup adheres to all
> > migration restrictions.
> 
> AFAICT, he *big* win here is avoiding the write side of the
> cgroup_threadgroup_rwsem. Or am I mis-reading the patch?

No, you're absolutely right. I just didn't bother putting implementation
specifics in the cover letter and I probably should have. So thanks for
pointing that out!

> 
> That global lock is what makes moving tasks/threads around super
> expensive, avoiding that by use of this clone() variant wins the day.

:)
Christian
