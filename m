Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B088C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E8820842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KcC7GCpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgBKK4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:56:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42316 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbgBKK4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:56:17 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200211105614euoutp02e64d314145b0f7cbe47a9cfe6154e406~yU9CmC_gP2372523725euoutp02P
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 10:56:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200211105614euoutp02e64d314145b0f7cbe47a9cfe6154e406~yU9CmC_gP2372523725euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581418574;
        bh=oN0t+1XIozTMZTPach2eqN9WGiTKDUrNNPUb1mW4tZg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KcC7GCpu+8tll9YkSS32kg50CYpN57gN7P96mkuBD/38nsgzZ273AZEWi5ut4Krio
         tpoPg/l3SNSF2pmC8S3/W/8mEs6nc8HdsAA6BS9URp/WcZ0CzLWj0WjU6nXexvIvF0
         vmEXNQn8qVXRFJu8JNNEJGvYo8KO0nq5QclSJSi8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200211105614eucas1p1a8e37bef8c0924d3a3f8309589050155~yU9CDi9Js2648326483eucas1p1b;
        Tue, 11 Feb 2020 10:56:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DE.33.61286.E48824E5; Tue, 11
        Feb 2020 10:56:14 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200211105613eucas1p27cac4202c4287a5967b2ed988779d523~yU9Bu5Uyu3190431904eucas1p2B;
        Tue, 11 Feb 2020 10:56:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200211105613eusmtrp239fbc1c76bac47107fbc34e296bfbfd7~yU9BuN-ji0669806698eusmtrp2z;
        Tue, 11 Feb 2020 10:56:13 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-db-5e42884e7a8b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 28.6D.08375.D48824E5; Tue, 11
        Feb 2020 10:56:13 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200211105613eusmtip20559c829aa30da3853d50978ae4a4e99~yU9BTfvOX2002620026eusmtip21;
        Tue, 11 Feb 2020 10:56:13 +0000 (GMT)
Subject: Re: [RFT PATCH] xhci: Fix memory leak when caching protocol
 extended capability PSI tables
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        pmenzel@molgen.mpg.de
Cc:     mika.westerberg@linux.intel.com, linux-usb@vger.kernel.org,
        greg@kroah.com, linux-kernel@vger.kernel.org,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <089285ab-7041-49bb-54ea-c73b25f96f48@samsung.com>
Date:   Tue, 11 Feb 2020 11:56:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200108151730.21022-1-mathias.nyman@linux.intel.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djPc7p+HU5xBsuvs1mcWzCD0eL8+Q3s
        Fpd3zWGzmHF+H5PFomWtzBavPzSxWEzZfoTd4uWsNAcOj02rOtk83j4M8Jh3MtDjybkJzB6f
        N8kFsEZx2aSk5mSWpRbp2yVwZex6rlbwyqjiw96/LA2M27W6GDk5JARMJBYfOsjYxcjFISSw
        glHicPN9NgjnC6NE1/JWKOczo0TnhL/MXYwcYC3bbvtDxJczSjy8sYQFwnnLKNE07wkbyFxh
        gVSJe4tXMYHYIgIeEhv3LmcFKWIWuMAo8aJxCliCTcBQouttF1gDr4CdRNe0zcwgNouAqsTS
        P6dZQWxRgViJM8e+s0LUCEqcnPmEBeQKTgFniTNLfUHCzALyEs1bZzND2OISt57MZ4L4bRu7
        xId5SRC2i0TbhoNQcWGJV8e3sEPYMhL/d4LUcwHZzUDfnFvLDuH0MEpcbprBCFFlLXHn3C82
        kMXMApoS63fpQ0LCUeLZF34Ik0/ixltBiBP4JCZtmw4NK16JjjYhiBlqErOOr4PbevDCJeYJ
        jEqzkPw1C8kzs5A8Mwth7QJGllWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBKej0v+Of
        djB+vZR0iFGAg1GJh7ci0DFOiDWxrLgy9xCjBAezkgivpTRQiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOK/xopexQgLpiSWp2ampBalFMFkmDk6pBsbkb96/hOo7uXd/SX5W9E2ud4Wr0QP/ev7L
        Fes32u3cO7Vf/86qmhdPNr6OtfjZp9XPdGvhjiVGj7cDE9y6gPypd5nq/4tInj1j7d6+4fbb
        hgfXM3c/XLLmvVC06nVFo2dej9cr/+z9zzf1yi192ZBJBZmfz4u+kkmZPGOBze7u3W/25Jtm
        MusrsRRnJBpqMRcVJwIAkPZiij0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7q+HU5xBm+WGlqcWzCD0eL8+Q3s
        Fpd3zWGzmHF+H5PFomWtzBavPzSxWEzZfoTd4uWsNAcOj02rOtk83j4M8Jh3MtDjybkJzB6f
        N8kFsEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXo
        Zex6rlbwyqjiw96/LA2M27W6GDk4JARMJLbd9u9i5OIQEljKKPF1UxdTFyMnUFxG4uS0BlYI
        W1jiz7UuNoii14wSBzauZwdJCAukSrS+/skIYosIeEhs3LucFaSIWeASo8TVXZ+YQRJCAtUS
        j59fBbPZBAwlut6CTOLk4BWwk+iathksziKgKrH0z2mwbaICsRLHtrexQ9QISpyc+YQF5FJO
        AWeJM0t9QcLMAmYS8zY/ZIaw5SWat86GssUlbj2ZzzSBUWgWku5ZSFpmIWmZhaRlASPLKkaR
        1NLi3PTcYkO94sTc4tK8dL3k/NxNjMCo23bs5+YdjJc2Bh9iFOBgVOLhrQh0jBNiTSwrrsw9
        xCjBwawkwmspDRTiTUmsrEotyo8vKs1JLT7EaAr020RmKdHkfGBCyCuJNzQ1NLewNDQ3Njc2
        s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwNjPLPxQen/mn0qDSU6LUl0Flu39kGvLFm8i
        o6fm9GlXts31gyapDCc+2LUZaK/VVT0SXbBMc1ro3J+ir6XyRQsTY/ZsXjtX9+sW4U8y9kWh
        fs8rbojO03Vu2KSwTOL2/EcP7S56Zb3/ns/5pPn/kvYnfzNP212odNL1sF/aLZDhdvDLlp71
        q5RYijMSDbWYi4oTATCNagvQAgAA
