Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CDDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A8F204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jX0++gUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgHGSZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:25:17 -0400
Received: from mail.efficios.com ([167.114.26.124]:34046 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGSZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 14:25:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2C2172C5413;
        Fri,  7 Aug 2020 14:25:16 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xA9g-c6Pskj9; Fri,  7 Aug 2020 14:25:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DDAB22C5412;
        Fri,  7 Aug 2020 14:25:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DDAB22C5412
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1596824715;
        bh=Fk7L47iTkSwZpfKYXHhMx/3iZW27NHUzuAWcFK9emjY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jX0++gUubwjvR8YKjXX6OXk4Ub+pQP9clE12B+bHSzYzElYrbvKeJO6RCDnAWP723
         I238ewjAMDukclMZpxs3UfGTGCpgm/VvZTOSLa2vWPIDsUsZ9hEM7Pb02TTZg84OHS
         YGmX3bwrB+mcxOFPPd3NiKsMK5GP7rW4Qz9urorlllU9VBbmTgxVDQbBnp4L1OL314
         a6kn1q6q06NmodgL3q5s2LrNZ16JbIptHDrMsDc0aggzR/4MLYRLwf35nK83ScIQSJ
         DU9Vw3jE+6SK1Z37f3i2auAusKi7T8e632I66NkaxiXTo9pb+ACMW7DkbBS3pqT+TL
         GeZDz0Q75Komg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KFo8OEDB8er2; Fri,  7 Aug 2020 14:25:15 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id CABDE2C4E6F;
        Fri,  7 Aug 2020 14:25:15 -0400 (EDT)
Date:   Fri, 7 Aug 2020 14:25:15 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Oskolkov <posk@google.com>, paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Message-ID: <1745833987.2640.1596824715742.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAFTs51VNdN8t79Gr7R6H0rYVYSx1Qyd6YC4P89OYSmHKn_PXLQ@mail.gmail.com>
References: <20200806170544.382140-1-posk@google.com> <20200806170544.382140-2-posk@google.com> <20200807002705.GA889@tardis> <CAFTs51VNdN8t79Gr7R6H0rYVYSx1Qyd6YC4P89OYSmHKn_PXLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] rseq/selftests: test
 MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq/selftests: test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
Thread-Index: wGhwrykpufytkyWLEFxWHunBY+rpvQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 7, 2020, at 1:55 PM, Peter Oskolkov posk@posk.io wrote:

> On Thu, Aug 6, 2020 at 5:27 PM Boqun Feng <boqun.feng@gmail.com> wrote:
[...]
>> What if the manager thread update ->percpu_list_ptr and call
>> membarrier() here? I.e.
>>
>>         CPU0                    CPU1
>>                                 list_ptr = atomic_load(&args->percpu_list_ptr); // read list_b
>>
>>         atomic_store(&args->percpu_list_ptr, list_a);
>>         sys_membarrier(MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU, 1); // send ipi to
>>         restart rseq.cs on CPU1
>>
>>                                 <got IPI, but not in a rseq.cs, so nothing to do>
>>                                 cpu = rseq_cpu_start(); // start a rseq.cs and accessing list_b!
>>
>> The thing is, atomic_load() is an reference to ->percpu_list_ptr, which
>> is outside the rseq.cs, simply restarting rseq doesn't kill this
>> reference.
>>
>> Am I missing something subtle?
> 
> rseq_cmpeqv_cmpeqv_store is used below to make sure the reference is
> the one that should be used; if it is no longer "active", the
> iteration is restarted.

I suspect it "works" because the manager thread does not free and
repurpose the memory where list_a is allocated, nor does it store to
its list head (which would corrupt the pointer dereferenced by CPU 1
in the scenario above). This shares similarities with type-safe memory
allocation (see SLAB_TYPESAFE_BY_RCU).

Even though it is not documented as such (or otherwise) in the example code,
I feel this example looks like it guarantees that the manager thread "owns"
list_a after the rseq-fence, when in fact it can still be read by the rseq
critical sections.

AFAIU moving the atomic_load(&args->percpu_list_ptr) into the critical section
should entirely solve this and guarantee exclusive access to the old list
after the manager's rseq-fence. I wonder why this simpler approach is not
favored ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
