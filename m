Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304A2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1318922C9F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uYmTC1kZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgHDOsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:48:53 -0400
Received: from mail.efficios.com ([167.114.26.124]:47576 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgHDOsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:48:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 322B92D7B46;
        Tue,  4 Aug 2020 10:48:42 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZEZP2hoar3Hm; Tue,  4 Aug 2020 10:48:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E1FD22D7B43;
        Tue,  4 Aug 2020 10:48:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E1FD22D7B43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1596552521;
        bh=DcQU8cz0KN0eXUyY05/A6WfPdiNsESHnmyMO1LCZ4uM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=uYmTC1kZZsQtypzvkqDNCRzveU5otX6OKgQccRZSDowJGm5tLIvSvmsbXdn/nUzzv
         Ebr5rHzYdxEqw44eWIZW0ODpWcMR3/L22gWeQd/HpQlgrkTKXIXOwoTirx3AIlUIo3
         bJLC1Rwl3RVoTScPjx0AFy+wm4X229MPtlbhBWa/EoJ1cU7jwE9gd/9CUpZx7oNAUQ
         mm9j1a2P4RrvZV4+Hz+sJ2zjgdblqkVdXZIKdvKzPrkmkcWx2q0zmJwWwJYhDhGgw7
         iUgjKF4kMxu0zYXM+Tza0LYTCp3TC94TFxS08IXIw/0/TLivvI1+9LmTtB/VzHkTUY
         2XbkGUOQ8/arQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cdPm4lxPdYGP; Tue,  4 Aug 2020 10:48:41 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D2D9A2D7A50;
        Tue,  4 Aug 2020 10:48:41 -0400 (EDT)
Date:   Tue, 4 Aug 2020 10:48:41 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-mm <linux-mm@kvack.org>
Message-ID: <709073430.39864.1596552521779.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200804143419.GL2657@hirez.programming.kicks-ass.net>
References: <20200728160010.3314-1-mathieu.desnoyers@efficios.com> <20200804143419.GL2657@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 1/2] sched: Fix exit_mm vs membarrier
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: sched: Fix exit_mm vs membarrier
Thread-Index: 4wlPtxcjq37vbD29WsZHDlFzoriwyA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Aug 4, 2020, at 10:34 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Jul 28, 2020 at 12:00:09PM -0400, Mathieu Desnoyers wrote:
>> exit_mm should issue memory barriers after user-space memory accesses,
>> before clearing current->mm, to order user-space memory accesses
>> performed prior to exit_mm before clearing tsk->mm, which has the
>> effect of skipping the membarrier private expedited IPIs.
>> 
>> The membarrier system call can be issued concurrently with do_exit
>> if we have thread groups created with CLONE_VM but not CLONE_THREAD.
> 
> I'm still wonder what the exact failure case is though; exit_mm() is on
> the exit path (as the name very much implies) and the thread is about to
> die. The context switch that follows guarantees a full barrier before we
> run anything else again.

Here is the scenario I have in mind:

Two thread groups are created, A and B. Thread group B is created by
issuing clone from group A with flag CLONE_VM set, but not CLONE_THREAD.
Let's assume we have a single thread within each thread group (Thread A
and Thread B).

The AFAIU we can have:

Userspace variables:

int x = 0, y = 0;

CPU 0                   CPU 1
Thread A                Thread B
(in thread group A)     (in thread group B)

x = 1
barrier()
y = 1
exit()
exit_mm()
current->mm = NULL;
                        r1 = load y
                        membarrier()
                          skips CPU 0 (no IPI) because its current mm is NULL
                        r2 = load x
                        BUG_ON(r1 == 1 && r2 == 0)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
