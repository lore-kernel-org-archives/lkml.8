Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C164AC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 16:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9642020674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 16:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUIkN4Fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgBDQ5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:57:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46364 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727307AbgBDQ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 11:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580835436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DsLUlmM8amVB646CyMdGtPNN2CTcMFvRObmyUEoXhx4=;
        b=TUIkN4FxXIReUIkZn41XHYFKdCCSj1q/w5TUVD4m0tRVGfc3eD/f73RIZX95Ks0dxMrfqa
        woqqGvRR7RTliV4h2Gjo9qpFjay4Z9ud0IilESZU+V3IF67nf9FmwzIZuJsa0ZQJtieWN1
        hCitFs867bxZEyU+aBJLhm6IBws5Zww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-AbcTWx2bNgunaM_Q6RNxhQ-1; Tue, 04 Feb 2020 11:57:12 -0500
X-MC-Unique: AbcTWx2bNgunaM_Q6RNxhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCBB0801A00;
        Tue,  4 Feb 2020 16:57:10 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F80A60BF4;
        Tue,  4 Feb 2020 16:57:10 +0000 (UTC)
Subject: Re: [PATCH v5 6/7] locking/lockdep: Reuse freed chain_hlocks entries
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-7-longman@redhat.com>
 <20200204154236.GE14879@hirez.programming.kicks-ass.net>
 <c1af8458-7269-53c3-59f4-b87c5d51c208@redhat.com>
 <16125cbf-09ee-919e-4b7a-33dabb123159@redhat.com>
Organization: Red Hat
Message-ID: <f7f4151d-6514-be7b-1915-37f19411ca96@redhat.com>
Date:   Tue, 4 Feb 2020 11:57:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <16125cbf-09ee-919e-4b7a-33dabb123159@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/20 11:26 AM, Waiman Long wrote:
> On 2/4/20 11:12 AM, Waiman Long wrote:
>> On 2/4/20 10:42 AM, Peter Zijlstra wrote:
>>> On Mon, Feb 03, 2020 at 11:41:46AM -0500, Waiman Long wrote:
>>>> +	/*
>>>> +	 * We require a minimum of 2 (u16) entries to encode a freelist
>>>> +	 * 'pointer'.
>>>> +	 */
>>>> +	req =3D max(req, 2);
>>> Would something simple like the below not avoid that whole 1 entry
>>> 'chain' nonsense?
>>>
>>> It boots and passes the selftests, so it must be perfect :-)
>>>
>>> --- a/kernel/locking/lockdep.c
>>> +++ b/kernel/locking/lockdep.c
>>> @@ -3163,7 +3163,7 @@ static int validate_chain(struct task_st
>>>  	 * (If lookup_chain_cache_add() return with 1 it acquires
>>>  	 * graph_lock for us)
>>>  	 */
>>> -	if (!hlock->trylock && hlock->check &&
>>> +	if (!chain_head && !hlock->trylock && hlock->check &&
>>>  	    lookup_chain_cache_add(curr, hlock, chain_key)) {
>>>  		/*
>>>  		 * Check whether last held lock:
>>>
>> Well, I think that will eliminate the 1-entry chains for the process
>> context. However, we can still have 1-entry chain in the irq context, =
I
>> think, as long as there are process context locks in front of it.
>>
>> I think this fix is still worthwhile as it will eliminate some of the
>> 1-entry chains.
> Sorry, I think I mis-read the code. This patch will eliminate some
> cross-context check. How=C2=A0 about something like
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 32406ef0d6a2..d746897b638f 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2931,7 +2931,7 @@ static int validate_chain(struct task_struct *cur=
r,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (If lookup_chain_cac=
he_add() return with 1 it acquires
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * graph_lock for us)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!hlock->trylock && hlock->che=
ck &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((chain_head !=3D 1) && !hlock=
->trylock && hlock->check &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 look=
up_chain_cache_add(curr, hlock, chain_key)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * Check whether last held lock:
> @@ -3937,7 +3937,7 @@ static int __lock_acquire(struct lockdep_map
> *lock, unsign
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hlock->prev_chain_key =3D ch=
ain_key;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (separate_irq_context(cur=
r, hlock)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 chain_key =3D INITIAL_CHAIN_KEY;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 chain_head =3D 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 chain_head =3D 2; /* Head of irq context chain */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chain_key =3D iterate_chain_=
key(chain_key, class_idx);

Wait, it is possible that we can have deadlock like this:

=C2=A0 cpu 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cpu 1
=C2=A0 -----=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 -----
=C2=A0 lock A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 lock B
=C2=A0 <irq>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 <irq>
=C2=A0 lock B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 lock A
=C2=A0
If we eliminate 1-entry chain, will that impact our ability to detect thi=
s
kind of deadlock?

Thanks,
Longman

