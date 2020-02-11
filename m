Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C309C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D932073C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqdlIkql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgBKXbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:31:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52356 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727911AbgBKXbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581463871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+cFOa0w3KLlC+RAL3jce6oG/pms2+VbYregt8avzBA=;
        b=IqdlIkqlvPK7yX6FLtVn6JY7LMJEE+/WBs9qgZeTN8kM7y8kKkybOWqV117z+s3hfdVyzv
        eRTyCdfcIgvDqq2x8Z3AgigSc1YbfkYoF12ZaGJICl8lTCThdSjKZdMhVatWLRk9EM+Al9
        wh1mv6qBkdXN2lISHZ2y9wOxeRxXLbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-c4xth61jOHCBnJi1LdoZtQ-1; Tue, 11 Feb 2020 18:31:10 -0500
X-MC-Unique: c4xth61jOHCBnJi1LdoZtQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75561DB61;
        Tue, 11 Feb 2020 23:31:08 +0000 (UTC)
Received: from llong.remote.csb (ovpn-124-198.rdu2.redhat.com [10.10.124.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5520F5DA7B;
        Tue, 11 Feb 2020 23:31:07 +0000 (UTC)
Subject: Re: [PATCH 0/3] locking/mutex: Add mutex_timed_lock() to solve
 potential deadlock problems
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20200210204651.21674-1-longman@redhat.com>
 <20200211123138.GN14914@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a8f67483-5ae1-98b6-a1f8-5985e5a8f889@redhat.com>
Date:   Tue, 11 Feb 2020 18:31:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200211123138.GN14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/20 7:31 AM, Peter Zijlstra wrote:
> On Mon, Feb 10, 2020 at 03:46:48PM -0500, Waiman Long wrote:
>> An alternative solution proposed by this patchset is to add a new
>> mutex_timed_lock() call that allows an additional timeout argument. This
>> function will return an error code if timeout happens. The use of this
>> new API will prevent deadlock from happening while allowing the task
>> to wait a sufficient period of time before giving up.
> We've always rejected timed_lock implementation because, as akpm has
> already expressed, their need is disgusting.
>
That is fine. I will see if the lock order can be changed in a way to
address the problem.

Thanks,
Longman

