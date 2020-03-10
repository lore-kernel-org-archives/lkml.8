Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540BFC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC7920727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JAzY+qKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgCJPN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:13:29 -0400
Received: from mail.efficios.com ([167.114.26.124]:54508 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgCJPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:13:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9853B270688;
        Tue, 10 Mar 2020 11:13:27 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hf4P-eZz5PEx; Tue, 10 Mar 2020 11:13:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 52E3C270687;
        Tue, 10 Mar 2020 11:13:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 52E3C270687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583853207;
        bh=ygq+xFbg0pKXixt2bJeuHEWZhMD2r571IYr4GTgCpgU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=JAzY+qKV4tcyM6oiv5KLJhnUCKAdCm7zPJ1ChKBZq+CBtmB2WgvN1HBJDOZgwq8Jv
         JFDTDiU3ZsqlLSKzFTDLjpi30J1Vq/rT4X3ozcoHsmtF4ubTJz69/DtRsq0qe9c+cj
         CWSaO+xILU4LgW0ReTSetoaxbeJGM+lt/X6DYu71/F+Y2tj9OBwwXtVZ6hL3+SiRdY
         Uqw83A/ufpdW6eybIkQpHH8ckB3btvzD3iIXdMY0LbejE7xWgFYPU1rhNdHFEf7/Ez
         aSPX/mt3jpZVRLJ7z3CMOA//hgv7rqBCRQpFH2BtKFtJrGzA+TUcyU2GaNgULmAtX7
         Euuf+wtCmrK4g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gvWh1kp4B_iU; Tue, 10 Mar 2020 11:13:27 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 42DBC26FF73;
        Tue, 10 Mar 2020 11:13:27 -0400 (EDT)
Date:   Tue, 10 Mar 2020 11:13:27 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Message-ID: <379743142.23419.1583853207158.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200309204710.GU2935@paulmck-ThinkPad-P72>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <20200309204710.GU2935@paulmck-ThinkPad-P72>
Subject: Re: Instrumentation and RCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Instrumentation and RCU
Thread-Index: 8i4frrb6x7CxCVijDFRccjHi4lqH1A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Mar 9, 2020, at 4:47 PM, paulmck paulmck@kernel.org wrote:
[...]

> 
> Suppose that we had a variant of RCU that had about the same read-side
> overhead as Preempt-RCU, but which could be used from idle as well as
> from CPUs in the process of coming online or going offline?  I have not
> thought through the irq/NMI/exception entry/exit cases, but I don't see
> why that would be problem.
> 
> This would have explicit critical-section entry/exit code, so it would
> not be any help for trampolines.
> 
> Would such a variant of RCU help?
> 
> Yeah, I know.  Just what the kernel doesn't need, yet another variant
> of RCU...

Hi Paul,

I think that before introducing yet another RCU flavor, it's important
to take a step back and look at the tracer requirements first. If those
end up being covered by currently available RCU flavors, then why add
another ?

I can start with a few use-cases I have in mind. Others should feel free
to pitch in:

Tracing callsite context:

1) Thread context

   1.1) Preemption enabled

   One tracepoint in this category is syscall enter/exit. We should introduce
   a variant of tracepoints relying on SRCU for this use-case so we can take
   page faults when fetching userspace data.

   1.2) Preemption disabled

   Tree-RCU works fine.

   1.3) IRQs disabled

   Tree-RCU works fine.

2) IRQ handler context

   Tree-RCU works fine.

3) NMI context

   Tree-RCU works fine.

4) cpuidle context (!rcu_is_watching())

   - By all means, we should not have tracepoints requiring to temporarily enable
     RCU in frequent code-paths. It appears that we should be able to remove the few
     offenders we currently have (e.g. enter from usermode),
   - For tracepoints which are infrequently called from !rcu_is_watching context, checking
     whether RCU is watching and only enabling when needed should be fast enough.

Are there other use-cases am I missing that would justify adding another flavor of RCU ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
