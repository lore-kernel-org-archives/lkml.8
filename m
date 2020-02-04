Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF094C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47A92166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMvYKY8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgBDPHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:07:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26407 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727250AbgBDPHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580828841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46Hve1xGM0GGqa7rzvMjQWFlUurdVpAqG0btxaN0zug=;
        b=PMvYKY8dAV6V1o0vIA9g8iVolCFAq0SMc+HUWrcoU5SGcRZMcSVx4y4tq0/ZDF9tgY0Aos
        5l6u9Wcz3AOwn0G6K5xanTqC7PFM+7OkSa3+rORyUF0aJ2jAcEmnELUWrSTAMS1G+Ox+kx
        CQS9TZmaF/VmuxgYLG/B3lG8lcpzERw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-tc5T4KB3OT2jXWQJVkTQfA-1; Tue, 04 Feb 2020 10:07:17 -0500
X-MC-Unique: tc5T4KB3OT2jXWQJVkTQfA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 574F318AB2E5;
        Tue,  4 Feb 2020 15:07:16 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6D2A60BF7;
        Tue,  4 Feb 2020 15:07:15 +0000 (UTC)
Subject: Re: [PATCH v5 7/7] locking/lockdep: Add a fast path for chain_hlocks
 allocation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-8-longman@redhat.com>
 <20200204124759.GP14914@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <40c89da9-999d-63e6-5a6b-9e7001af678f@redhat.com>
Date:   Tue, 4 Feb 2020 10:07:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200204124759.GP14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/20 7:47 AM, Peter Zijlstra wrote:
> On Mon, Feb 03, 2020 at 11:41:47AM -0500, Waiman Long wrote:
>> When alloc_chain_hlocks() is called, the most likely scenario is
>> to allocate from the primordial chain block which holds the whole
>> chain_hlocks[] array initially. It is the primordial chain block if its
>> size is bigger than MAX_LOCK_DEPTH. As long as the number of entries left
>> after splitting is still bigger than MAX_CHAIN_BUCKETS it will remain
>> in bucket 0. By splitting out a sub-block at the end, we only need to
>> adjust the size without changing any of the existing linkage information.
>> This optimized fast path can reduce the latency of allocation requests.
>>
>> This patch does change the order by which chain_hlocks entries are
>> allocated. The original code allocates entries from the beginning of
>> the array. Now it will be allocated from the end of the array backward.
> Cute; but why do we care? Is there any measurable performance indicator?
>
I used parallel kernel compilation test to see if there is a performance
benefit. I did see the compile time get reduced by a few seconds out of
several minutes of total time on average. So it is only about 1% or so.
I didn't mention it as it is within the margin of error.

One of the goals of this patchset is to make sure that little or no
performance regression is introduced. That was why I was hesitant to
adopt the single allocator approach as suggested. That is also why I add
this patch to try to get some performance back.

Cheers,
Longman

