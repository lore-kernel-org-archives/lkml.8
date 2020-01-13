Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8390EC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F76C2081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfiUEyQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgAMPom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:44:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52233 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726943AbgAMPom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578930280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=baGQEJFe1m8uz44ROty+5bEDcZTrF/M70P1MM+fc8Tk=;
        b=bfiUEyQfTAy6VDAmrhPbCQjh97mwehBTxiEZSYsiAz90+iXoxKOxd/7PO7OguEmYKFkpZi
        Hi50e14eAYzjtujbrvokcF8+ycX6r0t8c3nd3cS/sD7zKiTRzFYx5+KvHHWfI3y0V3y9tD
        LVwZULKIBvHp80JMeBJMR+6QaKefBQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-aKv1uNXONtiWhRNB4C5uNw-1; Mon, 13 Jan 2020 10:44:39 -0500
X-MC-Unique: aKv1uNXONtiWhRNB4C5uNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BBAD19586C4;
        Mon, 13 Jan 2020 15:44:38 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F6F55C1B0;
        Mon, 13 Jan 2020 15:44:37 +0000 (UTC)
Subject: Re: [PATCH v2 2/6] locking/lockdep: Throw away all lock chains with
 zapped class
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-3-longman@redhat.com>
 <20200113151806.GW2844@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2c742217-fa18-bf87-2c0d-2c7f95887646@redhat.com>
Date:   Mon, 13 Jan 2020 10:44:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200113151806.GW2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/20 10:18 AM, Peter Zijlstra wrote:
> On Mon, Dec 16, 2019 at 10:15:13AM -0500, Waiman Long wrote:
>> If a lock chain contains a class that is zapped, the whole lock chain is
>> now invalid.
> Possibly. But I'm thinking that argument can/should be made mode elaborate.
>
> Suppose we have A->B->C, and we're about to remove B.
>
> Now, I suppose the trivial argument goes that if we remove the text that
> causes A->B, then so B->C will no longer happen. However, that doesn't
> mean A->C won't still occur.
>
> OTOH, we might already have A->C and so our resulting chain would be a
> duplicate. Conversely, if we didn't already have A->C and it does indeed
> still occur (say it was omitted due to the redundant logic), then we
> will create this dependency the next time we'll encounter it.
I will prefer having it only when it actually happens rather than
leaving a partial chain behind assuming that it may happen.
>
> Bart, do you see a problem with this reasoning?
>
> In short, yes, I think you're right and we can remove the whole thing.
> But please, expand the Changelog a bit, possibly add some of this
> reasoning into a comment.
>
Yes, I will elaborate more in the changelog.

Cheers,
Longman

