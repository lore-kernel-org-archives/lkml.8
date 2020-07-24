Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2846FC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01CD520737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQsGRhL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgGXDBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 23:01:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41939 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726178AbgGXDBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 23:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595559658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnkanCRIM062ProhdGg7SX02oIMnz/wnozev/bBtcZI=;
        b=QQsGRhL6qOwc788PDSWIyPc+Lgj+skSVn1mWocRe6NsemJnYY9KGSWPnRUwrevNxbDmKsl
        LDdgo+USkGD0AUZZ8Jv/cb1ctk4t5524f71EDKct1Ds0Ke/eUURNZlzdADUv2p5QZb25UH
        6lUFxA7j2ZPorugSko+Wt1eEwk7F1m0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-dPBfuT8yPHSvcsSJBoqEXw-1; Thu, 23 Jul 2020 23:00:54 -0400
X-MC-Unique: dPBfuT8yPHSvcsSJBoqEXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4707257;
        Fri, 24 Jul 2020 03:00:52 +0000 (UTC)
Received: from llong.remote.csb (ovpn-119-128.rdu2.redhat.com [10.10.119.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83F775D9D3;
        Fri, 24 Jul 2020 03:00:50 +0000 (UTC)
Subject: Re: [PATCH for 5.9 1/3] futex: introduce FUTEX_SWAP operation
To:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>, Aaron Lu <aaron.lwe@gmail.com>
References: <20200722234538.166697-1-posk@posk.io>
 <20200722234538.166697-2-posk@posk.io>
 <20200723112757.GN5523@worktop.programming.kicks-ass.net>
 <CAFTs51UJhC9TmXkzz8VbDNmkSEyZE29=dRdUi65TDpSYqoK5vw@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <00ec99e0-2164-123e-44ed-229c52119d7e@redhat.com>
Date:   Thu, 23 Jul 2020 23:00:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFTs51UJhC9TmXkzz8VbDNmkSEyZE29=dRdUi65TDpSYqoK5vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/20 8:25 PM, Peter Oskolkov wrote:
> On Thu, Jul 23, 2020 at 4:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Thanks a lot for your comments, Peter! My answers below.
>
>> On Wed, Jul 22, 2020 at 04:45:36PM -0700, Peter Oskolkov wrote:
>>> This patchset is the first step to open-source this work. As explained
>>> in the linked pdf and video, SwitchTo API has three core operations: wait,
>>> resume, and swap (=switch). So this patchset adds a FUTEX_SWAP operation
>>> that, in addition to FUTEX_WAIT and FUTEX_WAKE, will provide a foundation
>>> on top of which user-space threading libraries can be built.
>> The PDF and video can go pound sand; you get to fully explain things
>> here.
> Will do. Should I expand the cover letter or the commit message? (I'll probably
> split the first patch into two in the latter case).

You should put it mostly in the commit message which will be part of the 
git log history. The cover letter, on the other hand, is not part of the 
git log.


>
>> What worries me is how FUTEX_SWAP would interact with the future
>> FUTEX_LOCK / FUTEX_UNLOCK. When we implement pthread_mutex with those,
>> there's very few WAIT/WAKE left.
> [+cc Waiman Long]
>
> I've looked through the latest FUTEX_LOCK patchset I could find (
> https://lore.kernel.org/patchwork/cover/772643/ and related), and it seems
> that FUTEX_SWAP and FUTEX_LOCK/FUTEX_UNLOCK patchsets
> address the same issue (slow wakeups) but for different use cases:
>
> FUTEX_LOCK/FUTEX_UNLOCK uses spinning and lock stealing to
> improve futex wake/wait performance in high contention situations;
> FUTEX_SWAP is designed to be used for fast context switching with
> _no_ contention by design: the waker that is going to sleep, and the wakee
> are using different futexes; the userspace will have a futex per thread/task,
> and when needed the thread/task will either simply sleep on its futex,
> or context switch (=FUTEX_SWAP) into a different thread/task.

I agree that it is a different use case. I just hope that you keep the 
possible future extension to support FUTEX_LOCK/UNLOCK in mind so that 
they won't conflict with each other.

Cheers,
Longman

