Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A0DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91FC820675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hJvoGzaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgENQDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:03:34 -0400
Received: from mail.efficios.com ([167.114.26.124]:37040 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgENQDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:03:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4A7772A66CC;
        Thu, 14 May 2020 12:03:31 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5gzQ1SdIexmK; Thu, 14 May 2020 12:03:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 62E122A690E;
        Thu, 14 May 2020 12:03:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 62E122A690E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589472210;
        bh=/hVJZGVH9zt1lpc/kaJwrZsacOrpH4fS70DXrJY7C9k=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=hJvoGzaMRoPQaeAYsIjTFj1VpmMQPioMMbsEcBbxBAY2+cpiPUtfDfTIqOyQybNH+
         LLK29BiaFU3JNxml4PAAKLitmiQCHccsk1SFXstfyk/3ao5kwsKvthpMJJcxqNDZLx
         DvSKDnEArHEnE2wjgWBOlSjabJ4hekUjjnvXSegx59CA2ePsbV7sjIEhXoLKzBD3+C
         6MNkuuVLNa0o5z85+BT6y0jQNlXN/AxaE8+BYmljO4h6chSozFhthMIWLIh8lIvsr0
         1X/5Chyz9DrZ6ZpMZSODyfRa476hISv26aIZuCBWQZqXoVaax1Bu6bhn4bYcFkK/Tt
         HxqiWLBG4ubcw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 80xRGhLcdnL6; Thu, 14 May 2020 12:03:30 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4CB892A681A;
        Thu, 14 May 2020 12:03:30 -0400 (EDT)
Date:   Thu, 14 May 2020 12:03:30 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>
Message-ID: <1278452779.21179.1589472210183.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200514141703.GD9266@zn.tnic>
References: <20200505131602.633487962@linutronix.de> <20200505134100.957390899@linutronix.de> <20200514141703.GD9266@zn.tnic>
Subject: Re: [patch V4 part 1 29/36] x86/mce: Send #MC singal from task work
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/mce: Send #MC singal from task work
Thread-Index: wef2KNYpsfeyobuXQ9ZvZ7vSRlOBzg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 14, 2020, at 10:17 AM, Borislav Petkov bp@alien8.de wrote:

> + Tony.
> 
> On Tue, May 05, 2020 at 03:16:31PM +0200, Thomas Gleixner wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>> 
>> Convert #MC over to using task_work_add(); it will run the same code
>> slightly later, on the return to user path of the same exception.
>> 
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>>  arch/x86/kernel/cpu/mce/core.c |   56 ++++++++++++++++++++++-------------------
>>  include/linux/sched.h          |    6 ++++
>>  2 files changed, 37 insertions(+), 25 deletions(-)
> 
> I like this:
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

What I am not fully grasping here is whether this patch preserves the instruction
pointer (and possibly other relevant information for siginfo_t) triggering the
exception in a scenario where we have:

- #MC triggered, queuing task work,
- unrelated signal happens to be delivered to task,
- exit to usermode loop handles do_signal first,
- then it runs task work.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
