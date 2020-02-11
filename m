Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F12C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD3920714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgBKM1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:27:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:31036 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgBKM1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:27:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 04:27:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="405924314"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga005.jf.intel.com with ESMTP; 11 Feb 2020 04:27:29 -0800
Subject: Re: [RFT PATCH] xhci: Fix memory leak when caching protocol extended
 capability PSI tables
To:     Greg KH <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     pmenzel@molgen.mpg.de, mika.westerberg@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <572bea6f-06d4-938a-802e-93386acf59d9@linux.intel.com>
 <20200108151730.21022-1-mathias.nyman@linux.intel.com>
 <CGME20200211105613eucas1p27cac4202c4287a5967b2ed988779d523@eucas1p2.samsung.com>
 <089285ab-7041-49bb-54ea-c73b25f96f48@samsung.com>
 <20200211122316.GG1856500@kroah.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <9d314940-086e-d9a7-88e2-88447cd1c67d@linux.intel.com>
Date:   Tue, 11 Feb 2020 14:29:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200211122316.GG1856500@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.2.2020 14.23, Greg KH wrote:
> On Tue, Feb 11, 2020 at 11:56:12AM +0100, Marek Szyprowski wrote:
>> Hi
>>
>> On 08.01.2020 16:17, Mathias Nyman wrote:
>>> xhci driver assumed that xHC controllers have at most one custom
>>> supported speed table (PSI) for all usb 3.x ports.
>>> Memory was allocated for one PSI table under the xhci hub structure.
>>>
>>> Turns out this is not the case, some controllers have a separate
>>> "supported protocol capability" entry with a PSI table for each port.
>>> This means each usb3 port can in theory support different custom speeds.
>>>
>>> To solve this cache all supported protocol capabilities with their PSI
>>> tables in an array, and add pointers to the xhci port structure so that
>>> every port points to its capability entry in the array.
>>>
>>> When creating the SuperSpeedPlus USB Device Capability BOS descriptor
>>> for the xhci USB 3.1 roothub we for now will use only data from the
>>> first USB 3.1 capable protocol capability entry in the array.
>>> This could be improved later, this patch focuses resolving
>>> the memory leak.
>>>
>>> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>> Reported-by: Sajja Venkateswara Rao <VenkateswaraRao.Sajja@amd.com>
>>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>
>> This patch landed in today's linux-next (20200211) and causes NULL 
>> pointer dereference during second suspend/resume cycle on Samsung 
>> Exynos5422-based (arm 32bit) Odroid XU3lite board:
>>
>> # time rtcwake -s10 -mmem
>> rtcwake: wakeup from "mem" using /dev/rtc0 at Tue Feb 11 10:51:43 2020
>> PM: suspend entry (deep)
>> Filesystems sync: 0.012 seconds
>> Freezing user space processes ... (elapsed 0.010 seconds) done.
>> OOM killer disabled.
>> Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
>> smsc95xx 1-1.1:1.0 eth0: entering SUSPEND2 mode
>> wake enabled for irq 153
>> wake enabled for irq 158
>> samsung-pinctrl 13400000.pinctrl: Setting external wakeup interrupt 
>> mask: 0xffffffe7
>> Disabling non-boot CPUs ...
>> IRQ 51: no longer affine to CPU1
>> IRQ 52: no longer affine to CPU2
>> s3c2410-wdt 101d0000.watchdog: watchdog disabled
>> wake disabled for irq 158
>> usb usb1: root hub lost power or was reset
>> usb usb2: root hub lost power or was reset
>> wake disabled for irq 153
>> exynos-tmu 10060000.tmu: More trip points than supported by this TMU.
>> exynos-tmu 10060000.tmu: 2 trip points should be configured in polling mode.
>> exynos-tmu 10064000.tmu: More trip points than supported by this TMU.
>> exynos-tmu 10064000.tmu: 2 trip points should be configured in polling mode.
>> exynos-tmu 10068000.tmu: More trip points than supported by this TMU.
>> exynos-tmu 10068000.tmu: 2 trip points should be configured in polling mode.
>> exynos-tmu 1006c000.tmu: More trip points than supported by this TMU.
>> exynos-tmu 1006c000.tmu: 2 trip points should be configured in polling mode.
>> exynos-tmu 100a0000.tmu: More trip points than supported by this TMU.
>> exynos-tmu 100a0000.tmu: 6 trip points should be configured in polling mode.
>> usb usb3: root hub lost power or was reset
>> s3c-rtc 101e0000.rtc: rtc disabled, re-enabling
>> usb usb4: root hub lost power or was reset
>> xhci-hcd xhci-hcd.8.auto: No ports on the roothubs?
>> PM: dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -12
>> PM: Device xhci-hcd.8.auto failed to resume async: error -12
>> hub 3-0:1.0: hub_ext_port_status failed (err = -32)
>> hub 4-0:1.0: hub_ext_port_status failed (err = -32)
>> usb 1-1: reset high-speed USB device number 2 using exynos-ehci
>> usb 1-1.1: reset high-speed USB device number 3 using exynos-ehci
>> OOM killer enabled.
>> Restarting tasks ... done.
>>
>> real    0m11.890s
>> user    0m0.001s
>> sys     0m0.679s
>> root@target:~# PM: suspend exit
>> mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, 
>> actual 396825HZ div = 63)
>> mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot req 200000000Hz, 
>> actual 200000000HZ div = 0)
>> mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, 
>> actual 50000000HZ div = 0)
>> mmc_host mmc0: Bus speed (slot 0) = 400000000Hz (slot req 200000000Hz, 
>> actual 200000000HZ div = 1)
>> smsc95xx 1-1.1:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xC1E1
>>
>> root@target:~#
>> root@target:~# time rtcwake -s10 -mmem[   35.451572] vdd_ldo12: disabling
>>
>> rtcwake: wakeup from "mem" using /dev/rtc0 at Tue Feb 11 10:52:02 2020
>> PM: suspend entry (deep)
>> Filesystems sync: 0.004 seconds
>> Freezing user space processes ... (elapsed 0.006 seconds) done.
>> OOM killer disabled.
>> Freezing remaining freezable tasks ... (elapsed 0.070 seconds) done.
>> hub 4-0:1.0: hub_ext_port_status failed (err = -32)
>> hub 3-0:1.0: hub_ext_port_status failed (err = -32)
>> 8<--- cut here ---
>> Unable to handle kernel NULL pointer dereference at virtual address 00000014
>> pgd = 4c26b54b
>> [00000014] *pgd=00000000
>> Internal error: Oops: 17 [#1] PREEMPT SMP ARM
>> Modules linked in:
>> CPU: 3 PID: 1468 Comm: kworker/u16:23 Not tainted 
>> 5.6.0-rc1-next-20200211 #268
>> Hardware name: Samsung Exynos (Flattened Device Tree)
>> Workqueue: events_unbound async_run_entry_fn
>> PC is at xhci_suspend+0x12c/0x520
>> LR is at 0xa6aa9898
>> pc : [<c0724c90>]    lr : [<a6aa9898>]    psr: 60000093
>> sp : ec401df8  ip : 0000001a  fp : c12e7864
>> r10: 00000000  r9 : ecfb87b0  r8 : ecfb8220
>> r7 : 00000000  r6 : 00000000  r5 : 00000004  r4 : ecfb81f0
>> r3 : 00007d00  r2 : 00000001  r1 : 00000001  r0 : 00000000
>> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> Control: 10c5387d  Table: 6bd4006a  DAC: 00000051
>> Process kworker/u16:23 (pid: 1468, stack limit = 0x6e4b6fba)
>> Stack: (0xec401df8 to 0xec402000)
>> ...
>> [<c0724c90>] (xhci_suspend) from [<c061b4f4>] (dpm_run_callback+0xb4/0x3fc)
>> [<c061b4f4>] (dpm_run_callback) from [<c061bd5c>] 
>> (__device_suspend+0x134/0x7e8)
>> [<c061bd5c>] (__device_suspend) from [<c061c42c>] (async_suspend+0x1c/0x94)
>> [<c061c42c>] (async_suspend) from [<c0154bd0>] 
>> (async_run_entry_fn+0x48/0x1b8)
>> [<c0154bd0>] (async_run_entry_fn) from [<c0149b38>] 
>> (process_one_work+0x230/0x7bc)
>> [<c0149b38>] (process_one_work) from [<c014a108>] (worker_thread+0x44/0x524)
>> [<c014a108>] (worker_thread) from [<c01511fc>] (kthread+0x130/0x164)
>> [<c01511fc>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
>> Exception stack(0xec401fb0 to 0xec401ff8)
>> ...
>> ---[ end trace c72caf6487666442 ]---
>> note: kworker/u16:23[1468] exited with preempt_count 1
>>
>> Reverting it fixes the NULL pointer issue. I can provide more 
>> information or do some other tests. Just let me know what will help to 
>> fix it.
>>
>>  > ...
> 
> Ugh.  Mathias, should I just revert this for now?
> 

Yes, revert it.

This looks very odd, after second resume, and losing power driver
can't find any port at all.

Marek, do you still get the "xhci-hcd xhci-hcd.8.auto: No ports on the roothubs?"
message on second resume after reverting the patch?

-Mathias