X-CMS-MailID: 20200211105613eucas1p27cac4202c4287a5967b2ed988779d523
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200211105613eucas1p27cac4202c4287a5967b2ed988779d523
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200211105613eucas1p27cac4202c4287a5967b2ed988779d523
References: <572bea6f-06d4-938a-802e-93386acf59d9@linux.intel.com>
        <20200108151730.21022-1-mathias.nyman@linux.intel.com>
        <CGME20200211105613eucas1p27cac4202c4287a5967b2ed988779d523@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 08.01.2020 16:17, Mathias Nyman wrote:
> xhci driver assumed that xHC controllers have at most one custom
> supported speed table (PSI) for all usb 3.x ports.
> Memory was allocated for one PSI table under the xhci hub structure.
>
> Turns out this is not the case, some controllers have a separate
> "supported protocol capability" entry with a PSI table for each port.
> This means each usb3 port can in theory support different custom speeds.
>
> To solve this cache all supported protocol capabilities with their PSI
> tables in an array, and add pointers to the xhci port structure so that
> every port points to its capability entry in the array.
>
> When creating the SuperSpeedPlus USB Device Capability BOS descriptor
> for the xhci USB 3.1 roothub we for now will use only data from the
> first USB 3.1 capable protocol capability entry in the array.
> This could be improved later, this patch focuses resolving
> the memory leak.
>
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reported-by: Sajja Venkateswara Rao <VenkateswaraRao.Sajja@amd.com>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>

This patch landed in today's linux-next (20200211) and causes NULL 
pointer dereference during second suspend/resume cycle on Samsung 
Exynos5422-based (arm 32bit) Odroid XU3lite board:

