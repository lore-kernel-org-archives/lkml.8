Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CDEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AED3206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="muyvBO34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404004AbgFYQex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:34:53 -0400
Received: from mail.efficios.com ([167.114.26.124]:47344 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390857AbgFYQew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:34:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8AC272CBD9F;
        Thu, 25 Jun 2020 12:34:51 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id V_vXVbAC0BhS; Thu, 25 Jun 2020 12:34:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3230D2CB9EC;
        Thu, 25 Jun 2020 12:34:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3230D2CB9EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593102891;
        bh=Zk5C15FGGk/Xy4rNgd1DGYYrFf9yMY11wDzm9RdN0hs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=muyvBO344EQCVFhdH7n7gQQ/WtDnpnNEPuBqCPPifWHoYbKn9eA1BE1YlsqlzESSR
         PGxk4DOdy3HqWRe2q52mS4oZl/86M1IW45rjSncy1N/SoeQs1EPMPyngXfKlUq/5uW
         i/nrc6N/lPP0rQm7NORrLamjOo2QsXyncKVDksoL6h1qep5zOtecqYOqH7Np5/hbb0
         YXDECgffOPsFUPq32w4XvW5fPpNsmbc5u2I2n7qVjnMhqQ8zRyn9k+HxdaUtJpbNF4
         fkGd/qvNzEn7kAUWMNX/W6NwyC9dnJleRRdMexSyb4UjmbpR/Rs0VYIgN2evNo+jhJ
         b/NhWQroOmaRA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dNaHWcnlp5Ng; Thu, 25 Jun 2020 12:34:51 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 227D82CB9EB;
        Thu, 25 Jun 2020 12:34:51 -0400 (EDT)
Date:   Thu, 25 Jun 2020 12:34:51 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joelaf@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        paulmck <paulmck@kernel.org>, Julien Desfossez <ju@klipix.org>
Message-ID: <489418873.12472.1593102891027.JavaMail.zimbra@efficios.com>
In-Reply-To: <1115572712.12427.1593096995446.JavaMail.zimbra@efficios.com>
References: <20200619202516.7109-1-mathieu.desnoyers@efficios.com> <20200624121136.GF4800@hirez.programming.kicks-ass.net> <269292405.11607.1593023493676.JavaMail.zimbra@efficios.com> <20200624195030.GG4800@hirez.programming.kicks-ass.net> <1115572712.12427.1593096995446.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH v2] sched_pair_cpu: Introduce scheduler task pairing
 system call
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: sched_pair_cpu: Introduce scheduler task pairing system call
Thread-Index: KKF2EJ/UOyY4CnhVA6NZtcIQEi8jPD1z4gT9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 25, 2020, at 10:56 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Jun 24, 2020, at 3:50 PM, Peter Zijlstra peterz@infradead.org wrote:
> 
>> On Wed, Jun 24, 2020 at 02:31:33PM -0400, Mathieu Desnoyers wrote:
>> 
> [...]
>> The other alternative is using a preempt_notifier for the worker I
>> suppose.
> 
[...]
>> 
>> preempt_notifier could work here too I suppose, install it on yourself
>> when you do the pear syscall and take it away again when you're finished
>> with it.

The issue I currently have with preempt notifiers is that I need to
send an IPI from a sched_out notifier, which has interrupts off and
hold the rq lock. smp_call_function_single() warns due to irq off, and
indeed it triggers deadlocks.

Before using preempt notifiers, I was touching the "prev" task after
irqs were reenabled and rq lock was released, which allowed me to
send an IPI from that context.

Any thoughts on how to best solve this ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
