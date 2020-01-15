Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A72C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AE824684
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGDXUQA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgAOT0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:26:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32751 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725999AbgAOT0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579116401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XzKnVd5XPZagi5I3mzSJAMyYWL/Qac21yo8CwdB8ouE=;
        b=MGDXUQA7AxYseH1OFtDJbOryLkYh53Jk6jnQHduPQTGEguSMbVCLFV9lEn1v6nZQBE22wG
        /1KK7e4E7Rf6unMDFzcS1a24mpWqphU+TH/5Btkdni5N8EKPosMW5jV1g4BmHFcrx5L9Q/
        XT4sNWZjoaJVJ0LgSG9Wvq5SgJA6iIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-MbbTRIyBOt-G005VWfOJ9g-1; Wed, 15 Jan 2020 14:26:40 -0500
X-MC-Unique: MbbTRIyBOt-G005VWfOJ9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71D8E107ACC7;
        Wed, 15 Jan 2020 19:26:39 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBA6E86CB7;
        Wed, 15 Jan 2020 19:26:38 +0000 (UTC)
Subject: Re: [PATCH v2 4/6] locking/lockdep: Reuse freed chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-5-longman@redhat.com>
 <20200113155823.GY2844@hirez.programming.kicks-ass.net>
 <e282e7f3-6010-ef13-bd07-524445049ef8@redhat.com>
 <20200114094656.GA2844@hirez.programming.kicks-ass.net>
 <b19df484-1d82-1014-1edf-a1294b4dcd09@redhat.com>
 <20200115104446.GK2827@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <6b3f5617-7c91-f013-039c-ed9c0ed13c68@redhat.com>
Date:   Wed, 15 Jan 2020 14:26:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200115104446.GK2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/20 5:44 AM, Peter Zijlstra wrote:
> On Tue, Jan 14, 2020 at 02:16:58PM -0500, Waiman Long wrote:
>> On 1/14/20 4:46 AM, Peter Zijlstra wrote:
>>> I'm thinking worst-fit might work well for our use-case. Best-fit would
>>> result in a heap of tiny fragments and we don't have really large
>>> allocations, which is the Achilles-heel of worst-fit.
>> I am going to add a patch to split chain block as a last resort in case
>> we run out of the main buffer.
> It will be the common path; you'll start with a single huge fragment.
>
> Remember, 1 allocator is better than 2.

One reason why I keep the array allocation code is because it is simple
and fast. Using a free block in the bucket will be a bit slower. Still
we are just dealing with the first block in the list as long as the size
isn't bigger than MAX_CHAIN_BUCKETS. Now if we need to deal with block
splitting (or even merging), it will be even more slow. Given the fact
that we are holding the graph lock in doing all these. It could have a
visible impact on performance.

That is the primary reason why I intend to allow block splitting only as
the last resort when the chain_hlocks array is running out.

>>> Also, since you put in a minimal allocation size of 2, but did not
>>> mandate size is a multiple of 2, there is a weird corner case of size-1
>>> fragments. The simplest case is to leak those, but put in a counter so
>>> we can see if they're a problem -- there is a fairly trivial way to
>>> recover them without going full merge.
>> There is no size-1 fragment. Are you referring to the those blocks with
>> a size of 2, but with only one entry used? There are some wasted space
>> there. I can add a counter to track that.
> There will be; imagine you have a size-6 fragment and request a size-5,
> then we'll have to split off one. But one is too short to encode on the
> free lists.
>
> Suppose you tag them with -2, then on free of the size-5, we can check
> if curr+size+1 is -2 and reunite.
>
> First-fit or best-fit would result in lots of that, hence my suggestion
> to use worst-fit if you can't find an exact match.
>
What I am thinking is to allow block splitting only if it has a size
that is at least 2 larger than the desire value. In that way, we will
not produce a fragment that is less than 2 in size. The down side is
that we have fewer viable candidates for splitting.

Cheers,
Longman

