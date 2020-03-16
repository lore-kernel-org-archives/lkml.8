Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDBEC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A5020674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SdlmuNY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbgCPPNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:13:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52986 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbgCPPNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Vl+Cf0ZuC3XZwjG76c59VMt7RhS7EZIRiTRbmqe9zmk=; b=SdlmuNY8kTO/HYkpoRHXV+09Fz
        ognI1JqujrUhRwxTTQN8bOgapO3nu5lae7DP0HW5ZRCwPCXWywqTso62Tz4lWV1L/lQymObYvU78W
        3XdvW7ZftBP4Rkgi8BmsiSmVAuJeBAXfDDZJmQ3XZQ4KqV70WDvNVp/aF06k5YRF/GhDwy5yh/wfi
        v3QVIH56XZjyRAvCgmRXfn0yox6Zb03IvOsEQCL5opmy6yH0rYwUiXdpGbwiAUl3L6FMe0fEzhdUg
        JAjbxC7nLls5BYm2fjEbriAEDpaj3JYnIED6DYqgR5ldcEkg3qvGOCycrW8WYD8j4eVrmhfBadu02
        QgmLKdeA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDrQz-0004GC-GF; Mon, 16 Mar 2020 15:13:41 +0000
Subject: Re: [PATCH 1/9] Documentation: Add lock ordering and nesting
 documentation
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200313174701.148376-1-bigeasy@linutronix.de>
 <20200313174701.148376-2-bigeasy@linutronix.de>
 <2e0912cc-6780-18e9-4e4c-7cc60da6709f@infradead.org>
 <20200316103454.iodi65uzbpat4kv5@linutronix.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <de6fdc5d-690a-1130-c911-caccbb0b1a8f@infradead.org>
Date:   Mon, 16 Mar 2020 08:13:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316103454.iodi65uzbpat4kv5@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/20 3:34 AM, Sebastian Andrzej Siewior wrote:
> On 2020-03-14 15:57:24 [-0700], Randy Dunlap wrote:
>> Hi,
> Hi Randy,
> 
>> A few comments for your consideration:
> 
> I merged all of you comments but two:
> 
>> On 3/13/20 10:46 AM, Sebastian Andrzej Siewior wrote:
> …
>>> +rwlock_t and PREEMPT_RT
>>> +-----------------------
>>> +
>>> +On a PREEMPT_RT enabled kernel rwlock_t is mapped to a separate
>>> +implementation based on rt_mutex which changes the semantics:
>>> +
>>> + - Same changes as for spinlock_t
>>> +
>>> + - The implementation is not fair and can cause writer starvation under
>>> +   certain circumstances. The reason for this is that a writer cannot
>>> +   inherit its priority to multiple readers. Readers which are blocked
>>
>>       ^^^^^^^ I think this is backwards. Maybe more like so:
>>                                                          a writer cannot
>>       bequeath or grant or bestow or pass down    ...    its priority to
> 
> So the term "inherit" is the problem. The protocol is officially called
> PI which is short for Priority Inheritance. Other documentation,
> RT-mutex for instance, is also using this term when it is referring to
> altering the priority of a task. For that reason I prefer to keep using
> this term.

OK, I get it.

>>> +   on a writer fully support the priority inheritance protocol.
> …
>>> +raw_spinlock_t
>>> +--------------
>>> +
>>> +As raw_spinlock_t locking disables preemption and eventually interrupts the
>>> +code inside the critical region has to be careful to avoid calls into code
>>
>> Can I buy a comma in there somewhere, please?
>> I don't get it as is.
> 
> What about
> 
> | As raw_spinlock_t locking disables preemption, and eventually interrupts, the
> | code inside the critical region has to be careful to avoid calls into code
> 
> any better?

Yes.

thanks.
-- 
~Randy

