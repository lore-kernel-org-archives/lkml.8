Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83CCC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7A42072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7zGVFYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgAPPed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:34:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47002 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726151AbgAPPed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579188871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kK6Km6s43/DeUxpqxgZHiJ00km9z23ARb6cNGp/MiO8=;
        b=B7zGVFYyekbp5ZfYtaG9QBMZakdMzfjk3UH5jaIqhgHf3qlahSmcnZnke5+y5Tuxdz7/xy
        zY4AXSZuobkcUTZhz6qcX+1QT/dap6GqD5HUqONnymDKwZEvFea6VzW6dRqfuK83uDTBZD
        z+srj6mYGIuHLcgQUEFaBAAb3zX5G1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-SKgw51c0PAWxiyIY-SCsiA-1; Thu, 16 Jan 2020 10:34:28 -0500
X-MC-Unique: SKgw51c0PAWxiyIY-SCsiA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39D0A1005516;
        Thu, 16 Jan 2020 15:34:22 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22EA65C28F;
        Thu, 16 Jan 2020 15:34:21 +0000 (UTC)
Subject: Re: [PATCH v2] watchdog: Fix possible soft lockup warning at bootup
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20200103151032.19590-1-longman@redhat.com>
 <87sgkgw3xq.fsf@nanos.tec.linutronix.de>
 <87blr3wrqw.fsf@nanos.tec.linutronix.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <bf71e29f-ae5a-aad0-758d-53293e2105b4@redhat.com>
Date:   Thu, 16 Jan 2020 10:34:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87blr3wrqw.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/20 6:44 AM, Thomas Gleixner wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>
> Added ARM64 and ThunderX folks 
>
>> Waiman Long <longman@redhat.com> writes:
>>> By adding some instrumentation code, it was found that for cpu 14,
>>> watchdog_enable() was called early with a timestamp of 1. That activates
>>> the watchdog time checking logic. It was also found that the monotonic
>>> time measured during the smp_init() phase runs much slower than the
>>> real elapsed time as shown by the below debug printf output:
>>>
>>>   [    1.138522] run_queues, watchdog_timer_fn: now =  170000000
>>>   [   25.519391] run_queues, watchdog_timer_fn: now = 4170000000
>>>
>>> In this particular case, it took about 24.4s of elapsed time for the
>>> clock to advance 4s which is the soft expiration time that is required
>>> to trigger the calling of watchdog_timer_fn(). That clock slowdown
>>> stopped once the smp_init() call was done and the clock time ran at
>>> the same rate as the elapsed time afterward.
> And looking at this with a more awake brain, the root cause is pretty
> obvious.
>
> sched_clock() advances by 24 seconds, but clock MONOTONIC on which the
> watchdog timer is based does not. As the timestamps you printed have 7
> trailing zeros, it's pretty clear that timekeeping is still jiffies
> based at this point and HZ is set to 100.
>
> So while bringing up the non-boot CPUs the boot CPU loses ~2000 timer
> interrupts. That needs to be fixed and not papered over.
>
You are right that the root-causing effort wasn't complete and I took
the easy way out. As I have limited knowledge on how the timer code
work, I was not sure how to start further investigation at that time.
Your insight gives me a hint on where to start now. So I will dig
further in to see what causes this.

Thanks,
Longman

