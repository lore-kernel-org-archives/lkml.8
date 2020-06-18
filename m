Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5570EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E9520890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijjGELKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgFRU70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:59:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27003 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726478AbgFRU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592513964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2iDTwr+/iWvsdg/YE4W4q4L8qhRtiVj32UpGEhBg6Zs=;
        b=ijjGELKAgzCuAxQiEFaeMtxy0HDr59QFyDgsOphcvYUVjO5Ftkecj1gPJ8vNE20vFFZ77H
        vnY2On8n/JVR/W7TVguU8Vi0jGt6Q/C/V6QaOP7ecD2fMAHsYyF2tsCsYVaa23yUw3z/9f
        K3C3RXF13C2eI1gMcojfLi2FDMXt1T8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-CkW3-5CMNT632YrXDGbmzw-1; Thu, 18 Jun 2020 16:59:20 -0400
X-MC-Unique: CkW3-5CMNT632YrXDGbmzw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 442C4107ACF4;
        Thu, 18 Jun 2020 20:59:19 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-66.rdu2.redhat.com [10.10.118.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70B4A5C1D0;
        Thu, 18 Jun 2020 20:59:18 +0000 (UTC)
Subject: Re: [PATCH] sched, mm: Optimize current_gfp_context()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michel Lespinasse <walken@google.com>,
        linux-kernel@vger.kernel.org
References: <20200618155847.30975-1-longman@redhat.com>
 <20200618160726.GL576905@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <6333186c-224a-fb84-7304-ca7c6c903c13@redhat.com>
Date:   Thu, 18 Jun 2020 16:59:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200618160726.GL576905@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/20 12:07 PM, Peter Zijlstra wrote:
> On Thu, Jun 18, 2020 at 11:58:47AM -0400, Waiman Long wrote:
>> The current_gfp_context() converts a number of PF_MEMALLOC_* per-process
>> flags into the corresponding GFP_* flags for memory allocation. In
>> that function, current->flags is accessed 3 times. That may lead to
>> duplicated access of the same memory location.
>>
>> This is not usually a problem with minimal debug config options on as the
>> compiler can optimize away the duplicated memory accesses.  With most
>> of the debug config options on, however, that may not be the case.
>> For example, the x86-64 object size of the __need_fs_reclaim() in a
>> debug kernel that calls current_gfp_context() was 309 bytes. With this
>> patch applied, the object size is reduced to 202 bytes. This is a saving
>> of 107 bytes and will probably be slightly faster too.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   include/linux/sched/mm.h | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
>> index 480a4d1b7dd8..09e01909d192 100644
>> --- a/include/linux/sched/mm.h
>> +++ b/include/linux/sched/mm.h
>> @@ -181,18 +181,20 @@ static inline bool in_vfork(struct task_struct *tsk)
>>    */
>>   static inline gfp_t current_gfp_context(gfp_t flags)
>>   {
>> -	if (unlikely(current->flags &
>> +	unsigned int pflags = current->flags;
> Per the above, I would've expected a READ_ONCE() there, otherwise the
> compiler can still re-load.
>
Right. Will do that.

Thanks,
Longman

