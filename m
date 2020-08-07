Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CADAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AD0214F1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="j5Rhew5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgHGU3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:29:43 -0400
Received: from mail.efficios.com ([167.114.26.124]:33144 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:29:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2AEA32C6121;
        Fri,  7 Aug 2020 16:29:40 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qxyOHdzca4m8; Fri,  7 Aug 2020 16:29:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CAE8D2C6120;
        Fri,  7 Aug 2020 16:29:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CAE8D2C6120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1596832179;
        bh=BDuTAIZVzt/yLCVpzcSYLilNnLlB24W/njcdFI8ePlk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=j5Rhew5ghmAXwzxrVTjxCApH8IGBej/M8hTARJjfuYbk53b9a6rbgxflFH0Yp3lJk
         G6Qeexw0TFrwwneqFi7/GJCs2M34E9BHeAS1VP5FDdm2OAKXEf1VCAY1WA1iDZ3xLW
         Sj20Si/y7DzqzWusHtjojlSPJ4mHP1ngGq7/Wni97AdNMGqLPvyUdN+AoSiLYqzGho
         bXZyaT40uXTzERh+Q3pLYWakHjlHyRCvTi15fPmdt2bvZNTqk437Au86nGE+tA/mmS
         E25Kr7Gj9Ynl2DfN7Vn9VohJ08Toije4FJkcpH+YV42+77VKMnSOQP13mBFfm8EyyX
         SlFVZ1Y5ss2yQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SAY34DD3HB3t; Fri,  7 Aug 2020 16:29:39 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id BCC652C5CF1;
        Fri,  7 Aug 2020 16:29:39 -0400 (EDT)
Date:   Fri, 7 Aug 2020 16:29:39 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Oskolkov <posk@google.com>, paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Message-ID: <1107483937.2727.1596832179695.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAFTs51X_5=Z_Rxyz5NCzjtYTvB9EWWyH4tV=k_CWaRWqjed-6A@mail.gmail.com>
References: <20200806170544.382140-1-posk@google.com> <20200806170544.382140-2-posk@google.com> <20200807002705.GA889@tardis> <CAFTs51VNdN8t79Gr7R6H0rYVYSx1Qyd6YC4P89OYSmHKn_PXLQ@mail.gmail.com> <1745833987.2640.1596824715742.JavaMail.zimbra@efficios.com> <CAFTs51X_5=Z_Rxyz5NCzjtYTvB9EWWyH4tV=k_CWaRWqjed-6A@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] rseq/selftests: test
 MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq/selftests: test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
Thread-Index: aJvkWB672xPFzbgceHCarRh8ltcNlw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 7, 2020, at 2:47 PM, Peter Oskolkov posk@posk.io wrote:

> On Fri, Aug 7, 2020 at 11:25 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On Aug 7, 2020, at 1:55 PM, Peter Oskolkov posk@posk.io wrote:
>>
>> > On Thu, Aug 6, 2020 at 5:27 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>> [...]
>> >> What if the manager thread update ->percpu_list_ptr and call
>> >> membarrier() here? I.e.
>> >>
>> >>         CPU0                    CPU1
>> >>                                 list_ptr = atomic_load(&args->percpu_list_ptr); // read list_b
>> >>
>> >>         atomic_store(&args->percpu_list_ptr, list_a);
>> >>         sys_membarrier(MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU, 1); // send ipi to
>> >>         restart rseq.cs on CPU1
>> >>
>> >>                                 <got IPI, but not in a rseq.cs, so nothing to do>
>> >>                                 cpu = rseq_cpu_start(); // start a rseq.cs and accessing list_b!
>> >>
>> >> The thing is, atomic_load() is an reference to ->percpu_list_ptr, which
>> >> is outside the rseq.cs, simply restarting rseq doesn't kill this
>> >> reference.
>> >>
>> >> Am I missing something subtle?
>> >
>> > rseq_cmpeqv_cmpeqv_store is used below to make sure the reference is
>> > the one that should be used; if it is no longer "active", the
>> > iteration is restarted.
>>
>> I suspect it "works" because the manager thread does not free and
>> repurpose the memory where list_a is allocated, nor does it store to
>> its list head (which would corrupt the pointer dereferenced by CPU 1
>> in the scenario above). This shares similarities with type-safe memory
>> allocation (see SLAB_TYPESAFE_BY_RCU).
>>
>> Even though it is not documented as such (or otherwise) in the example code,
>> I feel this example looks like it guarantees that the manager thread "owns"
>> list_a after the rseq-fence, when in fact it can still be read by the rseq
>> critical sections.
>>
>> AFAIU moving the atomic_load(&args->percpu_list_ptr) into the critical section
>> should entirely solve this and guarantee exclusive access to the old list
>> after the manager's rseq-fence. I wonder why this simpler approach is not
>> favored ?
> 
> I think the test code mimics our actual production code, where the concerns
> you outlined are not particularly relevant. I'll see if the test can
> be simplified
> in v3 along the lines you suggested.

In order to implement that, you'll need to extend the rseq per-arch
macros. Here is one I did for x86 (but not all other arch) which dereferences
a pointer, adds an offset that the resulting address, and loads the contents
of that memory location, all within a rseq critical section. See
https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/include/rseq/rseq-x86.h#n1292

int rseq_deref_loadoffp(intptr_t *p, off_t voffp, intptr_t *load, int cpu)

I did that following a discussion with Paul Turner about the requirements for the
rseq fence.

For the use-case you have in this example, you will probably want to create a new

int rseq_deref_offset_addv(intptr_t *p, off_t voffp, intptr_t count, int cpu)

Which dereferences the list pointer and adds an offset within the critical section,
and then increments the value at that memory location as a commit.

offsetof() is very useful to generate the voffp argument.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
