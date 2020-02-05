Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEDEC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606AE2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jv/U+us+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgBEODf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:03:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38217 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727468AbgBEODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580911414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+NpZFWNZ2f3MnvwKemG9bonuUWg6dLPQi0q8VHXlF0=;
        b=Jv/U+us+AbBvWnhuyCrzepLS07S0vacPoJGCkFK+eZhzRlZKP+3kc+ZwqnWKxpTQjObztl
        pHS8qsGNY1PKqmyi92MB28hc/XRWH2PWtHpVBcMu6eGHI/KoBeHoqkwWirk1bp47Rs04GU
        V6lmeAzLvrsUg3NjmAYS0ZrZuBayyEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-7xqNhPILPQiZkH1oJPITDg-1; Wed, 05 Feb 2020 09:03:30 -0500
X-MC-Unique: 7xqNhPILPQiZkH1oJPITDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46E771081FA1;
        Wed,  5 Feb 2020 14:03:29 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF2F419C7F;
        Wed,  5 Feb 2020 14:03:28 +0000 (UTC)
Subject: Re: [PATCH v5 6/7] locking/lockdep: Reuse freed chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-7-longman@redhat.com>
 <20200204154236.GE14879@hirez.programming.kicks-ass.net>
 <c1af8458-7269-53c3-59f4-b87c5d51c208@redhat.com>
 <16125cbf-09ee-919e-4b7a-33dabb123159@redhat.com>
 <f7f4151d-6514-be7b-1915-37f19411ca96@redhat.com>
 <20200205094838.GI14879@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <c3e01215-bb1c-e22a-32e3-f01e2e96584a@redhat.com>
Date:   Wed, 5 Feb 2020 09:03:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200205094838.GI14879@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/20 4:48 AM, Peter Zijlstra wrote:
> On Tue, Feb 04, 2020 at 11:57:09AM -0500, Waiman Long wrote:
>
>> Wait, it is possible that we can have deadlock like this:
>>
>> =C2=A0 cpu 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 cpu 1
>> =C2=A0 -----=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 -----
>> =C2=A0 lock A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 lock B
>> =C2=A0 <irq>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 <irq>
>> =C2=A0 lock B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 lock A
>> =C2=A0
>> If we eliminate 1-entry chain, will that impact our ability to detect =
this
>> kind of deadlock?
> I'm thinking that should trigger irq-inversion (irq-on vs in-irq) on
> either A or B (depending on timing).
>
> AFAICT the irq-state tracking is outside of validate_chain().
>
> This is also why I think your separate_irq_context() change is not
> needed.
>
> validate_chain() really only checks the per-context lock nesting, and
> there, a single lock doesn't do very much. Hence my proposed patch.
>
I see. Then it may be OK. I will take a further look just to be sure.

Cheers,
Longman