# time rtcwake -s10 -mmem
rtcwake: wakeup from "mem" using /dev/rtc0 at Tue Feb 11 10:51:43 2020
PM: suspend entry (deep)
Filesystems sync: 0.012 seconds
Freezing user space processes ... (elapsed 0.010 seconds) done.
OOM killer disabled.
Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
smsc95xx 1-1.1:1.0 eth0: entering SUSPEND2 mode
wake enabled for irq 153
wake enabled for irq 158
samsung-pinctrl 13400000.pinctrl: Setting external wakeup interrupt 
mask: 0xffffffe7
Disabling non-boot CPUs ...
IRQ 51: no longer affine to CPU1
IRQ 52: no longer affine to CPU2
s3c2410-wdt 101d0000.watchdog: watchdog disabled
wake disabled for irq 158
usb usb1: root hub lost power or was reset
usb usb2: root hub lost power or was reset
wake disabled for irq 153
exynos-tmu 10060000.tmu: More trip points than supported by this TMU.
exynos-tmu 10060000.tmu: 2 trip points should be configured in polling mode.
exynos-tmu 10064000.tmu: More trip points than supported by this TMU.
exynos-tmu 10064000.tmu: 2 trip points should be configured in polling mode.
exynos-tmu 10068000.tmu: More trip points than supported by this TMU.
exynos-tmu 10068000.tmu: 2 trip points should be configured in polling mode.
exynos-tmu 1006c000.tmu: More trip points than supported by this TMU.
exynos-tmu 1006c000.tmu: 2 trip points should be configured in polling mode.
exynos-tmu 100a0000.tmu: More trip points than supported by this TMU.
exynos-tmu 100a0000.tmu: 6 trip points should be configured in polling mode.
usb usb3: root hub lost power or was reset
s3c-rtc 101e0000.rtc: rtc disabled, re-enabling
usb usb4: root hub lost power or was reset
xhci-hcd xhci-hcd.8.auto: No ports on the roothubs?
PM: dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -12
PM: Device xhci-hcd.8.auto failed to resume async: error -12
hub 3-0:1.0: hub_ext_port_status failed (err = -32)
hub 4-0:1.0: hub_ext_port_status failed (err = -32)
usb 1-1: reset high-speed USB device number 2 using exynos-ehci
usb 1-1.1: reset high-speed USB device number 3 using exynos-ehci
OOM killer enabled.
Restarting tasks ... done.

real    0m11.890s
user    0m0.001s
sys     0m0.679s
root@target:~# PM: suspend exit
mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, 
actual 396825HZ div = 63)
mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot req 200000000Hz, 
actual 200000000HZ div = 0)
mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, 
actual 50000000HZ div = 0)
mmc_host mmc0: Bus speed (slot 0) = 400000000Hz (slot req 200000000Hz, 
actual 200000000HZ div = 1)
smsc95xx 1-1.1:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xC1E1

root@target:~#
root@target:~# time rtcwake -s10 -mmem[   35.451572] vdd_ldo12: disabling

rtcwake: wakeup from "mem" using /dev/rtc0 at Tue Feb 11 10:52:02 2020
PM: suspend entry (deep)
Filesystems sync: 0.004 seconds
Freezing user space processes ... (elapsed 0.006 seconds) done.
OOM killer disabled.
Freezing remaining freezable tasks ... (elapsed 0.070 seconds) done.
hub 4-0:1.0: hub_ext_port_status failed (err = -32)
hub 3-0:1.0: hub_ext_port_status failed (err = -32)
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000014
pgd = 4c26b54b
[00000014] *pgd=00000000
Internal error: Oops: 17 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 3 PID: 1468 Comm: kworker/u16:23 Not tainted 
5.6.0-rc1-next-20200211 #268
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_unbound async_run_entry_fn
PC is at xhci_suspend+0x12c/0x520
LR is at 0xa6aa9898
pc : [<c0724c90>]    lr : [<a6aa9898>]    psr: 60000093
sp : ec401df8  ip : 0000001a  fp : c12e7864
r10: 00000000  r9 : ecfb87b0  r8 : ecfb8220
r7 : 00000000  r6 : 00000000  r5 : 00000004  r4 : ecfb81f0
r3 : 00007d00  r2 : 00000001  r1 : 00000001  r0 : 00000000
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 6bd4006a  DAC: 00000051
Process kworker/u16:23 (pid: 1468, stack limit = 0x6e4b6fba)
Stack: (0xec401df8 to 0xec402000)
...
[<c0724c90>] (xhci_suspend) from [<c061b4f4>] (dpm_run_callback+0xb4/0x3fc)
[<c061b4f4>] (dpm_run_callback) from [<c061bd5c>] 
(__device_suspend+0x134/0x7e8)
[<c061bd5c>] (__device_suspend) from [<c061c42c>] (async_suspend+0x1c/0x94)
[<c061c42c>] (async_suspend) from [<c0154bd0>] 
(async_run_entry_fn+0x48/0x1b8)
[<c0154bd0>] (async_run_entry_fn) from [<c0149b38>] 
(process_one_work+0x230/0x7bc)
[<c0149b38>] (process_one_work) from [<c014a108>] (worker_thread+0x44/0x524)
[<c014a108>] (worker_thread) from [<c01511fc>] (kthread+0x130/0x164)
[<c01511fc>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xec401fb0 to 0xec401ff8)
...
---[ end trace c72caf6487666442 ]---
note: kworker/u16:23[1468] exited with preempt_count 1

Reverting it fixes the NULL pointer issue. I can provide more 
information or do some other tests. Just let me know what will help to 
fix it.

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

