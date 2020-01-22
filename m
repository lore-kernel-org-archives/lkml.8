Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EB2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6E52465B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTsgulfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgAVRZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:25:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25378 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbgAVRZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579713908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VHvnfO/LwUwnWaPYXVcUEbXAoTeNUswOZpwb/FvyBhE=;
        b=aTsgulfu5IiudvfMpFVC8LqaCLvatRb4cd/I8HIGaekKV7UJjVicICHoJ3nCYzs9TYZZqg
        sypt7gHsLFTFPLi3CQBLlFwWQ9sC5EpzHISIb3p/pVG8AvPef8OmdtJdNhm4LrpfYmQyJd
        eD/ukK/PAY67NiVXgtMb2llJNqcTURE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-ckjOS28dPFaMDyNWePyqDQ-1; Wed, 22 Jan 2020 12:25:06 -0500
X-MC-Unique: ckjOS28dPFaMDyNWePyqDQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 492019920A;
        Wed, 22 Jan 2020 17:25:03 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61CEC87023;
        Wed, 22 Jan 2020 17:24:59 +0000 (UTC)
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
To:     Lihao Liang <lihaoliang@google.com>,
        Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com, dave.dice@oracle.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        Will Deacon <will@kernel.org>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4e15fa1d-9540-3274-502a-4195a0d46f63@redhat.com>
Date:   Wed, 22 Jan 2020 12:24:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/20 6:45 AM, Lihao Liang wrote:
> Hi Alex,
>
> On Wed, Jan 22, 2020 at 10:28 AM Alex Kogan <alex.kogan@oracle.com> wro=
te:
>> Summary
>> -------
>>
>> Lock throughput can be increased by handing a lock to a waiter on the
>> same NUMA node as the lock holder, provided care is taken to avoid
>> starvation of waiters on other NUMA nodes. This patch introduces CNA
>> (compact NUMA-aware lock) as the slow path for qspinlock. It is
>> enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
>>
> Thanks for your patches. The experimental results look promising!
>
> I understand that the new CNA qspinlock uses randomization to achieve
> long-term fairness, and provides the numa_spinlock_threshold parameter
> for users to tune. As Linux runs extremely diverse workloads, it is not
> clear how randomization affects its fairness, and how users with
> different requirements are supposed to tune this parameter.
>
> To this end, Will and I consider it beneficial to be able to answer the
> following question:
>
> With different values of numa_spinlock_threshold and
> SHUFFLE_REDUCTION_PROB_ARG, how long do threads running on different
> sockets have to wait to acquire the lock? This is particularly relevant
> in high contention situations when new threads keep arriving on the sam=
e
> socket as the lock holder.
>
> In this email, I try to provide some formal analysis to address this
> question. Let's assume the probability for the lock to stay on the
> same socket is *at least* p, which corresponds to the probability for
> the function probably(unsigned int num_bits) in the patch to return *fa=
lse*,
> where SHUFFLE_REDUCTION_PROB_ARG is passed as the value of num_bits to =
the
> function.

That is not strictly true from my understanding of the code. The
probably() function does not come into play if a secondary queue is
present. Also calling cna_scan_main_queue() doesn't guarantee that a
waiter in the same node can be found. So the simple mathematical
analysis isn't that applicable in this case. One will have to do an
actual simulation to find out what the actual behavior will be.

The comment in the code states that:

/*
=C2=A0* Controls the probability for enabling the scan of the main queue =
when
=C2=A0* the secondary queue is empty. The chosen value reduces the amount=
 of
=C2=A0* unnecessary shuffling of threads between the two waiting queues w=
hen
=C2=A0* the contention is low, while responding fast enough and enabling
=C2=A0* the shuffling when the contention is high.
=C2=A0*/
#define SHUFFLE_REDUCTION_PROB_ARG=C2=A0 (7)

Cheers,
Longman



