Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2539C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3EB20774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgFIPEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgFIPD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:03:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FB2C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 08:03:59 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jifnA-0003HL-4R; Tue, 09 Jun 2020 17:03:56 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: Full barrier in data_push_tail(): was [PATCH v2 2/3] printk: add lockless buffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
        <20200501094010.17694-3-john.ogness@linutronix.de>
        <20200609094820.GC23752@linux-b0ei>
Date:   Tue, 09 Jun 2020 17:03:54 +0200
In-Reply-To: <20200609094820.GC23752@linux-b0ei> (Petr Mladek's message of
        "Tue, 9 Jun 2020 11:48:20 +0200")
Message-ID: <87h7vkuvqd.fsf@vostro.fn.ogness.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-09, Petr Mladek <pmladek@suse.com> wrote:
>> --- /dev/null
>> +++ b/kernel/printk/printk_ringbuffer.c
>> +static bool data_push_tail(struct printk_ringbuffer *rb,
>> +			   struct prb_data_ring *data_ring,
>> +			   unsigned long lpos)
>> +{
>> ...
>> +
>> +		/*
>> +		 * Guarantee any descriptor states that have transitioned to
>> +		 * reusable are stored before pushing the tail lpos. This
>> +		 * allows readers to identify if data has expired while
>> +		 * reading the descriptor. This pairs with desc_read:D.
>> +		 */
>> +		smp_mb(); /* LMM(data_push_tail:C) */
>
> The comment does not explain why we need a full barrier here.
>
> I would add something like:
>
> 		* Full barrier is necessary because the descriptors
> 		* might have been made reusable also by other CPUs.

Agreed. Somehow I missed that explanation for this comment.

> For people like me, it would be great to add also link to a more
> detailed explanation, for example, the litmus tests, or something
> even more human readable ;-) I think that it is a "rather" common
> problem. I wonder whether it is already documented somewhere.

I believe that memory barriers need to be formally documented. Perhaps
in such a way that litmus tests can be easily generated. Tools could
greatly assist with this. It is my hope that my memory barrier
documentation can spark some ideas about how we could do this. (Doing
all this manually really sucks!)

John Ogness
