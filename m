Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94574C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5077F221E7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbgIIRQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:16:37 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:53328 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbgIIP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:28:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kG0i8-000WWy-GA; Wed, 09 Sep 2020 08:04:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kG0i7-0006Mj-GK; Wed, 09 Sep 2020 08:04:32 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kexec@lists.infradead.org
References: <20200909075016.104407-1-kasong@redhat.com>
Date:   Wed, 09 Sep 2020 09:04:16 -0500
In-Reply-To: <20200909075016.104407-1-kasong@redhat.com> (Kairui Song's
        message of "Wed, 9 Sep 2020 15:50:13 +0800")
Message-ID: <87ft7r82sf.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kG0i7-0006Mj-GK;;;mid=<87ft7r82sf.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19GmTEcapAWi/Q2ocXgqmTk+cb5s6MSJTg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC PATCH 0/3] Add writing support to vmcore for reusing oldmem
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kairui Song <kasong@redhat.com> writes:

> Currently vmcore only supports reading, this patch series is an RFC
> to add writing support to vmcore. It's x86_64 only yet, I'll add other
> architecture later if there is no problem with this idea.
>
> My purpose of adding writing support is to reuse the crashed kernel's
> old memory in kdump kernel, reduce kdump memory pressure, and
> allow kdump to run with a smaller crashkernel reservation.
>
> This is doable because in most cases, after kernel panic, user only
> interested in the crashed kernel itself, and userspace/cache/free
> memory pages are not dumped. `makedumpfile` is widely used to skip
> these pages. Kernel pages usually only take a small part of
> the whole old memory. So there will be many reusable pages.
>
> By adding writing support, userspace then can use these pages as a fast
> and temporary storage. This helps reduce memory pressure in many ways.
>
> For example, I've written a POC program based on this, it will find
> the reusable pages, and creates an NBD device which maps to these pages.
> The NBD device can then be used as swap, or to hold some temp files
> which previouly live in RAM.
>
> The link of the POC tool: https://github.com/ryncsn/kdumpd

A couple of thoughts.
1) Unless I am completely mistaken treating this as a exercise in
   memory hotplug would be much simpler.

   AKA just plug in the memory that is not needed as part of the kdump.

   I see below that you have problems doing this because
   of fragmentation.  I still think hotplug is doable using some
   kind of fragmented memory zone.
   
2) The purpose of the memory reservation is because hardware is
   still potentially running agains the memory of the old kernel.

   By the time we have brought up a new kernel enough of the hardware
   may have been reinitialized that we don't have to worry about
   hardware randomly dma'ing into the memory used by the old kernel.

   With IOMMUs and care we may be able to guarantee for some machine
   configurations it is impossible for DMA to come from some piece of
   hardware that is present but the kernel does not have a driver
   loaded for.


I really do not like this approach because it is fundamentlly doing the
wrong thing.  Adding write support to read-only drivers.  I do not see
anywhere that you even mentioned the hard problem and the reason we
reserve memory in the first place.  Hardware spontaneously DMA'ing onto
it.

> It's have been a long time issue that kdump suffers from OOM issue
> with limited crashkernel memory. So reusing old memory could be very
> helpful.

There is a very fine line here between reusing existing code (aka
drivers and userspace) and doing something that should work.

It might make sense to figure out what is using so much memory
that an OOM is triggered.

Ages ago I did something that was essentially dumping the kernels printk
buffer to the serial console in case of a crash and I had things down to
something comparatively miniscule like 8M or less.

My memory is that historically it has been high performance scsi raid
drivers or something like that, that are behind the need to have such
large memory reservations.

Now that I think about it, you aren't by any chance doing something
silly like running systemd in your initrd are you?  Are these OOMs by
any chance a userspace problem rather than a problem with inefficient
drivers?


In summary you either need to show that it is safe to reuse the
memory of the old kernel, or do some work to reduce the memory footprint
of the crashdump kernel, and the crashdump userspace. 

Eric
