Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198B3C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A2A2084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgBDMam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 07:30:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33518 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgBDMam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 07:30:42 -0500
Received: from [212.187.182.162] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iyxLi-0004nq-H1; Tue, 04 Feb 2020 13:30:38 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 780AB100720; Tue,  4 Feb 2020 12:30:32 +0000 (GMT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-kernel@vger.kernel.org
Cc:     "Sverdlin\, Alexander \(Nokia - DE\/Ulm\)" 
        <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH RESEND] cpu/hotplug: Wait for cpu_hotplug to be enabled in cpu_up/down
In-Reply-To: <77570af6-733a-58e7-6975-b533a42daa4c@nokia.com>
References: <d950a169-941e-7caa-608a-df97a127c95d@nokia.com> <87o8uf1r3w.fsf@nanos.tec.linutronix.de> <77570af6-733a-58e7-6975-b533a42daa4c@nokia.com>
Date:   Tue, 04 Feb 2020 12:30:32 +0000
Message-ID: <87y2tiy1p3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matija,

Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com> writes:
> On 02/03/2020 07:08 PM, Thomas Gleixner wrote:
> EBUSY existing and being commonly used doesnt justify it in every 
> situation. We do not have problem only in userspace, but kernel as well, 
> no user of cpu_up/down takes into account of possible temporal

There is no point in caring about this, simply because if you look at
the 5 callsites on x86:

    - Three are debug stuff which handle the error return and do not care
      about whether its EBUSY or not

    - One is the boot time cpu onlining which ignores any error code on
      purpose because there are enough reasons why this can fail and we
      want at least get up to init.

    - The last one is the sysfs interface which you are tripping over.

> unavailability. Going into extreme, we could start returning EBUSY 
> whenever we have resource/facility taken which would made every 
> interface candidate for returning it. As I see it, EBUSY has its place 
> in nonblocking APIs. Others should try (hard) not to return it. Handling 
> it is further topic of its own. How large the timeout to quit? Let's say 
> that we know that for cpu, it is 10 seconds which I proposed. Passing 
> responsibility to select tmo to the users will spread out that policy to 
> each subsystem of its own, yielding to situations where it will for 
> someone work, for others not, depending on the tmo chosen.

We don't know whats the proper timeout for everyone. You picked one and
it fits your expectation, but its bound to break other peoples
expectations.

That's the exact reason why these kind of heuristics are bad and
horrible and should be avoided in general.

>> I have no idea why you need to offline/online CPUs to partition a
>> system. There are surely more sensible ways to do that, but that's not
>> part of this discussion.
>
> I'd be happy to make it part.
>
> We are using partrt from 
> https://github.com/OpenEneaLinux/rt-tools/tree/master/partrt, 
> cpu_up/down is part of it, AFAIK, it is there to force timer migration 
> and doesnt have any other (known to me) usage. In the meantime since we 
> started with core isolation, we changed how we treat isolated cores. We 
> are now starting with isolcpus=cpu-list nohz_full=cpu-list 
> rcu_nocbs=cpu-list, and we are atm at Linux 4.19. Earlier we had 
> different setup where we wanted to use cores in the startup, partition 
> later, however that showed to be problematic and not in line with how 
> things are going in the area.
>
> Do you think we do not need toggle them under these conditions?

If you have that isolation thingies on the kernel command line there is
no point in doing the cpu up/down dance. It's not providing you anything
useful except steering interrupts away which you can do on the kernel
command line as well with 'irqaffinity=...'.

Thanks,

        tglx
