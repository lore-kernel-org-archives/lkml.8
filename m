Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F26C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B652720757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbgDBOcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:32:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38040 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387680AbgDBOcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:32:11 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jK0sz-0005jW-9X; Thu, 02 Apr 2020 16:32:01 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id BE60A100D52; Thu,  2 Apr 2020 16:31:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        qemu-discuss@nongnu.org, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: qemu-x86: kernel panic when host is loaded
In-Reply-To: <18354be1-8dba-84f1-bdf5-6821a5013d78@oracle.com>
References: <20200402093132.GA15839@Red> <87eet6nra7.fsf@nanos.tec.linutronix.de> <18354be1-8dba-84f1-bdf5-6821a5013d78@oracle.com>
Date:   Thu, 02 Apr 2020 16:31:59 +0200
Message-ID: <878sjenelc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongli Zhang <dongli.zhang@oracle.com> writes:
> On 4/2/20 2:57 AM, Thomas Gleixner wrote:
>> Corentin Labbe <clabbe.montjoie@gmail.com> writes:
>>> On our kernelci lab, each qemu worker pass an healtcheck job each day and after each job failure, so it is heavily used.
>>> The healtcheck job is a Linux boot with a stable release.
>>>
>>> Since we upgraded our worker to buster, the qemu x86_64 healthcheck randomly panic with:
>>> <0>[    0.009000] Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report.  Then try booting with the 'noapic' option.
>>>
>>> After some test I found the source of this kernel panic, the host is
>>> loaded and qemu run "slower".  Simply renicing all qemu removed this
>>> behavour.
>>>
>>> So now what can I do ?
>>> Appart renicing qemu process, does something could be done ?
>> 
>> As the qemu timer/ioapic routing is actually sane, you might try to add
>> "no_timer_check" to the kernel command line.
>> 
>
> The no_timer_check is already permanently disabled in below commit?
>
> commit a90ede7b17d1 ("KVM: x86: paravirt skip pit-through-ioapic boot check")

Which only helps if the guest kernel has CONFIG_KVM_GUEST enabled...

As Corentin showed that it dies in the timer check this is clearly not
the case. So adding it to the kernel command line for this case should
work around the problem.

Thanks,

        tglx
