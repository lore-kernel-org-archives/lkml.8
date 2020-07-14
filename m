Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2754C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8AF821974
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxKpk6Su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgGNCsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 22:48:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21630 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726372AbgGNCsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 22:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594694886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MiPtdqz/qRf0p0lhAKuK6UoxiaDXuLPMDW6qoFGRADU=;
        b=HxKpk6Su1beNuU4WSexfjhx0KHXgd51pPoJTnOGpT5FPF+OL1sTR4HDCLRj7DtDPy2tCHQ
        JavLQ6JdOGl13F1ysAEavs4BMaWH8WtkbvpsgvXMZb1BhJci/E+ztl6v6JAiRjfvyEPzMa
        prx82686UNIwWN0fukPwOprYVZNvEy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-hpD3NLqWN5Wha_4iID9h8A-1; Mon, 13 Jul 2020 22:48:04 -0400
X-MC-Unique: hpD3NLqWN5Wha_4iID9h8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06AC0107ACCA;
        Tue, 14 Jul 2020 02:48:02 +0000 (UTC)
Received: from llong.remote.csb (ovpn-114-19.rdu2.redhat.com [10.10.114.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8854078A4D;
        Tue, 14 Jul 2020 02:48:00 +0000 (UTC)
Subject: Re: [PATCH 2/2] locking/pvqspinlock: Optionally store lock holder cpu
 into lock
To:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
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
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e850b327-d747-fbe8-95db-4e2fbb1d7871@redhat.com>
Date:   Mon, 13 Jul 2020 22:48:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1594613637.ds7pt1by9l.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/20 12:17 AM, Nicholas Piggin wrote:
> Excerpts from Waiman Long's message of July 13, 2020 9:05 am:
>> On 7/12/20 1:34 PM, Peter Zijlstra wrote:
>>> On Sat, Jul 11, 2020 at 02:21:28PM -0400, Waiman Long wrote:
>>>> The previous patch enables native qspinlock to store lock holder cpu
>>>> number into the lock word when the lock is acquired via the slowpath.
>>>> Since PV qspinlock uses atomic unlock, allowing the fastpath and
>>>> slowpath to put different values into the lock word will further slow
>>>> down the performance. This is certainly undesirable.
>>>>
>>>> The only way we can do that without too much performance impact is to
>>>> make fastpath and slowpath put in the same value. Still there is a slight
>>>> performance overhead in the additional access to a percpu variable in the
>>>> fastpath as well as the less optimized x86-64 PV qspinlock unlock path.
>>>>
>>>> A new config option QUEUED_SPINLOCKS_CPUINFO is now added to enable
>>>> distros to decide if they want to enable lock holder cpu information in
>>>> the lock itself for both native and PV qspinlocks across both fastpath
>>>> and slowpath. If this option is not configureed, only native qspinlocks
>>>> in the slowpath will put the lock holder cpu information in the lock
>>>> word.
>>> And this kills it,.. if it doesn't make unconditional sense, we're not
>>> going to do this. It's just too ugly.
>>>
>> You mean it has to be unconditional, no option config if we want to do
>> it. Right?
>>
>> It can certainly be made unconditional after I figure out how to make
>> the optimized PV unlock code work.
> Sorry I've not had a lot of time to get back to this thread and test
> things -- don't spend loads of effort or complexity on it until we get
> some more numbers. I did see some worse throughput results (with no
> attention to fairness) with the PV spin lock, but it was a really quick
> limited few tests, I need to get something a bit more substantial.
>
> I do very much appreciate your help with the powerpc patches, and
> interest in the PV issues though. I'll try to find more time to help
> out.

Native qspinlock is usually not a problem performance-wise. PV 
qspinlock, however, is usually the challenging part. It took me a long 
time to get the PV code right so that I can merge qspinlock upstream. I 
do some interest to get qspinlock used by ppc, though.

Storing the cpu number into the lock can be useful for other reason too. 
It is not totally related to PPC support.

Cheers,
Longman


