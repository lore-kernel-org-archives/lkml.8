Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B0FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E5AB2065E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SWzluhdl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qy4txc7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgG2MQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:16:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41756 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2MQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:16:47 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596025005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SXHcAb6oWONCLeVNr9cTE/DVR26uCTiz388p6xOprjs=;
        b=SWzluhdlz6biqnzx03kZiy+5Qw7ycUKQjCK1rlxwoM00lO6lI8gBhJN4ruvSMyTzMtqZRo
        6zRUhl/1jpj9znjfO7fIn7PkKhH9ey7SJWR8CTpx4vz90dx0iHgczS0rni0GULpjLKJ69g
        799oE0w/VVo8AkLMoApLDs1+bJt/NkrVet3V+w5KuGCh4l1Xm+yqurVv51KQQE9Lmtu35T
        HJ9n/PXBSaeojsAUSkNsbQWnI3/5boVbEwPqmZWqUlmd5IazyaApFKvXiaT+4TfjccrrWj
        +pdY35Yww1o0x4pA24URWfRjXoyxUYS4rry6EZXVAU/VbWQivZegznvae8qgUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596025005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SXHcAb6oWONCLeVNr9cTE/DVR26uCTiz388p6xOprjs=;
        b=Qy4txc7NdEsHLqixNC3YRTxUQ6njgl5djqfKPcabV10fnHdnSL5ZzEwk0BhvLDod7Vsxhp
        4eCsTAz8ZIbTVtDg==
To:     jun qian <qianjun.kernel@gmail.com>
Cc:     peterz@infradead.org, will@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH V4] Softirq:avoid large sched delay from the pending softirqs
In-Reply-To: <CAKc596+vF4eYa4h55P2cssQbRKqBV_-9c_v35SXVMdonP3HBHA@mail.gmail.com>
References: <1595601083-10183-1-git-send-email-qianjun.kernel@gmail.com> <87sgddaru7.fsf@nanos.tec.linutronix.de> <CAKc596+vF4eYa4h55P2cssQbRKqBV_-9c_v35SXVMdonP3HBHA@mail.gmail.com>
Date:   Wed, 29 Jul 2020 14:16:44 +0200
Message-ID: <87v9i6a53n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian,

jun qian <qianjun.kernel@gmail.com> writes:
> On Mon, Jul 27, 2020 at 11:41 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > +                     or_softirq_pending(pending << (vec_nr + 1));
>>
>> To or the value interrupts need to be disabled because otherwise you can
>> lose a bit when an interrupt happens in the middle of the RMW operation
>> and raises a softirq which is not in @pending and not in the per CPU
>> local softirq pending storage.
>>
> I can't understand the problem described above, could you explain in
> detail.

Oring a value to a memory location is a Read Modify Write (RMW)
operation.

        x |= a;

translates to pseudo code:

        R1 =  x      // Load content of memory location x into register R1
        R1 |= a      // Or value a on R1
        x = R1       // Write back result
        
So assume:

   x = 0
   a = 1

   R1 = x  --> R1 == 0
   R1 |= a --> R1 == 1

interrupt sets bit 1 in x       --> x == 0x02

   x = R1  --> x == 1

So you lost the set bit 1, right? Not really what you want.

>> There is another problem. Assume bit 0 and 1 are pending when the
>> processing starts. Now it breaks out after bit 0 has been handled and
>> stores back bit 1 as pending. Before ksoftirqd runs bit 0 gets raised
>> again. ksoftirqd runs and handles bit 0, which takes more than the
>> timeout. As a result the bit 0 processing can starve all other softirqs.
>>
> May I use a percpu val to record the order of processing softirq, by the order
> val, when it is in ksoftirqd we can process the pending softirq in order. In the
> scenario you described above, before ksoftirqd runs, bit 0 gets raised again,
> ksoftirqd runs and handles bit 1 by the percpu val. just like a ring.

Yes, you need something to save information about the not-processed
bits. Keeping track of which bit to process next works, but whether
that's going to result in efficient and simple code is a different
question.

Thanks,

        tglx

