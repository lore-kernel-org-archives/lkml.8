Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BE0C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBCA2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjWDNDUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437245AbgAPTOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:14:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47507 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2437490AbgAPTN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579202036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dfJAU7RaHy4HkG5bX3qzQ3Wzr16UrjmMEFK9k1V7IkQ=;
        b=YjWDNDUNaEK3ir3JdxHeu1DbYBW0GcyEZ4EtpIAngmxICCqN4agf+V4c/l/9lizUqMusYy
        76aE9S5GY/SjKDdUvf5pV6LqmHuvCvXtFdsPUvbok5OvFatwfW+j7P6EZRr0U8ocJf6N7o
        lYhTcfwkJ7rCPnprRj/uCkEOEAqiJQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-_pqLLkqMPlaIidvTIzRJPg-1; Thu, 16 Jan 2020 14:13:52 -0500
X-MC-Unique: _pqLLkqMPlaIidvTIzRJPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7299107ACC7;
        Thu, 16 Jan 2020 19:13:50 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 923CC60C63;
        Thu, 16 Jan 2020 19:13:49 +0000 (UTC)
Subject: Re: [PATCH v2] watchdog: Fix possible soft lockup warning at bootup
To:     Thomas Gleixner <tglx@linutronix.de>,
        Robert Richter <rrichter@marvell.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <87ftgffc9z.fsf@nanos.tec.linutronix.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <7168b0aa-4904-4246-0de5-3906df13b5c8@redhat.com>
Date:   Thu, 16 Jan 2020 14:13:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87ftgffc9z.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/20 2:10 PM, Thomas Gleixner wrote:
> Waiman Long <longman@redhat.com> writes:
>
>> On 1/16/20 11:57 AM, Thomas Gleixner wrote:
>>>> So your theory the MONOTONIC clock runs differently/wrongly could
>>>> explain that (assuming this drives the sched clock). Though, I am
>>> No. sched_clock() is separate. It uses a raw timestamp (in your case
>>> from the ARM arch timer) and converts it to something which is close =
to
>>> proper time. So my assumption was based on the printout Waiman had:
>>>
>>>  [ 1... ] CPU.... watchdog_fn now  170000000
>>>  [ 25.. ] CPU.... watchdog_fn now 4170000000
>>>
>>> I assumed that now comes from ktime_get() or something like
>>> that. Waiman?
>> I printed out the now parameter of the=C2=A0 __hrtimer_run_queues() ca=
ll.
> Yes. That's clock MONOTONIC.
>
>> So from the timer perspective, it is losing time. For watchdog, the so=
ft
>> expiry time is 4s. The watchdog function won't be called until the
>> timer's time advances 4s or more. That corresponds to about 24s in
>> timestamp time for that particular class of systems.
> Right. And assumed that the firmware call is the culprit this has an
> explanation.
>
> Could you please take sched_clock() timestamps before and after the
> firmware call which kicks the secondary CPUs into life to verify that?
>
> They should sum up to the amount of time which gets lost accross
> smp_init().

Sure, I will do that after I get hold of the arm64 system that can
reproduce the issue. That system is currently used by another engineer.

Cheers,
Longman

