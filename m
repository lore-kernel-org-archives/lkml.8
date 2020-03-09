Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9501FC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EDD22B48
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="le8ftsl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCITZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:25:55 -0400
Received: from mail.efficios.com ([167.114.26.124]:58454 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgCITZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:25:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1B380268C87;
        Mon,  9 Mar 2020 15:25:54 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id KnxvgsnLBXtE; Mon,  9 Mar 2020 15:25:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D62F3268C86;
        Mon,  9 Mar 2020 15:25:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D62F3268C86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583781953;
        bh=70bU9x4pFcw4EitJgLR67S4Wwba/RzoCmlkulbS+k70=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=le8ftsl+IzBrbyTQsXyfsvDSs/ACVk1v/NrLSE3i/cVEsBCpmT4zIcylFdX5TLRRT
         xkRsXEEbkNGgz09vLnNytZvfjVRQmVHAqjKXbjYFmDk7Rf70lkZG4A9ZGWoYXtZgCo
         cgV0/OoDYAr3aQgxxeYGhAorm+i3c+22gQ+VP50IvFRl1qakbne9gp2Vro9uD5+h84
         r3HnvHlvW7E5RYJg/PPT3lMKCvhfZmyD5PjR5tNBbhRI8yCr+6G73oQ3JlVL4tBleD
         6+1npY5Y8DZC/0W+EPYx0b8UOFJpAddskEnzlQ3WPYvKgUGSQmvv32qQY4jq8i4+aW
         HOelWCi3O0gAQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uGVwlSgowVas; Mon,  9 Mar 2020 15:25:53 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C9797268A1C;
        Mon,  9 Mar 2020 15:25:53 -0400 (EDT)
Date:   Mon, 9 Mar 2020 15:25:53 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Message-ID: <1421454673.21890.1583781953778.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200309150940.26730dee@gandalf.local.home>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com> <20200309144427.0ce0eabc@gandalf.local.home> <1851876075.21840.1583779960064.JavaMail.zimbra@efficios.com> <20200309150940.26730dee@gandalf.local.home>
Subject: Re: Instrumentation and RCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Instrumentation and RCU
Thread-Index: i3rbokcdGHS5QSdW4VDvsuVnJMyLcQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 9, 2020, at 3:09 PM, rostedt rostedt@goodmis.org wrote:

> On Mon, 9 Mar 2020 14:52:40 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> And when I say "go back to plain RCU", I really mean removing use of SRCU
>> from the tracepoints until we have other purposes for it (e.g. taking
>> faults within specific tracepoint probes such as syscall enter/exit).
> 
> Actually, with both you and Alexei talking about having a sleeping
> tracepoint callback, where we can add a can sleep check (but not in the
> DO_TRACE macro, I would think that registered sleeping callbacks would be
> its own callback), I would think we do not want to remove the SRCU usage.

Whether we keep it or add it back later when needed should not make much
difference.

In any case, considering that overhead which motivated use of SRCU for the rcuidle
case could instead be handled by using is_rcu_watching() and normal RCU, I would
prefer removing it from the rcuidle tracepoints for now, and add it back when we
add a new kind of "sleepable" tracepoints later on.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
