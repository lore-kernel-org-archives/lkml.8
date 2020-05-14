Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A4EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743DC20659
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="A84VVHvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbgENAlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:41:50 -0400
Received: from mail.efficios.com ([167.114.26.124]:44978 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733152AbgENAlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:41:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A55C82A0C9C;
        Wed, 13 May 2020 20:41:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id P8ONYUEstxRh; Wed, 13 May 2020 20:41:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4611B2A0C9B;
        Wed, 13 May 2020 20:41:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4611B2A0C9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589416908;
        bh=3Wm/gvabudc8kHypFiCs++EznKCBk7qXSKbLh6j+DB0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=A84VVHvDOq2zBEqUOam5nR011/RxNd+jfUiao9wKPvkAG8XDm7KLpoYCs7W92PY1z
         3Az84JohkE3Xb5c+BoxDCg6+JQNIw5jYn546Vh+KXIbYZvm3JZKIGRvU40nL5PJzbO
         EbMIqb0o4dL5y7aXCI9HuujNBCYLKM3/hJNRBYnQapyF/a91rSVxnmLSZhnI1cUAvp
         5sOL0DecAFckThGtPfLjf5N3dQqLgK64dJitjY92Cr4JaBMlUw28sT3L4XqraNUIxl
         iJHaLL+SmWOahVhRFe7jCsrL+v1z4ta+0bCuWYsFzeS2RY/Qh5vp4NT+Z6j9we2mOA
         Y2uY4FlllmSyw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dLqbyldt-k10; Wed, 13 May 2020 20:41:48 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2B9032A09AE;
        Wed, 13 May 2020 20:41:48 -0400 (EDT)
Date:   Wed, 13 May 2020 20:41:48 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Message-ID: <807929267.20601.1589416908153.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200512215108.5ea110b7@oasis.local.home>
References: <20200505134354.774943181@linutronix.de> <20200505134903.346741553@linutronix.de> <CALCETrW1pZ0NiN3F4g3=S+KpM79T9PbaYVC3Zr5p6P2rvk4v0A@mail.gmail.com> <20200512215108.5ea110b7@oasis.local.home>
Subject: Re: [patch V4 part 3 01/29] x86/traps: Mark fixup_bad_iret()
 noinstr
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/traps: Mark fixup_bad_iret() noinstr
Thread-Index: N3Znk34zz6brd7lyDamU+v8j7pOmBw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 12, 2020, at 9:51 PM, rostedt rostedt@goodmis.org wrote:

> On Fri, 8 May 2020 17:39:00 -0700
> Andy Lutomirski <luto@kernel.org> wrote:
> 
>> On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> >
>> > This is called from deep entry ASM in a situation where instrumentation
>> > will cause more harm than providing useful information.
>> >  
>> 
>> Acked-by: Andy Lutomirski <luto@kernel.org>
>> 
>> Maybe add to changelog:
>> 
>> Switch from memmove() to memcpy() because memmove() can't be called
>> from noinstr code.
> 
> Yes please, because I was about to say that there was changes that
> didn't seem to fit the change log.
> 
> I would also add a comment in the code saying that we need the temp
> variable to use memcpy as memmove can't be used in noinstr code.

Looking at an updated version of the tree, I see the acked-by from Andy,
but not comment about switching from memmove to memcpy.

Also, I notice a significant undocumented change in this patch: it changes
a this_cpu_read() (which presumes preemption is enabled) to a __this_cpu_read().

So the 100$ question: is preemption enabled or not in fixup_bad_iret() ? And of
course that change should be documented in the commit message.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
