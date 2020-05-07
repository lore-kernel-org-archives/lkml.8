Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA19FC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52DB20735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EowZoeuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgEGSSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:18:01 -0400
Received: from mail.efficios.com ([167.114.26.124]:42692 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgEGSSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:18:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3634729450F;
        Thu,  7 May 2020 14:17:59 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GE3ZTdXjmyqb; Thu,  7 May 2020 14:17:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DA50929450E;
        Thu,  7 May 2020 14:17:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DA50929450E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588875478;
        bh=sfoNYlknNxWbtjAcPPUxWFEQyQaZrX7JX5gYZ6DEU+c=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=EowZoeuwKYtC/0oCVnR6y9vsF2EgPC+XV8YOjiXugVOUtsx4OJcAEZKXWBpRWyV3X
         AktnepJw7KA8zkfzfSan0dey2FXb19S7Aa4GDVDd7xQ367+tA83THAwO+AEoTA91r5
         In7BMIc9+ewDLRVHpWXc6qq0Igc0iGh5InDvFLVwCRlo/rTIkhFx10EeF8qAiefUZN
         ahF54ewO64jMWEh9NIB1/GaMvpr5uKDgURGC+/d7fh9GpaX8VONWtMCgbB+FojXZYa
         y1/ZdBWEBu9dbkbLK4FbwNEnl+GBbOQn1umiSat6CtohObF6aGmY1IsZy5PxYKwqu1
         NiJ+FSWW7bk+Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pmKCbamH_942; Thu,  7 May 2020 14:17:58 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C537A294597;
        Thu,  7 May 2020 14:17:58 -0400 (EDT)
Date:   Thu, 7 May 2020 14:17:58 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <1603808584.1778.1588875478687.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALCETrXfemPJrVx+Nfp7k_PvKGezSK46_+dL5oNNV3o5i1qWVw@mail.gmail.com>
References: <20200505131602.633487962@linutronix.de> <20200505134101.525508608@linutronix.de> <CALCETrXfemPJrVx+Nfp7k_PvKGezSK46_+dL5oNNV3o5i1qWVw@mail.gmail.com>
Subject: Re: [patch V4 part 1 35/36] x86: Replace ist_enter() with
 nmi_enter()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86: Replace ist_enter() with nmi_enter()
Thread-Index: QOnfdOESWdufkt/rc3e4SPoytbt3ew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 7, 2020, at 2:04 PM, Andy Lutomirski luto@kernel.org wrote:

> On Tue, May 5, 2020 at 7:14 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> A few exceptions (like #DB and #BP) can happen at any location in the code,
>> this then means that tracers should treat events from these exceptions as
>> NMI-like. The interrupted context could be holding locks with interrupts
>> disabled for instance.
>>
>> Similarly, #MC is an actual NMI-like exception.
> 
> Is it permissible to send a signal from inside nmi_enter()?  I imagine
> so, but I just want to make sure.

If you mean sending a proper signal, I would guess not.

I suspect you'll rather want to use "irq_work()" from NMI context to ensure
the rest of the work (e.g. sending a signal or a wakeup) is performed from
IRQ context very soon after the NMI, rather than from NMI context.

AFAIK this is how this is done today by perf, ftrace, ebpf, and lttng.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
