Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5195C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09BC20768
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgFVQIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:08:05 -0400
Received: from foss.arm.com ([217.140.110.172]:49234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgFVQIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:08:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF4DA31B;
        Mon, 22 Jun 2020 09:08:03 -0700 (PDT)
Received: from [10.57.9.128] (unknown [10.57.9.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CA053F71E;
        Mon, 22 Jun 2020 09:07:55 -0700 (PDT)
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
To:     David Rientjes <rientjes@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200608132217.29945-1-geert@linux-m68k.org>
 <20200620200936.GA106151@roeck-us.net>
 <CAMuHMdX3mBDm9iHk+jhbGfmo+dbix=3tp5z2ewyddWxM1tdqGQ@mail.gmail.com>
 <c0889f5c-34ae-2314-6530-a9240e0901f2@roeck-us.net>
 <alpine.DEB.2.22.394.2006211308500.195301@chino.kir.corp.google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1287bffd-3363-0764-0309-32222b2b8c9a@arm.com>
Date:   Mon, 22 Jun 2020 17:07:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2006211308500.195301@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-21 21:20, David Rientjes wrote:
> On Sun, 21 Jun 2020, Guenter Roeck wrote:
> 
>>>> This patch results in a boot failure in some of my powerpc boot tests,
>>>> specifically those testing boots from mptsas1068 devices. Error message:
>>>>
>>>> mptsas 0000:00:02.0: enabling device (0000 -> 0002)
>>>> mptbase: ioc0: Initiating bringup
>>>> ioc0: LSISAS1068 A0: Capabilities={Initiator}
>>>> mptbase: ioc0: ERROR - Unable to allocate Reply, Request, Chain Buffers!
>>>> mptbase: ioc0: ERROR - didn't initialize properly! (-3)
>>>> mptsas: probe of 0000:00:02.0 failed with error -3
>>>>
>>>> Configuration is bamboo:44x/bamboo_defconfig plus various added drivers.
>>>> Qemu command line is
>>>>
>>>> qemu-system-ppc -kernel vmlinux -M bamboo \
>>>>       -m 256 -no-reboot -snapshot -device mptsas1068,id=scsi \
>>>>       -device scsi-hd,bus=scsi.0,drive=d0,wwn=0x5000c50015ea71ac -drive \
>>>>       file=rootfs.ext2,format=raw,if=none,id=d0 \
>>>>       --append "panic=-1 slub_debug=FZPUA root=/dev/sda  mem=256M console=ttyS0" \
>>>>       -monitor none -nographic
>>>>
>>>> canyonlands_defconfig with sam460ex machine and otherwise similar command line
>>>> fails as well.
>>>>
>>>> Reverting this patch fixes the problem.
>>>
>>> This looks like the minimum value of 128 KiB is not sufficient, and the
>>> bug is in the intention of 1d659236fb43c4d2 ("dma-pool: scale the
>>> default DMA coherent pool size with memory capacity")?
>>> Before, there was a single pool of (fixed) 256 KiB size, now there are
>>> up to three coherent pools (DMA, DMA32, and kernel), albeit of smaller
>>> size (128 KiB each).
>>>
>>> Can you print the requested size in drivers/message/fusion/mptbase.c:
>>> PrimeIocFifos()?
>>
>> 172928 bytes
>>
>>> Does replacing all SZ_128K by SZ_256K in my patch help?
>>
>> Yes, it does.
>>
> 
> The new coherent pools should auto expand when they are close to being
> depleted but there's no guarantee that it can be done fast enough.

More to the point, it's never going to help if the pool is empty and one 
allocation is simply larger than the entire thing ;)

Another angle, though, is to question why this driver is making such a 
large allocation with GFP_ATOMIC in the first place. At a glance it 
looks like there's no reason at all other than that it's still using the 
legacy pci_alloc_consistent() API, since every path to that appears to 
have CAN_SLEEP passed as its flag - modernising that would arguably be 
an even better long-term win.

Robin.

> Switching the min size to be the previous min size (256KB) seems like the
> best option and it matches what
> Documentation/admin-guide/kernel-parameters.txt still stays.
> 
> I'll also send a patch to point in the right direction when this happens.
> 
