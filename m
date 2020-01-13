Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2B8C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F861214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9221E/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgAMQPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:15:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46323 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726943AbgAMQPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578932122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3mlCkJMsLpw+SY5FW87kY6PYrhBEWZmLQN5bzMC5RGo=;
        b=a9221E/gQpEXyJvNWyWJAMJTx8OtX+BaYZbCEQCqKX8eILl2eAUVyTQ8mhu5YKb8nRs8ya
        CQkXSSYtYKYnBumtzXHGf51dN0CxpuAgZWvuKWNsBxP14PWmFbnShIpfZJ8bmplnW7Qmz5
        VX6IqWOx+s+iSECUzPghcQOjcLINEtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-RLZL7YHwPzCnkH-ysWJdsA-1; Mon, 13 Jan 2020 11:15:18 -0500
X-MC-Unique: RLZL7YHwPzCnkH-ysWJdsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DA2E63CC2;
        Mon, 13 Jan 2020 16:15:17 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B1BA19756;
        Mon, 13 Jan 2020 16:15:16 +0000 (UTC)
Subject: Re: [PATCH v2 2/6] locking/lockdep: Throw away all lock chains with
 zapped class
To:     Bart Van Assche <bvanassche@acm.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-3-longman@redhat.com>
 <20200113151806.GW2844@hirez.programming.kicks-ass.net>
 <8bf44cb0-81fa-1056-0158-7c14ee424044@acm.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <eceba096-0f59-5093-e19c-42f53dbe51b5@redhat.com>
Date:   Mon, 13 Jan 2020 11:15:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8bf44cb0-81fa-1056-0158-7c14ee424044@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/20 11:05 AM, Bart Van Assche wrote:
> On 1/13/20 7:18 AM, Peter Zijlstra wrote:
>> On Mon, Dec 16, 2019 at 10:15:13AM -0500, Waiman Long wrote:
>>> If a lock chain contains a class that is zapped, the whole lock
>>> chain is
>>> now invalid.
>>
>> Possibly. But I'm thinking that argument can/should be made mode
>> elaborate.
>>
>> Suppose we have A->B->C, and we're about to remove B.
>>
>> Now, I suppose the trivial argument goes that if we remove the text that
>> causes A->B, then so B->C will no longer happen. However, that doesn't
>> mean A->C won't still occur.
>>
>> OTOH, we might already have A->C and so our resulting chain would be a
>> duplicate. Conversely, if we didn't already have A->C and it does indeed
>> still occur (say it was omitted due to the redundant logic), then we
>> will create this dependency the next time we'll encounter it.
>>
>> Bart, do you see a problem with this reasoning?
>>
>> In short, yes, I think you're right and we can remove the whole thing.
>> But please, expand the Changelog a bit, possibly add some of this
>> reasoning into a comment.
>
> I think unconditionally dropping lock chains is wrong. If a lock class
> is zapped the rest of the lock chain remains valid and hence should be
> retained unless it duplicates another lock chain or if the length of
> the lock chain is reduced to a single element. 

If the zapped class is at the end of the chain, the shorten one without
the zapped class should have been stored already as the current code
will store all its predecessor chains. If it is somewhere in the middle,
there is no guarantee that the partial chain will actually happen. It
may just clutter up the hash and make searching slower. Why don't we
just store it when it actually happens?

Cheers,
Longman

