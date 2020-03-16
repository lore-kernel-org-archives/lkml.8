Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02DBC10F29
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B56205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Swk32jcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgCPCn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:43:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60103 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729348AbgCPCn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584326604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v28iiu28Saw8sKC5aBz4P+t6mwipYPE0TpE/22u2Jso=;
        b=Swk32jczUHKHvIUiAWbLSTSjAPE6dqSQy+Ieja5u/DIT7CjIJqKrR+c2RLeJhLSQtKr9C8
        n1NKOx3K2cAUifRrm60qxKdbph3AlCjabf7rUxNEOTmhLDhFYC5vRHVMuJDMm2Ptkn3pyY
        2toPPyRqxJldWb31gPmhTnbqT9iyz6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-5_VELePDOU6cTJVZmd6czg-1; Sun, 15 Mar 2020 22:43:22 -0400
X-MC-Unique: 5_VELePDOU6cTJVZmd6czg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 835B413EA;
        Mon, 16 Mar 2020 02:43:21 +0000 (UTC)
Received: from llong.remote.csb (ovpn-121-65.rdu2.redhat.com [10.10.121.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3663793518;
        Mon, 16 Mar 2020 02:43:20 +0000 (UTC)
Subject: Re: [RFC PATCH v2] tick: Make tick_periodic() check for missing ticks
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>, pbunyan@redhat.com
References: <20200207193929.27308-1-longman@redhat.com>
 <20200316022014.GA30856@roeck-us.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <087e8692-4bfd-6407-3aac-7689f80142de@redhat.com>
Date:   Sun, 15 Mar 2020 22:43:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200316022014.GA30856@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/20 10:20 PM, Guenter Roeck wrote:
> Hi,
>
> On Fri, Feb 07, 2020 at 02:39:29PM -0500, Waiman Long wrote:
>> The tick_periodic() function is used at the beginning part of the
>> bootup process for time keeping while the other clock sources are
>> being initialized.
>>
>> The current code assumes that all the timer interrupts are handled in
>> a timely manner with no missing ticks. That is not actually true. Some
>> ticks are missed and there are some discrepancies between the tick tim=
e
>> (jiffies) and the timestamp reported in the kernel log.  Some systems,
>> however, are more prone to missing ticks than the others.  In the extr=
eme
>> case, the discrepancy can actually cause a soft lockup message to be
>> printed by the watchdog kthread. For example, on a Cavium ThunderX2
>> Sabre arm64 system:
>>
>>  [   25.496379] watchdog: BUG: soft lockup - CPU#14 stuck for 22s!
>>
>> On that system, the missing ticks are especially prevalent during the
>> smp_init() phase of the boot process. With an instrumented kernel,
>> it was found that it took about 24s as reported by the timestamp for
>> the tick to accumulate 4s of time.
>>
>> Investigation and bisection done by others seemed to point to the
>> commit 73f381660959 ("arm64: Advertise mitigation of Spectre-v2, or
>> lack thereof") as the culprit. It could also be a firmware issue as
>> new firmware was promised that would fix the issue.
>>
>> To properly address this problem, we cannot assume that there will
>> be no missing tick in tick_periodic(). This function is now modified
>> to follow the example of tick_do_update_jiffies64() by using another
>> reference clock to check for missing ticks. Since the watchdog timer
>> uses running_clock(), it is used here as the reference. With this patc=
h
>> applied, the soft lockup problem in the arm64 system is gone and tick
>> time tracks much more closely to the timestamp time.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Since this patch is in linux-next, roughly 10% of my x86 and x86_64
> qemu emulation boots are stalling. Typical log:
>
> [    0.002016] smpboot: Total of 1 processors activated (7576.40 BogoMI=
PS)
> [    0.002016] devtmpfs: initialized
> [    0.002016] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfff=
fffff, max_idle_ns: 1911260446275000 ns
> [    0.002016] futex hash table entries: 256 (order: 3, 32768 bytes, li=
near)
> [    0.002016] xor: measuring software checksum speed
>
> another:
>
> [    0.002653] Freeing SMP alternatives memory: 44K
> [    0.002653] smpboot: CPU0: Intel Westmere E56xx/L56xx/X56xx (IBRS up=
date) (family: 0x6, model: 0x2c, stepping: 0x1)
> [    0.002653] Performance Events: unsupported p6 CPU model 44 no PMU d=
river, software events only.
> [    0.002653] rcu: Hierarchical SRCU implementation.
> [    0.002653] smp: Bringing up secondary CPUs ...
> [    0.002653] x86: Booting SMP configuration:
> [    0.002653] .... node  #0, CPUs:      #1
> [    0.000000] smpboot: CPU 1 Converting physical 0 to logical die 1
>
> ... and then there is silence until the test aborts.
>
> This is only (or at least predominantly) seen if the system running
> the emulation is under load.
>
> Reverting this patch fixes the problem.

I was aware that there are some problem with this patch, but it is hard
to reproduce it. Do you have a more consistent way to reproduce it.
When=A0 you say under load, you mean that the host system is also busy so
that there are a lot of vcpu preemption. Right? Could you give me the
x86-64 .config file that you use?

Thanks,
Longman

