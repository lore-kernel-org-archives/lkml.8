Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C77BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F02652070A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgESUeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgESUeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:34:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE1DC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:34:24 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jb8wP-0001Ip-0I; Tue, 19 May 2020 22:34:21 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 2/3] printk: add lockless buffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
        <20200501094010.17694-3-john.ogness@linutronix.de>
        <87v9ktcs3q.fsf@vostro.fn.ogness.net>
        <CAHk-=whSLRiNxehLiuX+ZfHsu8Kpj7R1Sdr3zA7==SMW0zh3ug@mail.gmail.com>
Date:   Tue, 19 May 2020 22:34:19 +0200
In-Reply-To: <CAHk-=whSLRiNxehLiuX+ZfHsu8Kpj7R1Sdr3zA7==SMW0zh3ug@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 18 May 2020 10:22:30 -0700")
Message-ID: <87tv0bhdf8.fsf@vostro.fn.ogness.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-18, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>                 smp_mb(); /* LMM(data_push_tail:C) */
>>
>> +               if (atomic_long_try_cmpxchg_relaxed(&data_ring->tail_lpos,
>> +                               &tail_lpos,
>> +                               next_lpos)) { /* LMM(data_push_tail:D) */
>> +                       break;
>> +               }
>
> Doing an "smp_mb()" followed by a "cmpxchg_relaxed" seems all kinds of
> odd and pointless, and is very much non-optimal on x86 for example.,
>
> Just remove the smp_mb(), and use the non-relaxed form of cmpxchg.
> It's defined to be fully ordered if it succeeds (and if the cmpxchg
> doesn't succeed, it's a no-op and the memory barrier shouldn't make
> any difference).
>
> Otherwise you'll do two memory ordering operations on x86 (and
> probably some other architectures), since the cmpxchg is always
> ordered on x86 and there exists no "relaxed" form of it.

ACK.

All three smp_mb()'s and both smp_wmb()'s sit directly next to
cmpxchg_relaxed() calls. Having explicit memory barriers was helpful for
identifying, proving, and testing a minimal set of pairs (on arm64), but
all will be folded into full cmpxchg()'s for the next version.

John Ogness
