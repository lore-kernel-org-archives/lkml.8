Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E5CC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D822071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GsLvp5i9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgGPFsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:48:46 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57082 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGPFsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:48:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200716054843euoutp02ef2b751564123665fd21a6e67f0a608e~iJZE6OqFj2965829658euoutp02z
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:48:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200716054843euoutp02ef2b751564123665fd21a6e67f0a608e~iJZE6OqFj2965829658euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594878523;
        bh=6Q/xxSpfArr5DptfUozWTHm7AaP1voqUMXHivc+J01A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GsLvp5i9Q9g/JmBAyf3rmIBZMoziPTYp6DjOb5vcuF4GFM1SJaboozQNEaDu2fpiH
         BD0IMxqXmh4P9LabQ5yjT06UOfCYMmxNZeBTviZa6TiEYEylis9/ASRl2Yi0VYZdUg
         wWB/gNDtI0BCC6ZAzDwX+LJWkoHIU+mgqDKkDYKs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200716054842eucas1p2695988b9d0a25a781a1b47785e05fa43~iJZEE79n43126531265eucas1p27;
        Thu, 16 Jul 2020 05:48:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AB.B0.05997.A3AEF0F5; Thu, 16
        Jul 2020 06:48:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200716054841eucas1p2ab5df837beed7d14b6237978f1ad0f0e~iJZDHzaPW2093120931eucas1p2J;
        Thu, 16 Jul 2020 05:48:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200716054841eusmtrp1f74e71c677e01ed9e3ae0ae41ba777ea~iJZDHO64T1632816328eusmtrp1a;
        Thu, 16 Jul 2020 05:48:41 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-b7-5f0fea3a4828
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 02.7F.06314.93AEF0F5; Thu, 16
        Jul 2020 06:48:41 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200716054841eusmtip2447ef8ce31dc0fb5df0b9c15c50022c6~iJZCuTKlY1421714217eusmtip2r;
        Thu, 16 Jul 2020 05:48:41 +0000 (GMT)
Subject: Re: [PATCH v1] driver core: Fix scheduling while atomic warnings
 during device link deletion
To:     Guenter Roeck <linux@roeck-us.net>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <99bf8e73-1daa-34b8-ca7e-093a44fdba9b@samsung.com>
Date:   Thu, 16 Jul 2020 07:48:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e3f4469e-8467-1736-8a39-6539b9f542af@roeck-us.net>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djP87pWr/jjDTbs0rZoXryezWLHdhGL
        y7vmsFk8WXiGyWLul6nMFl2H/rI5sHls272N1WPBplKPTas62Tz2z13D7rHzewO7x+dNcgFs
        UVw2Kak5mWWpRfp2CVwZdzq+sxfM06s4sucbewNjm0YXIyeHhICJxKueqSxdjFwcQgIrGCWu
        3bvICOF8YZQ4fG87O4TzmVHi44KzQGUcYC3XbmpDxJczSty/NQWq/T2jxIcr81lB5goLpEs8
        /3mAGSQhIrCGUaK97TdYglnAUuLVmjlgNpuAoUTX2y42EJtXwE7i85NGZpANLAKqEtueCIOE
        RQXiJNa/3M4EUSIocXLmE7AjOAUcJC5/joeYKC/RvHU2M4QtLnHryXwmiNc2sUvce1ALYbtI
        XFl1AiouLPHq+BZ2CFtG4vTkHrD7JQSaGSUenlvLDuH0MEpcbprBCFFlLXHn3C82kMXMApoS
        63fpQ4QdJXbcuMEMCRQ+iRtvBSFu4JOYtG06VJhXoqNNCKJaTWLW8XVwaw9euMQ8gVFpFpLH
        ZiH5ZhaSb2Yh7F3AyLKKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMPmc/nf8yw7GXX+S
        DjEKcDAq8fAq/OSLF2JNLCuuzD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlOavEhRmkOFiVx
        XuNFL2OFBNITS1KzU1MLUotgskwcnFINjE7v1sSr/vFe8e6eOpfLpvKLmhmHnx9+NT1s+tKr
        KSmdIpaWM3tC30poXXutcoO5KVfu6KwjYl+XpCwu270o48sJEzGZhs2x7CGH+i4c+xr5N67s
        +I9vZpayVcJ3fEJ/ZfN5NlsFsAjVrrY+kLY+7W+10oPr/2NWTU0z9M59X3REQHlJWvqDq0os
        xRmJhlrMRcWJANwNx8E6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7qWr/jjDQ7v17FoXryezWLHdhGL
        y7vmsFk8WXiGyWLul6nMFl2H/rI5sHls272N1WPBplKPTas62Tz2z13D7rHzewO7x+dNcgFs
        UXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZdzq+
        sxfM06s4sucbewNjm0YXIweHhICJxLWb2l2MnBxCAksZJab0SYLYEgIyEienNbBC2MISf651
        sXUxcgHVvGWUuP12A1hCWCBd4vnPA8wgCRGBNYwSLafmM4IkmAUsJV6tmcMK0XGUUeLy2ZNg
        CTYBQ4mutyCjODl4BewkPj9pZAa5gkVAVWLbE2GQsKhAnMTyLfPZIUoEJU7OfMICUsIp4CBx
        +XM8xHgziXmbHzJD2PISzVtnQ9niEreezGeawCg0C0n3LCQts5C0zELSsoCRZRWjSGppcW56
        brGhXnFibnFpXrpecn7uJkZgtG079nPzDsZLG4MPMQpwMCrx8Cr85IsXYk0sK67MPcQowcGs
        JMLrdPZ0nBBvSmJlVWpRfnxRaU5q8SFGU6DXJjJLiSbnAxNBXkm8oamhuYWlobmxubGZhZI4
        b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxjhG1jhXZe52z7Uhdxw2VSXXpzt9jt3xXXth4y/b
        yt3eu8yzL2118PffmmF1yN1n2m9bhT8Bae+c9s6Qn5B55r+mUcDLrPnvPp/NbBcyuyAq9eRy
        jJ2X1MTWv3Ulq4IMb7dH7D0vGcPL9cXALEi0rO3n53dGqSrdTdN/JNqunXfT40+DrPQTJZbi
        jERDLeai4kQA7l/FBMwCAAA=
