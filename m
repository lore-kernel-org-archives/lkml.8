Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BBDC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F84208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="K6geIgU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgD2R3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:29:48 -0400
Received: from mail.efficios.com ([167.114.26.124]:38294 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgD2R3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:29:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9AA19294F4F;
        Wed, 29 Apr 2020 13:29:46 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wV5krUHBi7wo; Wed, 29 Apr 2020 13:29:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 40FDA294F4E;
        Wed, 29 Apr 2020 13:29:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 40FDA294F4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588181386;
        bh=D1YIauERmx7u1Xcu9eVlzjzTdRrs1DrzoctdbB6KdM0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=K6geIgU71fgZlYvhOJM7l6fYqsCXHDru8cfCuvKK1PiXigLG4tKAB8U+cYaoJsXBT
         ywB9PVBmR4M264nW3U8T90sqpqGR7Hria3Nw8Y+Uw+ISr0s+BxrQKZcNSFaJABTOOD
         zldAHt6pKag764XmA9wJu+fNJ4Romd2XNDr0ntnk2r+TNn3lzczmiYXkvpDcsNfueY
         RXzs5Uy2ib1Z7WT2ogoWpi3N1vul76XCN2zcz3XX+ifNUimJDUTfiorBBIPff4I/xf
         N7eYKzfUn7hyoWzq/nQHkh1cRjrkx2m9nQPFjtXrrnf9uJyQv5wI7A4v5tFNXgYjo6
         AqivUff9WIlIA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wM9fp5kTRvk8; Wed, 29 Apr 2020 13:29:46 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2D22A29528E;
        Wed, 29 Apr 2020 13:29:46 -0400 (EDT)
Date:   Wed, 29 Apr 2020 13:29:46 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Joerg Roedel <jroedel@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Message-ID: <951556503.76104.1588181386082.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200429125245.5a804f62@gandalf.local.home>
References: <20200429054857.66e8e333@oasis.local.home> <20200429105941.GQ30814@suse.de> <20200429082854.6e1796b5@oasis.local.home> <20200429100731.201312a9@gandalf.local.home> <20200429161747.GS30814@suse.de> <20200429162026.GT30814@suse.de> <20200429125245.5a804f62@gandalf.local.home>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before
 text_poke()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: x86/mm: Sync all vmalloc mappings before text_poke()
Thread-Index: jcBEkkna6hZ/plK+1lnYOdJw4aPR+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 29, 2020, at 12:52 PM, rostedt rostedt@goodmis.org wrote:

> On Wed, 29 Apr 2020 18:20:26 +0200
> Joerg Roedel <jroedel@suse.de> wrote:
> 
>> On Wed, Apr 29, 2020 at 06:17:47PM +0200, Joerg Roedel wrote:
>> > On Wed, Apr 29, 2020 at 10:07:31AM -0400, Steven Rostedt wrote:
>> > > Talking with Mathieu about this on IRC, he pointed out that my code does
>> > > have a vzalloc() that is called:
>> > > 
>> > > in trace_pid_write()
>> > > 
>> > > 	pid_list->pids = vzalloc((pid_list->pid_max + 7) >> 3);
>> > > 
>> > > This is done when -P1,2 is on the trace-cmd command line.
>> > 
>> > And that buffer is written to at any function entry?
>> 
>> What I meant to say, is it possible that the page-fault handler does not
>> complete because at its beginning it calls into trace-code and faults
>> again on the same address?
>> 
> 
> It should be read only at sched_switch.
> 
> Basically, it's a big bitmask, where each bit represents a possible process
> id (can be 2 gigs if we allow all positive ints!).

I think you mean 2 giga-bit, for 256MB worth of memory, right ?

And AFAIU the PID_MAX_LIMIT is at a maximum of 4 million PIDs in
include/linux/threads.h, which means 512MB worth of memory for a
bitmask.

> Then, it is only written when setting it up. Bits 1 and 2 are set here
> (-P1,2). At context switch, next->pid is checked against this bitmask, and
> if it is set, it means we should allow this process to be traced.
> 
> This mask should only be accessed at sched_switch time, not at other times.
> And it may read any possible page in that mask depending on the process id
> of the next task to be scheduled in.

Not sure how relevant it is, but I notice that it is also touched from IPI
context, see:

on_each_cpu(ignore_task_cpu, tr, 1);

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
