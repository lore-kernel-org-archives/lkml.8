Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51253C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3757421744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rzTDFuR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgHDRZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:25:25 -0400
Received: from mail.efficios.com ([167.114.26.124]:41690 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbgHDRZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:25:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 28EE02E0B39;
        Tue,  4 Aug 2020 13:25:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ebHR5V_QCNWb; Tue,  4 Aug 2020 13:25:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CAE1A2E0AC6;
        Tue,  4 Aug 2020 13:25:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CAE1A2E0AC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1596561919;
        bh=LKgbLerUFgbYve9YdtBVomWfEyKussbk8GtMS0UFY4w=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=rzTDFuR7kE9NHm3XEWdAut30byYgH5ZY0pRe7ozqd4YsIDVrkceWkHqNEWT1pjqhk
         bCm2d1d+gLtPTuv3rxx9TkZfXmAU1vF1eqBFROpYi96+8X5znR98wUdk3qYV026U29
         NWLdeA9OsVGgbnoZ5g5DCE069qdUlgSUKNz7pPktBHEZ+0HJs4F8vBewR1tevUkV2E
         YTCdRSHfULJJ9S00rG9DMQ1xZUs6t6OPjD8AIQFz06imcZ3ZsUOCq/Lt8Cyic76XTr
         psJwMnb9kwp2bDHxtKyYhzthEHEBwH8JDq5MzkvXC+yENjR0Ow79zijFbEiNPTH1GT
         4xE2lND6xgkzw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tokFWkSMtnbK; Tue,  4 Aug 2020 13:25:19 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id BB96F2E0A57;
        Tue,  4 Aug 2020 13:25:19 -0400 (EDT)
Date:   Tue, 4 Aug 2020 13:25:19 -0400 (EDT)
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
Message-ID: <269299324.40115.1596561919633.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200804165118.GN2657@hirez.programming.kicks-ass.net>
References: <20200728160010.3314-1-mathieu.desnoyers@efficios.com> <20200804143419.GL2657@hirez.programming.kicks-ass.net> <709073430.39864.1596552521779.JavaMail.zimbra@efficios.com> <20200804165118.GN2657@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 1/2] sched: Fix exit_mm vs membarrier
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: sched: Fix exit_mm vs membarrier
Thread-Index: BO9QOzk5BkwuprAmMByJcjz3i1N+zw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 4, 2020, at 12:51 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Aug 04, 2020 at 10:48:41AM -0400, Mathieu Desnoyers wrote:
>> Here is the scenario I have in mind:
> 
>> Userspace variables:
>> 
>> int x = 0, y = 0;
>> 
>> CPU 0                   CPU 1
>> Thread A                Thread B
>> (in thread group A)     (in thread group B)
>> 
>> x = 1
>> barrier()
>> y = 1
>> exit()
>> exit_mm()
>> current->mm = NULL;
>>                         r1 = load y
>>                         membarrier()
>>                           skips CPU 0 (no IPI) because its current mm is NULL
>>                         r2 = load x
>>                         BUG_ON(r1 == 1 && r2 == 0)
>> 
> 
> Ah, yes of course.
> 
> We really should have a bunch of these scenarios in membarrier.c.

Good point.

> 
> 
> 
> Now, the above cannot happen because we have an unconditional
> atomic_dec_and_test() in do_exit() before exit_mm(), but I'm sure
> relying on that is a wee bit dodgy.

I am not against using this already existing barrier to provide the
guarantee we need, but it would have to be documented in the code.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
