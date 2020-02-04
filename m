Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B35C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 16:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EC52087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 16:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfPi7CGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgBDQ1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:27:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60139 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727336AbgBDQ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 11:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580833625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7UfeUadWGEMW1NQQDMTb46Kq24+b/r0Da8oMBdBFtk8=;
        b=FfPi7CGiKXNPhNUap0OsIK9RWAqqg3h6x9cR8JzHj/A1cH+p0fcfyBdvguvvJ2GHOfr/NA
        uZvG8j7JqSPMX7GdJ62dJ5SRx+jLgl0VAfbC9kmL3D+1nsTeRHmNLbpgw4QOhwj5XVLoFm
        0i2PmeVdP8bEFAvGZSOT3MAHwVN9kSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-bUZ9P-RVMyOj2_w0T8-OiQ-1; Tue, 04 Feb 2020 11:26:59 -0500
X-MC-Unique: bUZ9P-RVMyOj2_w0T8-OiQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95BB4802586;
        Tue,  4 Feb 2020 16:26:58 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04D9B857AF;
        Tue,  4 Feb 2020 16:26:56 +0000 (UTC)
Subject: Re: [PATCH v5 6/7] locking/lockdep: Reuse freed chain_hlocks entries
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-7-longman@redhat.com>
 <20200204154236.GE14879@hirez.programming.kicks-ass.net>
 <c1af8458-7269-53c3-59f4-b87c5d51c208@redhat.com>
Organization: Red Hat
Message-ID: <16125cbf-09ee-919e-4b7a-33dabb123159@redhat.com>
Date:   Tue, 4 Feb 2020 11:26:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c1af8458-7269-53c3-59f4-b87c5d51c208@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/20 11:12 AM, Waiman Long wrote:
> On 2/4/20 10:42 AM, Peter Zijlstra wrote:
>> On Mon, Feb 03, 2020 at 11:41:46AM -0500, Waiman Long wrote:
>>> +	/*
>>> +	 * We require a minimum of 2 (u16) entries to encode a freelist
>>> +	 * 'pointer'.
>>> +	 */
>>> +	req =3D max(req, 2);
>> Would something simple like the below not avoid that whole 1 entry
>> 'chain' nonsense?
>>
>> It boots and passes the selftests, so it must be perfect :-)
>>
>> --- a/kernel/locking/lockdep.c
>> +++ b/kernel/locking/lockdep.c
>> @@ -3163,7 +3163,7 @@ static int validate_chain(struct task_st
>>  	 * (If lookup_chain_cache_add() return with 1 it acquires
>>  	 * graph_lock for us)
>>  	 */
>> -	if (!hlock->trylock && hlock->check &&
>> +	if (!chain_head && !hlock->trylock && hlock->check &&
>>  	    lookup_chain_cache_add(curr, hlock, chain_key)) {
>>  		/*
>>  		 * Check whether last held lock:
>>
> Well, I think that will eliminate the 1-entry chains for the process
> context. However, we can still have 1-entry chain in the irq context, I
> think, as long as there are process context locks in front of it.
>
> I think this fix is still worthwhile as it will eliminate some of the
> 1-entry chains.

Sorry, I think I mis-read the code. This patch will eliminate some
cross-context check. How=C2=A0 about something like

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 32406ef0d6a2..d746897b638f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2931,7 +2931,7 @@ static int validate_chain(struct task_struct *curr,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (If lookup_chain_cache=
_add() return with 1 it acquires
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * graph_lock for us)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!hlock->trylock && hlock->check=
 &&
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((chain_head !=3D 1) && !hlock->=
trylock && hlock->check &&
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lookup=
_chain_cache_add(curr, hlock, chain_key)) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /*
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * Check whether last held lock:
@@ -3937,7 +3937,7 @@ static int __lock_acquire(struct lockdep_map
*lock, unsign
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hlock->prev_chain_key =3D chai=
n_key;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (separate_irq_context(curr,=
 hlock)) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 chain_key =3D INITIAL_CHAIN_KEY;
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 chain_head =3D 1;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 chain_head =3D 2; /* Head of irq context chain */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chain_key =3D iterate_chain_ke=
y(chain_key, class_idx);
=C2=A0
Cheers,
Longman

