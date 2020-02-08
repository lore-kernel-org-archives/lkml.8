Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359B1C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 16:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFB421775
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 16:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BTV9Z/Np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgBHQjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 11:39:36 -0500
Received: from mail.efficios.com ([167.114.26.124]:46488 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgBHQjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 11:39:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1408A25523F;
        Sat,  8 Feb 2020 11:39:34 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jNGUq9CR6BTU; Sat,  8 Feb 2020 11:39:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B6E8A25523E;
        Sat,  8 Feb 2020 11:39:33 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B6E8A25523E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1581179973;
        bh=VOw4+I0TzGG4rVxSaGY18Hxkclp9wd6ZNEaKLZxeVTU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=BTV9Z/Np0UVGflS8/fLD0mfW46enOfMQV+cnu8wynVl2q68qGouSQzTos71St27fR
         thtkI2RtLxbSXlO89ylOGuxb1M0o0zyGQnTtK1EWvpKxpRMt5I5KV/eY+eqWflLS2L
         O11/J2EQXOs92nYsgOd+A5tzYKivYa2SMB7m4CVoSn7Y+qc1y1mBPE+49ReXWu7jOp
         aCShxVLylqO7QsRYl5+zFD6AUx90JVI5GzycMW0T0OeO0P1D5YcBSdumcnlBRbXsvU
         veruwTNkBlpKNGZPgTt51msGBBRABLJs8wcLawiCDDNqW94NwH1RjSpbU+aZM4zB+H
         x8g2NrDYS/hbQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qTpXJDVWOpUe; Sat,  8 Feb 2020 11:39:33 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A14A5255140;
        Sat,  8 Feb 2020 11:39:33 -0500 (EST)
Date:   Sat, 8 Feb 2020 11:39:33 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     "Joel Fernandes, Google" <joel@joelfernandes.org>
Cc:     paulmck <paulmck@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <898571880.615459.1581179973560.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200207214357.GA75841@google.com>
References: <20200207205656.61938-1-joel@joelfernandes.org> <20200207212450.GP2935@paulmck-ThinkPad-P72> <20200207214357.GA75841@google.com>
Subject: Re: [RFC 0/3] Revert SRCU from tracepoint infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: Revert SRCU from tracepoint infrastructure
Thread-Index: Iq7Zznl4vnD64yRE7mSMugN2+v2g3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 7, 2020, at 4:43 PM, Joel Fernandes, Google joel@joelfernandes.org wrote:

> On Fri, Feb 07, 2020 at 01:24:50PM -0800, Paul E. McKenney wrote:
>> On Fri, Feb 07, 2020 at 03:56:53PM -0500, Joel Fernandes (Google) wrote:
>> > Hi,
>> > These patches remove SRCU usage from tracepoints. The reason for proposing the
>> > reverts is because the whole point of SRCU was to avoid having to call
>> > rcu_irq_enter_irqson(). However this was added back in 865e63b04e9b2 ("tracing:
>> > Add back in rcu_irq_enter/exit_irqson() for rcuidle tracepoints") because perf
>> > was breaking..
>> > 
>> > Further it occurs to me that, by using SRCU for tracepoints, we forgot that RCU
>> > is not really watching the tracepoint callbacks. This means that anyone doing
>> > preempt_disable() in their tracepoint callback, and expecting RCU to listen to
>> > them is in for a big surprise. When RCU is not watching, it does not care about
>> > preempt-disable sections on CPUs as you can see in the forced-quiescent state
>> > loop.
>> > 
>> > Since SRCU is not providing any benefit because of 865e63b04e9b2 anyway, let us
>> > revert SRCU tracepoint code to maintain the sanity of potential
>> > tracepoint callback registerers.
>> 
>> For whatever it is worth, SRCU is the exception to the "RCU needs to
>> be watching" rule.  You can have SRCU readers on idle CPUs, offline
>> CPUs, CPUs executing in userspace, whatever.
> 
> Yes sure. My concern was that callbacks are still using regular RCU somewhere
> and RCU isn't watching. I believe BPF is using RCU that way (not sure). But
> could be other out-of-tree kernel modules etc.

Tracepoint users should issue "tracepoint_synchronize_unregister()" rather than
expect tracepoints to rely on RCU.

I cannot find a good reason for perf to issue a redundant rcu_read_lock/unlock from
a tracepoint probe already providing RCU or SRCU synchronization. Same goes for BPF.
If they _really_ need to do it, then they could implement their own idle probes
which do an additional rcu_irq_enter/exit_irqson(), but this work-around does not
belong in tracepoint.h.

If out-of-tree modules fail to use the API properly, the burden of getting fixed
is on their shoulders, as it has always been.

Thanks,

Mathieu

> 
> thanks,
> 
> - Joel
> 
>> 
>> 							Thanx, Paul
>> 
>> > Joel Fernandes (Google) (3):
>> > Revert "tracepoint: Use __idx instead of idx in DO_TRACE macro to make
>> > it unique"
>> > Revert "tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
>> > tracepoints"
>> > Revert "tracepoint: Make rcuidle tracepoint callers use SRCU"
>> > 
>> > include/linux/tracepoint.h | 40 ++++++--------------------------------
>> > kernel/tracepoint.c        | 10 +---------
>> > 2 files changed, 7 insertions(+), 43 deletions(-)
>> > 
>> > --
>> > 2.25.0.341.g760bfbb309-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