X-CMS-MailID: 20200716054841eucas1p2ab5df837beed7d14b6237978f1ad0f0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200716053024eucas1p1fc9f469ce40472554cf377e4cd12e1d2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200716053024eucas1p1fc9f469ce40472554cf377e4cd12e1d2
References: <20200716050846.2047110-1-saravanak@google.com>
        <CGME20200716053024eucas1p1fc9f469ce40472554cf377e4cd12e1d2@eucas1p1.samsung.com>
        <e3f4469e-8467-1736-8a39-6539b9f542af@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 16.07.2020 07:30, Guenter Roeck wrote:
> On 7/15/20 10:08 PM, Saravana Kannan wrote:
>> Marek and Guenter reported that commit 287905e68dd2 ("driver core:
>> Expose device link details in sysfs") caused sleeping/scheduling while
>> atomic warnings.
>>
>> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
>> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworker/0:1
>> 2 locks held by kworker/0:1/12:
>>    #0: ee8074a8 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
>>    #1: ee921f20 ((work_completion)(&sdp->work)){+.+.}-{0:0}, at: process_one_work+0x174/0x7dc
>> Preemption disabled at:
>> [<c01b10f0>] srcu_invoke_callbacks+0xc0/0x154
>> ----- 8< ----- SNIP
>> [<c064590c>] (device_del) from [<c0645c9c>] (device_unregister+0x24/0x64)
>> [<c0645c9c>] (device_unregister) from [<c01b10fc>] (srcu_invoke_callbacks+0xcc/0x154)
>> [<c01b10fc>] (srcu_invoke_callbacks) from [<c01493c4>] (process_one_work+0x234/0x7dc)
>> [<c01493c4>] (process_one_work) from [<c01499b0>] (worker_thread+0x44/0x51c)
>> [<c01499b0>] (worker_thread) from [<c0150bf4>] (kthread+0x158/0x1a0)
>> [<c0150bf4>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
>> Exception stack(0xee921fb0 to 0xee921ff8)
>>
>> This was caused by the device link device being released in the context
>> of srcu_invoke_callbacks().  There is no need to wait till the RCU
>> callback to release the device link device.  So release the device
>> earlier and revert the RCU callback code to what it was before
>> commit 287905e68dd2 ("driver core: Expose device link details in sysfs")
>>
>> Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>> ---
>> Marek and Guenter,
>>
>> It haven't had a chance to test this yet. Can one of you please test it
>> and confirm it fixes the issue?
>>
> With this patch applied, the original warning is gone, but I get lots
> of other warnings.
>
> WARNING: CPU: 0 PID: 1 at drivers/base/core.c:1790 device_release+0x94/0xa4^M
> Device 'regulators:regulator@0:50038000.ethernet' does not have a release() function, it is broken and must be fixed.
>
> WARNING: CPU: 0 PID: 1 at drivers/base/core.c:1790 device_release+0x94/0xa4
> Device '53f9c000.gpio:50038000.ethernet' does not have a release() function, it is broken and must be fixed.
>
> WARNING: CPU: 0 PID: 1 at drivers/base/core.c:1790 device_release+0x94/0xa4^M
> Device '50030000.tscadc:50030400.tcq' does not have a release() function, it is broken and must be fixed.

I confirm that I also get such warnings for every platform device in the 
system with this patch applied to linux next-20200715:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/base/core.c:1790 device_release+0x94/0x98
Device '10023c40.power-domain:13620000.sysmmu' does not have a release() 
function, it is broken and must be fixed. See 
Documentation/core-api/kobject.rst.
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
5.8.0-rc5-next-20200715-00002-g0f637964c4b0 #1270
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c011184c>] (unwind_backtrace) from [<c010d250>] (show_stack+0x10/0x14)
[<c010d250>] (show_stack) from [<c051b8fc>] (dump_stack+0xbc/0xe8)
[<c051b8fc>] (dump_stack) from [<c0126ed8>] (__warn+0xf0/0x108)
[<c0126ed8>] (__warn) from [<c0126f64>] (warn_slowpath_fmt+0x74/0xb8)
[<c0126f64>] (warn_slowpath_fmt) from [<c064a2a0>] 
(device_release+0x94/0x98)
[<c064a2a0>] (device_release) from [<c0522178>] (kobject_put+0x104/0x288)
[<c0522178>] (kobject_put) from [<c064b45c>] (__device_link_del+0x38/0xac)
[<c064b45c>] (__device_link_del) from [<c064c1f0>] 
(device_links_driver_bound+0x260/0x26c)
[<c064c1f0>] (device_links_driver_bound) from [<c0650af0>] 
(driver_bound+0x5c/0x110)
[<c0650af0>] (driver_bound) from [<c0651038>] (really_probe+0x2d4/0x4fc)
[<c0651038>] (really_probe) from [<c06513c8>] 
(driver_probe_device+0x78/0x1fc)
[<c06513c8>] (driver_probe_device) from [<c064ee00>] 
(bus_for_each_drv+0x74/0xb8)
[<c064ee00>] (bus_for_each_drv) from [<c0650cc4>] 
(__device_attach+0xd4/0x16c)
[<c0650cc4>] (__device_attach) from [<c064fdc4>] 
(bus_probe_device+0x88/0x90)
[<c064fdc4>] (bus_probe_device) from [<c064c604>] 
(fw_devlink_resume+0xa0/0x134)
[<c064c604>] (fw_devlink_resume) from [<c102bfd4>] 
(of_platform_default_populate_init+0xa8/0xc0)
[<c102bfd4>] (of_platform_default_populate_init) from [<c0102378>] 
(do_one_initcall+0x8c/0x424)
[<c0102378>] (do_one_initcall) from [<c1001158>] 
(kernel_init_freeable+0x190/0x204)
[<c1001158>] (kernel_init_freeable) from [<c0ac05d0>] 
(kernel_init+0x8/0x118)
[<c0ac05d0>] (kernel_init) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xef0dffb0 to 0xef0dfff8)
ffa0:                                     00000000 00000000 00000000 
00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
irq event stamp: 40543
hardirqs last  enabled at (40551): [<c019d624>] console_unlock+0x430/0x6cc
hardirqs last disabled at (40568): [<c019d348>] console_unlock+0x154/0x6cc
softirqs last  enabled at (40584): [<c010174c>] __do_softirq+0x50c/0x608
softirqs last disabled at (40595): [<c0130218>] irq_exit+0x168/0x16c
---[ end trace 1d4780a89f63483a ]---

> and so on. I don't know if this is caused by this patch or by
> some other patch in -next.

This is caused by patch 287905e68dd2 ("driver core: Expose device link 
details in sysfs"). If you revert it, the warning will go away.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

