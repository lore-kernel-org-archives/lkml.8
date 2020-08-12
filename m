Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2E1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B51E20781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VYvAT9cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHLSaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:30:05 -0400
Received: from mail.efficios.com ([167.114.26.124]:44340 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLSaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:30:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BA7D12D8D92;
        Wed, 12 Aug 2020 14:30:02 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aLaFTJWJDsWS; Wed, 12 Aug 2020 14:30:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3AB3A2D8AB7;
        Wed, 12 Aug 2020 14:30:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3AB3A2D8AB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1597257002;
        bh=wWKN0yaYQRTJWOSRXy8TRtHBowknCXyDteZ+yeYc/kI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=VYvAT9cpOSUz95bZF+jWy2g6as+sPCaFF6eZ+mivM3GmYgJJr4JvGbDwztXO36Q7G
         OwLfqgkcnX9pHa9whl2iWKVQIp4MlO0XsbHWYHM0Fi5An+brMqrSLjANvsLXIGwAOd
         GOh+cioA5Bk3hY6eH5tYrKKGD6EAq6k609Wddl54ExrT0rPMUH/fUoDVC1RiqITZtU
         U8grqhlh0zO1RaXi8UvHvDkNrN4aKdGkTq8He5t7MYxO+wpt3DZyR8nB0a9616wHiJ
         Oe/PHunctgixEtNjs+W0V/5JHP74GAsmxVywwsPpFVCvewviijrlLScBhZKZH5xEzB
         hgNhqj4Zy/big==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YSQWz5Y17whP; Wed, 12 Aug 2020 14:30:02 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1FB192D8AB6;
        Wed, 12 Aug 2020 14:30:02 -0400 (EDT)
Date:   Wed, 12 Aug 2020 14:30:02 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Peter Oskolkov <posk@google.com>, paulmck <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Message-ID: <1003774683.6088.1597257002027.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAFTs51XK0HLwCCvXCcfE5P7a4ExANPNPw7UvNigwHZ8sZVP+nQ@mail.gmail.com>
References: <20200811000959.2486636-1-posk@google.com> <20200811062733.GP3982@worktop.programming.kicks-ass.net> <CAFTs51XK0HLwCCvXCcfE5P7a4ExANPNPw7UvNigwHZ8sZVP+nQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] rseq/membarrier: add
 MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
Thread-Index: 5KvaIIh8ddLoPaEY5Z6fczm1Q7UhbQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Aug 11, 2020, at 5:08 PM, Peter Oskolkov posk@posk.io wrote:

> On Mon, Aug 10, 2020 at 11:27 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Mon, Aug 10, 2020 at 05:09:58PM -0700, Peter Oskolkov wrote:
>> > @@ -27,6 +35,12 @@
>> >
>> >  static void ipi_mb(void *info)
>> >  {
>>
>> The #ifdef wants to behere, otherwise you'll get a compile warning for
>> !RSEQ builds.
> 
> Ack. Will do in the next version - for now waiting for the rest to be
> worked out.
> 
> [...]
> 
>>
>> Mathieu did mention a few other points that I didn't see addressed:
>>
>>  - he didn't like abusing the @flags syscall argument for a CPUid;
> 
> @flags is not used now; maybe just rename it to something more
> generic? @param? Or @options? Or maybe more specific, like @cpu_id?

"flags" is there to allow extensibility without requiring to add new
membarrier commands for every change. Even though it is not used now,
I don't think re-purposing it is a good idea. What is wrong with just
adding an additional "cpu" parameter to the system call ?

A "flags" parameter is very common for system calls. I don't see why
we should change its name, especially given it is already exposed and
documented as "flags" in man pages.

> 
>>  - he wondered if we should support SYNC_CORE + RSEQ.
> 
> It seems to me that CMD_PRIVATE_EXPEDITED_RSEQ is basically
> CMD_PRIVATE_EXPEDITED_SYNC_CORE with the extra "restart RSEQ CSs"
> behavior. Am I missing something?

No. The "sync-core" is about doing context synchronization for JIts, and
is not implemented on all architectures today. RSEQ however is available
on a wider range of architectures.

> If not, what is the point of
> complicating the code as suggested below? Maybe just renaming
> CMD_PRIVATE_EXPEDITED_RSEQ to CMD_PRIVATE_EXPEDITED_SYNC_CORE_RSEQ
> will do?

We basically have the following feature matrix:

- private / global
- expedited / non-expedited
- sync-core / non-sync-core
- rseq-fence / non-rseq-fence

For a total of about 16 combinations in total if we want to support them
all.

We can continue to add separate commands for new combinations, but if we
want to allow them to be combined, using flags rather than adding extra
commands would have the advantage of keeping the number of commands
manageable.

However, if there is no actual use-case for combining a membarrier sync-core
and a membarrier rseq-fence, then it limits the number of commands and maybe
then it's acceptable to add the rseq-fence as a separate membarrier command.

I prefer to have this discussion now rather than once we get to the point of
having 40 membarrier commands for all possible combinations.

Thanks,

Mathieu

> 
>>
>>
>> Not sure we can easily change the syscall at this point, but the latter
>> point could be addressed with something like this.
>>
>> ---
>> Index: linux-2.6/kernel/sched/membarrier.c
>> ===================================================================
>> --- linux-2.6.orig/kernel/sched/membarrier.c
>> +++ linux-2.6/kernel/sched/membarrier.c
>> @@ -374,8 +374,26 @@ static int membarrier_register_private_e
>>   */
>>  SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
>>  {
>> +       int cflags = 0, int cpuid = -1;
>> +
>>         if (unlikely(flags) && cmd != MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)
>>                 return -EINVAL;
>> +
>> +       if (cmd & (MEMBARRIER_CMD_PRIVATE_EXPEDITED |
>> +                  MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE |
>> +                  MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)) {
>> +
>> +               if (cmd & MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)
>> +                       cflags |= MEMBARRIER_FLAG_RSEQ;
>> +
>> +               if (cmd & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
>> +                       cflags |= MEMBARRIER_FLAG_SYNC_CORE;
>> +                       cpuid = flags;
>> +               }
>> +
>> +               cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED;
>> +       }
>> +
>>         switch (cmd) {
>>         case MEMBARRIER_CMD_QUERY:
>>         {
>> @@ -396,18 +414,16 @@ SYSCALL_DEFINE2(membarrier, int, cmd, in
>>                 return membarrier_global_expedited();
>>         case MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED:
>>                 return membarrier_register_global_expedited();
>> -       case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
>> -               return membarrier_private_expedited(0, -1);
>>         case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED:
>>                 return membarrier_register_private_expedited(0);
>> -       case MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE:
>> -               return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE,
>> -1);
>>         case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE:
>>                 return membarrier_register_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
>> -       case MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
>> -               return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ,
>> flags);
>>         case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
>>                 return membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ);
>> +
>> +       case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
>> +               return membarrier_private_expedited(cflags, cpuid);
>> +
>>         default:
>>                 return -EINVAL;
>>         }

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
