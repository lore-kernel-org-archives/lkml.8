Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772F7C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498E32081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHEwTrMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgAMO6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:58:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21796 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728843AbgAMO6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578927518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0iWBtjb/6H1xhRa1v3TPsGTDIS/S6k7aw42PEobHbYw=;
        b=NHEwTrMwfykcAI9PlOKEyLWzwEk2kqwhdHXX0lnKwmpJXJEceD3txx5Ukso34rn0fIUR+r
        8H02ydPX/eKZ/NS3W4jWmhR/gsW6BU/I4sQ8/zBWIyzfaYVvoqAWA8V6DVKfmgZYsWuufQ
        eHr0eKVeeYBOX3z+eEbEx1q6mXKH6cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-a5a4ngezNMODdqjQUq1ofA-1; Mon, 13 Jan 2020 09:58:31 -0500
X-MC-Unique: a5a4ngezNMODdqjQUq1ofA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 522D31856A63;
        Mon, 13 Jan 2020 14:58:30 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3F3560BE2;
        Mon, 13 Jan 2020 14:58:29 +0000 (UTC)
Subject: Re: [PATCH v2 1/6] locking/lockdep: Track number of zapped classes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-2-longman@redhat.com>
 <20200113145542.GV2844@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <137a3e75-ca3c-2222-d2af-a6b7bb692b66@redhat.com>
Date:   Mon, 13 Jan 2020 09:58:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200113145542.GV2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/20 9:55 AM, Peter Zijlstra wrote:
> On Mon, Dec 16, 2019 at 10:15:12AM -0500, Waiman Long wrote:
>> The whole point of the lockdep dynamic key patch is to allow unused
>> locks to be removed from the lockdep data buffers so that existing
>> buffer space can be reused. However, there is no way to find out how
>> many unused locks are zapped and so we don't know if the zapping process
>> is working properly.
>>
>> Add a new nr_zapped_classes variable to track that and show it in
>> /proc/lockdep_stats if it is non-zero.
>>
>> diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
>> index dadb7b7fba37..d98d349bb648 100644
>> --- a/kernel/locking/lockdep_proc.c
>> +++ b/kernel/locking/lockdep_proc.c
>> @@ -336,6 +336,15 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
>>  	seq_printf(m, " debug_locks:                   %11u\n",
>>  			debug_locks);
>>  
>> +	/*
>> +	 * Zappped classes and lockdep data buffers reuse statistics.
>> +	 */
>> +	if (!nr_zapped_classes)
>> +		return 0;
>> +
>> +	seq_puts(m, "\n");
>> +	seq_printf(m, " zapped classes:                %11lu\n",
>> +			nr_zapped_classes);
>>  	return 0;
>>  }
> Why is that conditional?
>
Because I thought zapping class doesn't occur that often. Apparently,
class zapping happens when the system first boots up. I guess that
conditional check isn't needed. I can remove it in the next version.

Cheers,
Longman

