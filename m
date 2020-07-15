Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85757C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605F620663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVSAsZi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgGOQdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:33:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38731 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725861AbgGOQdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594830815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ueTi4W83G6jGz9HNkJRAJrjkHVYlLXifzOX2E3CXOU=;
        b=XVSAsZi+B2hn9nMgtjbKlujXrterSC68X96v2usM9Bwqwy7Eu7JurHDRd2piNafB0Aw/LY
        NGfCsoKZIeKDQOG5vtyvoiaR0kmYCzif6YprEjf2qLF1FQFHHDtTvDCUeZAEgUGDf4F8uH
        +xpiDF4VacYd6kgEeWT1jQ3HORAav9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-zX7W-UiINyS9YcPFQsxazw-1; Wed, 15 Jul 2020 12:33:31 -0400
X-MC-Unique: zX7W-UiINyS9YcPFQsxazw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AF18108A;
        Wed, 15 Jul 2020 16:33:29 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-244.rdu2.redhat.com [10.10.118.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD87F6FEF5;
        Wed, 15 Jul 2020 16:33:27 +0000 (UTC)
Subject: Re: [PATCH 2/2] locking/pvqspinlock: Optionally store lock holder cpu
 into lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org
References: <20200711182128.29130-1-longman@redhat.com>
 <20200711182128.29130-3-longman@redhat.com>
 <20200712173452.GB10769@hirez.programming.kicks-ass.net>
 <bed22603-e347-8bff-f586-072a18987946@redhat.com>
 <1594613637.ds7pt1by9l.astroid@bobo.none>
 <e850b327-d747-fbe8-95db-4e2fbb1d7871@redhat.com>
 <20200714090126.GR10769@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b16a2d2b-3c72-cb70-5b6c-2f02a0953e42@redhat.com>
Date:   Wed, 15 Jul 2020 12:33:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200714090126.GR10769@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/20 5:01 AM, Peter Zijlstra wrote:
> On Mon, Jul 13, 2020 at 10:48:00PM -0400, Waiman Long wrote:
>> Storing the cpu number into the lock can be useful for other reason too. It
>> is not totally related to PPC support.
> Well, the thing you did only works for 'small' (<253 CPU) systems.
> There's a number of Power systems that's distinctly larger than that. So
> it simply cannot work as anything other than a suggestion/hint. It must
> not be a correctness thing.
>
Yes, there are limit on how much data one can put into the lock byte. So 
it is not a sure way to find out who the lock holder is. There are 
certainly large systems with hundreds or even thousands of cpus, but 
they are the minority in the sea of Linux systems out there.

If the lock holder goes through the slowpath, the one behind it can save 
its cpu number which can be used a hint of who the lock holder is though 
it is not that reliable as lock stealing can happen.

BTW, I did get the optimized PV unlock asm code working now. I will post 
the updated unconditional patch later this week for further discussion.

Cheers,
Longman


