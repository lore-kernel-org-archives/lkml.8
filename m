Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29821C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F176D2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/i24iBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgBEN73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:59:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40086 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726822AbgBEN72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580911166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sEKZAVbhR+WgDA9hgYDagd1h+xb9JnJDbusY+IWYcbs=;
        b=h/i24iBBJ59XlVujfYxAAhF8ExgZ//y/GIerZR7Ib8zriwZcJy4J1DoCn1H1JOLhr+UBTF
        29BuNmiEq9zfoP7ZpltU9MR8BAkTorY6jl+7slytKQzsyPRXkvyWZiIJqWCz9dZ4KwIl6I
        nmuPJImMqANNV3gO+rQihHqOZ2um1UQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-12VBgNs8OyuTH5ISjPH0AA-1; Wed, 05 Feb 2020 08:59:25 -0500
X-MC-Unique: 12VBgNs8OyuTH5ISjPH0AA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD6491088387;
        Wed,  5 Feb 2020 13:59:23 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1799D790C5;
        Wed,  5 Feb 2020 13:59:23 +0000 (UTC)
Subject: Re: [PATCH v5 6/7] locking/lockdep: Reuse freed chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-7-longman@redhat.com>
 <20200204123629.GO14914@hirez.programming.kicks-ass.net>
 <8fd7ce61-d8eb-6bde-7d41-54b9920e3e39@redhat.com>
 <20200205094153.GH14879@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <f475cd25-2b63-39bc-c18c-14ac7274428b@redhat.com>
Date:   Wed, 5 Feb 2020 08:59:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200205094153.GH14879@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/20 4:41 AM, Peter Zijlstra wrote:
> On Tue, Feb 04, 2020 at 11:45:15AM -0500, Waiman Long wrote:
>> On 2/4/20 7:36 AM, Peter Zijlstra wrote:
>>> --- a/kernel/locking/lockdep_proc.c
>>> +++ b/kernel/locking/lockdep_proc.c
>>> @@ -278,9 +278,11 @@ static int lockdep_stats_show(struct seq
>>>  #ifdef CONFIG_PROVE_LOCKING
>>>  	seq_printf(m, " dependency chains:             %11lu [max: %lu]\n",
>>>  			lock_chain_count(), MAX_LOCKDEP_CHAINS);
>>> -	seq_printf(m, " dependency chain hlocks:       %11lu [max: %lu]\n",
>>> -			MAX_LOCKDEP_CHAIN_HLOCKS - nr_free_chain_hlocks,
>>> +	seq_printf(m, " dependency chain hlocks used:  %11lu [max: %lu]\n",
>>> +			MAX_LOCKDEP_CHAIN_HLOCKS - (nr_free_chain_hlocks - nr_lost_chain_=
hlocks),
>>>  			MAX_LOCKDEP_CHAIN_HLOCKS);
>>> +	seq_printf(m, " dependency chain hlocks free:  %11lu\n", nr_free_ch=
ain_hlocks);
>>> +	seq_printf(m, " dependency chain hlocks lost:  %11lu\n", nr_lost_ch=
ain_hlocks);
>> I do have some comments on this. There are three buckets now - free,
>> lost, used. They add up to MAX_LOCKDEP_CHAIN_HLOCKS. I don't think we
>> need to list all three. We can compute the third one by subtracting ma=
x
>> from the other two.
>>
>> Something like:
>>
>> diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_pr=
oc.c
>> index 14932ea50317..6fe6a21c58d3 100644
>> --- a/kernel/locking/lockdep_proc.c
>> +++ b/kernel/locking/lockdep_proc.c
>> @@ -278,9 +278,12 @@ static int lockdep_stats_show(struct seq_file *m,
>> void *v)
>> =C2=A0#ifdef CONFIG_PROVE_LOCKING
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(m, " dependency =
chains:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 %11lu [max: %lu]\n",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_c=
hain_count(), MAX_LOCKDEP_CHAINS);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(m, " dependency chain=
 hlocks:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %11lu [max: %lu]\n",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX_LOCKD=
EP_CHAIN_HLOCKS - nr_free_chain_hlocks,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(m, " dependency chain=
 hlocks used:=C2=A0 %11lu [max: %lu]\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX_LOCKD=
EP_CHAIN_HLOCKS -
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (nr_free_=
chain_hlocks + nr_lost_chain_hlocks),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX_LO=
CKDEP_CHAIN_HLOCKS);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(m, " dependency chain=
 hlocks lost:=C2=A0 %11lu\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_lost_c=
hain_hlocks);
>> =C2=A0#endif
>> =C2=A0
> Sure, also I tihnk the compiler is unhappy about %lu vs 'unsigned int'
> for some of them.
>
Yes, I found that after I compiled the code :-)

Cheers,
Longman

