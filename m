Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652F4C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3AB24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPDBuTtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgANPEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:04:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24554 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728935AbgANPEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579014271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6hFaOb0q+0e2hwbCTNrgpqathNKxW60FqCJIxBPb1XE=;
        b=RPDBuTtH++NkAArVwyMCJg6jhJjGjrvSuEoS664/yF57wUJUOyYKy6AWfPxgam7ZGOPfBO
        OrYHt5jultPKDb+tGVcEHwflzr+rjieo3pdWhqKe9evmyb1WXsqUnjrKJDuTtvAE7edqla
        VXAqqyPoM90eVhy+CcAB1cl1X+pBYsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-y6ASX3NIOv-65gdnIgmS0g-1; Tue, 14 Jan 2020 10:04:27 -0500
X-MC-Unique: y6ASX3NIOv-65gdnIgmS0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87BBA8024D1;
        Tue, 14 Jan 2020 15:04:26 +0000 (UTC)
Received: from llong.remote.csb (ovpn-124-77.rdu2.redhat.com [10.10.124.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF9981000232;
        Tue, 14 Jan 2020 15:04:25 +0000 (UTC)
Subject: Re: [PATCH v2 5/6] locking/lockdep: Decrement irq context counters
 when removing lock chain
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-6-longman@redhat.com>
 <20200114095345.GB2844@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <0ea82499-af07-6193-9672-4a1050442ada@redhat.com>
Date:   Tue, 14 Jan 2020 10:04:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200114095345.GB2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/20 4:53 AM, Peter Zijlstra wrote:
> On Mon, Dec 16, 2019 at 10:15:16AM -0500, Waiman Long wrote:
>> There are currently three counters to track the irq context of a lock
>> chain - nr_hardirq_chains, nr_softirq_chains and nr_process_chains.
>> They are incremented when a new lock chain is added, but they are
>> not decremented when a lock chain is removed. That causes some of the
>> statistic counts reported by /proc/lockdep_stats to be incorrect.
>>
>> Fix that by decrementing the right counter when a lock chain is removed.
>>
>> Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Fixes go at the start of a series, because if the depend on prior
> patches (as this one does) we cannot apply them.
>
Will put it at the front in the next version.

Cheers,
Longman

